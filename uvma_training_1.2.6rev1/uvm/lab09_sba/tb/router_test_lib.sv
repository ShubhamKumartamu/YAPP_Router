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
	uvm_config_wrapper::set(this, "router_tb.yapp_env.yapp_tx_agent.yapp_tx_sequencer.run_phase","default_sequence", yapp_base_seq::get_type());
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
//Run Phase
task run_phase(uvm_phase phase);
uvm_objection obj = phase.get_objection();
obj.set_drain_time(this, 200ns);
endtask

endclass

//////////////////////////////////////////////////////////////
//Simple Test
//
class simple_test extends base_test;
 `uvm_component_utils(simple_test)
 //Constructor
 function new(string name = "simple_test", uvm_component parent);
	 super.new(name, parent);
 endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_wrapper::set(this, "router_tb.yapp_env.yapp_tx_agent.yapp_tx_sequencer.run_phase","default_sequence",yapp_012_seq::get_type());
	uvm_config_wrapper::set(this, "router_tb.chan*.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::get_type());
	uvm_config_wrapper::set(this, "router_tb.chan1.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::get_type());
	uvm_config_wrapper::set(this, "router_tb.chan2.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::get_type());
	uvm_config_wrapper::set(this, "router_tb.clk_rst_gen.agent.sequencer.run_phase","default_sequence",clk10_rst5_seq::get_type());
	set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction

endclass : simple_test

//////////////////////////////////////////////////////////////
//Check Test
//
class check_test extends base_test;
 `uvm_component_utils(check_test)
 //Constructor
 function new(string name = "check_test", uvm_component parent);
	 super.new(name, parent);
 endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
	uvm_config_wrapper::set(this, "router_tb.chan*.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::get_type());
	uvm_config_wrapper::set(this, "router_tb.clk_rst_gen.agent.sequencer.run_phase","default_sequence",clk10_rst5_seq::get_type());
	uvm_config_wrapper::set(this, "router_tb.mcseqr.run_phase","default_sequence",router_simple_mcseq::get_type());
	set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction

endclass : check_test


