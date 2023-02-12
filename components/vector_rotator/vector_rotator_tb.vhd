library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vector_rotator_tb is
end;

architecture vector_rotator_arch of vector_rotator_tb is
    component vector_rotator is
    generic(
        N_BITS_VECTOR : integer:= 32;
        N_BITS_ANGLE : integer := 17);
    port(
        -- 2**(N_BITS_VECTOR-1) -->  1
        -- 2**(N_BITS_VECTOR)-1 --> -1
        -- 2**(N_BITS_ANGLE-1) --> 180
        -- 2**(N_BITS_ANGLE-2) --> 90
        -- 2**(N_BITS_ANGLE-3) --> 45
        clk   : in std_logic;
        x0    : in signed(N_BITS_VECTOR-1 downto 0);
        y0    : in signed(N_BITS_VECTOR-1 downto 0);
        z0    : in signed(N_BITS_VECTOR-1 downto 0);
        alpha : in signed(N_BITS_ANGLE-1 downto 0);
        beta  : in signed(N_BITS_ANGLE-1 downto 0);
        gamma : in signed(N_BITS_ANGLE-1 downto 0);
        start : in std_logic;
        done  : out std_logic);
    end component;

	constant N_BITS_VECTOR : integer := 8;
	constant N_BITS_ANGLE : integer := 8;

	signal clk_tb   : std_logic := '0';
	signal x0_tb    : signed(N_BITS_VECTOR-1 downto 0) := "00001000";
	signal y0_tb    : signed(N_BITS_VECTOR-1 downto 0) := "00001100";
	signal z0_tb    : signed(N_BITS_VECTOR-1 downto 0) := "00001110";
	signal alpha_tb : signed(N_BITS_ANGLE-1 downto 0)  := "0010000";
	signal beta_tb  : signed(N_BITS_ANGLE-1 downto 0)  := "0010000";
	signal gamma_tb : signed(N_BITS_ANGLE-1 downto 0)  := "0001000";
	signal start_tb : std_logic := '0';
	signal done _tb : std_logic;

begin

    clk_tb  <= not clk_tb after 10 ns;
    start_tb <= '1' after 20 ns;

	DUT: vector_rotator
		generic map(N_BITS_VECTOR, N_BITS_ANGLE)
		port map(
            clk   => clk_tb,
            x0    => x0_tb,
            y0    => y0_tb,
            z0    => z0_tb,
            alpha => alpha_tb,
            beta  => beta_tb,
            gamma => gamma_tb,
            start => start_tb,
            done  => done_tb);
end;