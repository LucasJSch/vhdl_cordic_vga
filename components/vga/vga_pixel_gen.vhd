library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_pixel_gen is
   port(
      clk: in std_logic;
      -- pixel_x: horizontal address
      -- pixel_y: vertical address
      pixel_x, pixel_y: in std_logic_vector (9 downto 0);
      -- vidon: Enables writing pixels to the screen.
      vidon: in std_logic;
      rgb_data_in : in std_logic_vector(2 downto 0);
      rgb_data_out : out std_logic_vector(2 downto 0));
end vga_pixel_gen;

architecture vga_pixel_gen_arch of vga_pixel_gen is
begin
   process(vidon, rgb_data_in)
   begin
      if vidon = '1' then
         rgb_data_out <= rgb_data_in;
      end if;
   end process;
end vga_pixel_gen_arch;