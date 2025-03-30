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
	tb = new("tb",this);
 `uvm_info("Phase Info","Build Phase Of Test Running",UVM_HIGH)
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

endclass
