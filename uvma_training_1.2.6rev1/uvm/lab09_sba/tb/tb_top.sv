/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module tb_top;
// import the UVM library
// include the UVM macros
// import the YAPP package
import uvm_pkg::*;
import yapp_pkg ::*; 
import hbus_pkg ::*; 
import channel_pkg::*;
import clock_and_reset_pkg::*;
 //yapp_if in0(clock, reset);
`include "uvm_macros.svh"
`include "router_mcsequencer.sv"
`include "router_mcseqs_lib.sv"
`include "../sv/router_scoreboard.sv"
`include "router_tb.sv"
`include "router_test_lib.sv"
// generate 5 random packets and use the print method
// to display the results
initial begin
yapp_vif_config::set(null, "*.router_tb.yapp*", "vif", hw_top.in0);
hbus_vif_config::set(null, "*.router_tb.hbus*", "vif", hw_top.in1);
clock_and_reset_vif_config::set(null, "*.router_tb.clk_rst_gen*", "vif", hw_top.in5);

channel_vif_config::set(null, "*.router_tb.chan0*", "vif", hw_top.chan0);
channel_vif_config::set(null, "*.router_tb.chan1*", "vif", hw_top.chan1);
channel_vif_config::set(null, "*.router_tb.chan2*", "vif", hw_top.chan2);
run_test("base_test");
end
// experiment with the copy, clone and compare UVM method
endmodule : top
