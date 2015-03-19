# ========== Copyright Header Begin ==========================================
# 
# OpenSPARC T1 Processor File: user_cfg.scr
# Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
# 
# The above named program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License version 2 as published by the Free Software Foundation.
# 
# The above named program is distributed in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this work; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
# 
# ========== Copyright Header End ============================================
source -echo -verbose project_sparc_cfg.tcl

# Modify the absolute path of the verilog source files.
set rtl_files { \ 
../std_gate_lib/not_n.v \
../std_gate_lib/xor2_n.v \
../std_gate_lib/or2_n.v \
../std_gate_lib/and2_n.v \
../std_gate_lib/mux2_n.v \
../std_gate_lib/mux4_n.v \
../std_gate_lib/mux3_n.v \
../std_gate_lib/eq2_n.v \
../register_file/register_file.v \ 
../control/control.v \
../instruction_fetch/instruction_fetch.v \
../fpu/multiplier.v \
../fpu/fpu.v \
../alu/shifter/shifter.v \
../alu/adder/32_cla_adder.v \
../alu/alu.v \
../forward/exe_forward.v \
../forward/dec_forward.v \
../forward/mem_forward.v \
../stages/decode/decode.v \
../stages/execute/execute.v \
../stages/fetch/fetch.v \
../stages/fetch/hazard.v \
../stages/memory/memory.v \
../stages/write_back/write_back.v \
top.v  \
 }

set mix_files {}

# Modify the name of the top level module
set top_module Processor

set include_paths { design/sys/iop/include }

set black_box_libs {}
set black_box_designs {}
set mem_libs {}

set compile_effort   "high"
set area_effort "low"

set compile_flatten_all 1

set compile_no_new_cells_at_top_level false

set default_clk clk
set default_clk_freq  1000
set default_setup_skew  0.00
set default_hold_skew  0.00
set default_clk_transition  0.00
set clk_list {                        \
                {clk   250.0   0.000   0.000   0.000}        \
}
set ideal_net_list {}
set false_path_list {}
set enforce_input_fanout_one     0
set allow_outport_drive_innodes  1
set skip_scan            0
set add_lockup_latch     false
set chain_count          1
set scanin_port_list     {}
set scanout_port_list    {}
set scanenable_port      global_shift_enable
set has_test_stub        1
set scanenable_pin       test_stub_no_bist/se
set long_chain_so_0_net  long_chain_so_0
set short_chain_so_0_net short_chain_so_0
set so_0_net             so_0
set insert_extra_lockup_latch 0
set extra_lockup_latch_clk_list {}
