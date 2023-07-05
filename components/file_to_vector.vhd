library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity file_to_vector is
end entity;

architecture file_to_vector_arch of file_to_vector is
	component vector_rotator is
	generic(
		-- Describes the amount of bits per vector element.
		N_BITS_VECTOR : integer:= 32;
		-- Describes the amount of bits to represent the angle.
		N_BITS_ANGLE : integer := 17);
	port(
		-- 2**(N_BITS_VECTOR-1) -->  1
		-- 2**(N_BITS_VECTOR)-1 --> -1
		-- 2**(N_BITS_ANGLE-1) --> 180
		-- 2**(N_BITS_ANGLE-2) --> 90
		-- 2**(N_BITS_ANGLE-3) --> 45
		clk   : in std_logic;
		xin   : in signed(N_BITS_VECTOR-1 downto 0);
		yin   : in signed(N_BITS_VECTOR-1 downto 0);
		zin   : in signed(N_BITS_VECTOR-1 downto 0);
		alpha : in signed(N_BITS_ANGLE-1 downto 0);
		beta  : in signed(N_BITS_ANGLE-1 downto 0);
		gamma : in signed(N_BITS_ANGLE-1 downto 0);
		start : in std_logic;
		xout  : out signed(N_BITS_VECTOR downto 0);
		yout  : out signed(N_BITS_VECTOR downto 0);
		zout  : out signed(N_BITS_VECTOR downto 0);
		done  : out std_logic);
	end component;

    component rotator is
        generic (
            N_BITS_VECTOR            : integer := 10;
            N_BITS_ANGLE    : integer := 10;
            N_ITER                  : integer := 16
        );
        port (
            clk                         :   in std_logic;
            X0, Y0, Z0                  :   in signed(N_BITS_VECTOR-1 downto 0);
            angle_X, angle_Y, angle_Z   :   in signed(N_BITS_ANGLE-1 downto 0);
            X, Y, Z                     :   out signed(N_BITS_VECTOR-1 downto 0)
        );
    
    end component;

	constant N_BITS_VECTOR : integer := 17;
	constant N_BITS_ANGLE : integer := 10;

    -- Bits tolerance to verify correctness of result.
    constant TOLERANCE     : signed := to_signed(300, N_BITS_VECTOR+1);
	
    -- Remember to remove header line from file, if present.
	file data_file : text open read_mode is "/home/ljsch/FIUBA/SisDig/repo_TP_final/vhdl_cordic_vga/testing/float_coordenadas_test.txt";

	signal clk_tb : std_logic := '0';

    signal alpha_file : signed(N_BITS_ANGLE-1 downto 0);
    signal beta_file  : signed(N_BITS_ANGLE-1 downto 0);
    signal gamma_file : signed(N_BITS_ANGLE-1 downto 0);
	signal xi_file: signed(N_BITS_VECTOR-1 downto 0);
	signal yi_file: signed(N_BITS_VECTOR-1 downto 0);
	signal zi_file: signed(N_BITS_VECTOR-1 downto 0);
	signal xo_file: signed(N_BITS_VECTOR-1 downto 0);
	signal yo_file: signed(N_BITS_VECTOR-1 downto 0);
	signal zo_file: signed(N_BITS_VECTOR-1 downto 0);

	signal line_counter   : unsigned(N_BITS_VECTOR downto 0) := (others => '0');
	signal errors_counter_x : unsigned(N_BITS_VECTOR downto 0) := (others => '0');
	signal errors_counter_y : unsigned(N_BITS_VECTOR downto 0) := (others => '0');
	signal errors_counter_z : unsigned(N_BITS_VECTOR downto 0) := (others => '0');

	signal iter_count : unsigned(3 downto 0) := (others => '0');
	
	signal xout_tb    : signed(N_BITS_VECTOR-1 downto 0);
	signal yout_tb    : signed(N_BITS_VECTOR-1 downto 0);
	signal zout_tb    : signed(N_BITS_VECTOR-1 downto 0);

    type state_t is (uninitialized_state,
                     read_vec_state,
                     ready_to_begin_rotate_vec_state,
                     start_rotate_vec_state,
                     wait_rotate_vec_state,
                     evaluate_errors_state,
                     endfile_state);
    signal current_state : state_t := uninitialized_state;

begin
	clk_tb        <= not clk_tb after 1 ns;

	test_sequence: process(clk_tb)
		variable l: line;
		variable ch: character:= ',';
		variable aux: integer;
	begin
        if rising_edge(clk_tb) then
            case current_state is
                when uninitialized_state =>
                    current_state <= read_vec_state;
                when read_vec_state =>
                    if endfile(data_file) then
                        current_state <= endfile_state;
                    else
                        readline(data_file, l);
                        read(l, aux);

                        alpha_file <= to_signed(aux, N_BITS_ANGLE);
                        read(l, ch);
                        read(l, aux);

                        beta_file <= to_signed(aux, N_BITS_ANGLE);
                        read(l, ch);
                        read(l, aux);

                        gamma_file <= to_signed(aux, N_BITS_ANGLE);
                        read(l, ch);
                        read(l, aux);

                        xi_file <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        yi_file <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        zi_file <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        xo_file <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        yo_file <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        zo_file <= to_signed(aux, N_BITS_VECTOR);
                        line_counter <= line_counter + 1;
                        current_state <= ready_to_begin_rotate_vec_state;
                    end if;
                when ready_to_begin_rotate_vec_state =>
                    current_state <= start_rotate_vec_state;
                when start_rotate_vec_state =>
                    current_state <= wait_rotate_vec_state;
                when wait_rotate_vec_state =>
                    iter_count <= iter_count + 1;
                    if iter_count = to_unsigned(15, 4) then
                        current_state <= evaluate_errors_state;
                    end if;
                when evaluate_errors_state =>
                        iter_count <= (others => '0');
                        if (abs(xo_file - xout_tb) > TOLERANCE) then
                            errors_counter_x <= errors_counter_x + 1;
                        end if;
                        if (abs(yo_file - yout_tb) > TOLERANCE) then
                            errors_counter_y <= errors_counter_y + 1;
                        end if;
                        if (abs(zo_file - zout_tb) > TOLERANCE) then
                            errors_counter_z <= errors_counter_z + 1;
                        end if;
                    current_state <= read_vec_state;
                when endfile_state =>
                    null;
            end case;
        end if;
    end process;

    DUT: rotator
    generic map(N_BITS_VECTOR, N_BITS_ANGLE)
    port map(
        clk   => clk_tb,
        x0    => xi_file,
        y0    => yi_file,
        z0    => zi_file,
        angle_x  => alpha_file,
        angle_y  => beta_file,
        angle_z  => gamma_file,
        x    => xout_tb,
        y    => yout_tb,
        z    => zout_tb);

    

end architecture file_to_vector_arch;