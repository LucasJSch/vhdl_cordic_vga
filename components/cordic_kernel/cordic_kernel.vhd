library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cordic_kernel is
	generic(
        -- Describes the amount of bits per vector element.
        N_BITS_VECTOR : integer:= 32;
        -- Describes the amount of bits to represent the angle.
        -- 2**(N_BITS_ANGLE-3) --> 45 degrees
        -- 2**(N_BITS_ANGLE-2) --> 90 degrees
        -- 2**(N_BITS_ANGLE-1) --> 180 degrees
        N_BITS_ANGLE : integer:= 18);
    port(
        x_i       : in signed(N_BITS_VECTOR downto 0);
        y_i       : in signed(N_BITS_VECTOR downto 0);
        z_i       : in signed(N_BITS_ANGLE-1 downto 0);
        iteration : in unsigned(N_BITS_ANGLE-1 downto 0);
        atan      : in signed(N_BITS_ANGLE-1 downto 0);
        -- Mode flag
        -- 0: Rotation mode.
        -- 1: Vectoring mod.
        mode      : in std_logic;
        ena       : in std_logic;
        x_o       : out signed(N_BITS_VECTOR downto 0);
        y_o       : out signed(N_BITS_VECTOR downto 0);
        z_o       : out signed(N_BITS_ANGLE-1 downto 0));

end;

architecture iterative_arch of cordic_kernel is

    function TG_MUL(x : signed(N_BITS_VECTOR downto 0); i : unsigned(N_BITS_ANGLE-1 downto 0))
    return signed is
        variable iter_int : integer := to_integer(i);
        variable sign     : std_logic := x(N_BITS_VECTOR);
        variable retval   : signed(N_BITS_VECTOR downto 0);
        variable x_2c     : unsigned(N_BITS_VECTOR downto 0);
        variable x_2c_shifted : std_logic_vector(N_BITS_VECTOR downto 0);
    begin
        x_2c := unsigned(not(std_logic_vector(x))) + to_unsigned(1, N_BITS_VECTOR+1);
        x_2c_shifted := std_logic_vector(shift_right(x_2c, iter_int));
        if sign = '0' then
            retval := signed(shift_right(unsigned(x), iter_int));
        else
            retval := signed(unsigned(not(x_2c_shifted)) + to_unsigned(1, N_BITS_VECTOR+1));
        end if;

        return retval;
    end TG_MUL;

    -- Flag indicating to which side to converge.
    signal d : std_logic;
    signal x_o_aux : signed(N_BITS_VECTOR downto 0);
    signal y_o_aux : signed(N_BITS_VECTOR downto 0);
    signal z_o_aux : signed(N_BITS_ANGLE-1 downto 0);
begin
    process(mode, x_i, y_i, z_i)
    begin
        if mode = '0' then
            if z_i >= to_signed(0, N_BITS_ANGLE) then
                d <= '0';
            else
                d <= '1';
            end if;
        else
            if y_i >= to_signed(0, N_BITS_ANGLE) then
                d <= '1';
            else
                d <= '0';
            end if;
        end if;
    end process;

    x_o_aux <= x_i - TG_MUL(y_i, iteration-1) when d = '0' else
           x_i + TG_MUL(y_i, iteration-1);
    y_o_aux <= y_i + TG_MUL(x_i, iteration-1) when d = '0' else
           y_i - TG_MUL(x_i, iteration-1);
    z_o_aux <= z_i - atan when d = '0' else
           z_i + atan;

    process(ena, x_o_aux, y_o_aux, z_o_aux)
    begin
        if (ena = '1') then
            x_o <= x_o_aux;
            y_o <= y_o_aux;
            z_o <= z_o_aux;
        end if;
    end process;
end;