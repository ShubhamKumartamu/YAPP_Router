class router_tb extends uvm_env ;
//Macro for automation
yapp_env env;

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
// env = new("env", this);
 env = yapp_env::type_id::create("yapp_env", this);

endfunction
endclass
