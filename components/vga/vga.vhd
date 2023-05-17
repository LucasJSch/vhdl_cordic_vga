library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
   port(
      clk        : in std_logic;
      reset      : in std_logic;
      rgb_input  : in std_logic_vector(2 downto 0);
      rgb_output : out std_logic_vector(2 downto 0);
      hsync      : out std_logic;
      vsync      : out std_logic;
      -- These two are to control which coordinate to read.
      pixel_x    : out std_logic_vector(9 downto 0);  -- 800 pixels max
      pixel_y    : out std_logic_vector(9 downto 0)); -- 524 pixels max
end vga;

architecture vga_arch of vga is
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

	signal vidon_reg   : std_logic;
	signal pixel_x_reg : std_logic_vector(9 downto 0);
	signal pixel_y_reg : std_logic_vector(9 downto 0);
	signal p_tick_reg  : std_logic;
	signal hsync_reg   : std_logic;
	signal vsync_reg   : std_logic;

begin
    sync_gen: vga_sync_gen
    port map(
        clk     => clk,
        reset   => reset,
        hsync   => hsync_reg,
        vsync   => vsync_reg,
        vidon   => vidon_reg,
        p_tick  => p_tick_reg,
        pixel_x => pixel_x_reg,
        pixel_y => pixel_y_reg);

    pixel_gen: vga_pixel_gen
    port map(
        clk     => clk,
        pixel_x => pixel_x_reg,
        pixel_y => pixel_y_reg,
        vidon => vidon_reg,
        rgb_data_in => rgb_input,
        rgb_data_out => rgb_output);

    hsync <= hsync_reg;
    vsync <= vsync_reg;
    pixel_x <= pixel_x_reg;
    pixel_y <= pixel_y_reg;

end vga_arch;