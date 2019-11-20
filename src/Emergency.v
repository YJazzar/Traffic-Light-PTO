module Emergency(emergencyLane, laneOutput);
    //  INPUTS
    input [0:3] emergencyLane;

    //  OUTPUTS
    output [0:7] laneOutput;

    assign laneOutput = {{emergencyLane[3]}, {emergencyLane[3]},
                         {emergencyLane[2]}, {emergencyLane[2]},
                         {emergencyLane[1]}, {emergencyLane[1]},
                         {emergencyLane[0]}, {emergencyLane[0]}};
endmodule