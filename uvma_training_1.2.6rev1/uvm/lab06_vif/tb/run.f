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
-incdir ../sv
// compile files
//*** add compile files here
../sv/yapp_pkg.sv
../sv/yapp_if.sv
../../router_rtl/yapp_router.sv
./clkgen.sv
./hw_top.sv
tb_top.sv 
+UVM_VERBOSITY=UVM_LOW
+UVM_NO_RELNOTES
+SVSEED=random
