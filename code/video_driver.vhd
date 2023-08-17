library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity video_driver is
	generic (
		-- A word's width, measured in bits
		VRAM_BITS_WIDTH : natural := 1;
		-- Number of bits for addresses
		VRAM_ADDR_BITS  : natural := 16);
    port (
		rst        : in std_logic;
		clk        : in std_logic;
		pixel_x    : in unsigned(9 downto 0);
		pixel_y    : in unsigned(9 downto 0);
		data_rd    : in std_logic_vector(VRAM_BITS_WIDTH-1 downto 0);
		red_en_o   : out std_logic;
		green_en_o : out std_logic;
		blue_en_o  : out std_logic;
		addr_rd    : out std_logic_vector(VRAM_ADDR_BITS-1 downto 0));
end video_driver;

architecture Behavioral of video_driver is
	
	signal vram_addr_rd_current, vram_addr_rd_next : std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
	signal pixel_current, pixel_next: std_logic := '0';
	
	begin
	
	process(clk, rst)
	begin
	if(rst='1') then
		vram_addr_rd_current <= "0000000000000000";
		pixel_current <= '0';
    elsif (clk'event and clk='1') then
		vram_addr_rd_current <= vram_addr_rd_next;
		pixel_current <= pixel_next;
    end if;
    end process;

	process(pixel_x, pixel_y, pixel_current, vram_addr_rd_current, data_rd)
	begin
	vram_addr_rd_next <= vram_addr_rd_current;
	pixel_next <= pixel_current;
		if ((to_integer(pixel_y) >= 112) and (to_integer(pixel_y) <= 368) and (to_integer(pixel_x)>= 192) and (to_integer(pixel_x)<= 448)) then
			vram_addr_rd_next <= std_logic_vector(to_unsigned(to_integer(pixel_x)-192,8) & to_unsigned(to_integer(pixel_y)-112,8));
			pixel_next <= data_rd(0);
		else
			vram_addr_rd_next <= "0000000000000000";
			pixel_next <= '0';
		end if;
	end process;
	
	addr_rd <= vram_addr_rd_current;
	red_en_o <= pixel_current;
	green_en_o <= pixel_current;
	blue_en_o <= pixel_current;
	
end Behavioral;
