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

//  MODULES TO CONTROL THE TRAFFIC MODE
module TrafficMode (clk, timeSignal, pedSignal, emgSignal, trafficModeOutput);

    //  INPUT
    input clk;
    input timeSignal, pedSignal, emgSignal;
    output [1:0] trafficModeOutput;

    //  LOCAL VARIABLES
    wire [1:0] nextState;

    assign nextState = {{pedSignal | emgSignal}, 
                        {(~timeSignal & ~pedSignal) | emgSignal}};

    DFF #(2) trafficMode(clk, nextState, trafficModeOutput);
endmodule

/**********************************************
    THESE ARE TESTS FOR THE TRAFFIC MODE MODULE
***********************************************/

module TrafficModeTestBreadboard (clk, timeSignal, pedSignal, emgSignal);
    //  INPUT
    input clk;
    input timeSignal, pedSignal, emgSignal;

    //  LOCAL VARIABLES
    wire [1:0] trafficMode;

    TrafficMode TM (clk, timeSignal, pedSignal, emgSignal, trafficMode);
endmodule

module TrafficModeTest ();
    //  REGISTERS
    reg clk;
    reg timeSignal;
    reg pedSignal;
    reg emgSignal;

    //  BREADBOARD
    TrafficModeTestBreadboard TMTB(clk, timeSignal, pedSignal, emgSignal);

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
        $display("CLK|TIME|PED|EMG|OUT");
        $display("---+----+---+---+---");
        forever
            begin
                #5
                $display("%1b  |%1b   |%1b  |%1b  |%2b", clk, timeSignal, pedSignal, emgSignal, TMTB.trafficMode);
            end
    end

    //  THREAD WITH INPUT STIMULUS
    initial
    begin
        #2
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 1; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 1; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 1; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 1; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        $finish;
    end
endmodule