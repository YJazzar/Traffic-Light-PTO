module Pedestrian(pedSignal, walkingLightOutput, nightTimeLightOutput, loadTime);
    //  INPUTS
    input pedSignal;

    //  OUTPUTS
    output [0:7] nightTimeLightOutput;
    output [0:7] walkingLightOutput;
    output [6:0] loadTime;

    assign nightTimeLightOutput = 8'b00000000;

    Mux2 #(8) PedestrianLightMux ({8'b11111111}, {8'b00000000}, {pedSignal, ~pedSignal}, walkingLightOutput);

    assign loadTime = 6;
endmodule