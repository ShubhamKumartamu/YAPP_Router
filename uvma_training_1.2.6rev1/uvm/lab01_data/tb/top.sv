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
yapp_packet p1;
yapp_packet p2;
yapp_packet p3;
// generate 5 random packets and use the print method
// to display the results
initial begin
p1 = new();
p2 = new();
repeat (6) begin
p1.randomize();
p2.copy(p1);
$cast(p3, p1.clone());
p1.print();
end
end
// experiment with the copy, clone and compare UVM method
endmodule : top
