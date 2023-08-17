library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity main is
    generic (
        -- RAM constants
        constant RAM_DATA_WIDTH		: integer := 8;
        constant RAM_ADDRESS_WIDTH	: integer := 15; --32 kBytes de RAM
        constant BYTES_TO_RECEIVE	: natural := 32700;
        constant CYCLES_TO_WAIT		: integer := 100000;
        -- CORDIC Constants
        constant COORDS_WIDTH: integer := 8;
        constant ANGLE_WIDTH: integer := 10;
        constant CORDIC_STAGES: integer := 8;
        constant CORDIC_WIDTH: integer := 12;
        constant CORDIC_OFFSET: integer := 4;
        constant ANGLE_STEP_INITIAL: natural := 1;  
        constant CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH: natural := 10;
        -- VRAM constants
        constant VRAM_ADDR_BITS: natural 	:= 16; -- 8 KBytes 
        constant VRAM_DATA_BITS_WIDTH: natural := 1);
    port (
        -- Clks and ctrl signals
        clk          : in std_logic;
        clk_wiz      : in std_logic;
        rst          : in std_logic;
        -- Buttons
        btn_x1       : in std_logic;
        btn_x2       : in std_logic;
        btn_y1       : in std_logic;
        btn_y2       : in std_logic;
        btn_z1       : in std_logic;
        -- Feedback signal to clk_wizard. Used to stabilize clock
        wiz_rst      : out std_logic;
        -- Zedboard-specific probe signals
        JA1          : out std_logic;
        JA2          : out std_logic;
        JA3          : out std_logic;
        JA4          : out std_logic;
        -- VGA signals
        hs_main, vs_main : out std_logic;
        red_out_main   :	out std_logic_vector(2 downto 0);
        grn_out_main   :   out std_logic_vector(2 downto 0);
        blu_out_main	 :	out std_logic_vector(1 downto 0));
end entity;

architecture main_arch of main is

-- Prototipos a utilizar
component vga_ctrl is
    port(
        mclk, red_i, grn_i, blu_i : in std_logic;
        hs, vs                    : out std_logic;
        red_o                     : out std_logic_vector(2 downto 0);
        grn_o                     : out std_logic_vector(2 downto 0);
        blu_o                     : out std_logic_vector(1 downto 0);
        pixel_row, pixel_col      : out std_logic_vector(9 downto 0)
    );
end component;

component sram_internal is
    port(
        clka	:	in std_logic;
        wea		:	in std_logic_vector(0 downto 0);
        addra	:	in std_logic_vector(RAM_ADDRESS_WIDTH-1 downto 0);
        dina	:	in std_logic_vector(RAM_DATA_WIDTH-1 downto 0);
        douta	:	out std_logic_vector(RAM_DATA_WIDTH-1 downto 0)
    );
end component;

component vram is
    generic (
        -- Ancho de palabra de la memoria medido en bits
        VRAM_BITS_WIDTH : natural := 1; 
        -- Cantidad de bits de address (tamaño de la memoria es 2^ADDRS_BITS)
        VRAM_ADDR_BITS : natural := 16);
    port (
        rst		: in std_logic;
        clk		: in std_logic;
        data_wr : in std_logic_vector(VRAM_BITS_WIDTH-1 downto 0);
        addr_wr : in std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
        ena_wr 	: in std_logic;
        addr_rd : in std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
        data_rd : out std_logic_vector(VRAM_BITS_WIDTH-1 downto 0));
end component;

component video_driver is
    generic (
        -- Ancho de palabra de la memoria medido en bits
        VRAM_BITS_WIDTH : natural := 1; 
        -- Cantidad de bits de address (tamaño de la memoria es 2^ADDRS_BITS)
        VRAM_ADDR_BITS  : natural := 16);
        port (
        rst        : in std_logic;
        clk        : in std_logic;
        red_en_o   : out std_logic;
        green_en_o : out std_logic;
        blue_en_o  : out std_logic;
        pixel_x    : in unsigned(9 downto 0);
        pixel_y    : in unsigned(9 downto 0);
        addr_rd    : out std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
        data_rd    : in std_logic_vector(VRAM_BITS_WIDTH-1 downto 0));
end component;

component rotator is
    generic (
        COORDS_WIDTH            : integer := CORDIC_WIDTH;
        ANGLES_INTEGER_WIDTH    : integer := ANGLE_WIDTH;
        STAGES                  : integer := CORDIC_STAGES);
        port (
        clk                         :   in std_logic;
        X_in, Y_in, Z_in                  :   in signed(CORDIC_WIDTH-1 downto 0);
        angle_X, angle_Y, angle_Z   :   in signed(ANGLES_INTEGER_WIDTH-1 downto 0);
        X_out, Y_out, Z_out                     :   out signed(CORDIC_WIDTH-1 downto 0));
end component;

signal rst_main: std_logic := '1';

-- Auxiliar signals
signal aux_pixel_x_i: std_logic_vector(9 downto 0) := (others => '0');
signal aux_pixel_y_i: std_logic_vector(9 downto 0) := (others => '0');
signal pixel_x, pixel_y: unsigned(9 downto 0);

signal max_memory_address : unsigned(15 downto 0) := to_unsigned(35838, 16); 

-- Used to read component by component when rotating
signal xyz_selector_current, xyz_selector_next: natural := 0;

-- VGA signals
signal blue_enable: std_logic 	:= '0';
signal red_enable: std_logic	:= '0';
signal green_enable: std_logic	:= '0';

-- Coordenadas
signal x_coord_current, x_coord_next: std_logic_vector(COORDS_WIDTH-1 downto 0) := (others => '0');
signal y_coord_current, y_coord_next: std_logic_vector(COORDS_WIDTH-1 downto 0) := (others => '0');
signal z_coord_current, z_coord_next: std_logic_vector(COORDS_WIDTH-1 downto 0) := (others => '0');

-- Rotator inputs & outputs
signal X_in_rotator, Y_in_rotator, Z_in_rotator: signed(CORDIC_WIDTH-1 downto 0);
signal X_coord_rotated: signed(CORDIC_WIDTH-1 downto 0);
signal Y_coord_rotated: signed(CORDIC_WIDTH-1 downto 0);
signal Z_coord_rotated: signed(CORDIC_WIDTH-1 downto 0);
signal angle_x_rotator: signed(ANGLE_WIDTH-1 downto 0) := (others => '0');
signal angle_y_rotator: signed(ANGLE_WIDTH-1 downto 0) := (others => '0');
signal angle_z_rotator: signed(ANGLE_WIDTH-1 downto 0) := (others => '0');

-- Coords used to generated VRAM addresses.
signal X_coord_rotated_unsigned: std_logic_vector(COORDS_WIDTH-1 downto 0) := (others => '0');
signal Y_coord_rotated_unsigned: std_logic_vector(COORDS_WIDTH-1 downto 0) := (others => '0');
signal Z_coord_rotated_unsigned: std_logic_vector(COORDS_WIDTH-1 downto 0) := (others => '0');

-- SRAM
signal sram_address	    : std_logic_vector(RAM_ADDRESS_WIDTH-1 downto 0) := (others => '0');
signal sram_data_out	: std_logic_vector(RAM_DATA_WIDTH-1 downto 0);

-- VRAM
signal vram_addr_rd	: std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
signal vram_data_rd   	: std_logic_vector(VRAM_DATA_BITS_WIDTH-1 downto 0);

-- FSM
type state_t is (state_init, state_idle, state_read_from_sram,
state_clean_vram, state_process_coords, state_print_coords,
state_reset_device, state_read_from_sram_prev, state_read_from_sram_prev2);
signal state_current, state_next : state_t := state_init;
signal sram_address_current, sram_address_next: unsigned(14 downto 0) := to_unsigned(0, 15);
signal sram_rw_current, sram_rw_next: std_logic_vector(0 downto 0) := "0";
signal sram_data_in_current, sram_data_in_next: std_logic_vector(RAM_DATA_WIDTH-1 downto 0) := (others => '0');
signal vram_addr_wr_current, vram_addr_wr_next : std_logic_vector(VRAM_ADDR_BITS-1 downto 0) := (others => '0');
signal vram_ena_wr_current, vram_ena_wr_next: std_logic := '0';
signal vram_data_wr_current, vram_data_wr_next: std_logic_vector(VRAM_DATA_BITS_WIDTH-1 downto 0) := "0";
signal vram_addr_wr_pointer_current, vram_addr_wr_pointer_next : integer range 0 to 2**VRAM_ADDR_BITS-1;
signal cycles_current, cycles_next: natural := CYCLES_TO_WAIT;

-- Misc control signals
signal clk_main : std_logic;
signal not_rst_main : std_logic;

-- Buttons
signal btn_x1_cycles_pressed : unsigned(19 downto 0) := to_unsigned(0, 20);
signal btn_x2_cycles_pressed : unsigned(19 downto 0) := to_unsigned(0, 20);
signal btn_y1_cycles_pressed : unsigned(19 downto 0) := to_unsigned(0, 20);
signal btn_y2_cycles_pressed : unsigned(19 downto 0) := to_unsigned(0, 20);
signal btn_z1_cycles_pressed : unsigned(19 downto 0) := to_unsigned(0, 20);
signal max_cycles_pressed : unsigned(19 downto 0) := (others => '1');--"00000000000011111111";
signal angles_changed : std_logic := '0';
signal rotating_curr : std_logic := '0';
signal rotating_next : std_logic := '0';

begin

-- Clock wizard reset generator
process(clk_main)
begin
    if rising_edge(clk_main) then
        wiz_rst <= '1';
    end if;
end process;

-- Probe signals to measure desired signals
JA1 <= btn_x1;
JA2 <= btn_x1_cycles_pressed(0);
JA3 <= btn_x1_cycles_pressed(1);
JA4 <= angle_x_rotator(0);

-- Use clock wizard's clock
clk_main <= clk_wiz;

not_rst_main <= not rst;

pixel_x <= unsigned(aux_pixel_x_i);
pixel_y <= unsigned(aux_pixel_y_i);

X_in_rotator <= signed(std_logic_vector(to_unsigned(0, CORDIC_OFFSET)) & X_coord_current(COORDS_WIDTH-1 downto 0)) when X_coord_current(COORDS_WIDTH-1) = '0' else
                signed(std_logic_vector(to_unsigned((2**CORDIC_OFFSET)-1, CORDIC_OFFSET)) & X_coord_current(COORDS_WIDTH-1 downto 0)) when X_coord_current(COORDS_WIDTH-1) = '1';
Y_in_rotator <= signed(std_logic_vector(to_unsigned(0, CORDIC_OFFSET)) & Y_coord_current(COORDS_WIDTH-1 downto 0)) when Y_coord_current(COORDS_WIDTH-1) = '0' else
                signed(std_logic_vector(to_unsigned((2**CORDIC_OFFSET)-1, CORDIC_OFFSET)) & Y_coord_current(COORDS_WIDTH-1 downto 0)) when Y_coord_current(COORDS_WIDTH-1) = '1';
Z_in_rotator <= signed(std_logic_vector(to_unsigned(0, CORDIC_OFFSET)) & Z_coord_current(COORDS_WIDTH-1 downto 0)) when Z_coord_current(COORDS_WIDTH-1) = '0' else
                signed(std_logic_vector(to_unsigned((2**CORDIC_OFFSET)-1, CORDIC_OFFSET)) & Z_coord_current(COORDS_WIDTH-1 downto 0)) when Z_coord_current(COORDS_WIDTH-1) = '1';

X_coord_rotated_unsigned <= std_logic_vector(X_coord_rotated(COORDS_WIDTH-1 downto 0) + to_signed(-(2**(COORDS_WIDTH-1)), COORDS_WIDTH));
Y_coord_rotated_unsigned <= std_logic_vector(Y_coord_rotated(COORDS_WIDTH-1 downto 0) + to_signed(-(2**(COORDS_WIDTH-1)), COORDS_WIDTH));
Z_coord_rotated_unsigned <= std_logic_vector(Z_coord_rotated(COORDS_WIDTH-1 downto 0) + to_signed(-(2**(COORDS_WIDTH-1)), COORDS_WIDTH));

sram_address <= std_logic_vector(sram_address_current);

-- Registers update
process(clk_main, rst)     
    begin
    if(rst='0') then
        state_current <= state_reset_device;
    elsif rising_edge(clk_main) then
        state_current <= state_next;
        sram_address_current <= sram_address_next;
        sram_rw_current <= sram_rw_next;
        sram_data_in_current <= sram_data_in_next;
        cycles_current <= cycles_next;
        x_coord_current <= x_coord_next;
        y_coord_current <= y_coord_next;
        z_coord_current <= z_coord_next;
        xyz_selector_current <= xyz_selector_next;
        vram_addr_wr_current <= vram_addr_wr_next;
        vram_ena_wr_current <= vram_ena_wr_next;
        vram_data_wr_current <= vram_data_wr_next;
        vram_addr_wr_pointer_current <= vram_addr_wr_pointer_next;
        rotating_curr <= rotating_next;
    end if;
end process;

-- FSM implementation
process(
sram_address_current, state_current, sram_rw_current, xyz_selector_current, sram_data_in_current, 
sram_data_out, sram_address_current, cycles_current,
x_coord_current, y_coord_current, z_coord_current, vram_addr_wr_current, vram_ena_wr_current, vram_data_wr_current,
vram_addr_wr_pointer_current, cycles_current, X_coord_rotated_unsigned, Y_coord_rotated_unsigned, Z_coord_rotated_unsigned)
begin
    -- Valores por defecto
    cycles_next <= cycles_current;
    sram_rw_next <= sram_rw_current;
    sram_data_in_next <= sram_data_in_current;
    sram_address_next <= sram_address_current;
    xyz_selector_next <= xyz_selector_current;
    x_coord_next <= x_coord_current;
    y_coord_next <= y_coord_current;
    z_coord_next <= z_coord_current;
    cycles_next <= cycles_current;
    vram_addr_wr_next <= vram_addr_wr_current;
    vram_ena_wr_next <= vram_ena_wr_current;
    vram_data_wr_next <= vram_data_wr_current;
    vram_addr_wr_pointer_next <= vram_addr_wr_pointer_current;
    rotating_next <= rotating_curr;
    case state_current is
        when state_init =>
            sram_address_next <= to_unsigned(0, sram_address_next'length);
            sram_rw_next <= "0";
            vram_ena_wr_next <= '0';
            vram_data_wr_next <= "0";
            vram_addr_wr_next <= (others=> '0');
            if cycles_current = 0 then
                state_next <= state_clean_vram;
                rotating_next <= '1';
            else
                cycles_next <= cycles_current - 1;
                state_next <= state_init;
            end if;
        when state_idle =>
            state_next <= state_process_coords;
        when state_read_from_sram_prev => --Le da el ciclo de clock que la RAM necesita
            state_next <= state_read_from_sram_prev2;
        when state_read_from_sram_prev2 => --Le da el ciclo de clock que la RAM necesita
            state_next <= state_read_from_sram;
        when state_read_from_sram =>
            if angles_changed = '0' and rotating_curr = '0' then
                state_next <= state_idle;
            elsif sram_address_current > BYTES_TO_RECEIVE then
                rotating_next <= '0';
                xyz_selector_next <= 0;
                sram_address_next <= to_unsigned(0, sram_address_next'length);
                state_next <= state_idle;
            elsif angles_changed = '1' and rotating_curr = '0' then
                state_next <= state_clean_vram;
                rotating_next <= '1';
            else
                vram_ena_wr_next <= '0';
                case xyz_selector_current is
                    when 0 =>
                        sram_address_next <= sram_address_current + 1;
                        x_coord_next <= sram_data_out;
                        xyz_selector_next <= xyz_selector_current + 1;
                        state_next <= state_read_from_sram_prev;
                    when 1 =>
                        sram_address_next <= sram_address_current + 1;
                        y_coord_next <= sram_data_out;
                        xyz_selector_next <= xyz_selector_current + 1;
                        state_next <= state_read_from_sram_prev;
                    when 2 =>
                        sram_address_next <= sram_address_current + 1;
                        z_coord_next <= sram_data_out;
                        xyz_selector_next <= 0;
                        cycles_next <= 0;
                        state_next <= state_process_coords;
                    when others =>
                        state_next <= state_idle;
                end case;
            end if;
        when state_process_coords =>
            if cycles_current < CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH then
                cycles_next <= cycles_current + 1;
                vram_ena_wr_next <= '0';
                state_next <= state_process_coords;
            else
                state_next <= state_print_coords;
            end if;
        when state_print_coords =>
            vram_ena_wr_next <= '1';
            vram_data_wr_next <= "1";
            vram_addr_wr_next <= z_coord_rotated_unsigned(7 downto 0) & y_coord_rotated_unsigned(7 downto 0);
            state_next <= state_read_from_sram_prev;
        when state_reset_device =>
            sram_address_next <= to_unsigned(0, sram_address_next'length);
            state_next <= state_read_from_sram;
            rotating_next <= '1';
        when state_clean_vram =>
            if vram_addr_wr_pointer_current < ((2**VRAM_ADDR_BITS)-1) then
                vram_addr_wr_pointer_next <= vram_addr_wr_pointer_current + 1;
                vram_ena_wr_next <= '1';
                vram_data_wr_next <= "0";
                state_next <= state_clean_vram;
            else
                vram_addr_wr_pointer_next <= 0;
                vram_ena_wr_next <= '0';
                vram_data_wr_next <= "0";
                state_next <= state_read_from_sram_prev;
            end if;
            vram_addr_wr_next <= std_logic_vector(to_unsigned(vram_addr_wr_pointer_current, VRAM_ADDR_BITS));
        when others =>
            state_next <= state_idle;
    end case;
end process;

-- VGA control
vga_control_inst : vga_ctrl
port map (
    mclk => clk_main,
    hs => hs_main,
    vs => vs_main,
    red_o => red_out_main,
    grn_o => grn_out_main,
    blu_o => blu_out_main,
    red_i => red_enable,
    grn_i => green_enable,
    blu_i => blue_enable,
    pixel_row => aux_pixel_y_i,
    pixel_col => aux_pixel_x_i);

-- Single port RAM
sram_inst : sram_internal
port map (
    clka => clk_main,
    wea => "0",
    addra => sram_address,
    dina => sram_data_in_current,
    douta => sram_data_out);

-- Video buffer
vram_inst : vram
generic map(
    VRAM_BITS_WIDTH => VRAM_DATA_BITS_WIDTH,
    VRAM_ADDR_BITS => VRAM_ADDR_BITS)
port map(
    rst => not_rst_main,
    clk => clk_main,
    data_wr => vram_data_wr_current,
    addr_wr => vram_addr_wr_current,
    ena_wr  => vram_ena_wr_current,
    data_rd => vram_data_rd,
    addr_rd => vram_addr_rd);

-- Video driver
video_driver_inst : video_driver
generic map(
    VRAM_BITS_WIDTH => VRAM_DATA_BITS_WIDTH,
    VRAM_ADDR_BITS => VRAM_ADDR_BITS)
port map (
    rst => not_rst_main,
    clk => clk_main,
    red_en_o => red_enable,
    green_en_o => green_enable,
    blue_en_o => blue_enable,
    pixel_y => pixel_y,
    pixel_x => pixel_x,
    data_rd => vram_data_rd,
    addr_rd => vram_addr_rd);

process(btn_x1, btn_x2, btn_y1, btn_y2, btn_z1, clk_main)
begin
    if rising_edge(clk_main) then
        if btn_x1 = '1' then
           btn_x1_cycles_pressed <= btn_x1_cycles_pressed + 1;
        else
           btn_x1_cycles_pressed <= (others => '0');
        end if;

        if btn_x2 = '1' then
           btn_x2_cycles_pressed <= btn_x2_cycles_pressed + 1;
        else
           btn_x2_cycles_pressed <= (others => '0');
        end if;

        if btn_y1 = '1' then
           btn_y1_cycles_pressed <= btn_y1_cycles_pressed + 1;
        else
           btn_y1_cycles_pressed <= (others => '0');
        end if;

        if btn_y2 = '1' then
           btn_y2_cycles_pressed <= btn_y2_cycles_pressed + 1;
        else
           btn_y2_cycles_pressed <= (others => '0');
        end if;

        if btn_z1 = '1' then
           btn_z1_cycles_pressed <= btn_z1_cycles_pressed + 1;
        else
           btn_z1_cycles_pressed <= (others => '0');
        end if;

        if btn_x1_cycles_pressed = max_cycles_pressed then
            if angle_x_rotator > 180 then
                angle_x_rotator <= to_signed(180, angle_x_rotator'length);
            else
                angle_x_rotator <= angle_x_rotator + 1;
            end if;
            btn_x1_cycles_pressed <= (others => '0');
        end if;
        if btn_x2_cycles_pressed = max_cycles_pressed then
            if angle_x_rotator < -90 then
                angle_x_rotator <= to_signed(-180, angle_x_rotator'length);
            else
                angle_x_rotator <= angle_x_rotator - 1;
            end if;
            btn_x2_cycles_pressed <= (others => '0');
            end if;
        if btn_y1_cycles_pressed = max_cycles_pressed then
            if angle_y_rotator > 180 then
                angle_y_rotator <= to_signed(180, angle_y_rotator'length);
            else
                angle_y_rotator <= angle_y_rotator + 1;
            end if;
        end if;
        if btn_y2_cycles_pressed = max_cycles_pressed then
            if angle_y_rotator < -180 then
                angle_y_rotator <= to_signed(-90, angle_y_rotator'length);
            else
                angle_y_rotator <= angle_y_rotator - 1;
            end if;
        end if;
        if btn_z1_cycles_pressed = max_cycles_pressed then
            if angle_z_rotator > 180 then
                angle_z_rotator <= angle_z_rotator - to_signed(360, angle_z_rotator'length);
            elsif angle_z_rotator < -180 then
                angle_z_rotator <= angle_z_rotator + to_signed(360, angle_z_rotator'length);
            else
                angle_z_rotator <= angle_z_rotator + 1;
            end if;
        end if;
    end if;
    if btn_x1='1' or btn_x2='1' or btn_y1='1' or btn_y2='1' or btn_z1='1' then
        angles_changed <= '1';
    else
        angles_changed <= '0';
    end if;
end process;

cordic_rotator: rotator
generic map (
    COORDS_WIDTH=>CORDIC_WIDTH,
    ANGLES_INTEGER_WIDTH=>ANGLE_WIDTH,
    STAGES=>CORDIC_STAGES
)
port map(
    clk=>clk,
    X_in=>X_in_rotator, Y_in=>Y_in_rotator, Z_in=>Z_in_rotator,
    angle_X=>angle_x_rotator, angle_Y=>angle_y_rotator, angle_Z=>angle_z_rotator,
    X_out=>X_coord_rotated, Y_out=>Y_coord_rotated, Z_out=>Z_coord_rotated
);

end main_arch;
