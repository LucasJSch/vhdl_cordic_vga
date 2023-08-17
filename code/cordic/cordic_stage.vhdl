library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic_stage is
    generic (
        COORDS_WIDTH : integer := 10;
        ANGLE_WIDTH  : integer := 22;
        STEP_WIDTH   : integer := 4);
    port (
        X_in, Y_in : in signed(COORDS_WIDTH-1 downto 0);
        Z_in     : in signed(ANGLE_WIDTH-1 downto 0);
        atan   : in signed(ANGLE_WIDTH-1 downto 0);
        step   : in unsigned(STEP_WIDTH-1 downto 0);
        X_out, Y_out : out signed(COORDS_WIDTH-1 downto 0);
        Z_out     : out signed(ANGLE_WIDTH-1 downto 0));
end entity cordic_stage;

architecture behavioral of cordic_stage is

    -- Buffer signals
    signal Xshifted: signed(COORDS_WIDTH-1 downto 0) := ( others => '0');
    signal Yshifted: signed(COORDS_WIDTH-1 downto 0) := ( others => '0');
    signal sigma: std_logic := '0';

begin

    Xshifted <= shift_right(X_in, to_integer(step));
    Yshifted <= shift_right(Y_in, to_integer(step));
    sigma <= Z_in(ANGLE_WIDTH-1);

    X_out <= X_in - Yshifted   when sigma = '0' else
             X_in + Yshifted;
    Y_out <= Y_in + Xshifted   when sigma = '0' else
             Y_in - Xshifted;
    Z_out <= Z_in - atan       when sigma = '0' else
             Z_in + atan;                       

end architecture behavioral;

