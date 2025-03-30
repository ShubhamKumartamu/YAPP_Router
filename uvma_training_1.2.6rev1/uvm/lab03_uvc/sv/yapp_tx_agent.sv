class yapp_tx_agent extends uvm_agent;
//Constructor
function new (string name, uvm_component parent);
	super.new(name, parent);
endfunction
//Handles for Agent components
yapp_tx_monitor monitor;
yapp_tx_driver  driver;
yapp_tx_sequencer sequencer;

//Component Utility macro 
`uvm_component_utils_begin (yapp_tx_agent)
`uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
`uvm_component_utils_end

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	monitor = new("monitor", this);
	if(is_active==UVM_ACTIVE) begin
	driver    = new("driver", this);
	sequencer = new("sequencer", this);
	end
endfunction

function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_type_name(), $sformatf("Running Agent"), UVM_HIGH)	
endfunction
virtual function void connect_phase(uvm_phase phase);
	if(is_active==UVM_ACTIVE) 
		driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction

endclass
