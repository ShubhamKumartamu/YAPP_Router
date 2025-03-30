class mips_pkt extends uvm_sequence_item;
      typedef enum bit [3:0] {ADD, SUB, INCR, DECR, AND, NAND, OR, NOR, EXOR, EXNOR, BUFF, INV, MUL, DIV, LD, STR} instrs;
      rand instrs [15:0] inst_in [];
      bit [15:0] reg_wr;
      bit [2:0]  wr_addr;
      bit [1:0]  wr_en;

	`uvm_object_utils_begin (mips_pkt) 
	   uvm_field_int(inst_in, UVM_ALL_DEFAULT)
	   uvm_field_int(inst_in, UVM_ALL_DEFAULT)
	   uvm_field_int(inst_in, UVM_ALL_DEFAULT)
	   uvm_field_int(inst_in, UVM_ALL_DEFAULT)
	`uvm_object_utils_end
     //Data Constructor
     function new((string name = "mips_pkt");
     super.new(name);
     endfunction

     constraint ADD_SUB { foreach(inst_in[i]) begin
	     if(inst_in[i] == ADD) begin
		(i+1 < inst_in.size()) -> inst_in[i+1] != SUB;
		(i+2 < inst_in.size()) -> inst_in[i+2] != SUB;
		(i+3 < inst_in.size()) -> inst_in[i+3] != SUB;
		(i+4 < inst_in.size()) -> inst_in[i+4] != SUB;
	     end  
			}
     constraint MUL_DIV { 
endclass : mips_pkt

class mips_pkt_sequence extends uvm_sequence #(mips_pkt);
	`uvm_object_utils(mips_pkt_sequence)

	function new(string name = "mips_pkt_sequence", uvm component parent = "null");
		super.new(name,parent);
	endfunction

	virtual task body();
	if(starting_phase != null) 
		starting_phase.raise_objection(this, get_type_name());
	repeat (5) begin
	`uvm_do(req)
	end
	if(starting_phase != null) 
		starting_phase.drop_objection(this, get_type_name());
	endtask
endclass

class mips_pkt_sequencer extends uvm_sequencer #(mips_pkt);
	`uvm_component_utils()
//COnsructor

endclass : mips_pkt_sequencer

//Driver
class mips_driver extends uvm_driver #(mips_pkt);
	`uvm_component_utils(mips_driver)
    function new(string name = "mips_driver", uvm_component parent = "null");
	    super.new(name, parent);
    endfunction

    virtual mips_vif vif;

    function build_phase(uvm_phase phase);
	    super.build(phase);
	    if(!uvm_config_db#(virtual interface mips_vif ) :: get (this, "", "vif", vif) )
		    `uvm_error90;
    endfunction

    virtual task run_phase(uvm_phase phase);
	mips_pkt pkt = new();

	forever begin
		seq_item_port.get_next_item(pkt);
		drive_through_dut(pkt);
		seq_item_port.item_done();

	end
	endtask
   task drive_through_dut(mips_pkt pkt);


   endtask



endclass

//Monitor
class mips_monitor extends uvm_monitor;
 `uvm_component_utils(mips_monitor)
 function new(string name ="mips_monitor", uvm_component parent = "null");
	 super.new(name, parent);
 endfunction

 virtual interf_vif vif;
 `uvm_analysis_port #(mips_ppkt) mon_analysis_port
 semaphore sem;

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual interface interf_vif)::get(this, "", "vif", vif)) 
		`uvm_error ("VIF not found")

 endfunction

virtual task run_phase(uvm_phase phase);
mips_pkt pkt = new;
forever begin
@(vif.clk) begin
for (int i=0; i< vif.instrs.size(); i++) begin
pkt.instrs <= vif.instr_in[i];
end
mon_analysis_port.write(pkt);
end
endtask

endclass
