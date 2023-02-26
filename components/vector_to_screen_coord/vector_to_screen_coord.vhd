library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vector_to_screen_coord is
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

end;

architecture vector_to_screen_coord_arch of vector_to_screen_coord is
    -- TODO: Safek si esta bien esto, esta rara la cuenta.
    -- Preguntar al profesor sobre como funcionan las coordenadas, ya que en el pdf la coordenada (1,0) es mas grande que la  (0,-1)
    -- 153079 - y * 102440 + x * 160
    -- Predefined by screen.
	constant N_BITS_COORD  : integer := 19;

    -- Bits necessary to represent radius with a signed vector.
    constant ROW_OFFSET    : signed(18 downto 0) := to_signed(153079, 19);
    constant ROW_SCALE     : signed(17 downto 0) := to_signed(102440, 18);
    constant COL_SCALE    : signed(8 downto 0) := to_signed(160, 9);

    signal y_scaled_aux    : signed(N_BITS_VECTOR+17 downto 0);
    signal y_scaled        : signed(18 downto 0);
    signal x_scaled_aux    : signed(N_BITS_VECTOR+8 downto 0);
    signal x_scaled        : signed(9 downto 0);
    signal y_offseted      : signed(18 downto 0);
    signal pre_coord       : signed(N_BITS_VECTOR-1 downto 0);

begin
    -- The rasterization is simple: Ignore X component.
    y_scaled_aux <= -zin * ROW_SCALE;
    y_scaled <= y_scaled_aux(y_scaled_aux'length-1 downto y_scaled_aux'length-19);
    y_offseted <=  resize(ROW_OFFSET + y_scaled, 19);
    x_scaled_aux <= yin * COL_SCALE;
    x_scaled <= x_scaled_aux(x_scaled_aux'length-1 downto x_scaled_aux'length-10);
    pre_coord <= resize(x_scaled + y_offseted, N_BITS_VECTOR);
    process(pre_coord)
    begin
        coord <= resize(unsigned(pre_coord), 19);
    end process;
end;
