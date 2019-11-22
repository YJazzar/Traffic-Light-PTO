//=============================================
// D Flip-Flop
//=============================================


module DFF (clk,in,out);
  parameter REGISTER_WIDTH = 1;
  parameter initialValue = 0;

  input  clk;
  input  [REGISTER_WIDTH-1:0]  in;
  output [REGISTER_WIDTH-1:0] out;
  reg    [REGISTER_WIDTH-1:0] out;
  
  initial out = {REGISTER_WIDTH{initialValue}};

  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
    out = in;
endmodule