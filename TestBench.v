
module testbench();

    reg [8:0] lane1 = 9'b101010101;
    reg [8:0] lane2 = 9'b000111011; 
    wire  Result;

    MagnitudeComparator mg (lane2, lane1, Result);

    initial begin

    $display("%b", Result);

    $finish;
    end

endmodule

