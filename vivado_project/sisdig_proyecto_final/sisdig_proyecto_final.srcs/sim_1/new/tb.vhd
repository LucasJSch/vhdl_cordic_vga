----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2023 09:57:52 PM
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component top_level is
    generic (
        -- RAM Single Port (IP Core Generated)
        constant RAM_DATA_WIDTH		: integer := 8;
        constant RAM_ADDRESS_WIDTH	: integer := 16; --32 kBytes de RAM
        constant CYCLES_TO_WAIT		: integer := 4000;
        constant UART_BYTES_TO_RECEIVE	: natural := 32768;
        -- CORDIC Constants
        constant COORDS_WIDTH: integer := 8;
        constant ANGLE_WIDTH: integer := 10;
        constant CORDIC_STAGES: integer := 8;
        constant CORDIC_WIDTH: integer := 12;
        constant CORDIC_OFFSET: integer := 4;
        constant ANGLE_STEP_INITIAL: natural := 1;  
        constant CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH: natural := 10;
        -- Dual Port RAM
        constant DPRAM_ADDR_BITS: natural 	:= 16; -- 8 KBytes 
        constant DPRAM_DATA_BITS_WIDTH: natural := 1
    );
    port (
        -- VGA signals (16I/OS2 : VGA Module)
        clk  :   in std_logic;
        clk_wiz  :   in std_logic;
        rst  :   in std_logic;
        wiz_rst : out std_logic;
        hs_tl, vs_tl    :   out std_logic;
        red_out_tl  :	out std_logic_vector(2 downto 0);
        grn_out_tl  :   out std_logic_vector(2 downto 0);
        blu_out_tl	:	out std_logic_vector(1 downto 0);
        -- BUTTONS (8I/OS2 : 4x4 button Matrix)
        btn_x1: in std_logic;
        btn_x2: in std_logic;
        btn_y1: in std_logic;
        btn_y2: in std_logic;
        btn_z1: in std_logic
    );
end component;

signal clk_tb : std_logic := '1';
signal clk_wiz_tb : std_logic;
signal rst_tb : std_logic := '1';
signal wiz_rst_tb : std_logic;
signal rx_tb : std_logic := '1';
signal tx_tb : std_logic;
signal hs_tb : std_logic;
signal vs_tb : std_logic;
signal red_out_tb : std_logic_vector(2 downto 0);
signal grn_out_tb : std_logic_vector(2 downto 0);
signal blu_out_tb : std_logic_vector(1 downto 0);
signal btn_x1_tb : std_logic := '0';
signal btn_y1_tb : std_logic := '0';
signal btn_z1_tb : std_logic := '0';

begin
    clk_tb <= not clk_tb after 10 us;
    clk_wiz_tb <= clk_tb;
    rst_tb <= '0' after 5 ns, '1' after 1 ns;
    btn_x1_tb <= '1' after 20 us, '0' after 30 sec;
    btn_y1_tb <= '1' after 20 us, '0' after 30 sec;
    btn_z1_tb <= '1' after 20 us, '0' after 30 sec;

    dut : top_level
    port map (
        clk => clk_tb,
        clk_wiz => clk_wiz_tb,
        rst => rst_tb,
        wiz_rst => wiz_rst_tb,
        hs_tl => hs_tb,
        vs_tl => vs_tb,
        red_out_tl => red_out_tb, 
        grn_out_tl => grn_out_tb,
        blu_out_tl => blu_out_tb,
        btn_x1 => btn_x1_tb,
        btn_x2 => '0',
        btn_y1 => btn_y1_tb,
        btn_y2 => '0',
        btn_z1 => btn_z1_tb
    );

end Behavioral;
