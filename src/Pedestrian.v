module Pedestrian(pedestrianOutput, laneOutput);
    //  OUTPUTS
    output [0:7] laneOutput;
    output pedestrianOutput;

    assign laneOutput = 8'b00000000;
    assign pedestrianOutput = 1'b1;
endmodule