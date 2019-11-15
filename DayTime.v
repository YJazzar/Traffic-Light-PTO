/* @return the 1-Hot number corrosponding to the lane with the 
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
    output [3:0] out;

    // Add all adjacent lanes
    wire [3:0][8:0] laneSum;
    Adder_8 one (lane[0], lane[1], laneSum[0]);
    Adder_8 two (lane[2], lane[3], laneSum[1]);
    Adder_8 three (lane[4], lane[5], laneSum[2]);
    Adder_8 four (lane[6], lane[7], laneSum[3]);

    

endmodule  

/* @return a true/false value if A > B
 * 
 * Where:
 *      A = 9 bits wide
 *      B = 9 bits wide
 */
module MagnitudeComparator (A, B, Result);
    input [8:0] A, B;
    output Result;

    assign Result = A > B;
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
//----------------------------------------------------------------------
