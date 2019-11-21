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


module SpecialDFF #(parameter REGISTER_WIDTH = 1) (clk,in,out);
  input  clk;
  input  [REGISTER_WIDTH-1:0]  in;
  output [REGISTER_WIDTH-1:0] out;
  reg    [REGISTER_WIDTH-1:0] out;
  
  initial out = 0;

  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
    out = in;
endmodule

module InitializedDFF #(parameter REGISTER_WIDTH = 1) (clk,initialValue,in,out);
  input  clk;
  input  initialValue;
  input  [REGISTER_WIDTH-1:0]  in;
  output [REGISTER_WIDTH-1:0] out;
  reg    [REGISTER_WIDTH-1:0] out;
  
  initial out = initialValue;

  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
    out = in;
endmodule