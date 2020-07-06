`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:47 06/13/2016 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lpddr_control(
  
    
	 
	 input clk_100mhz,

	 
	inout  [15:0]               mcb3_dram_dq,
	output [12:0]               mcb3_dram_a,
	output [2:0]                mcb3_dram_ba,
	output                      mcb3_dram_ras_n,
	output                      mcb3_dram_cas_n,
	output                      mcb3_dram_we_n,
	output                      mcb3_dram_cke,
	output                      mcb3_dram_dm,
	inout                       mcb3_dram_udqs,	
	output                      mcb3_dram_udm,
	inout                       mcb3_dram_dqs,
	output                      mcb3_dram_ck,
	output                      mcb3_dram_ck_n,
	output 						c3_calib_done,
	inout mcb3_rzq,
	
	input sys_rst_h,
	

///**** write control******

	input 			cmd_en_wr_a,
	input 			wr_en_pls_a,
	input [31:0]	wr_data_a,
	output 			wr_empty_a,
	output 			wr_full_a,
	input 			addr_rstA_wr,
	input 			addr_incA_wr,
///**** write control*****

	input 			cmd_en_rd_a,
	input 			rd_en_pls_a,
	output [31:0]	rd_data_a,
	output 			rd_empty_a,
	input 			addr_rstA_rd,
	input 			addr_incA_rd,

	output test_led


	
	

    );

////***** INTERNAL WIRE ********

	wire [29:0]	ddr_addr_a_wr,ddr_addr_a_rd;

	wire c1_clk0;
	wire clk_ddr_fifo;
	reg [27:0]ddr_addr_a_pico_wr,ddr_addr_a_pico_rd;
   wire cmd_en_wr_a1,cmd_en_rd_a1,rd_en_pls_a1,wr_en_pls_a1;
	
   wire clkA_addr;
   wire c1_calib_done;
	
  
assign clk_ddr_fifo=clk_100;
assign test_led=clk_ddr_fifo;//c1_clk0; 


		  // Instantiate the module
L_TO_P instance_clkA_addr (
    .CLK_in(clk_100), 
    .LEVEL(addr_incA_wr || addr_incA_rd), 
    .PULSE(clkA_addr)
    );


//****************************************************************************************
//****************************************************************************************

always @ (posedge clkA_addr or posedge addr_rstA_wr  or posedge sys_rst_h)  /// mem write address define 
 begin
   if(addr_rstA_wr || sys_rst_h)
	  ddr_addr_a_pico_wr=28'd08;
	else
	if(addr_incA_wr)
	  ddr_addr_a_pico_wr=ddr_addr_a_pico_wr + 32;
 end


always @ (posedge clkA_addr or posedge addr_rstA_rd or posedge sys_rst_h)  /// mem read address define 
 begin
   if(addr_rstA_rd || sys_rst_h)
	  ddr_addr_a_pico_rd=28'd07;
	else
	if(addr_incA_rd)
	  ddr_addr_a_pico_rd=ddr_addr_a_pico_rd + 32;
 end


assign ddr_addr_a_wr={ddr_addr_a_pico_wr,2'b00};
assign ddr_addr_a_rd={ddr_addr_a_pico_rd,2'b00};


//****************************************************************************************
//****************************************************************************************



		  
L_TO_P instance_cmd_en_wr_a (
    .CLK_in(clk_100), 
    .LEVEL(cmd_en_wr_a), 
    .PULSE(cmd_en_wr_a1)
    );


		
L_TO_P instance_cmd_en_rd_a (
    .CLK_in(clk_100), 
    .LEVEL(cmd_en_rd_a), 
    .PULSE(cmd_en_rd_a1)
    );




		  
L_TO_P instance_rd_en_pls_a (
    .CLK_in(clk_100), 
    .LEVEL(rd_en_pls_a), 
    .PULSE(rd_en_pls_a1)
    );



L_TO_P instance_wr_en_pls_a(
    .CLK_in(clk_100), 
    .LEVEL(wr_en_pls_a), 
    .PULSE(wr_en_pls_a1)
    );


 ddr2 # (
    .C1_P0_MASK_SIZE(4),
    .C1_P0_DATA_PORT_SIZE(32),
    .C1_P1_MASK_SIZE(4),
    .C1_P1_DATA_PORT_SIZE(32),
    .DEBUG_EN(0),
    .C1_MEMCLK_PERIOD(3200),
    .C1_CALIB_SOFT_IP("TRUE"),
    .C1_SIMULATION("FALSE"),
    .C1_RST_ACT_LOW(0),
    .C1_INPUT_CLK_TYPE("SINGLE_ENDED"),
    .C1_MEM_ADDR_ORDER("ROW_BANK_COLUMN"),
    .C1_NUM_DQ_PINS(16),
    .C1_MEM_ADDR_WIDTH(13),
    .C1_MEM_BANKADDR_WIDTH(3)
)

inst_ddr2 (
 
    .c3_sys_clk             (clk_100mhz),   
    .c3_sys_rst_i           (sys_rst_h),                        
    
	.mcb3_dram_dq           (mcb3_dram_dq),  
	.mcb3_dram_a            (mcb3_dram_a),  
	.mcb3_dram_ba           (mcb3_dram_ba),
	.mcb3_dram_ras_n        (mcb3_dram_ras_n),                        
	.mcb3_dram_cas_n        (mcb3_dram_cas_n),                        
	.mcb3_dram_we_n         (mcb3_dram_we_n),                          
	.mcb3_dram_cke          (mcb3_dram_cke),                          
	.mcb3_dram_ck           (mcb3_dram_ck),                          
	.mcb3_dram_ck_n         (mcb3_dram_ck_n), 	
	.mcb3_dram_dqs          (mcb3_dram_dqs),                          
	.mcb3_dram_udqs         (mcb3_dram_udqs),    // for X16 parts                        
	.mcb3_dram_udm          (mcb3_dram_udm),     // for X16 parts
	
	
	
	.mcb3_dram_dm           (mcb3_dram_dm),	
	.c3_clk0		           (clk_ddr_fifo),
	.c3_rst0		           (c1_rst0),	
	
	.c3_calib_done          (c3_calib_done),
	.mcb3_rzq               (mcb1_rzq),
   

 //********************* MEM WRITE ONLY ********************
	
   .c3_p0_cmd_clk                          (clk_ddr_fifo),
   .c3_p0_cmd_en                           (cmd_en_wr_a1),
   .c3_p0_cmd_instr                        (3'b000),
   .c3_p0_cmd_bl                           ('d31),
   .c3_p0_cmd_byte_addr                    (ddr_addr_a_wr),
   .c3_p0_cmd_empty                       (),

   .c3_p0_wr_clk                           (clk_ddr_fifo),
   .c3_p0_wr_en                            (wr_en_pls_a1),
   .c3_p0_wr_mask                          (4'b0000),
   .c3_p0_wr_data                          (wr_data_a),
   .c3_p0_wr_empty                         (wr_empty_a),
   .c3_p0_wr_full                         (wr_full_a),
	
 //**3****************** MEM READ ONLY ********************
   .c3_p1_cmd_clk                          (clk_ddr_fifo),
   .c3_p1_cmd_en                           (cmd_en_rd_a1),
   .c3_p1_cmd_instr                        (3'b001),
   .c3_p1_cmd_bl                           ('d31),
   .c3_p1_cmd_byte_addr                    (ddr_addr_a_rd),

   .c3_p1_rd_clk                           (clk_ddr_fifo),
   .c3_p1_rd_en                            (rd_en_pls_a1),
   .c3_p1_rd_data                          (rd_data_a),  
   .c3_p1_rd_empty                         (rd_empty_a)
	
	

	
	
	
	

);



endmodule
