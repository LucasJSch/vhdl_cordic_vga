library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rotator_pulsator_tb is
end;

architecture rotator_pulsator_arch of rotator_pulsator_tb is
    component rotator_pulsator is
    generic(
        -- Describes the amount of bits per vector element.
        N_BITS_ANGLE : integer:= 8);
    port(
        clk   : in std_logic;
        p     : in signed(1 downto 0);
        angle : out signed(N_BITS_ANGLE-1 downto 0));
    end component;

	constant N_BITS_ANGLE : integer := 8;

	signal clk_tb   : std_logic := '0';
    signal p_tb     : signed(1 downto 0) := "00";
	signal angle_tb : signed(N_BITS_ANGLE-1 downto 0);

begin

    clk_tb <= not clk_tb after 10 ns;
    p_tb <= "01" after 10 ns, "00" after 100 ns, "10" after 110 ns, "11" after 150 ns, "01" after 170 ns, "10" after 200 ns;

	DUT: rotator_pulsator
		generic map(N_BITS_ANGLE)
		port map(
            clk   => clk_tb,
            p    => p_tb,
            angle    => angle_tb);
end;