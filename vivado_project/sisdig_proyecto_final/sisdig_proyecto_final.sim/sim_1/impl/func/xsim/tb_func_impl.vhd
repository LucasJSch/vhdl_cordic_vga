-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
-- Date        : Wed Aug  2 22:05:52 2023
-- Host        : ljsch-IdeaPad-3-15IML05 running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               /home/ljsch/project_2/project_2.sim/sim_1/impl/func/xsim/tb_func_impl.vhd
-- Design      : design_1_wrapper
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_top_level_0_0_top_level is
  port (
    clk : in STD_LOGIC;
    JA4 : out STD_LOGIC
  );
  attribute ANGLE_STEP_INITIAL : integer;
  attribute ANGLE_STEP_INITIAL of design_1_top_level_0_0_top_level : entity is 1;
  attribute ANGLE_WIDTH : integer;
  attribute ANGLE_WIDTH of design_1_top_level_0_0_top_level : entity is 10;
  attribute COORDS_WIDTH : integer;
  attribute COORDS_WIDTH of design_1_top_level_0_0_top_level : entity is 8;
  attribute CORDIC_OFFSET : integer;
  attribute CORDIC_OFFSET of design_1_top_level_0_0_top_level : entity is 4;
  attribute CORDIC_STAGES : integer;
  attribute CORDIC_STAGES of design_1_top_level_0_0_top_level : entity is 8;
  attribute CORDIC_WIDTH : integer;
  attribute CORDIC_WIDTH of design_1_top_level_0_0_top_level : entity is 12;
  attribute CYCLES_TO_WAIT : integer;
  attribute CYCLES_TO_WAIT of design_1_top_level_0_0_top_level : entity is 4000;
  attribute CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH : integer;
  attribute CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH of design_1_top_level_0_0_top_level : entity is 10;
  attribute DPRAM_ADDR_BITS : integer;
  attribute DPRAM_ADDR_BITS of design_1_top_level_0_0_top_level : entity is 16;
  attribute DPRAM_DATA_BITS_WIDTH : integer;
  attribute DPRAM_DATA_BITS_WIDTH of design_1_top_level_0_0_top_level : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_top_level_0_0_top_level : entity is "top_level";
  attribute RAM_ADDRESS_WIDTH : integer;
  attribute RAM_ADDRESS_WIDTH of design_1_top_level_0_0_top_level : entity is 15;
  attribute RAM_DATA_WIDTH : integer;
  attribute RAM_DATA_WIDTH of design_1_top_level_0_0_top_level : entity is 8;
  attribute UART_BYTES_TO_RECEIVE : integer;
  attribute UART_BYTES_TO_RECEIVE of design_1_top_level_0_0_top_level : entity is 32768;
  attribute UART_COORDS_WIDTH : integer;
  attribute UART_COORDS_WIDTH of design_1_top_level_0_0_top_level : entity is 8;
end design_1_top_level_0_0_top_level;

architecture STRUCTURE of design_1_top_level_0_0_top_level is
  signal \^clk\ : STD_LOGIC;
begin
  JA4 <= \^clk\;
  \^clk\ <= clk;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_top_level_0_0 is
  port (
    clk : in STD_LOGIC;
    JA4 : out STD_LOGIC
  );
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_top_level_0_0 : entity is "design_1_top_level_0_0,top_level,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_top_level_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_top_level_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_top_level_0_0 : entity is "top_level,Vivado 2018.3";
end design_1_top_level_0_0;

architecture STRUCTURE of design_1_top_level_0_0 is
  attribute ANGLE_STEP_INITIAL : integer;
  attribute ANGLE_STEP_INITIAL of U0 : label is 1;
  attribute ANGLE_WIDTH : integer;
  attribute ANGLE_WIDTH of U0 : label is 10;
  attribute COORDS_WIDTH : integer;
  attribute COORDS_WIDTH of U0 : label is 8;
  attribute CORDIC_OFFSET : integer;
  attribute CORDIC_OFFSET of U0 : label is 4;
  attribute CORDIC_STAGES : integer;
  attribute CORDIC_STAGES of U0 : label is 8;
  attribute CORDIC_WIDTH : integer;
  attribute CORDIC_WIDTH of U0 : label is 12;
  attribute CYCLES_TO_WAIT : integer;
  attribute CYCLES_TO_WAIT of U0 : label is 4000;
  attribute CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH : integer;
  attribute CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH of U0 : label is 10;
  attribute DPRAM_ADDR_BITS : integer;
  attribute DPRAM_ADDR_BITS of U0 : label is 16;
  attribute DPRAM_DATA_BITS_WIDTH : integer;
  attribute DPRAM_DATA_BITS_WIDTH of U0 : label is 1;
  attribute RAM_ADDRESS_WIDTH : integer;
  attribute RAM_ADDRESS_WIDTH of U0 : label is 15;
  attribute RAM_DATA_WIDTH : integer;
  attribute RAM_DATA_WIDTH of U0 : label is 8;
  attribute UART_BYTES_TO_RECEIVE : integer;
  attribute UART_BYTES_TO_RECEIVE of U0 : label is 32768;
  attribute UART_COORDS_WIDTH : integer;
  attribute UART_COORDS_WIDTH of U0 : label is 8;
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 10000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
begin
U0: entity work.design_1_top_level_0_0_top_level
     port map (
      JA4 => JA4,
      clk => clk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    JA4 : out STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute hw_handoff : string;
  attribute hw_handoff of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  attribute syn_black_box : string;
  attribute syn_black_box of top_level_0 : label is "TRUE";
  attribute x_core_info : string;
  attribute x_core_info of top_level_0 : label is "top_level,Vivado 2018.3";
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_clk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000";
begin
top_level_0: entity work.design_1_top_level_0_0
     port map (
      JA4 => JA4,
      clk => clk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    JA4 : out STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_wrapper : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of design_1_wrapper : entity is "258e4329";
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  signal JA4_OBUF : STD_LOGIC;
  signal clk_IBUF : STD_LOGIC;
  attribute hw_handoff : string;
  attribute hw_handoff of design_1_i : label is "design_1.hwdef";
begin
pullup_JA4inst: unisim.vcomponents.PULLUP
    port map (
      O => JA4
    );
JA4_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => JA4_OBUF,
      O => JA4
    );
clk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => clk,
      O => clk_IBUF
    );
design_1_i: entity work.design_1
     port map (
      JA4 => JA4_OBUF,
      clk => clk_IBUF
    );
end STRUCTURE;
