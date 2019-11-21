module Emergency(emergencyLane, laneOutput);
    //  INPUTS
    input [0:7] emergencyLane;

    //  OUTPUTS
    output [0:7] laneOutput;

    assign laneOutput = {{emergencyLane[0] | emergencyLane[1]}, {emergencyLane[0] | emergencyLane[1]},
                         {emergencyLane[2] | emergencyLane[3]}, {emergencyLane[2] | emergencyLane[3]},
                         {emergencyLane[4] | emergencyLane[5]}, {emergencyLane[4] | emergencyLane[5]},
                         {emergencyLane[6] | emergencyLane[7]}, {emergencyLane[6] | emergencyLane[7]}};
endmodule