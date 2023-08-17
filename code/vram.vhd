library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vram is
	generic (
		VRAM_BITS_WIDTH : natural := 1; 
		VRAM_ADDR_BITS  : natural := 16);
	port (
		rst     : in std_logic;
		clk     : in std_logic;
		data_wr : in std_logic_vector(VRAM_BITS_WIDTH-1 downto 0);
		addr_wr : in std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
		ena_wr  : in std_logic;
		addr_rd : in std_logic_vector(VRAM_ADDR_BITS-1 downto 0);
		data_rd : out std_logic_vector(VRAM_BITS_WIDTH-1 downto 0));
end vram;


architecture rtl of vram is
	-- Array para la memoria
	subtype t_word is std_logic_vector(VRAM_BITS_WIDTH-1 downto 0);
	type t_memory is array(2**VRAM_ADDR_BITS-1 downto 0) of t_word;
	signal ram : t_memory;
	-- Address casting
	signal rd_pointer : integer range 0 to 2**VRAM_ADDR_BITS-1;
	signal wr_pointer : integer range 0 to 2**VRAM_ADDR_BITS-1;
	begin
	-- Address casting
	rd_pointer <= to_integer(unsigned(addr_rd));
	wr_pointer <= to_integer(unsigned(addr_wr));
	-- Write
	process(clk)
		begin
		if clk='1' and clk'event then
			if ena_wr='1' then
				ram(wr_pointer) <= data_wr;
			end if;
		end if;
	end process;
	-- Read
	process(clk)
		begin
		if clk='1' and clk'event then
			data_rd <= ram(rd_pointer);
		end if;
	end process;
end architecture;