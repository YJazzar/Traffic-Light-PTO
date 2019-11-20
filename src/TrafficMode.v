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


/*  This Module will figure out the repective enable lines for: Day-time, Night-time, Pedestrian, and Emergency
 *  @param:
 *      Inputs:
 *          clk -> Clock signal
 *          pedSignal -> Will be true if there is a pedestrian
 *          emgSignal -> Will be true if there is an emergency vehicle
 *          dayTime -> Will be true if it is currently Day or false if it is Night
 *          
 *
 *      Outputs:
 *          currentState -> Will indicate if we are currently in which of the following states, where:
 *                            Day-time   =  00
 *                            Night-time =  01 
 *                            Pedestrian =  10
 *                            Emergency  =  11
 */
module TrafficMode (clk, pedSignal, emgSignal, dayTime, currentState);

    //  INPUT
    input clk;
    input pedSignal;  
    input emgSignal;  
    input dayTime;

    // Output
    output [1:0] currentState;

    //  LOCAL VARIABLES
    wire [1:0] nextState;

    // Equation for the next state
    assign nextState = {{pedSignal | emgSignal}, 
                        {(~dayTime & ~pedSignal) | emgSignal}};

    DFF #(2) trafficMode(clk, nextState, currentState);  

endmodule