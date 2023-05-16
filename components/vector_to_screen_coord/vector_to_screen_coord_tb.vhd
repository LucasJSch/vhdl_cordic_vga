library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vector_to_screen_coord_tb is
end;

architecture vector_to_screen_coord_arch of vector_to_screen_coord_tb is
    component vector_to_screen_coord is
    generic(
        -- Describes the amount of bits per vector element.
        N_BITS_VECTOR : integer:= 32);
    port(
        -- 2**(N_BITS_VECTOR-2) -->  1
        -- 2**(N_BITS_VECTOR-1) --> -1
        -- Components of abstract vector.
        xin   : in signed(N_BITS_VECTOR-1 downto 0);
        yin   : in signed(N_BITS_VECTOR-1 downto 0);
        zin   : in signed(N_BITS_VECTOR-1 downto 0);
        -- Coordinates of screen pixel.
        coord  : out unsigned(19-1 downto 0));
    end component;

	constant N_BITS_VECTOR : integer := 30;

	signal xin_tb   : signed(N_BITS_VECTOR-1 downto 0) := to_signed(0, N_BITS_VECTOR);
	signal yin_tb   : signed(N_BITS_VECTOR-1 downto 0) := to_signed(0, N_BITS_VECTOR);
	signal zin_tb   : signed(N_BITS_VECTOR-1 downto 0) := to_signed(0, N_BITS_VECTOR);
	signal coord_tb : unsigned(19-1 downto 0);

begin

    -- The rasterization in the module is:
    -- (x,y,z) --> (y,z). Thus, the X component doesn't matter.

    yin_tb  <= to_signed(2**29-1, N_BITS_VECTOR) after 1 ns, 
               to_signed(0, N_BITS_VECTOR) after 1.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 1.6 ns, 
               to_signed(2**29-1, N_BITS_VECTOR) after 2 ns, 
               to_signed(0, N_BITS_VECTOR) after 2.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 2.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 3 ns, 
               to_signed(0, N_BITS_VECTOR) after 3.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 3.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 4 ns, 
               to_signed(0, N_BITS_VECTOR) after 4.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 4.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 5 ns, 
               to_signed(0, N_BITS_VECTOR) after 5.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 5.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 6 ns, 
               to_signed(0, N_BITS_VECTOR) after 6.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 6.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 7 ns, 
               to_signed(0, N_BITS_VECTOR) after 7.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 7.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 8 ns, 
               to_signed(0, N_BITS_VECTOR) after 8.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 8.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 9 ns, 
               to_signed(0, N_BITS_VECTOR) after 9.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 9.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 10 ns, 
               to_signed(0, N_BITS_VECTOR) after 10.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 10.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 11 ns, 
               to_signed(0, N_BITS_VECTOR) after 11.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 11.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 12 ns, 
               to_signed(0, N_BITS_VECTOR) after 12.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 12.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 13 ns, 
               to_signed(0, N_BITS_VECTOR) after 13.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 13.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 14 ns, 
               to_signed(0, N_BITS_VECTOR) after 14.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 14.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 15 ns, 
               to_signed(0, N_BITS_VECTOR) after 15.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 15.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 16 ns, 
               to_signed(0, N_BITS_VECTOR) after 16.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 16.6 ns,
               to_signed(2**29-1, N_BITS_VECTOR) after 17 ns, 
               to_signed(0, N_BITS_VECTOR) after 17.3 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 17.6 ns;
               

    zin_tb  <= to_signed(2**4, N_BITS_VECTOR) after 1 ns, 
               to_signed(2**7, N_BITS_VECTOR) after 2 ns, 
               to_signed(2**10, N_BITS_VECTOR) after 3 ns, 
               to_signed(2**13, N_BITS_VECTOR) after 4 ns, 
               to_signed(2**16, N_BITS_VECTOR) after 5 ns, 
               to_signed(2**20, N_BITS_VECTOR) after 6 ns, 
               to_signed(2**24, N_BITS_VECTOR) after 7 ns, 
               to_signed(2**28, N_BITS_VECTOR) after 8 ns, 
               to_signed(2**29-1, N_BITS_VECTOR) after 9 ns, 
               to_signed(-2**29, N_BITS_VECTOR) after 10 ns,
               to_signed(-2**7, N_BITS_VECTOR) after 11 ns, 
               to_signed(-2**10, N_BITS_VECTOR) after 12 ns, 
               to_signed(-2**13, N_BITS_VECTOR) after 13 ns, 
               to_signed(-2**16, N_BITS_VECTOR) after 14 ns, 
               to_signed(-2**20, N_BITS_VECTOR) after 15 ns, 
               to_signed(-2**24, N_BITS_VECTOR) after 16 ns, 
               to_signed(-2**28, N_BITS_VECTOR) after 17 ns;

	DUT: vector_to_screen_coord
		generic map(N_BITS_VECTOR)
		port map(
            xin    => xin_tb,
            yin    => yin_tb,
            zin    => zin_tb,
            coord  => coord_tb);
end;