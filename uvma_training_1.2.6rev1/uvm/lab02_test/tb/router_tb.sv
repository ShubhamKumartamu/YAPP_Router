class router_tb extends uvm_env ;
//Macro for automation
`uvm_component_utils(router_tb)
//Constructor
function new(string name, uvm_component parent);
 super.new(name,parent);
endfunction

//Build Phase
virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 `uvm_info("Phase Info","Build Phase Running",UVM_HIGH)
endfunction
endclass
