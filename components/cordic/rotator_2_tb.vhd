library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rotator_tb is
end;

architecture rotator_arch of rotator_tb is
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
	constant N_BITS_ANGLE  : integer := 10;
	constant N_ITER        : integer := 15;

	signal clk_tb          : std_logic := '0';

    signal x0_tb           : signed(N_BITS_VECTOR-1 downto 0) := to_signed(19381, N_BITS_VECTOR);
	signal y0_tb           : signed(N_BITS_VECTOR-1 downto 0) := to_signed(47755, N_BITS_VECTOR);
	signal z0_tb           : signed(N_BITS_VECTOR-1 downto 0) := to_signed(4803, N_BITS_VECTOR);

    signal angle_X_tb         : signed(N_BITS_ANGLE-1 downto 0) := to_signed(166, N_BITS_ANGLE);
    signal angle_Y_tb         : signed(N_BITS_ANGLE-1 downto 0) := to_signed(70, N_BITS_ANGLE);
    signal angle_Z_tb         : signed(N_BITS_ANGLE-1 downto 0) := to_signed(99, N_BITS_ANGLE);

    signal x_tb           : signed(N_BITS_VECTOR-1 downto 0);
    signal y_tb           : signed(N_BITS_VECTOR-1 downto 0);
    signal z_tb           : signed(N_BITS_VECTOR-1 downto 0);

begin
    clk_tb <= not clk_tb after 10 ns;

	DUT: rotator
		generic map(N_BITS_VECTOR, N_BITS_ANGLE, N_ITER)
		port map(
            clk   => clk_tb,
            x0    => x0_tb,
            y0    => y0_tb,
            z0    => z0_tb,
            angle_x  => angle_X_tb,
            angle_y  => angle_Y_tb,
            angle_z  => angle_z_tb,
            x    => x_tb,
            y    => y_tb,
            z    => z_tb);
end;