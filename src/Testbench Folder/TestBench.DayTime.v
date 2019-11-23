// // // module TrafficModeTestBench();

// // // 	//clock signal
// // // 	reg clk;
// // // 	initial begin
// // // 		forever begin
// // // 			#5 
// // // 			clk = 0 ;
// // // 			#5
// // // 			clk = 1 ;
// // // 		end
// // //     end
	
	
// // // 	//registers to/from daytime
// // //     reg  [7:0][7:0] carCounts; //same as reg [7:0] carCounts[0:7]
// // //     wire [7:0] laneOutput;
  
// // // 	// Outside inputs used for TrafficMode
// // // 	reg pedSignal, emgSignal, dayTime;

// // // 	// Output of Traffic Mode
// // // 	wire [1:0] currentState;	


// // // 	TrafficMode tf (clk, pedSignal, emgSignal, dayTime, currentState);
	
// // // 	//display output
// // //     initial begin
// // // 		#1
// // // 		forever begin
// // // 		#5
// // // 			$display("clk: %b ------- currentState: %2b", clk, currentState);
// // // 			$display("pedSignal = %1b", pedSignal);
// // // 			$display("emgSignal = %1b", emgSignal);
// // // 			$display("  dayTime = %1b", dayTime);
// // // 			$display("---------------------------------");
// // // 		end														
// // //     end
	
// // // 	//input stimulus
// // // 	initial begin
// // // 		#2
// // // 		pedSignal = 1'b0;
// // // 		emgSignal = 1'b0;
// // // 		  dayTime = 1'b0;
// // // 		#10
// // // 		pedSignal = 1'b0;
// // // 		emgSignal = 1'b0;
// // // 		  dayTime = 1'b1;
// // // 		#10
// // // 		pedSignal = 1'b0;
// // // 		emgSignal = 1'b1;
// // // 		  dayTime = 1'b0;
// // // 		#10
// // // 		pedSignal = 1'b0;
// // // 		emgSignal = 1'b1;
// // // 		  dayTime = 1'b1;
// // // 		#10
// // // 		pedSignal = 1'b1;
// // // 		emgSignal = 1'b0;
// // // 		  dayTime = 1'b0;
// // // 		#10
// // // 		pedSignal = 1'b1;
// // // 		emgSignal = 1'b0;
// // // 		  dayTime = 1'b0;
// // // 		#10
// // // 		pedSignal = 1'b1;
// // // 		emgSignal = 1'b0;
// // // 		  dayTime = 1'b1;
// // // 		#10
// // // 		pedSignal = 1'b1;
// // // 		emgSignal = 1'b1;
// // // 		  dayTime = 1'b0;
// // // 		#10
// // // 		pedSignal = 1'b1;
// // // 		emgSignal = 1'b1;
// // // 		  dayTime = 1'b1;
// // // 		#10
// // // 		$finish;
// // // 	end



// // // endmodule

module DayTimeTestBench();
	//clock signal
	reg clk;
	reg rst;
	
	initial begin
		forever begin
			#5 
			clk = 0 ;
			#5
			clk = 1 ;
		end
    end

	initial begin 
		rst = 1;
		#10
		rst = 0;
	end
	
	
	//registers to/from daytime
    reg  [7:0][7:0] carCounts; //same as reg [7:0] carCounts[0:7]
    wire [7:0] laneOutput;
    wire  [6:0] loadTimer;
    DayTime dt(clk, carCounts, laneOutput, loadTimer);
	// (clk, isZero, lane, laneOutput, loadTimer);
	integer f;



	//display output
    initial begin
		f = $fopen("output-DayTime.txt","w");
		$fwrite(f, "-----------------------------------\n");
		#1
		forever begin
		#5
			$fwrite(f, "N1:%8d  N2:%8d\nE1:%8d  E2:%8d\nS1:%8d  S2:%8d\nW1:%8d  W2:%8d\nclk: %1b\nlights(WWSSEENN):%8b\n-----------------------------------\n",
															carCounts[0], carCounts[1], 
															carCounts[2], carCounts[3],
															carCounts[4], carCounts[5],
															carCounts[6], carCounts[7],
															clk,
															laneOutput);
											
		end			
		$fclose(f);											
    end
	
	//input stimulus (changing number of cars)
	initial begin
		#2
		carCounts[0] = 8'b00000111;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00000000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b01111111;carCounts[5] = 8'b00000000;
		carCounts[6] = 8'b00000000;carCounts[7] = 8'b00000000;
		#10
		carCounts[0] = 8'b00000100;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00001000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00001000;carCounts[5] = 8'b00000100;
		carCounts[6] = 8'b00000010;carCounts[7] = 8'b10000000;
		#10
		carCounts[0] = 8'b00000100;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00001000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00001000;carCounts[5] = 8'b10000100;
		carCounts[6] = 8'b00000010;carCounts[7] = 8'b10000000;
		#10
		carCounts[0] = 8'b00000100;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00001000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00001000;carCounts[5] = 8'b00000100;
		carCounts[6] = 8'b00000010;carCounts[7] = 8'b00000000;
		#10
		carCounts[0] = 8'b10000100;carCounts[1] = 8'b10000000;
		carCounts[2] = 8'b01001000;carCounts[3] = 8'b10100000;
		carCounts[4] = 8'b00001000;carCounts[5] = 8'b10000100;
		carCounts[6] = 8'b00000010;carCounts[7] = 8'b10000000;
		#20
		
		$finish;
	end

endmodule

