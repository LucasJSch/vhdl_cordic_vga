-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
-- Date        : Thu Aug 17 00:16:21 2023
-- Host        : ljsch-IdeaPad-3-15IML05 running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_main_0_0_stub.vhdl
-- Design      : design_1_main_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
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

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,clk_wiz,rst,btn_x1,btn_x2,btn_y1,btn_y2,btn_z1,wiz_rst,JA1,JA2,JA3,JA4,hs_main,vs_main,red_out_main[2:0],grn_out_main[2:0],blu_out_main[1:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "main,Vivado 2018.3";
begin
end;
