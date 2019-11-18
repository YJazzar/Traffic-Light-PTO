//=============================================
// D Flip-Flop
//=============================================
module DFF #(parameter REGISTER_WIDTH = 1) (clk,in,out);
  input  clk;
  input  [REGISTER_WIDTH-1:0]  in;
  output [REGISTER_WIDTH-1:0] out;
  reg    [REGISTER_WIDTH-1:0] out;
  
  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
    out = in;
 endmodule

 module NightTime (clk, laneOutput);
    input clk;
    output [7:0] laneOutput;

    
 endmodule