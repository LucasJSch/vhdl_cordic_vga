library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory_mock_rgb_tb is
end;

architecture memory_mock_rgb_tb_arch of memory_mock_rgb_tb is
    component memory_mock_rgb is
        generic(
            PPL  : natural := 640; -- Pixels per line
            LPS : natural := 480); -- Lines per screen
        port(
            addr_x_i : in std_logic_vector(9 downto 0);
            addr_y_i : in std_logic_vector(9 downto 0);
            data_o : out std_logic);
    end component memory_mock_rgb;

	signal clk_tb     : std_logic := '0';

    signal addr_x_i_reg : std_logic_vector(9 downto 0) := (others => '0');
    signal addr_y_i_reg : std_logic_vector(9 downto 0) := (others => '0');
    signal data_o_reg : std_logic;

begin

    clk_tb  <= not clk_tb after 10 ns;
    addr_y_i_reg <= std_logic_vector(unsigned(addr_y_i_reg) + to_unsigned(integer(1),10)) after 10 ps;
    addr_x_i_reg <= std_logic_vector(unsigned(addr_x_i_reg) + to_unsigned(integer(1),10)) after 20480 ns;

    DUT: memory_mock_rgb
    port map(
        addr_x_i => addr_x_i_reg,
        addr_y_i => addr_y_i_reg,
        data_o   => data_o_reg);
end;