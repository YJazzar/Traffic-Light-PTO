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

/**********************************************
                    TEST NUMBER 2:
***********************************************/


// module TrafficModeTestBench();

// 	//clock signal
// 	reg clk;
// 	initial begin
// 		forever begin
// 			#5 
// 			clk = 0 ;
// 			#5
// 			clk = 1 ;
// 		end
//     end
	
	
// 	//registers to/from daytime
//     reg  [7:0][7:0] carCounts; //same as reg [7:0] carCounts[0:7]
//     wire [7:0] laneOutput;
  
// 	// Outside inputs used for TrafficMode
// 	reg pedSignal, emgSignal, dayTime;

// 	// Output of Traffic Mode
// 	wire [1:0] currentState;	


// 	TrafficMode tf (clk, pedSignal, emgSignal, dayTime, currentState);
	
// 	//display output
//     initial begin
// 		#1
// 		forever begin
// 		#5
// 			$display("clk: %b ------- currentState: %2b", clk, currentState);
// 			$display("pedSignal = %1b", pedSignal);
// 			$display("emgSignal = %1b", emgSignal);
// 			$display("  dayTime = %1b", dayTime);
// 			$display("---------------------------------");
// 		end														
//     end
	
// 	//input stimulus
// 	initial begin
// 		#2
// 		pedSignal = 1'b0;
// 		emgSignal = 1'b0;
// 		  dayTime = 1'b0;
// 		#10
// 		pedSignal = 1'b0;
// 		emgSignal = 1'b0;
// 		  dayTime = 1'b1;
// 		#10
// 		pedSignal = 1'b0;
// 		emgSignal = 1'b1;
// 		  dayTime = 1'b0;
// 		#10
// 		pedSignal = 1'b0;
// 		emgSignal = 1'b1;
// 		  dayTime = 1'b1;
// 		#10
// 		pedSignal = 1'b1;
// 		emgSignal = 1'b0;
// 		  dayTime = 1'b0;
// 		#10
// 		pedSignal = 1'b1;
// 		emgSignal = 1'b0;
// 		  dayTime = 1'b0;
// 		#10
// 		pedSignal = 1'b1;
// 		emgSignal = 1'b0;
// 		  dayTime = 1'b1;
// 		#10
// 		pedSignal = 1'b1;
// 		emgSignal = 1'b1;
// 		  dayTime = 1'b0;
// 		#10
// 		pedSignal = 1'b1;
// 		emgSignal = 1'b1;
// 		  dayTime = 1'b1;
// 		#10
// 		$finish;
// 	end



// endmodule