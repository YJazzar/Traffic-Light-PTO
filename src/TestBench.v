module testbench();

	//clock signal
	reg clk;
	initial begin
		forever begin
			#5 
			clk = 0 ;
			#5
			clk = 1 ;
		end
    end
	
	
	//registers to/from daytime
    reg  [7:0][7:0] carCounts; //same as reg [7:0] carCounts[0:7]
    wire [7:0] laneOutput;

    DayTime dt(carCounts, clk, laneOutput);
	
	//display output
    initial begin
		#1
		forever begin
		#5
			$display("Curr Max: %b -- Decoder out: %b -- LargestDFF: %b", dt.currMax, dt.decOut, dt.largest.out);
			$display("N1:%8b  N2:%8b\nE1:%8b  E2:%8b\nS1:%8b  S2:%8b\nW1:%8b  W2:%8b\nclk: %1b\nlights(NNEESSWW):%8b\n-----------------------------------",
															carCounts[0], carCounts[1], 
															carCounts[2], carCounts[3],
															carCounts[4], carCounts[5],
															carCounts[6], carCounts[7],
															clk,
															laneOutput);
		end														
    end
	
	//input stimulus (changing number of cars)
	initial begin
		#2
		carCounts[0] = 8'b00000000;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00000000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00000000;carCounts[5] = 8'b00000000;
		carCounts[6] = 8'b00000000;carCounts[7] = 8'b00000000;
		#10
		carCounts[0] = 8'b00000100;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00000000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00000000;carCounts[5] = 8'b00000000;
		carCounts[6] = 8'b00000000;carCounts[7] = 8'b00000000;
		#10
		carCounts[0] = 8'b00000000;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00010000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00000000;carCounts[5] = 8'b00000000;
		carCounts[6] = 8'b00000000;carCounts[7] = 8'b00000000;
		#10
		carCounts[0] = 8'b00000000;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00000000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00100000;carCounts[5] = 8'b00000000;
		carCounts[6] = 8'b00000000;carCounts[7] = 8'b00000000;
		#10
		carCounts[0] = 8'b00000000;carCounts[1] = 8'b00000000;
		carCounts[2] = 8'b00000000;carCounts[3] = 8'b00000000;
		carCounts[4] = 8'b00000000;carCounts[5] = 8'b00000000;
		carCounts[6] = 8'b01000000;carCounts[7] = 8'b00000000;
		#20
		
		
		$finish;
	end

endmodule

