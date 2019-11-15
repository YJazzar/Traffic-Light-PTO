
//=============================================
// D Flip-Flop
//=============================================
module DFF #(parameter REGISTER_WIDTH = 1) (clk,in,out);
  input  clk;
  input  [REGISTER_WIDTH-1:0]  in;
  output [REGISTER_WIDTH-1:0] out;
  reg    [REGISTER_WIDTH-1:0] out;
  
  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
    out = in;
 endmodule

//=============================================
// 2-Channel, n-Bit Multiplexer with One-Hot Selector
//=============================================
//  parameter just lets us use a preprocessor directive to set 
//  a different value for BUS_WIDTH
//  1 is the default value
module Mux2 #(parameter BUS_WIDTH = 1) (a1, a0, selector, out);
	input [BUS_WIDTH-1:0] a1, a0;  // inputs
	input [1:0] selector; // one-hot select
	output[BUS_WIDTH-1:0] out;

	assign out = ({BUS_WIDTH{selector[1]}} & a1) |
                 ({BUS_WIDTH{selector[0]}} & a0) ;
endmodule

//=============================================
// 4-Channel, n-Bit Multiplexer with One-Hot Selector
//=============================================
//  parameter just lets us use a preprocessor directive to set 
//  a different value for BUS_WIDTH
//  1 is the default value
module Mux4 #(parameter BUS_WIDTH = 1) (a3, a2, a1, a0, selector, out);
	input [BUS_WIDTH-1:0] a3, a2, a1, a0;  // inputs
	input [3:0] selector; // one-hot select
	output[BUS_WIDTH-1:0] out;

	assign out = ({BUS_WIDTH{selector[3]}} & a3) | 
                 ({BUS_WIDTH{selector[2]}} & a2) | 
                 ({BUS_WIDTH{selector[1]}} & a1) |
                 ({BUS_WIDTH{selector[0]}} & a0) ;
endmodule

//=============================================
// Saturation Counter
//=============================================
module SaturationCounter #(parameter COUNT_SIZE = 5) (clk, rst, up, down, load, loadMax, maxIn, in, out) ;
    //---------------------------------------------
    // inputs/outputs
    //---------------------------------------------
    input clk, rst, up, down, load;
    input [1:0] loadMax;
    input [COUNT_SIZE-1:0] in, maxIn ;
    output [COUNT_SIZE-1:0] out;

    //---------------------------------------------
    // Local Variables
    //---------------------------------------------
    wire [COUNT_SIZE-1:0] next, satDpOutPm1, satDpOutDown, satDpOutUp;
    wire [COUNT_SIZE-1:0] max;
    wire [COUNT_SIZE-1:0] mux2out;

    //---------------------------------------------
    // Load Max Count
    //---------------------------------------------
    //Dec maxDec (loadMax, selectMax);
    Mux2 #(COUNT_SIZE) muxSat (maxIn, max, loadMax, mux2out);
    DFF #(COUNT_SIZE) maxcount(clk, mux2out, max);

    //---------------------------------------------
    // Main Counter Control
    //---------------------------------------------

    //  SAT INC/DEC DATAPATH
    assign satDpOutUp = (max > out) ? out + {{COUNT_SIZE-1{down}}, 1'b1} : max;
    assign satDpOutDown = (0 < out) ? out + {{COUNT_SIZE-1{down}}, 1'b1} : {COUNT_SIZE{1'b0}};
    assign satDpOutPm1 = ({down} > 0) ? {satDpOutDown} : {satDpOutUp};

    //  DFF REGISTER TO HOLD COUNT
    DFF #(COUNT_SIZE) count (clk, next, out);

    //  MUX TO FIND NEXT VALUE OF COUNT
    Mux4 #(COUNT_SIZE) mux(out, in, satDpOutPm1, {COUNT_SIZE{1'b0}}, {(~rst & ~up & ~down & ~load), (~rst & load), (~rst & (up | down)), rst}, next);
                    //{COUNT_SIZE{1'b0}}, 
                    //{(~rst & ~up & ~down & ~load), (~rst & load), (~rst & (up | down)), rst}, 
                    //next); 
endmodule

module Breadboard #(parameter COUNT_SIZE = 5) (clk, rst, up, down, load, loadMax, maxIn, in);
    //  INPUT/OUPUT PARAMETERS
    input clk;
    input rst;
    input up;
    input down;
    input load;

    input [1:0] loadMax;
    input [COUNT_SIZE-1:0] maxIn;
    input [COUNT_SIZE-1:0] in;

    //  LOCAL VARIABLE TO HOLD OUTPUT OF SAT COUNTER
    wire [COUNT_SIZE-1:0] out;

    //  INSTATIATION OF SATURATION COUNTER
    SaturationCounter #(COUNT_SIZE) SatCounter(clk, rst, up, down, load, loadMax, maxIn, in, out);

endmodule

module TestBench();
    parameter COUNT_SIZE = 5;

    //  INPUTS
    reg clk;
    reg rst;
    reg up;
    reg down;
    reg load;

    reg [1:0] loadMax;
    reg [COUNT_SIZE-1: 0] maxIn;
    reg [COUNT_SIZE-1: 0] in;

    Breadboard Counter(clk, rst, up, down, load, loadMax, maxIn, in);

    //  THREAD WITH CLOCK CONTROL
    initial
    begin
        forever
            begin
                #5
                clk = 0;
                #5
                clk = 1;
            end 
    end

    //  THREAD THAT DISPLAYS OUTPUTS
    initial
    begin
        #2
        $display("CLK|RST|UP|DOWN|LOAD|LOADMAX|MAXIN|IN   |OUT");
        $display("---+---+--+----+----+-------+-----+-----+-----");
        forever
            begin
                #5
                $display("%1b  |%1b  |%1b |%1b   |%1b   |%2b     |%5b|%5b|%5b", clk, rst, up, down, load, loadMax, maxIn, in, Counter.out);
            end
    end

    //  THREAD WITH INPUT STIMULUS
    initial
    begin
        #2
        #5 rst = 1'b1; up = 1'b0; down = 1'b0; load = 1'b0; loadMax = 2'b01; maxIn = 5'b00000; in = 5'b00000;
        #5 $display("^Reset^");

        #5 rst = 1'b0; up = 1'b0; down = 1'b0; load = 1'b0; loadMax = 2'b10; maxIn = 5'b11111; in = 5'b00000;
        #5 $display("^Load 31 to max^");

        #5 rst = 1'b0; up = 1'b1; down = 1'b0; load = 1'b0; loadMax = 2'b01; maxIn = 5'b11111; in = 5'b00000;
        #340 $display("^Count to 31^");

        #5 rst = 1'b1; up = 1'b0; down = 1'b0; load = 1'b0; loadMax = 2'b01; maxIn = 5'b11111; in = 5'b00000;
        #5 $display("^Reset^");

        #5 rst = 1'b0; up = 1'b0; down = 1'b0; load = 1'b0; loadMax = 2'b10; maxIn = 5'b01111; in = 5'b00000;
        #5 $display("^Load 15 to max^");

        #5 rst = 1'b0; up = 1'b1; down = 1'b0; load = 1'b0; loadMax = 2'b01; maxIn = 5'b01111; in = 5'b00000;
        #202 $display("^Count to 15^");

        $finish;
    end
endmodule