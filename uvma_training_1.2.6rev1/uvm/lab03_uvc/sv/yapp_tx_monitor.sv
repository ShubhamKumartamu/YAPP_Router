class yapp_tx_monitor extends uvm_monitor;
`uvm_component_utils(yapp_tx_monitor)
//Constructor
function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(), $sformatf("Running Monitor"), UVM_HIGH)	
endfunction
//Run Phase
virtual task run_phase(uvm_phase phase);
	`uvm_info("Phase",$sformatf("Running inside Monitor"),UVM_LOW)
endtask
endclass
