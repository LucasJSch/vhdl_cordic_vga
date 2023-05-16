library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_pixel_gen_tb is
end;

architecture vga_pixel_gen_arch of vga_pixel_gen_tb is
    component vga_pixel_gen is
    port(
        clk: in std_logic;
        -- pixel_x: horizontal address
        -- pixel_y: vertical address
        pixel_x, pixel_y: in std_logic_vector (9 downto 0);
        -- vidon: Enables writing pixels to the screen.
        vidon: in std_logic;
        rgb_data_in : in std_logic_vector(2 downto 0);
        rgb_data_out : out std_logic_vector(2 downto 0));
    end component;

	signal clk_tb   : std_logic := '0';
	signal pixel_x_tb : std_logic_vector(9 downto 0);
	signal pixel_y_tb : std_logic_vector(9 downto 0);
	signal vidon_tb : std_logic := '0';
	signal rgb_data_in_tb  : std_logic_vector(2 downto 0) := "000";
	signal rgb_data_out_tb : std_logic_vector(2 downto 0);

begin

    clk_tb  <= not clk_tb after 25 ns;
    vidon_tb <= '1' after 50 ns, '0' after 450 ns;
    rgb_data_in_tb <= "001" after 50 ns, 
                      "010" after 100 ns, 
                      "011" after 150 ns, 
                      "100" after 200 ns, 
                      "101" after 250 ns, 
                      "110" after 300 ns, 
                      "111" after 350 ns, 
                      "000" after 400 ns, 
                      "001" after 450 ns, 
                      "010" after 500 ns, 
                      "011" after 550 ns;

	DUT: vga_pixel_gen
		port map(
            clk     => clk_tb,
            pixel_x => pixel_x_tb,
            pixel_y => pixel_y_tb,
            vidon => vidon_tb,
            rgb_data_in => rgb_data_in_tb,
            rgb_data_out => rgb_data_out_tb);
end;