
//  MODULES TO CONTROL THE TRAFFIC MODE
/*  This Module will figure out the repective enable lines for: Day-time, Night-time, Pedestrian, and Emergency
 *  @param:
 *      Inputs:
 *          clk -> Clock signal
 *          rst -> Reset signal
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
module TrafficMode (clk, rst, timeSignal, pedSignal, emgSignal, currentState);

    //  INPUT
    input clk, rst;
    input timeSignal, pedSignal, emgSignal;

    //  OUTPUT
    output [1:0] currentState;

    //  LOCAL VARIABLES
    wire [1:0] nextState;
    wire [1:0] nextTrafficMode;
    wire [1:0] resetState = 2'b01;

    assign nextState = {{pedSignal | emgSignal}, 
                        {(~timeSignal & ~pedSignal) | emgSignal}};

    Mux2 #(2) inputMux(resetState, nextState, {rst, ~rst}, nextTrafficMode);

    DFF #(2) trafficMode(clk, nextTrafficMode, currentState);
endmodule