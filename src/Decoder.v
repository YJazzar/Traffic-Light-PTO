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

	assign out[0] = ~largest[1] & ~largest[0];
    assign out[1] = ~largest[1] &  largest[0];
    assign out[2] =  largest[1] & ~largest[0];
    assign out[3] =  largest[1] &  largest[0];
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