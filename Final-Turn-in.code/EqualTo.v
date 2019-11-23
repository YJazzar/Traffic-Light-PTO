
module EqualTo (A, B, result);
    parameter n = 8;
    input [n-1:0] A, B;
    output result;

    assign result = (A == B);

endmodule
