

module CounterTestBench();
	//clock signal
	reg clk;
    parameter BIT_WIDTH = 6;
    reg reset, down, load;
    reg [BIT_WIDTH-1:0] loadIn;
    
    wire [BIT_WIDTH-1:0] currentCount;
    wire isZero;
    SaturationTimer #(BIT_WIDTH) sc(clk, down, loadIn, currentCount, isZero);

	
	initial begin
		forever begin
			#5 
			clk = 0 ;
			#5
			clk = 1 ;
		end
    end

	
	integer f;

	//display currentCountput
    initial begin
        $display("Begin");
		f = $fopen("output-Counter.txt","w");
		$fwrite(f, "CLK|RST| down | load|loadIn | currCount | isZero |\n");
		$fwrite(f, "---|---|------|-----|-------|-----------|--------|\n");
		#1
		forever begin
		#5
             $fwrite(f, " %b | %b |   %b  |  %b  | %4d |   %4d   |    %b   |\n", 
                clk, reset, down, load, loadIn, currentCount, isZero);

											
		end												
    end
	
	//input stimulus (changing number of cars)
	 initial begin 
        #2  
        #10 down = 0;  
        #10 down = 0;                          // Reset to Zero
        #10 down = 0; loadIn = 10; 
        #10 down = 1;        
        #170
        #10 down = 1;  loadIn = 31;             // Reset to zero
        #10 down = 1;  loadIn = 15;     // Load 15 into the counter
        #10 down = 1; 
        #10 down = 1; 
        #350
		$fclose(f);	
        $finish;
    end

endmodule
