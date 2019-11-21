//=============================================
// 2-Channel, n-Bit Multiplexer with One-Hot Selector
//=============================================
//  parameter just lets us use a preprocessor directive to set 
//  a different value for BUS_WIDTH
//  1 is the default value
module Mux2 #(parameter BUS_WIDTH = 1) (a1, a0, selector, out);
	input [BUS_WIDTH-1:0] a1, a0;  // inputs
	input [1:0] selector; // one-hot select
	output[BUS_WIDTH-1:0] out;

	assign out = ({BUS_WIDTH{selector[1]}} & a1) |
                 ({BUS_WIDTH{selector[0]}} & a0) ;
endmodule


