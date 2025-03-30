class router_tb extends uvm_env ;
//Macro for automation
yapp_env env;
channel_env chan0;
channel_env chan1;
channel_env chan2;
hbus_env hbus;
clock_and_reset_env clk_rst_gen;
`uvm_component_utils(router_tb)
//Constructor
function new(string name, uvm_component parent);
 super.new(name,parent);
endfunction

function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(), $sformatf("Running Testbench"), UVM_HIGH)	
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 `uvm_info("Phase Info","Build Phase Running",UVM_HIGH)
 uvm_config_int::set(this, "chan0", "channel_id", 0);
 uvm_config_int::set(this, "chan1", "channel_id", 1);
 uvm_config_int::set(this, "chan2", "channel_id", 2);
 uvm_config_int::set(this, "hbus", "num_masters", 1);
 uvm_config_int::set(this, "hbus", "num_slaves", 0);

 env = yapp_env::type_id::create("yapp_env", this);
 clk_rst_gen = clock_and_reset_env::type_id::create("clk_rst_gen", this);
 hbus = hbus_env::type_id::create("hbus", this);
 chan0 = channel_env::type_id::create("chan0",this);
 chan1 = channel_env::type_id::create("chan1",this);
 chan2 = channel_env::type_id::create("chan2",this);
 endfunction
endclass
