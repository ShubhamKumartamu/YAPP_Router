/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module top;
// import the UVM library
// include the UVM macros

// import the YAPP package
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "yapp_packet.sv"
`include "router_tb.sv"
`include "router_test_lib.sv"
// generate 5 random packets and use the print method
// to display the results
initial begin
run_test("base_test");
end
// experiment with the copy, clone and compare UVM method
endmodule : top
