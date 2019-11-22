/**********************************************
    THESE ARE TESTS FOR THE TRAFFIC MODE MODULE
***********************************************/

/*
module TrafficModeTestBreadboard (clk, rst, timeSignal, pedSignal, emgSignal);
    //  INPUT
    input clk, rst;
    input timeSignal, pedSignal, emgSignal;

    //  LOCAL VARIABLES
    wire [1:0] trafficMode;

    TrafficMode TM (clk, rst, timeSignal, pedSignal, emgSignal, trafficMode);
endmodule

module TrafficModeTest ();
    //  REGISTERS
    reg clk, rst;
    reg timeSignal;
    reg pedSignal;
    reg emgSignal;

    //  BREADBOARD
    TrafficModeTestBreadboard TMTB(clk, rst, timeSignal, pedSignal, emgSignal);

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
        $display("CLK|RST|TIME|PED|EMG|OUT");
        $display("---+---+----+---+---+---");
        forever
            begin
                #5
                $display("%1b  |%1b  |%1b  |%1b  |%1b  |%2b", clk, rst, timeSignal, pedSignal, emgSignal, TMTB.trafficMode);
            end
    end

    //  THREAD WITH INPUT STIMULUS
    initial
    begin
        #2
        #5 timeSignal = 0; rst = 1; pedSignal = 0; emgSignal = 0;
        #5 $display("^rst Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 1; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 1; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 1; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Night Signal^");
        #5 timeSignal = 1; rst = 0; pedSignal = 0; emgSignal = 0;
        #5 $display("^Day Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 1; emgSignal = 0;
        #5 $display("^Ped Signal^");
        #5 timeSignal = 0; rst = 0; pedSignal = 0; emgSignal = 1;
        #5 $display("^Emg Signal^");
        $finish;
    end
endmodule

*/