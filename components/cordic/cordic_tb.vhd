library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cordic_tb is
end;

architecture cordic_arch of cordic_tb is
    component cordic is
    generic(
        -- Describes the amount of bits per vector element.
        N_BITS_VECTOR : integer:= 32;
        -- Describes the amount of bits to represent the angle.
        N_BITS_ANGLE : integer := 18;
        N_ITER       : integer := 15);
    port(
        clk  : in std_logic;
        x1   : in std_logic_vector(N_BITS_VECTOR-1 downto 0);
        y1   : in std_logic_vector(N_BITS_VECTOR-1 downto 0);
        beta : in signed(N_BITS_ANGLE-1 downto 0);
        -- 0: Rotation mode.
        -- 1: Vectoring mode.
        start: in std_logic;
        x2   : out std_logic_vector(N_BITS_VECTOR downto 0);
        y2   : out std_logic_vector(N_BITS_VECTOR downto 0);
        z2   : out std_logic_vector(N_BITS_ANGLE-1 downto 0);
        done : out std_logic);
    end component;

	constant N_BITS_VECTOR : integer := 17;
	constant N_BITS_ANGLE  : integer := 16;
	constant N_ITER        : integer := 15;

	signal clk_tb          : std_logic := '0';

    signal x1_tb           : std_logic_vector(N_BITS_VECTOR-1 downto 0) := std_logic_vector(to_signed(-24772, N_BITS_VECTOR));
	signal y1_tb           : std_logic_vector(N_BITS_VECTOR-1 downto 0) := std_logic_vector(to_signed(-28497, N_BITS_VECTOR));
    signal beta_tb         : signed(N_BITS_ANGLE-1 downto 0) := "0111000101010100"; --159 grados

    signal x2_tb           : std_logic_vector(N_BITS_VECTOR downto 0);
    signal y2_tb           : std_logic_vector(N_BITS_VECTOR downto 0);
    signal done_tb         : std_logic;
    signal start_tb         : std_logic := '0';

begin

    start_tb <= '1' after 5 ns;
    clk_tb <= not clk_tb after 10 ns;

	DUT: cordic
		generic map(N_BITS_VECTOR, N_BITS_ANGLE, N_ITER)
		port map(
            clk   => clk_tb,
            x1    => x1_tb,
            y1    => y1_tb,
            beta  => beta_tb,
            start => start_tb,
            x2    => x2_tb,
            y2    => y2_tb,
            done  => done_tb);
end;