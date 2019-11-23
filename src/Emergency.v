//module Emergency(emergencyLane, laneOutput, loadCommand, loadTime);
module Emergency(emergencyLane, laneOutput, loadTime);
    //  INPUTS
    input [0:7] emergencyLane;

    //  OUTPUTS
    output [0:7] laneOutput;
    output [6:0] loadTime;
    //output loadCommand;

    assign laneOutput = {{emergencyLane[0] | emergencyLane[1]}, {emergencyLane[0] | emergencyLane[1]},
                         {emergencyLane[2] | emergencyLane[3]}, {emergencyLane[2] | emergencyLane[3]},
                         {emergencyLane[4] | emergencyLane[5]}, {emergencyLane[4] | emergencyLane[5]},
                         {emergencyLane[6] | emergencyLane[7]}, {emergencyLane[6] | emergencyLane[7]}};
    assign loadTime = 4;
    /*assign loadCommand =  emergencyLane[0] |  emergencyLane[1]
                        | emergencyLane[2] |  emergencyLane[3]
                        | emergencyLane[4] |  emergencyLane[5]
                        | emergencyLane[6] |  emergencyLane[7];
	*/
endmodule