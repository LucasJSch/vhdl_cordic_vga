#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.3 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Wed Aug 16 00:10:45 -03 2023
# SW Build 2405991 on Thu Dec  6 23:36:41 MST 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xsim tb_behav -key {Behavioral:sim_1:Functional:tb} -tclbatch tb.tcl -protoinst "protoinst_files/design_1.protoinst" -view /home/ljsch/project_2/tb_behav.wcfg -view /home/ljsch/project_2/tb_func_synth.wcfg -log simulate.log