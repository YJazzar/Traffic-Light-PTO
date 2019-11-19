
//  MODULES TO CONTROL THE TRAFFIC MODE
module TrafficMode (clk, timeSignal, pedSignal, emgSignal, trafficModeOutput);

    //  INPUT
    input clk;
    input timeSignal, pedSignal, emgSignal;
    output [1:0] trafficModeOutput;

    //  LOCAL VARIABLES
    wire [1:0] nextState;

    assign nextState = {{pedSignal | emgSignal}, 
                        {(~timeSignal & ~pedSignal) | emgSignal}};

    DFF #(2) trafficMode(clk, nextState, trafficModeOutput);
endmodule