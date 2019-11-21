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

module CounterTestBench();
	//clock signal
	reg clk;
    parameter BIT_WIDTH = 5;
    reg reset, up, down, load, loadMax;
    reg [BIT_WIDTH-1:0] maxIn, in;
    
    wire [BIT_WIDTH-1:0] currentCount;
    CountDownTimer #(BIT_WIDTH) sc(clk, reset, down, load, in, currentCount);


	
	initial begin
		forever begin
			#5 
			clk = 0 ;
			#5
			clk = 1 ;
		end
    end

	initial begin 
		reset = 1;
		#10
		reset = 0;
	end
	

	
	integer f;

	//display currentCountput
    initial begin
        $display("Begin");
		f = $fopen("output-Counter.txt","w");
		$fwrite(f, "CLK|RST|up |down | load|loadMax| CurrIn | Max In |currMax | Output |\n");
		$fwrite(f, "---+---+---+-----+-----|-------|--------|--------|--------|--------|\n");
		#1
		forever begin
		#5
			 $fwrite(f, " %b | %b | %b |  %b  |  %b  |   %b   | %b  | %b  | %b  | %b  |\n", 
                clk, reset, up, down, load, loadMax, in, maxIn, sc.counter.max, currentCount);

											
		end			
		$fclose(f);											
    end
	
	//input stimulus (changing number of cars)
	 initial begin 
        #17  
        #10 reset = 0; up = 0; down = 0; load = 0; 
        #10 reset = 1; up = 0; down = 0; load = 0;                          // Reset to Zero
        #10 reset = 0; up = 0; down = 0; load = 0; loadMax = 1; maxIn = 31; // Load 31 into maximum register
        #10 reset = 0; up = 1; down = 0; load = 0; loadMax = 0;             // Count up for  sufficient amount of time to show output should stop at 31
        #350
        
        $fwrite(f, "---+---+---+-----+-----|-------|--------|--------|--------|--------|\n");
        $fwrite(f, "CLK|RST|up |down | load|loadMax| CurrIn | Max In |currMax | Output |\n");
        $fwrite(f, "---+---+---+-----+-----|-------|--------|--------|--------|--------|\n");
       
        #10 reset = 1; up = 0; down = 0; load = 0;              // Reset to zero
        #10 reset = 0; up = 0; down = 0; load = 1; in = 15;     // Load 15 into the counter
        #10 reset = 0; up = 0; down = 1; load = 0;
        #170
        #10 reset = 1; up = 0; down = 1; load = 0;

		$fclose(f);	
        $finish;
    end

endmodule

