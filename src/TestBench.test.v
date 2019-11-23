/**********************************************
    THESE ARE TESTS FOR THE TEST BENCH
***********************************************/
module TestTestBench ();
    integer f;  // File 
    //  SIGNALS
    reg clk, rst, pedSignal, emgSignal;
	reg [4:0] hoursIn;

    //  TRAFFIC LANE COUNT
    reg [7:0] w1;
	reg [7:0] w2;
	reg [7:0] s1;
	reg [7:0] s2;
	reg [7:0] e1;
    reg [7:0] e2;
	reg [7:0] n1;
    reg [7:0] n2;
    
    
    
    
    

    //  WHICH LANE THE EMERGENCY IS IN
    reg [7:0] emgLane;
	
	//carLights
	//wire TB.dayTimeLightOutput;

    //  BREADBOARD (clk, rst, hoursIn, pedSignal, emgSignal, emgLane, lanes, TB.dayTimeLightOutput);
    // Breadboard TB(clk, rst, hoursIn, pedSignal, emgSignal, emgLane, {n1, n2, e1, e2, s1, s2, w1, w2});
    wire [7:0] trafficLightOutput;
    Breadboard TB(clk, rst, hoursIn, pedSignal, emgSignal, emgLane, {w1, w2, s1, s2, e1, e2, n1, n2}, trafficLightOutput);


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
        f = $fopen("Final-Output.txt", "w");
        #7
        forever
            begin
                #5
                $fwrite(f, "=================================================================================\n", );
                $fwrite(f, "=================================================================================\n");
                $fwrite(f, "                                                              \n");
                $fwrite(f, "                            N                                 \n");
                $fwrite(f, "            S1: %8b                                           \n", s1);
                $fwrite(f, "            S2: %8b                                           \n", s2);
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                %1b%1b|   |   |###| %1b | %1b |%1b%1b         \n", TB.walkingLightOutput[6], TB.walkingLightOutput[0], trafficLightOutput[0], trafficLightOutput[1], TB.walkingLightOutput[4], TB.walkingLightOutput[7]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                 %1b                     W1: %8b              \n", trafficLightOutput[6], w1);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                 %1b                     W2: %8b              \n", trafficLightOutput[7], w2);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "  W               |   |   |###|   |   |                E      \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "     E1: %8b                      %1b                         \n", e1, trafficLightOutput[2]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "     E2: %8b                      %1b                         \n", e2, trafficLightOutput[3]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                %1b%1b| %1b | %1b |###|   |   |%1b%1b         \n", TB.walkingLightOutput[2], TB.walkingLightOutput[1], trafficLightOutput[4], trafficLightOutput[5], TB.walkingLightOutput[5], TB.walkingLightOutput[3]);
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                                 N1: %8b                      \n", n1);
                $fwrite(f, "                                 N2: %8b                      \n", n2);
                $fwrite(f, "                            S                                 \n");
                $fwrite(f, "                                                              \n");
                $fwrite(f, "CLK|RST|HOURSIN|dayNightSignal|PED|EMG|MODE|EMG_LANE|Countdown|            DayLoad|NgtLoad|EmgLoad|PedLoad|ACTUAL_LOAD|\n");
                $fwrite(f, "---+---+-------+--------------+---+---+----+WWSSEENN|---------\n");
                $fwrite(f, "%1b  |%1b  |%5b  |%1b             |%1b  |%1b  |%2b  |%8b|%7b  |            %7b|%7b|%7b|%7b|%7b    |\n", clk, rst, hoursIn, TB.dayNightSignal, pedSignal, emgSignal, TB.trafficMode, emgLane, TB.currentCount,
																								TB.dayLoadTime, TB.nightLoadTime, TB.emgLoadTime, TB.pedLoadTime, TB.loadIn);
                
            end
    end  
    //  THREAD WITH INPUT STIMULUS
    initial
    begin
		#2
		w1 = 8'b00110000; w2 = 8'b00001110; s1 = 8'b00000011; s2 = 8'b00000000;
        e1 = 8'b00000000; e2 = 8'b00000000; n1 = 8'b00000000; n2 = 8'b00001111;
		hoursIn = 5'b01100; pedSignal = 0; emgSignal = 0; emgLane = 8'b00000000;
		
		#5 rst = 1; 
        #5 rst = 0;
			
        #60 emgSignal = 1; emgLane = 8'b00001000; e2 = 8'b00000001;
		#40 emgSignal = 0; emgLane = 8'b00000000;
		#20
		w1 = 8'b00000000; w2 = 8'b00000000; s1 = 8'b00000011; s2 = 8'b00000011;
        e1 = 8'b00110000; e2 = 8'b00011100; n1 = 8'b00000000; n2 = 8'b00000000;
		
		#60 hoursIn = 22;
		#55 pedSignal = 1;
		#50
           
        // $fclose(f);
        $finish;
    end
endmodule