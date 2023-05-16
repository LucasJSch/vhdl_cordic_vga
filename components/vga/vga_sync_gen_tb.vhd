library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_sync_gen_tb is
end;

architecture vga_sync_gen_arch of vga_sync_gen_tb is
    component vga_sync_gen is
    port(
        clk, reset: in std_logic;
        -- hsync, vsync: Digital signals that control the analogic hsync
        -- and vsync signals that move the cathode ray tube.
        hsync, vsync: out std_logic;
        -- vidon: Enables writing pixels to the screen.
        -- p_tick: Indicates a new start of the horizontal sync. (25 MHz tick)
        vidon, p_tick: out std_logic;
        -- pixel_x: horizontal address
        -- pixel_y: vertical address
        pixel_x, pixel_y: out std_logic_vector (9 downto 0));
    end component;

	signal clk_tb   : std_logic := '0';
	signal reset_tb : std_logic := '1';
	signal hsync_tb : std_logic;
	signal vsync_tb : std_logic;
	signal vidon_tb : std_logic;
	signal p_tick_tb : std_logic;
	signal pixel_x_tb : std_logic_vector(9 downto 0);
	signal pixel_y_tb : std_logic_vector(9 downto 0);

begin

    reset_tb <= '0' after 20 ns;
    clk_tb  <= not clk_tb after 10 ns;

	DUT: vga_sync_gen
		port map(
            clk     => clk_tb,
            reset   => reset_tb,
            hsync   => hsync_tb,
            vsync   => vsync_tb,
            vidon   => vidon_tb,
            p_tick  => p_tick_tb,
            pixel_x => pixel_x_tb,
            pixel_y => pixel_y_tb);
end;