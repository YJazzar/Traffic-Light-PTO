module Pedestrian(pedSignal, walkingLightOutput, laneOutput, loadTime);
    //  INPUTS
    input pedSignal;

    //  OUTPUTS
    output [0:7] laneOutput;
    output [0:7] walkingLightOutput;
    output [6:0] loadTime;

    assign laneOutput = 8'b00000000;

    Mux2 #(8) PedestrianLightMux ({8'b11111111}, {8'b00000000}, {pedSignal, ~pedSignal}, walkingLightOutput);

    assign loadTime = 25;
endmodule