/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit {GOOD_PARITY, BAD_PARITY} parity_type_e;
class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:
  rand bit [1:0] addr;
  rand bit [5:0] length;
  rand bit [7:0] payload[];
       bit [7:0] parity;

  // Define protocol data
  function new(string name = "yapp_packet");
	  super.new(name);
  endfunction

  // Define control knobs
  rand parity_type_e parity_type;
  rand int  packet_delay;
  // Enable automation of the packet's fields
`uvm_object_utils_begin(yapp_packet)
`uvm_field_int(length, UVM_ALL_ON)
`uvm_field_int(addr, UVM_ALL_ON)
`uvm_field_array_int( payload, UVM_ALL_ON )
`uvm_field_int( parity, UVM_ALL_ON + UVM_BIN )
`uvm_field_enum( parity_type_e, parity_type, UVM_ALL_ON )
`uvm_field_int( packet_delay, UVM_ALL_ON )

`uvm_object_utils_end
  // Define packet constraints
  constraint pkt_addr {addr !=3;}
  constraint pkt_length {length == payload.size();}
  constraint default_len {length >0; length <64;}
  constraint parity_c {
        parity_type dist {
            0 := 5, // Good parity (0) with a weight of 5
            1 := 1  // Bad parity (1) with a weight of 1
        };
    }
  constraint delay {packet_delay > 0; packet_delay < 20;}
  // Add methods for parity calculation and class construction
  function void set_parity();
    if(parity_type==GOOD_PARITY)
	    parity = calc_parity();
    else if (parity_type==GOOD_PARITY)
            parity = ~parity;
  endfunction
  function bit [7:0] calc_parity() ;
	  bit [7:0] xor_result;
	  foreach (payload[i]) begin
            xor_result ^= payload[i]; // XOR with each element
        end
      parity =  {length,addr} ^ xor_result;
      return parity;
  endfunction
  function void post_randomize();
	set_parity();
  endfunction
endclass: yapp_packet

//Short Packet Declaration
class short_yapp_packet extends yapp_packet;
 `uvm_object_utils(short_yapp_packet)
function new(string name = "short_yapp_packet");
	super.new(name);
endfunction
constraint short_length {length < 15;}
//constraint short_addr {addr!=2;}

endclass : short_yapp_packet
