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

	constant N_BITS_VECTOR : integer := 17;
	constant N_BITS_ANGLE : integer := 8;

    -- Bits tolerance to verify correctness of result.
    constant TOLERANCE     : signed := to_signed(10, N_BITS_VECTOR+1);
	
    -- Remember to remove header line from file, if present.
	file data_file : text open read_mode is "/home/ljsch/FIUBA/SisDig/repo_TP_final/vhdl_cordic_vga/testing/float_coordenadas.txt";

	signal clk_tb : std_logic := '0';

	signal xi_tb: signed(N_BITS_VECTOR-1 downto 0);
	signal yi_tb: signed(N_BITS_VECTOR-1 downto 0);
	signal zi_tb: signed(N_BITS_VECTOR-1 downto 0);

	signal counter : unsigned(N_BITS_VECTOR downto 0) := (others => '0');
	signal alpha_tb : signed(N_BITS_ANGLE-1 downto 0) := "00011101";
	signal start_vec_rot : std_logic := '0';
	signal vec_rot_done : std_logic;
	
	signal xout_tb    : signed(N_BITS_VECTOR downto 0);
	signal yout_tb    : signed(N_BITS_VECTOR downto 0);
	signal zout_tb    : signed(N_BITS_VECTOR downto 0);

    type state_t is (uninitialized_state,
                     read_vec_state,
                     ready_to_begin_rotate_vec_state,
                     start_rotate_vec_state,
                     wait_rotate_vec_state,
                     endfile_state);
    signal current_state : state_t := uninitialized_state;

begin
	clk_tb        <= not clk_tb after 10 ns;
    --current_state <= read_vec_state after 11 ns;

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

                        xi_tb <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        yi_tb <= to_signed(aux, N_BITS_VECTOR);
                        read(l, ch);
                        read(l, aux);

                        zi_tb <= to_signed(aux, N_BITS_VECTOR);
                        counter <= counter + 1;
                        current_state <= ready_to_begin_rotate_vec_state;
                    end if;
                when ready_to_begin_rotate_vec_state =>
                    current_state <= start_rotate_vec_state;
                when start_rotate_vec_state =>
                    start_vec_rot <= '1';
                    current_state <= wait_rotate_vec_state;
                when wait_rotate_vec_state =>
                    start_vec_rot <= '0';
                    if vec_rot_done = '1' then
                        current_state <= read_vec_state;
                    end if;
                when endfile_state =>
                    null;
            end case;
        end if;
    end process;

    vec_rotator : vector_rotator
    generic map(N_BITS_VECTOR, N_BITS_ANGLE)
    port map(
        clk   => clk_tb,
        xin    => xi_tb,
        yin    => yi_tb,
        zin    => zi_tb,
        alpha => alpha_tb,
        beta  => alpha_tb,
        gamma => alpha_tb,
        start => start_vec_rot,
        xout  => xout_tb,
        yout  => yout_tb,
        zout  => zout_tb,
        done  => vec_rot_done);

    

end architecture file_to_vector_arch;