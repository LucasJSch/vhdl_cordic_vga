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
        xout  : out unsigned(19-1 downto 0);
        yout  : out unsigned(19-1 downto 0));

end;

architecture vector_to_screen_coord_arch of vector_to_screen_coord is

    -- Predefined by screen.
	constant N_BITS_COORD  : integer := 19;

    -- Bits necessary to represent radius with a signed vector.
    constant N_BITS_RADIUS : integer := 10;
    constant CIRCLE_RADIUS : signed(N_BITS_RADIUS-1 downto 0) := to_signed(374, N_BITS_RADIUS);
    -- Scaling constant for vector components.
    constant COMPONENT_SCALING : signed(N_BITS_VECTOR-1 downto 0) := 
                                 to_signed(integer(1/(2**(N_BITS_VECTOR-2))), N_BITS_VECTOR);


    function signed_mul(a : signed(N_BITS_VECTOR-1 downto 0); b : signed(N_BITS_VECTOR-1 downto 0))
    return signed is
        variable sign_bit : std_logic;
        variable retval   : signed(N_BITS_VECTOR-1 downto 0);
        variable aux_mul  : signed(N_BITS_VECTOR*2-1 downto 0);
    begin
        aux_mul := a * b;
        if (a(a'length-1) = '0' and b(b'length-1) = '0') or (a(a'length-1) = '1' and b(b'length-1) = '1') then
            sign_bit := '0';
        else
            sign_bit := '1';
        end if;
        -- TODO: Not sure if the following line is ok.
        retval := sign_bit & aux_mul((N_BITS_VECTOR*2)-3 downto N_BITS_VECTOR-1);
        return retval;
    end signed_mul;

    function transform_component_to_coord(x : signed(N_BITS_VECTOR-1 downto 0), y : signed(N_BITS_VECTOR-1 downto 0))
    return signed is
        constant BEGIN_X_COORD : integer := 153119; 
        constant BEGIN_Y_COORD : integer := 255519; 
        variable scaled_component : signed(N_BITS_VECTOR+N_BITS_RADIUS-1 downto 0);
        variable coordinate       : unsigned(N_BITS_COORD-1 downto 0);
    begin
        scaled_component := signed_mul(yin, COMPONENT_SCALING);
        coordinate := BEGIN_COORD + (scaled_component + CIRCLE_RADIUS)
        return aux(aux'length-1 downto aux'length-1-);
    end transform_component_to_coord;

begin
    -- The rasterization is simple: Ignore X component.
    xout <= transform_component_to_coord(yin);
    yout <= transform_component_to_coord(zin);
end;
