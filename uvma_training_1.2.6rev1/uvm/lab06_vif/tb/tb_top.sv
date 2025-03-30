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
 //yapp_if in0(clock, reset);
`include "uvm_macros.svh"
`include "router_tb.sv"
`include "router_test_lib.sv"
// generate 5 random packets and use the print method
// to display the results
initial begin
yapp_vif_config::set(null, "*.router_tb.yapp*", "vif", hw_top.in0);
run_test("base_test");
end
// experiment with the copy, clone and compare UVM method
endmodule : top
