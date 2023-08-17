// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Thu Aug 17 00:16:23 2023
// Host        : ljsch-IdeaPad-3-15IML05 running 64-bit Ubuntu 20.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/ljsch/sisdig_proyecto_final/sisdig_proyecto_final.srcs/sources_1/bd/design_1/ip/design_1_main_0_0/design_1_main_0_0_stub.v
// Design      : design_1_main_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "main,Vivado 2018.3" *)
module design_1_main_0_0(clk, clk_wiz, rst, btn_x1, btn_x2, btn_y1, btn_y2, 
  btn_z1, wiz_rst, JA1, JA2, JA3, JA4, hs_main, vs_main, red_out_main, grn_out_main, blu_out_main)
/* synthesis syn_black_box black_box_pad_pin="clk,clk_wiz,rst,btn_x1,btn_x2,btn_y1,btn_y2,btn_z1,wiz_rst,JA1,JA2,JA3,JA4,hs_main,vs_main,red_out_main[2:0],grn_out_main[2:0],blu_out_main[1:0]" */;
  input clk;
  input clk_wiz;
  input rst;
  input btn_x1;
  input btn_x2;
  input btn_y1;
  input btn_y2;
  input btn_z1;
  output wiz_rst;
  output JA1;
  output JA2;
  output JA3;
  output JA4;
  output hs_main;
  output vs_main;
  output [2:0]red_out_main;
  output [2:0]grn_out_main;
  output [1:0]blu_out_main;
endmodule
