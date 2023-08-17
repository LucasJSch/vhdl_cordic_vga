-- (c) Copyright 1995-2023 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:main:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_main_0_0 IS
  PORT (
    clk : IN STD_LOGIC;
    clk_wiz : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    btn_x1 : IN STD_LOGIC;
    btn_x2 : IN STD_LOGIC;
    btn_y1 : IN STD_LOGIC;
    btn_y2 : IN STD_LOGIC;
    btn_z1 : IN STD_LOGIC;
    wiz_rst : OUT STD_LOGIC;
    JA1 : OUT STD_LOGIC;
    JA2 : OUT STD_LOGIC;
    JA3 : OUT STD_LOGIC;
    JA4 : OUT STD_LOGIC;
    hs_main : OUT STD_LOGIC;
    vs_main : OUT STD_LOGIC;
    red_out_main : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    grn_out_main : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    blu_out_main : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END design_1_main_0_0;

ARCHITECTURE design_1_main_0_0_arch OF design_1_main_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_main_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT main IS
    GENERIC (
      RAM_DATA_WIDTH : INTEGER;
      RAM_ADDRESS_WIDTH : INTEGER;
      BYTES_TO_RECEIVE : INTEGER;
      CYCLES_TO_WAIT : INTEGER;
      COORDS_WIDTH : INTEGER;
      ANGLE_WIDTH : INTEGER;
      CORDIC_STAGES : INTEGER;
      CORDIC_WIDTH : INTEGER;
      CORDIC_OFFSET : INTEGER;
      ANGLE_STEP_INITIAL : INTEGER;
      CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH : INTEGER;
      VRAM_ADDR_BITS : INTEGER;
      VRAM_DATA_BITS_WIDTH : INTEGER
    );
    PORT (
      clk : IN STD_LOGIC;
      clk_wiz : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      btn_x1 : IN STD_LOGIC;
      btn_x2 : IN STD_LOGIC;
      btn_y1 : IN STD_LOGIC;
      btn_y2 : IN STD_LOGIC;
      btn_z1 : IN STD_LOGIC;
      wiz_rst : OUT STD_LOGIC;
      JA1 : OUT STD_LOGIC;
      JA2 : OUT STD_LOGIC;
      JA3 : OUT STD_LOGIC;
      JA4 : OUT STD_LOGIC;
      hs_main : OUT STD_LOGIC;
      vs_main : OUT STD_LOGIC;
      red_out_main : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      grn_out_main : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      blu_out_main : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
  END COMPONENT main;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF design_1_main_0_0_arch: ARCHITECTURE IS "main,Vivado 2018.3";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF design_1_main_0_0_arch : ARCHITECTURE IS "design_1_main_0_0,main,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF design_1_main_0_0_arch: ARCHITECTURE IS "design_1_main_0_0,main,{x_ipProduct=Vivado 2018.3,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=main,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,RAM_DATA_WIDTH=8,RAM_ADDRESS_WIDTH=15,BYTES_TO_RECEIVE=32700,CYCLES_TO_WAIT=100000,COORDS_WIDTH=8,ANGLE_WIDTH=10,CORDIC_STAGES=8,CORDIC_WIDTH=12,CORDIC_OFFSET=4,ANGLE_STEP_INITIAL=1,CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH=10,VRAM_ADDR_BITS=16,VRAM_DATA_BITS_WIDTH=1}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF design_1_main_0_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF wiz_rst: SIGNAL IS "XIL_INTERFACENAME wiz_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF wiz_rst: SIGNAL IS "xilinx.com:signal:reset:1.0 wiz_rst RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF rst: SIGNAL IS "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF rst: SIGNAL IS "xilinx.com:signal:reset:1.0 rst RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk: SIGNAL IS "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_clk, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 clk CLK";
BEGIN
  U0 : main
    GENERIC MAP (
      RAM_DATA_WIDTH => 8,
      RAM_ADDRESS_WIDTH => 15,
      BYTES_TO_RECEIVE => 32700,
      CYCLES_TO_WAIT => 100000,
      COORDS_WIDTH => 8,
      ANGLE_WIDTH => 10,
      CORDIC_STAGES => 8,
      CORDIC_WIDTH => 12,
      CORDIC_OFFSET => 4,
      ANGLE_STEP_INITIAL => 1,
      CYCLES_TO_WAIT_TO_CORDIC_TO_FINISH => 10,
      VRAM_ADDR_BITS => 16,
      VRAM_DATA_BITS_WIDTH => 1
    )
    PORT MAP (
      clk => clk,
      clk_wiz => clk_wiz,
      rst => rst,
      btn_x1 => btn_x1,
      btn_x2 => btn_x2,
      btn_y1 => btn_y1,
      btn_y2 => btn_y2,
      btn_z1 => btn_z1,
      wiz_rst => wiz_rst,
      JA1 => JA1,
      JA2 => JA2,
      JA3 => JA3,
      JA4 => JA4,
      hs_main => hs_main,
      vs_main => vs_main,
      red_out_main => red_out_main,
      grn_out_main => grn_out_main,
      blu_out_main => blu_out_main
    );
END design_1_main_0_0_arch;
