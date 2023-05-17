library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_tb is
end;

architecture vga_arch of vga_tb is
    component vga is
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
    end component;

    component memory_mock_rgb is
        generic(
            PPL  : natural := 640; -- Pixels per line
            LPS : natural := 480); -- Lines per screen
        port(
            addr_x_i : in std_logic_vector(9 downto 0);
            addr_y_i : in std_logic_vector(9 downto 0);
            data_o : out std_logic);
    end component memory_mock_rgb;

	signal clk_tb     : std_logic := '0';
	signal reset_tb   : std_logic := '1';
	signal rgb_input_tb  : std_logic_vector(2 downto 0) := "000";
	signal rgb_output_tb : std_logic_vector(2 downto 0);
	signal hsync_tb : std_logic;
	signal vsync_tb : std_logic;

    signal addr_x_i_reg : std_logic_vector(9 downto 0);
    signal addr_y_i_reg : std_logic_vector(9 downto 0);
    signal data_o_reg : std_logic;

begin

    clk_tb  <= not clk_tb after 10 ps;
    reset_tb <= '0' after 21 ps;

	DUT: vga
    port map(
        clk        => clk_tb,
        reset      => reset_tb,
        rgb_input  => rgb_input_tb,
        rgb_output => rgb_output_tb,
        hsync      => hsync_tb,
        vsync      => vsync_tb,
        -- These are swapped so that I can see changes.
        -- Try to swap them again and you won't see changes in output because of simulation time limits.
        pixel_x    => addr_y_i_reg,
        pixel_y    => addr_x_i_reg);

    memory_mock: memory_mock_rgb
    port map(
        addr_x_i => addr_x_i_reg,
        addr_y_i => addr_y_i_reg,
        data_o   => data_o_reg);
end;