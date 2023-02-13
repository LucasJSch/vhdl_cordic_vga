library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vector_rotator_tb is
end;

architecture vector_rotator_arch of vector_rotator_tb is
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
        xout  : out signed(N_BITS_VECTOR-1 downto 0);
        yout  : out signed(N_BITS_VECTOR-1 downto 0);
        zout  : out signed(N_BITS_VECTOR-1 downto 0);
        done  : out std_logic);
    end component;

	constant N_BITS_VECTOR : integer := 8;
	constant N_BITS_ANGLE : integer := 8;

	signal clk_tb   : std_logic := '0';
	signal xin_tb    : signed(N_BITS_VECTOR-1 downto 0) := "00100000";
	signal yin_tb    : signed(N_BITS_VECTOR-1 downto 0) := "00100000";
	signal zin_tb    : signed(N_BITS_VECTOR-1 downto 0) := "00100000";
	signal alpha_tb : signed(N_BITS_ANGLE-1 downto 0)  := "00100000";
	signal beta_tb  : signed(N_BITS_ANGLE-1 downto 0)  := "00000000";
	signal gamma_tb : signed(N_BITS_ANGLE-1 downto 0)  := "00000000";
	signal start_tb : std_logic := '0';
	signal xout_tb    : signed(N_BITS_VECTOR-1 downto 0);
	signal yout_tb    : signed(N_BITS_VECTOR-1 downto 0);
	signal zout_tb    : signed(N_BITS_VECTOR-1 downto 0);
	signal done_tb : std_logic;

begin

    clk_tb  <= not clk_tb after 10 ns;
    start_tb <= '1' after 20 ns, '0' after 30 ns;

	DUT: vector_rotator
		generic map(N_BITS_VECTOR, N_BITS_ANGLE)
		port map(
            clk   => clk_tb,
            xin    => xin_tb,
            yin    => yin_tb,
            zin    => zin_tb,
            alpha => alpha_tb,
            beta  => beta_tb,
            gamma => gamma_tb,
            start => start_tb,
            xout  => xout_tb,
            yout  => yout_tb,
            zout  => zout_tb,
            done  => done_tb);
end;