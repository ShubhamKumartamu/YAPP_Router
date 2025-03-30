class base_test extends uvm_test ;
//Macro Component utils
`uvm_component_utils(base_test)

//COnstructor
function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction
router_tb tb;
//Build Phase
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "router_tb.yapp_env.yapp_tx_agent.yapp_tx_sequencer.run_phase","default_sequence",yapp_5_packets::get_type());
//	tb = new("tb",this);
	tb = router_tb::type_id::create("router_tb", this);
 `uvm_info("Phase Info","Build Phase Of Test Running",UVM_HIGH)
  uvm_config_int::set( this, "*", "recording_detail", 1); //to enable transaction recording
endfunction
//Check Phase
virtual function void check_phase(uvm_phase phase);
	check_config_usage();
endfunction
//End of Elaboration Phase
virtual function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction	
endclass

//Test2
class test2 extends base_test;
`uvm_component_utils(test2)
//COnstructor
function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

endclass :test2

//Short_packet_test\
//////////////////////////////////////////
class short_packet_test extends base_test;
`uvm_component_utils(short_packet_test)
//COnstructor
function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction

endclass :short_packet_test

//set_config_test
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class set_config_test extends base_test;
`uvm_component_utils(set_config_test)
//COnstructor
function new(string name, uvm_component parent);
	super.new(name, parent);
endfunction
router_tb tb;

//Build Phase
virtual function void build_phase(uvm_phase phase);
	uvm_config_int::set(this, "router_tb.yapp_env.yapp_tx_agent", "is_active", UVM_PASSIVE);
	super.build_phase(phase);

endfunction

endclass : set_config_test

//incr_payload_test
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class incr_payload_test extends base_test;
 `uvm_component_utils(incr_payload_test)
 //Constructor
 function new(string name = "incr_payload_test", uvm_component parent);
	 super.new(name, parent);
 endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "router_tb.yapp_env.yapp_tx_agent.yapp_tx_sequencer.run_phase","default_sequence",yapp_incr_payload_seq::get_type());
	set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction

endclass : incr_payload_test
//exhaustive_payload_test
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class exhaustive_seq_test extends base_test;
 `uvm_component_utils(exhaustive_seq_test)
 //Constructor
 function new(string name = "exhaustive_seq_test", uvm_component parent);
	 super.new(name, parent);
 endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "router_tb.yapp_env.yapp_tx_agent.yapp_tx_sequencer.run_phase","default_sequence",yapp_exhaustive_seq::get_type());
	set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction

endclass : exhaustive_seq_test
