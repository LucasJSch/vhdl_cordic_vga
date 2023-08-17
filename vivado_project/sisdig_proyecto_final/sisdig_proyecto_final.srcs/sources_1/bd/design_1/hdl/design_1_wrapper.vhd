--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
--Date        : Thu Aug 17 00:13:29 2023
--Host        : ljsch-IdeaPad-3-15IML05 running 64-bit Ubuntu 20.04.6 LTS
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
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
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    clk : in STD_LOGIC;
    VGA_HS : out STD_LOGIC;
    VGA_VS : out STD_LOGIC;
    VGA_R : out STD_LOGIC_VECTOR ( 2 downto 0 );
    VGA_G : out STD_LOGIC_VECTOR ( 2 downto 0 );
    VGA_B : out STD_LOGIC_VECTOR ( 1 downto 0 );
    VGA_B2 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_B3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_G3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_R3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    btn_x1 : in STD_LOGIC;
    btn_x2 : in STD_LOGIC;
    btn_y1 : in STD_LOGIC;
    btn_z1 : in STD_LOGIC;
    btn_y2 : in STD_LOGIC;
    JA2 : out STD_LOGIC;
    JA3 : out STD_LOGIC;
    JA4 : out STD_LOGIC;
    JA1 : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      JA1 => JA1,
      JA2 => JA2,
      JA3 => JA3,
      JA4 => JA4,
      VGA_B(1 downto 0) => VGA_B(1 downto 0),
      VGA_B2(0) => VGA_B2(0),
      VGA_B3(0) => VGA_B3(0),
      VGA_G(2 downto 0) => VGA_G(2 downto 0),
      VGA_G3(0) => VGA_G3(0),
      VGA_HS => VGA_HS,
      VGA_R(2 downto 0) => VGA_R(2 downto 0),
      VGA_R3(0) => VGA_R3(0),
      VGA_VS => VGA_VS,
      btn_x1 => btn_x1,
      btn_x2 => btn_x2,
      btn_y1 => btn_y1,
      btn_y2 => btn_y2,
      btn_z1 => btn_z1,
      clk => clk
    );
end STRUCTURE;
