--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
--Date        : Thu Aug 17 00:13:29 2023
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
    JA2 : out STD_LOGIC;
    JA3 : out STD_LOGIC;
    JA4 : out STD_LOGIC;
    VGA_B : out STD_LOGIC_VECTOR ( 1 downto 0 );
    VGA_B2 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_B3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_G : out STD_LOGIC_VECTOR ( 2 downto 0 );
    VGA_G3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_HS : out STD_LOGIC;
    VGA_R : out STD_LOGIC_VECTOR ( 2 downto 0 );
    VGA_R3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_VS : out STD_LOGIC;
    btn_x1 : in STD_LOGIC;
    btn_x2 : in STD_LOGIC;
    btn_y1 : in STD_LOGIC;
    btn_y2 : in STD_LOGIC;
    btn_z1 : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_board_cnt=4,da_clkrst_cnt=1,synth_mode=OOC_per_IP}";
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
  component design_1_xlconstant_1_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_xlconstant_1_0;
  component design_1_main_0_0 is
  port (
    clk : in STD_LOGIC;
    clk_wiz : in STD_LOGIC;
    rst : in STD_LOGIC;
    btn_x1 : in STD_LOGIC;
    btn_x2 : in STD_LOGIC;
    btn_y1 : in STD_LOGIC;
    btn_y2 : in STD_LOGIC;
    btn_z1 : in STD_LOGIC;
    wiz_rst : out STD_LOGIC;
    JA1 : out STD_LOGIC;
    JA2 : out STD_LOGIC;
    JA3 : out STD_LOGIC;
    JA4 : out STD_LOGIC;
    hs_main : out STD_LOGIC;
    vs_main : out STD_LOGIC;
    red_out_main : out STD_LOGIC_VECTOR ( 2 downto 0 );
    grn_out_main : out STD_LOGIC_VECTOR ( 2 downto 0 );
    blu_out_main : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component design_1_main_0_0;
  signal btn_x1_1 : STD_LOGIC;
  signal btn_x2_1 : STD_LOGIC;
  signal btn_y1_1 : STD_LOGIC;
  signal btn_y2_1 : STD_LOGIC;
  signal btn_z1_1 : STD_LOGIC;
  signal clk_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal main_0_JA1 : STD_LOGIC;
  signal main_0_JA2 : STD_LOGIC;
  signal main_0_JA3 : STD_LOGIC;
  signal main_0_JA4 : STD_LOGIC;
  signal main_0_blu_out_main : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal main_0_grn_out_main : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal main_0_hs_main : STD_LOGIC;
  signal main_0_red_out_main : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal main_0_vs_main : STD_LOGIC;
  signal main_0_wiz_rst : STD_LOGIC;
  signal xlconstant_2_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_clk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000";
begin
  JA1 <= main_0_JA1;
  JA2 <= main_0_JA2;
  JA3 <= main_0_JA3;
  JA4 <= main_0_JA4;
  VGA_B(1 downto 0) <= main_0_blu_out_main(1 downto 0);
  VGA_B2(0) <= xlconstant_2_dout(0);
  VGA_B3(0) <= xlconstant_2_dout(0);
  VGA_G(2 downto 0) <= main_0_grn_out_main(2 downto 0);
  VGA_G3(0) <= xlconstant_2_dout(0);
  VGA_HS <= main_0_hs_main;
  VGA_R(2 downto 0) <= main_0_red_out_main(2 downto 0);
  VGA_R3(0) <= xlconstant_2_dout(0);
  VGA_VS <= main_0_vs_main;
  btn_x1_1 <= btn_x1;
  btn_x2_1 <= btn_x2;
  btn_y1_1 <= btn_y1;
  btn_y2_1 <= btn_y2;
  btn_z1_1 <= btn_z1;
  clk_1 <= clk;
clk_wiz_0: component design_1_clk_wiz_0_0
     port map (
      clk_in1 => clk_1,
      clk_out1 => clk_wiz_0_clk_out1,
      locked => clk_wiz_0_locked,
      resetn => main_0_wiz_rst
    );
main_0: component design_1_main_0_0
     port map (
      JA1 => main_0_JA1,
      JA2 => main_0_JA2,
      JA3 => main_0_JA3,
      JA4 => main_0_JA4,
      blu_out_main(1 downto 0) => main_0_blu_out_main(1 downto 0),
      btn_x1 => btn_x1_1,
      btn_x2 => btn_x2_1,
      btn_y1 => btn_y1_1,
      btn_y2 => btn_y2_1,
      btn_z1 => btn_z1_1,
      clk => clk_1,
      clk_wiz => clk_wiz_0_clk_out1,
      grn_out_main(2 downto 0) => main_0_grn_out_main(2 downto 0),
      hs_main => main_0_hs_main,
      red_out_main(2 downto 0) => main_0_red_out_main(2 downto 0),
      rst => clk_wiz_0_locked,
      vs_main => main_0_vs_main,
      wiz_rst => main_0_wiz_rst
    );
xlconstant_2: component design_1_xlconstant_1_0
     port map (
      dout(0) => xlconstant_2_dout(0)
    );
end STRUCTURE;
