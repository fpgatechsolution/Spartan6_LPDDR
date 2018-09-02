`timescale 1ns / 1ps

module pico(

input clk,
input reset,

/////////////////this signal shows ddr memory ready ///////////////////////
input ddr_calib_done,

////////////////write port/////////////////////////

input wr_empty_a,
input wr_full_a,
output reg cmd_en_wr_a,
output reg wr_en_pls_a,
output reg addr_incA_wr,
output  addr_rstA_wr,



////////////////read port/////////////////////////
output reg  cmd_en_rd_a,
input [31:0] rd_data_a,
input  rd_empty_a,
output reg rd_en_pls_a,

output reg addr_incA_rd,     
output reg addr_rstA_rd, 




output tx_232,



output reg [31:0]data_usb_write


    );



//***************** INTERNAL WIRE AND REG DEFINE FOR PICO****************************
//***********************************************************************************

parameter [7:0] 	hwbuild = 8'h00 ;
parameter [11:0] 	interrupt_vector = 12'h3FF ;
parameter integer scratch_pad_memory_size = 64 ;   

wire [11:0]	address;
wire [17:0] instruction;
reg [7:0]	in_port;
wire [7:0]	out_port;
wire [7:0]	port_id;
wire	bram_enable;
wire	write_strobe;
wire	k_write_strobe;
wire	read_strobe;
wire	interrupt;
wire	interrupt_ack;
wire	sleep;
wire pp1,pp2,pp3,pp4,pp5,pp6;
//***************** INTERNAL WIRE AND REG DEFINE FOR PICO****************************
//***********************************************************************************

 reg [7:0]tx_data_i;
 wire tx_strobe;


//******************KCPSM6 INSTANCE*************************
//*********************************************************

kcpsm6 uu1 (
    .address(address), 
    .instruction(instruction), 
    .bram_enable(bram_enable), 
    .in_port(in_port), 
    .out_port(out_port), 
    .port_id(port_id), 
    .write_strobe(write_strobe), 
    .k_write_strobe(k_write_strobe), 
    .read_strobe(read_strobe), 
    .interrupt(interrupt), 
    .interrupt_ack(interrupt_ack), 
    .sleep(sleep), 
    .reset(reset), 
    .clk(clk)
    );

//*************************************************************

//*******************PROGRAM PROM INSTANCE********************
// Instantiate the module
write_pico_psm instance_write_pico (
    .address(address), 
    .instruction(instruction), 
    .enable(bram_enable), 
    .rdl(), 
    .clk(clk)
    );
	 
	 
//##########################  INPUT PORT DEFINE ##############################

always @ (posedge read_strobe)
		  begin
		  case(port_id)
		  



1: begin in_port[0] <=rd_empty_a; end

2: begin in_port <=rd_data_a[7:0]; end
3: begin in_port <=rd_data_a[15:8]; end
4: begin in_port <=rd_data_a[23:16]; end
5: begin in_port <=rd_data_a[31:24]; end



6: begin in_port[0] <= ddr_calib_done; end
7: begin in_port[0] <= wr_empty_a; end


9: begin in_port <= data_usb_out; end

 endcase
  end

  
  








//########################## OUTPUT PORT ############################

assign tx_strobe = (write_strobe && port_id==1) ? (1'b1) : (1'b0); 

 always @ (posedge write_strobe)
  begin
    case(port_id)
	 

	 
1: begin addr_rstA_rd <= out_port[0]; end
2: begin addr_incA_rd<=out_port[0]; end
3: begin cmd_en_rd_a<=out_port[0]; end 
4: begin  rd_en_pls_a<=out_port[0]; end

5: begin usb_rd_pulse1<=out_port[0]; end 


6: begin addr_incA_wr<=out_port[0]; end


7: begin cmd_en_wr_a<=out_port[0]; end 


8: begin wr_en_pls_a<=out_port[0]; end 



9: begin data_usb_write[7:0]<=out_port; end
10: begin data_usb_write[15:8]<=out_port; end
11: begin data_usb_write[23:16]<=out_port; end
12: begin data_usb_write[31:24]<=out_port; end


  endcase
  end
  


endmodule
