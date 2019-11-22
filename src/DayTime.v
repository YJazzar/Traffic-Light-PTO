/*
 *  This Module will figure out the repective enable lines for: Day-time, Night-time, Pedestrian, and Emergency
 *  @param:
 *      Inputs:
 *          clk -> Clock signal
 *          isZero -> a true/false value for when timer has reached 0 or not
 *          lane -> 8 bits for each lane, where:
 *                  lane[0] = N1
 *                  lane[1] = N2
 *                  lane[2] = E1
 *                  lane[3] = E2
 *                  lane[4] = S1
 *                  lane[5] = S2
 *                  lane[6] = W1
 *                  lane[7] = W2  
 *
 *      Outputs:
 *          laneOutput -> an 8-bit value for each traffic light, where:
 *                  out = 00000011 -> lane = N
 *                  out = 00001100 -> lane = E
 *                  out = 00110000 -> lane = S
 *                  out = 11000000 -> lane = W
 *          loadTimer -> A wire that holds the value the timer should reset to the next time it reaches 0
 * 
 *      local variables:
 *          largestLane -> an itnermediate value between currMax and nextMax to ensure no duplicates happen
 *          decOut -> Changing the "state" of the traffic light signals to an actual output that can be sent to them (by using a decoder)
 *          currMax -> The current "state" of the traffic signals (this will feed into the decoder)
 *          newLane -> An array similar to "lane" that changes whichever lane previously had a green light to zero
 *          offsetTime -> an offset to the default 20sec to be added based on how full each lane is
 *          
 */
module DayTime (clk, isZero, lane, laneOutput, loadTimer);
    input [7:0][7:0] lane;
    input clk, isZero;

    output [7:0] laneOutput;
    output [6:0] loadTimer;

    wire [1:0] largestLaneIndex;
    wire [3:0] decOut;
    wire [3:0] currMax;
    wire [7:0][7:0] newLane;
	wire [1:0][8:0] largestTwoLanes; //for offset comparison
    wire [6:0] offsetTime;  // TODO; Implement

  
    // Force set the last lane that had the green light to zero:    
    // North lanes
    assign newLane[0] = {8{~laneOutput[0]}} & lane[0];
    assign newLane[1] = {8{~laneOutput[1]}} & lane[1];
    // East lanes  
    assign newLane[2] = {8{~laneOutput[2]}} & lane[2];
    assign newLane[3] = {8{~laneOutput[3]}} & lane[3];
    // South lanes  
    assign newLane[4] = {8{~laneOutput[4]}} & lane[4];
    assign newLane[5] = {8{~laneOutput[5]}} & lane[5];
    // West lanes  
    assign newLane[6] = {8{~laneOutput[6]}} & lane[6];
    assign newLane[7] = {8{~laneOutput[7]}} & lane[7];


    // Add all adjacent lanes
    wire [3:0][8:0] laneSum;
    AddLanes adders (newLane, laneSum);

    // A 2 bit wire (from GetLargestLane Module) that gets the largest lane
    GetLargestLane largest (laneSum, largestTwoLanes, largestLaneIndex);
	
	// To find how much the timer should count down, we do the following operations
    OffSet howMuchDiffBetweenLargestAndSecondLargestLane (largestTwoLanes, offsetTime); //TODO: Implement

    // Get the 1-hot for which lane to turn on
    Decoder dec (largestLaneIndex, decOut);
	
	DFF decoderOut[3:0] (clk, decOut, currMax);

    DecoderToLights decToLights (currMax, laneOutput);

endmodule




/*  @return the 1-Hot number corrosponding to the lane with the 
 *  largest number of cars present.
 *  Where:
 *      lane[0] = N1
 *      lane[1] = N2
 *      lane[2] = E1
 *      lane[3] = E2
 *      lane[4] = S1
 *      lane[5] = S2
 *      lane[6] = W1
 *      lane[7] = W2
 * 
 *      out = 0001 -> lane = N
 *      out = 0010 -> lane = E
 *      out = 0100 -> lane = S
 *      out = 1000 -> lane = W
 *      
 */
module GetLargestLane (laneSum, largestTwoLanes, out);
    input  [3:0][8:0] laneSum;
	output [1:0][8:0] largestTwoLanes;
    output [1:0] out;


    // Wire holding results of comparator 
    wire [2:0] mgResult;
    // Wire holding output from the 2 intermediate mux
    wire [1:0][8:0] intermediateMax;

    // Compare the first two lanes (North and East)
    MagnitudeComparator mg1 (laneSum[0], laneSum[1], mgResult[0]);  // mgResult[0] = laneSum[0] > laneSum[1] = North > East
    MagnitudeComparator mg2 (laneSum[2], laneSum[3], mgResult[1]);  // mgResult[1] = laneSum[2] > laneSum[3] = South > West

    // Get the max lane from mg1
    Mux2 #(9) mux1 (laneSum[1], laneSum[0], {~mgResult[0], mgResult[0]}, intermediateMax[0]);
    // Get the max lane from mg2
    Mux2 #(9) mux2 (laneSum[3], laneSum[2], {~mgResult[1], mgResult[1]}, intermediateMax[1]);
	
	//return the actual # of cars in the largest two lanes. used to calculate offest.
	assign largestTwoLanes = {intermediateMax[0], intermediateMax[1]};
	
    MagnitudeComparator mg3 (intermediateMax[0], intermediateMax[1], mgResult[2]);

    // The three wires to figure out the final max:
    //      mgResult[0], mgResult[1], mgResult[2]
    wire [2:0] temp;
    assign temp[0] = ~mgResult[1] & ~mgResult[2];
    assign temp[1] = ~mgResult[0] & mgResult[2];
    assign temp[2] = temp[0] | temp[1];

    assign out = {~mgResult[2], temp[2]};
    

endmodule  


// Add all adjacent lanes
module AddLanes (newLane, laneSum);
    input  [7:0][7:0] newLane;
    output [3:0][8:0] laneSum;

    Adder_8 one   (newLane[0], newLane[1], laneSum[0]);   // Add North lanes
    Adder_8 two   (newLane[2], newLane[3], laneSum[1]);   // Add East  lanes
    Adder_8 three (newLane[4], newLane[5], laneSum[2]);   // Add South lanes
    Adder_8 four  (newLane[6], newLane[7], laneSum[3]);   // Add West  lanes
endmodule

module OffSet (largestTwoLanes, offsetTime);
	input  [1:0][8:0] largestTwoLanes;
	output [6:0] offsetTime;
	
	
	wire  [1:0][8:0] twoMostSigBits;
	LeftArbiter9bit getMostSigBit [1:0] (largestTwoLanes, twoMostSigBits);
	
	assign offsetTime = 7'b0010100;
	
	
endmodule
