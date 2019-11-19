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
endmodule