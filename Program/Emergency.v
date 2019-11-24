//module Emergency(emergencyLane, emergencyLightOutput, loadCommand, loadTime);
module Emergency(emergencyLane, emergencyLightOutput, loadTime);
    //  INPUTS
    input [0:7] emergencyLane;

    //  OUTPUTS
    output [0:7] emergencyLightOutput;
    output [6:0] loadTime;
    //output loadCommand;

    assign emergencyLightOutput = {{emergencyLane[0] | emergencyLane[1]}, {emergencyLane[0] | emergencyLane[1]},
                         {emergencyLane[2] | emergencyLane[3]}, {emergencyLane[2] | emergencyLane[3]},
                         {emergencyLane[4] | emergencyLane[5]}, {emergencyLane[4] | emergencyLane[5]},
                         {emergencyLane[6] | emergencyLane[7]}, {emergencyLane[6] | emergencyLane[7]}};
    assign loadTime = 3;
endmodule