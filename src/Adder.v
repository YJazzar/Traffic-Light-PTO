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