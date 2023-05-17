library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity memory_mock_rgb is
	generic(
		PPL  : natural := 640; -- Pixels per line
		LPS : natural := 480); -- Lines per screen
	port(
		addr_x_i : in std_logic_vector(9 downto 0);
		addr_y_i : in std_logic_vector(9 downto 0);
		data_o : out std_logic);
end entity memory_mock_rgb;


architecture memory_mock_rgb_arch of memory_mock_rgb is

	type rom_type is array (natural range <>) of std_logic_vector(LPS-1 downto 0);

	function atan (constant index : natural) return std_logic_vector is
		variable retval : std_logic_vector(LPS-1 downto 0) := (others => '0');
    begin
			retval(LPS-1 downto LPS-8) := "11110101";
			retval(7 downto 0) := "10101111";
		return
		retval;
        --std_logic_vector(to_unsigned(integer((2**19) - 1), LPS));
	end;

	signal rom : rom_type(0 to PPL-1);
	signal debug : std_logic_vector(1 downto 0) := "00";

begin
	Load_ROM : for i in 0 to PPL-1 generate
		rom(i) <= atan(i);
	end generate Load_ROM;
    
	process(addr_x_i, addr_y_i)
	begin
		if (unsigned(addr_x_i) > to_unsigned(PPL-1, 10) or unsigned(addr_y_i) > to_unsigned(LPS-1, 10)) then
			data_o <= '0';
			debug <= "10";
		else
			data_o <= rom(to_integer(unsigned(addr_x_i)))(to_integer(unsigned(addr_y_i)));
			debug <= "11";
		end if;
	end process;
end memory_mock_rgb_arch;
