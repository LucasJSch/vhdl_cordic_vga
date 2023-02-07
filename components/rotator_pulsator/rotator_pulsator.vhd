library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Angle calculator, based on two pulsator.
-- There's one pulsator for positive angles, and one for negatives.
-- When p(0) is pulsated, ANGLE_DIFF is added to the accumulated angle.
-- When p(1) is pulsated, ANGLE_DIFF is substracted to the accumulated angle.
entity rotator_pulsator is
    generic(
        -- Describes the amount of bits per vector element.
        N_BITS_ANGLE : integer:= 8);
    port(
        clk   : in std_logic;
        p     : in signed(1 downto 0);
        angle : out signed(N_BITS_ANGLE-1 downto 0));

end;

architecture rotator_pulsator_arch of rotator_pulsator is
    
    constant ANGLE_DIFF : signed(N_BITS_ANGLE-1 downto 0) := "00000001";

    signal angle_aux : signed(N_BITS_ANGLE-1 downto 0) := (others => '0');
    
begin
        process(clk)
        begin
            if rising_edge(clk) then
                angle <= angle_aux;
            end if;
        end process;

        process(p)
        begin
            case p is
                when "10" => angle_aux <= angle_aux + ANGLE_DIFF;
                when "01" => angle_aux <= angle_aux - ANGLE_DIFF;
                when others => null;
              end case;
        end process;
end;
