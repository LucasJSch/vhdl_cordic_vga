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
        clk  : in std_logic;
        -- Components of abstract vector.
        xin   : in signed(N_BITS_VECTOR-1 downto 0);
        yin   : in signed(N_BITS_VECTOR-1 downto 0);
        zin   : in signed(N_BITS_VECTOR-1 downto 0);
        -- X and Y coordinates of screen pixels.
        coord  : out unsigned(19-1 downto 0));

end;

architecture vector_to_screen_coord_arch of vector_to_screen_coord is
    -- TODO: Safek si esta bien esto, esta rara la cuenta.
    -- Preguntar al profesor sobre como funcionan las coordenadas, ya que en el pdf la coordenada (1,0) es mas grande que la  (0,-1)
    -- 153079 - y * 102440 + x * 160
    -- Predefined by screen.
	constant N_BITS_COORD  : integer := 19;

    -- Bits necessary to represent radius with a signed vector.
    constant ROW_OFFSET    : signed(N_BITS_VECTOR-1 downto 0) := to_signed(153079, N_BITS_VECTOR);
    constant ROW_SCALE     : signed(N_BITS_VECTOR-1 downto 0) := to_signed(102440, N_BITS_VECTOR);
    constant COL_OFFSET    : signed(N_BITS_VECTOR-1 downto 0) := to_signed(160, N_BITS_VECTOR);

    signal y_scaled        : signed(N_BITS_VECTOR downto 0);
    signal y_offseted      : signed(N_BITS_VECTOR downto 0);
    signal x_scaled        : signed(N_BITS_VECTOR downto 0);
    signal pre_coord       : signed(N_BITS_VECTOR downto 0);

    function signed_mul(a : signed(N_BITS_VECTOR-1 downto 0); b : signed(N_BITS_VECTOR-1 downto 0))
    return signed is
        variable sign_bit : std_logic;
        variable retval   : signed(N_BITS_VECTOR downto 0);
        variable aux_mul  : signed(N_BITS_VECTOR*2-1 downto 0);
    begin
        aux_mul := a * b;
        if (a(a'length-1) = '0' and b(b'length-1) = '0') or (a(a'length-1) = '1' and b(b'length-1) = '1') then
            sign_bit := '0';
        else
            sign_bit := '1';
        end if;
        retval := sign_bit & aux_mul(N_BITS_VECTOR*2-2 downto N_BITS_VECTOR-1);
        return retval;
    end signed_mul;

begin
    -- The rasterization is simple: Ignore X component.
    -- TODO: Test if computation is correct.
    y_scaled <= -signed_mul(yin, ROW_SCALE);
    y_offseted <=  ROW_OFFSET + y_scaled;
    x_scaled <= signed_mul(xin, COL_OFFSET);
    pre_coord <= x_scaled + y_offseted;
    process(pre_coord)
    begin
        coord <= unsigned(pre_coord(N_BITS_VECTOR downto N_BITS_VECTOR-18));
    end process;
end;
