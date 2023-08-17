--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
--Date        : Sun Aug  6 18:56:29 2023
--Host        : ljsch-IdeaPad-3-15IML05 running 64-bit Ubuntu 20.04.6 LTS
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    JA1 : out STD_LOGIC;
    JA4 : out STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_board_cnt=3,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_clk_wiz_0_0 is
  port (
    resetn : in STD_LOGIC;
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component design_1_clk_wiz_0_0;
  component design_1_top_level_0_0 is
  port (
    clk : in STD_LOGIC;
    clk_wiz : in STD_LOGIC;
    rst : in STD_LOGIC;
    JA4 : out STD_LOGIC;
    JA1 : out STD_LOGIC;
    wiz_rst : out STD_LOGIC;
    rx : in STD_LOGIC;
    tx : out STD_LOGIC
  );
  end component design_1_top_level_0_0;
  signal clk_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal top_level_0_JA1 : STD_LOGIC;
  signal top_level_0_JA4 : STD_LOGIC;
  signal top_level_0_wiz_rst : STD_LOGIC;
  signal NLW_top_level_0_tx_UNCONNECTED : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_clk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000";
begin
  JA1 <= top_level_0_JA1;
  JA4 <= top_level_0_JA4;
  clk_1 <= clk;
clk_wiz_0: component design_1_clk_wiz_0_0
     port map (
      clk_in1 => clk_1,
      clk_out1 => clk_wiz_0_clk_out1,
      locked => clk_wiz_0_locked,
      resetn => top_level_0_wiz_rst
    );
top_level_0: component design_1_top_level_0_0
     port map (
      JA1 => top_level_0_JA1,
      JA4 => top_level_0_JA4,
      clk => clk_1,
      clk_wiz => clk_wiz_0_clk_out1,
      rst => clk_wiz_0_locked,
      rx => clk_1,
      tx => NLW_top_level_0_tx_UNCONNECTED,
      wiz_rst => top_level_0_wiz_rst
    );
end STRUCTURE;
