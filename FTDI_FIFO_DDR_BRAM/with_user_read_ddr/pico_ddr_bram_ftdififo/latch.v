
module latch( in_b,clk, out_b,en);
parameter SIZE=8;

input [SIZE-1:0] in_b;
output [SIZE-1:0]out_b;
input en,clk;
genvar i; 
	generate
for(i=0; i<SIZE; i=i+1) 
begin:sreggen
// FD f1							  (.Q(out_b[i]),.D(in_b[i]),.C(en) );
 
 FDE #(.INIT(1'b0))FDCE_f1(.Q(out_b[i]),.C(clk),.CE(en),.D(in_b[i]));
end
endgenerate

 endmodule 
 
 
// module SRf1(set,reset,Q);
//	input set,reset;
//	output Q;
//  
//	FDC #(.INIT(1'b0))	
//	FDC_f1(
//				.Q(Q),
//				.CLR(reset),
//				.D(1'b1),
//				.C(set)
//			 );
//endmodule


//module ready_ff(set,reset,rdyq);
//input set,reset;
//output rdyq;
//reg rdyq;
//
//always@(negedge set,negedge reset)
//begin
//if(~reset)
//rdyq= 1'b0;
//else
//if(~set)
//rdyq=1'b1;
//end
//endmodule

//module input_buff( in_b, out_b,en);
//parameter SIZE=8;
//
//input [SIZE-1:0] in_b;
//output [SIZE-1:0]out_b;
//input en;
//genvar i; 
//	generate
//for(i=0; i<SIZE; i=i+1) 
//begin:sreggen
// BUFF b1 (.O (out_b[i]), .E (en), .I (in_b[i]) );
//end
//endgenerate
//endmodule