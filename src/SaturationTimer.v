
//=============================================
// Saturation Timer
//=============================================
// module SaturationTimer#(parameter COUNT_SIZE = 5) (clk, rst, up, down, load, loadMin, minIn, in, currCount, done);
//     //---------------------------------------------
//     // inputs/outputs
//     //---------------------------------------------
//     input clk, rst, up, down, load;
//     input [1:0] loadMin;
//     input [COUNT_SIZE-1:0] in, minIn ;
//     output [COUNT_SIZE-1:0] currCount;      // This will hold the actual value of the timer 
//     output done;                            // This will signify if the timer is 0 or not

//     //---------------------------------------------
//     // Local Variables
//     //---------------------------------------------
//     wire [COUNT_SIZE-1:0] next, satDpOutPm1, satDpOutDown, satDpOutUp;
//     wire [COUNT_SIZE-1:0] min;
//     wire [COUNT_SIZE-1:0] mux2out;

//     //---------------------------------------------
//     // Load Min Count
//     //---------------------------------------------
//     //Dec minDec (loadMin, selectMin);
//     Mux2 #(COUNT_SIZE) muxSat (minIn, min, loadMin, mux2out);
//     DFF #(COUNT_SIZE) mincount(clk, mux2out, min);

//     //---------------------------------------------
//     // Main Counter Control
//     //---------------------------------------------

//     //  SAT INC/DEC DATAPATH
//     assign satDpOutUp = ({COUNT_SIZE{1'b1}} > currCount) ? currCount + {{COUNT_SIZE-1{down}}, 1'b1} : {COUNT_SIZE{1'b0}};
//     assign satDpOutDown = (min < currCount) ? currCount + {{COUNT_SIZE-1{down}}, 1'b1} : min;
//     assign satDpOutPm1 = ({down} > 0) ? {satDpOutDown} : {satDpOutUp};

//     //  DFF REGISTER TO HOLD COUNT
//     DFF #(COUNT_SIZE) count (clk, next, currCount);

//     //  MUX TO FIND NEXT VALUE OF COUNT
//     Mux4 #(COUNT_SIZE) mux(currCount, in, satDpOutPm1, {COUNT_SIZE{1'b1}}, {(~rst & ~up & ~down & ~load), (~rst & load), (~rst & (up | down)), rst}, next);
//     EqualTo #(COUNT_SIZE) equalToZero (currCount, 5'b0, done);


// endmodule


/*
 *  This module will calculate the next value of counter 
 *  @param:
 *      Inputs:
 *          down -> is true when the counter needs to count down
 *          prevCount -> The value currently stored in the counter 
 *
 *      Outputs:
 *          nextCount -> The next value of "currCount" (This is one of the inputs to a mux in "Saturated Counter")
 *
 *      local variables:
 *          stop -> A temporary wire that will check if the counter has reached 0. If so, it stops subtracting 1 from "prevCount"
 */
module Counter (down, prevCount, nextCount);
    parameter BIT_WIDTH = 6;
    
    input down;
    input   [BIT_WIDTH-1:0] prevCount;
    output  [BIT_WIDTH-1:0] nextCount;

    wire stop;    
    assign stop = (prevCount == 0);                                         // stop is true when the count has reached 0

    assign nextCount = ({BIT_WIDTH{down & ~stop}} & (prevCount - 1'b1))     // Subtract 1 if down == 1
                    | ({BIT_WIDTH{~down & ~stop}} & (prevCount))            // No-op if down != 1
                    | ({BIT_WIDTH{stop}} & prevCount);                      // No-op if stop == 1

endmodule

/*
 *  This module will calculate the selector bits that go into the mux
 *  @param:
 *      Inputs:
 *          reset -> reset signal
 *          down -> is true when the counter needs to count down
 *          load -> a 1 bit number signifying when to load in (can be used to force a load into "currCount")
 *          isZero -> a wire thats value will signify if "currCount" is equal to 0 or not
 *
 *      Outputs:
 *          out -> The resulting selector line based on the boolean equations
 *          
 */
module CombinationalLogic (reset, down, load, isZero, out);
    parameter BIT_WIDTH = 4;

    input reset, down, load, isZero;
    output [3:0] out;

    assign out[3] = (~reset & ~down & ~load)        // Is true for a No-op
                    | (~reset & down & load);   
    assign out[2] = ~reset & ~down & load;          // Is true when its time to load
    assign out[1] = (~reset & down & ~load);        // Is true when it needs to count down
    assign out[0] = reset | isZero;                 // Is true when it needs to reset
    
endmodule

/*
 *  This module will count down from whatever number is stored in "currCount" until it hits zero, to which it will 
 *      then reset itself to whatever value is stored in "loadIn"
 *  @param:
 *      Inputs:
 *          clk -> Clock signal
 *          reset -> reset signal
 *          down -> is true when the counter needs to count down
 *          load -> a 1 bit number signifying when to load in (can be used to force a load into "currCount")
 *          loadIn -> a wire that will hold the value that the counter needs to countdown the next time it resets
 *
 *      Outputs:
 *          currCount -> a wire that holds the value of the current count stored in the timer's "countRegister"
 *          isZero -> a wire thats value will signify if "currCount" is equal to 0 or not
 * 
 *      local variables:
 *          nextCount -> The next predicted count if the system doesn't reset
 *          mux4Out -> The output of the mux that chooses between the actions to: reset, load, countdown, or No-op. This is later stored inside the "countRegister"
 *          clOut -> "Combinational Logic Output" that serves as the select bit to the 4-Channel mux
 *          ZERO -> A register that holds the constant number for 0
 */
module SaturationCounter (clk, reset, down, load, loadIn, currCount, isZero);
    parameter BIT_WIDTH = 4;
    reg [BIT_WIDTH-1:0] ZERO = 0;

    // Basic inputs used in other modules
    input clk, reset;

    // Commands that go into the Combinational Logic Unit
    input down, load;

    // Input used when loading in numbers 
    //      In is used to load in a current value
    //      maxIn Used to load in a maximum value
    input   [BIT_WIDTH-1:0] loadIn;
    
    // out is Output of the entire clock
    output [BIT_WIDTH-1:0] currCount;
    output isZero;
    
    // currCount: Holds the current count (will get its value from the count register) 
    // currMax: Holds the current max (will get its value from the max register) 
    // nextCount: Make the counter
    wire [BIT_WIDTH-1:0] nextCount, mux4Out;
    wire [3:0] clOut;


    Counter #(BIT_WIDTH) counter (down, currCount, nextCount);

    // Use Combinational logic to get the 1-hot number that goes into the following mux
    CombinationalLogic #(BIT_WIDTH) cl(reset, down, load, isZero, clOut); 

    // Pass the output of the CL unit into the 4-channel mux
    Mux4 #(BIT_WIDTH) mux4(currCount, loadIn, nextCount, loadIn, clOut, mux4Out);

    // Make the register with the input being from the mux
    DFF #(BIT_WIDTH, 1'bx) countRegister (clk, mux4Out, currCount);

    // Calculate the value for "isZero"
    EqualTo #(BIT_WIDTH) equalToZero (currCount, ZERO, isZero);

endmodule