/*-----------------------------------------------------------------
File name     : run.f
Description   : lab01_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/
// 64 bit option for AWS labs
-64
-timescale 1ns/1ns
 -uvmhome $UVMHOME

// include directories
//*** add incdir include directories here
-incdir ../../yapp/sv
-incdir ../../hbus/sv
-incdir ../../channel/sv
-incdir ../../clock_and_reset/sv
// compile files
//*** add compile files here
../../yapp/sv/yapp_pkg.sv
../../hbus/sv/hbus_pkg.sv
../../channel/sv/channel_pkg.sv
../../clock_and_reset/sv/clock_and_reset_pkg.sv
../../yapp/sv/yapp_if.sv
../../hbus/sv/hbus_if.sv
../../channel/sv/channel_if.sv
../../clock_and_reset/sv/clock_and_reset_if.sv
../../router_rtl/yapp_router.sv

./clkgen.sv
./hw_top.sv
tb_top.sv 
+UVM_VERBOSITY=UVM_LOW
+UVM_NO_RELNOTES
+SVSEED=random
