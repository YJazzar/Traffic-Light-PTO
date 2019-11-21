module Pedestrian(pedSignal, walkingLightOutput, laneOutput);
    //  INPUTS
    input pedSignal;

    //  OUTPUTS
    output [0:7] laneOutput;
    output [0:7] walkingLightOutput;

    assign laneOutput = 8'b00000000;

    Mux2 #(8) PedestrianLightMux ({8'b11111111}, {8'b00000000}, {pedSignal, ~pedSignal}, walkingLightOutput);
endmodule