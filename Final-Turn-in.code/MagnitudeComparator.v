
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