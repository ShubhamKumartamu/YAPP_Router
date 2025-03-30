`uvm_analysis_imp_decl(_yapp)
`uvm_analysis_imp_decl(_chan0)
`uvm_analysis_imp_decl(_chan1)
`uvm_analysis_imp_decl(_chan2)


class router_scoreboard extends uvm_scoreboard;

//Component utility macro
 `uvm_component_utils(router_scoreboard)

  uvm_analysis_imp_yapp#(yapp_packet, router_scoreboard) yapp_in; 
 uvm_analysis_imp_chan0#(channel_packet, router_scoreboard) chan0_in; 
 uvm_analysis_imp_chan1#(channel_packet, router_scoreboard) chan1_in; 
 uvm_analysis_imp_chan2#(channel_packet, router_scoreboard) chan2_in; 

int no_of_pkt = 0;
int passed_pkt = 0;
int failed_pkt = 0;

//Constructor
function new(string name, uvm_component parent);
 super.new(name, parent);
yapp_in= new("yapp_in", this);
chan0_in= new("chan0_in", this);
chan1_in= new("chan1_in", this);
chan2_in= new("chan2_in", this);
endfunction : new
yapp_packet q0[$], q1[$], q2[$];
//channel_packet chan0_pkt[$], chan1_pkt[$],chan2_pkt[$];
//YAPP_WRITE
function void write_yapp(input yapp_packet pkt);
 yapp_packet pkt1;
 $cast(pkt1, pkt.clone() );
 $display("Writing in the yapp queue");
 case(pkt1.addr)
 2'b00: q0.push_back(pkt1);
 2'b01: q1.push_back(pkt1);
 2'b10: q2.push_back(pkt1);
 default : ;
 endcase
endfunction : write_yapp
//Channel 0 Write
function void write_chan0(input channel_packet cp);
yapp_packet yp;
yp = q0.pop_front();
no_of_pkt++;

 $display("Reading from the Chan0 queue, Packet no. : %0d", no_of_pkt);
if(comp_equal(yp, cp)) begin
	passed_pkt++;
end
else begin
	failed_pkt++;
end
endfunction : write_chan0

//Channel 1 Write
function void write_chan1(input channel_packet cp);
yapp_packet yp;
yp = q1.pop_front();
no_of_pkt++;

 $display("Reading from the Chan1 queue, Packet no. : %0d", no_of_pkt);
if(comp_equal(yp, cp)) begin
	passed_pkt++;
end
else begin
	failed_pkt++;
end
endfunction : write_chan1

//Channel 2 Write
function void write_chan2(input channel_packet cp);
yapp_packet yp;
yp = q2.pop_front();
no_of_pkt++;

 $display("Reading from the Chan2 queue, Packet no. : %0d", no_of_pkt);
if(comp_equal(yp, cp)) begin
	passed_pkt++;
end
else begin
	failed_pkt++;
end
endfunction : write_chan2
  // custom packet compare function using inequality operators
   function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
          `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
      if (yp.parity != cp.parity) begin
        `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
        return(0);
      end
      return(1);
   endfunction
//Report Phase
function void report_phase(uvm_phase phase);
		`uvm_info("SCOREBOARD",$sformatf("Received packets: %0d\n",no_of_pkt), UVM_NONE)
		`uvm_info("SCOREBOARD",$sformatf("Matched packets: %0d\n",passed_pkt), UVM_NONE)
		`uvm_info("SCOREBOARD",$sformatf("Failed packets: %0d\n",failed_pkt), UVM_NONE)
		`uvm_info("SCOREBOARD",$sformatf("Remaining packets in q0: %0d, q1 :%0d q2: %0d\n", q0.size(), q1.size(), q2.size()), UVM_NONE)
endfunction : report_phase
endclass : router_scoreboard
