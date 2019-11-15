/*  @return the 1-Hot number corrosponding to the lane with the 
 *          largest number of cars present.
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
 */
module GetLargestLane (lane, out);
    input [7:0][7:0] lane;
    output [1:0] out;

    // Add all adjacent lanes
    wire [3:0][8:0] laneSum;
    Adder_8 one   (lane[0], lane[1], laneSum[0]);
    Adder_8 two   (lane[2], lane[3], laneSum[1]);
    Adder_8 three (lane[4], lane[5], laneSum[2]);
    Adder_8 four  (lane[6], lane[7], laneSum[3]);

    // Wire holding results of comparator 
    wire [2:0] mgResult;
    // Wire holding output from the 2 intermediate mux
    wire [1:0][8:0] intermediateMax;

    // Compare the first two lanes (North and East)
    MagnitudeComparator mg1 (laneSum[0], laneSum[1], mgResult[0]);
    MagnitudeComparator mg2 (laneSum[2], laneSum[3], mgResult[1]);

    // Get the max lane from mg1
    Mux2Ch mux1 (laneSum[0], laneSum[1], {mgResult[0], ~mgResult[0]}, intermediateMax[0]);
    // Get the max lane from mg1
    Mux2Ch mux2 (laneSum[2], laneSum[3], {mgResult[1], ~mgResult[1]}, intermediateMax[1]);

    MagnitudeComparator mg3 (intermediateMax[0], intermediateMax[1], mgResult[2]);

    // The three wires to figure out the final max:
    //      mgResult[0], mgResult[1], mgResult[2]
    wire [2:0] temp;
    assign temp[0] = ~mgResult[1] & ~mgResult[2];
    assign temp[1] = ~mgResult[0] & mgResult[2];
    assign temp[2] = temp[0] | temp[1];

    assign out = {~mgResult[2], temp[2]};
    

endmodule  

/*  @return a true/false value if A > B
 * 
 *  Where:
 *      A = 9 bits wide
 *      B = 9 bits wide
 */
module MagnitudeComparator (A, B, Result);
    input [8:0] A, B;
    output Result;

    assign Result = A > B;
endmodule

/*  @return the chosen channel
 *  @param select -> a 1-Hot number to choose the channel
 */
module Mux2Ch (channel0, channel1, select, out);
    parameter BIT_WIDTH = 9;

    input   [BIT_WIDTH-1:0]  channel0;
    input   [BIT_WIDTH-1:0]  channel1;
    input   [1:0]    select;
    output  [BIT_WIDTH-1:0]  out;

    assign out = ({BIT_WIDTH{select[1]}} & channel1) | ({BIT_WIDTH{select[0]}} & channel0);

endmodule


/* @return A + B
 * 
 * Where:
 *      A = 8 bits wide
 *      B = 8 bits wide
 *      Result = 9 bits wide
 */
module Adder_8 (A, B, Result);
    input [7:0] A, B;
    output [8:0] Result;

    assign Result = A + B;
endmodule

module D_Flip_Flop (clk, in, out);
    input   clk;
    input   in;
    output  out;
    reg     out;

    always @(posedge clk)
        out = in;

endmodule

/*  @return the 1-Hot number corrosponding to the lane with the 
 *          largest number of cars present.
 *  Where: 
 *      out = 0001 -> lane = N
 *      out = 0010 -> lane = E
 *      out = 0100 -> lane = S
 *      out = 1000 -> lane = W
 */
module Decoder(largest, out);
	input [1:0] largest;
	output [3:0] out;

	assign out[0] = ~largest[0] & ~largest[1];
    assign out[1] = ~largest[0] &  largest[1];
    assign out[2] =  largest[0] & ~largest[1];
    assign out[3] =  largest[0] &  largest[1];
endmodule

module DecoderToLights (inFromDecoder, outToLights);
    input  [3:0] inFromDecoder;
    output [7:0] outToLights;

    //4 bit decoder onehot to 8 bit lights output
    assign outToLights = {inFromDecoder[3], inFromDecoder[3], 
                        inFromDecoder[2], inFromDecoder[2], 
                        inFromDecoder[1], inFromDecoder[1], 
                        inFromDecoder[0], inFromDecoder[0]};
endmodule

//----------------------------------------------------------------------


module DayTime (lane, clk, laneOutput);
    input [7:0][7:0] lane;
    input clk;
    output [7:0] laneOutput;

    // A 2 bit wire (from GetLargestLane Module) that gets stored into D-Flip-Flops
    wire [1:0] largestOut;
    GetLargestLane largest (lane, largestOut);

    // Feed the output of GetLargestLane module into the D-Flip-Flop
    wire [1:0] currMax;
    D_Flip_Flop dffHighBit (clk, largestOut[1], currMax[1]);
    D_Flip_Flop dffLowBit (clk, largestOut[0], currMax[0]);

    // Get the 1-hot for which lane to turn on
    wire [3:0] decOut;
    Decoder dec (currMax, decOut);

    wire [7:0] temp;
    DecoderToLights decToLights (decOut, temp);
    assign laneOutput = temp;

endmodule