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

module TrafficMode (clk, timeSignal, pedSignal, emgSignal, trafficModeOutput);

    //  INPUT
    input clk;
    input timeSignal, pedSignal, emgSignal;
    output [1:0] trafficModeOutput;

    //  LOCAL VARIABLES
    wire [1:0] nextState;

    assign nextState = {{pedSignal | emgSignal}, 
                        {(~timeSignal & ~pedSignal) | emgSignal}};

    DFF #(2) trafficMode(clk, nextState,trafficModeOutput);

endmodule