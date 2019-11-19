//=============================================
// 4-Channel, n-Bit Multiplexer with One-Hot Selector
//=============================================
//  parameter just lets us use a preprocessor directive to set 
//  a different value for BUS_WIDTH
//  1 is the default value
module Mux4 #(parameter BUS_WIDTH = 1) (a3, a2, a1, a0, selector, out);
	input [BUS_WIDTH-1:0] a3, a2, a1, a0;  // inputs
	input [3:0] selector; // one-hot select
	output[BUS_WIDTH-1:0] out;

	assign out = ({BUS_WIDTH{selector[3]}} & a3) | 
                 ({BUS_WIDTH{selector[2]}} & a2) | 
                 ({BUS_WIDTH{selector[1]}} & a1) |
                 ({BUS_WIDTH{selector[0]}} & a0) ;
endmodule
