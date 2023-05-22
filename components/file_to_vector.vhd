library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity file_to_vector is
end entity;

architecture file_to_vector_arch of file_to_vector is
	constant N_BITS_VECTOR : integer := 17;

    -- Bits tolerance to verify correctness of result.
    constant TOLERANCE     : signed := to_signed(10, N_BITS_VECTOR+1);
	
    -- Remember to remove header line from file, if present.
	file data_file : text open read_mode is "/home/ljsch/FIUBA/SisDig/repo_TP_final/vhdl_cordic_vga/testing/float_coordenadas.txt";

	signal clk_tb: std_logic := '0';
    -- Clock for DUT since it needs a few clk cycles to finish its work.
	signal clk_tb_internal: std_logic := '0';
	signal xi_file: signed(N_BITS_VECTOR-1 downto 0):= (others => '0');
	signal yi_file: signed(N_BITS_VECTOR-1 downto 0):= (others => '0');
	signal zi_file: signed(N_BITS_VECTOR-1 downto 0):= (others => '0');

	signal xi_tb: std_logic_vector(N_BITS_VECTOR-1 downto 0);
	signal yi_tb: std_logic_vector(N_BITS_VECTOR-1 downto 0);
	signal zi_tb: std_logic_vector(N_BITS_VECTOR-1 downto 0);
	
		
begin
	clk_tb      <= not clk_tb after 10 ns;

	test_sequence: process
		variable l: line;
		variable ch: character:= ',';
		variable aux: integer;
	begin
		while not(endfile(data_file)) loop 		-- si se quiere leer de stdin se pone "input"
			wait until rising_edge(clk_tb);
			readline(data_file, l); 			-- se lee una linea del archivo de valores de prueba
			read(l, aux); 				    	-- se extrae un entero de la linea
			
			xi_file <= to_signed(aux, N_BITS_VECTOR); -- se carga el valor del operando A
			read(l, ch); 					    -- se lee un caracter (es el espacio)
			read(l, aux); 					    -- se lee otro entero de la linea
			
			yi_file <= to_signed(aux, N_BITS_VECTOR); -- se carga el valor del operando B
			read(l, ch); 					    -- se lee otro caracter (es el espacio)
			read(l, aux); 					    -- se lee otro entero

			zi_file <= to_signed(aux, N_BITS_VECTOR); -- se carga el valor del operando B
		end loop;
	
		file_close(data_file); -- cierra el archivo
	end process test_sequence;
	
	xi_tb <= std_logic_vector(xi_file);
	yi_tb <= std_logic_vector(yi_file);
	zi_tb <= std_logic_vector(zi_file);

end architecture file_to_vector_arch;