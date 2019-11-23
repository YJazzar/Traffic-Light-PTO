/**********************************************
    THESE ARE TESTS FOR THE TEST BENCH
***********************************************/
module TestTestBench ();
    integer f;  // File 
    //  SIGNALS
    reg clk, rst, pedSignal, emgSignal;
	reg [4:0] hoursIn;

    //  TRAFFIC LANE COUNT
    reg [7:0] n1;
    reg [7:0] n2;
    reg [7:0] e1;
    reg [7:0] e2;
    reg [7:0] s1;
    reg [7:0] s2;
    reg [7:0] w1;
    reg [7:0] w2;

    //  WHICH LANE THE EMERGENCY IS IN
    reg [7:0] emgLane;
	
	//carLights
	//wire TB.dayTimeLightOutput;

    //  BREADBOARD (clk, rst, hoursIn, pedSignal, emgSignal, emgLane, lanes, TB.dayTimeLightOutput);
    Breadboard TB(clk, rst, hoursIn, pedSignal, emgSignal, emgLane, {n1, n2, e1, e2, s1, s2, w1, w2});

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
        #2
        forever
            begin
                #5
                $fwrite(f, "=================================================================================\n");
                $fwrite(f, "=================================================================================\n");
                $fwrite(f, "                                                              \n");
                $fwrite(f, "                            N                                 \n");
                $fwrite(f, "            S1: %8b                                           \n", s1);
                $fwrite(f, "            S2: %8b                                           \n", s2);
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                %1b%1b|   |   |###| %1b | %1b |%1b%1b         \n", TB.walkingLightOutput[6], TB.walkingLightOutput[0], TB.dayTimeLightOutput[0], TB.dayTimeLightOutput[1], TB.walkingLightOutput[4], TB.walkingLightOutput[7]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                 %1b                     W1: %8b              \n", TB.dayTimeLightOutput[6], w1);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                 %1b                     W2: %8b              \n", TB.dayTimeLightOutput[7], w2);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                  |   |   |###|       |                       \n");
                $fwrite(f, "  W               |   |   |###|       |                E      \n");
                $fwrite(f, "                  |   |   |###|       |                       \n");
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "     E1: %8b                      %1b                         \n", e1, TB.dayTimeLightOutput[2]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "     E2: %8b                      %1b                         \n", e2, TB.dayTimeLightOutput[3]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                %1b%1b| %1b | %1b |###|   |   |%1b%1b         \n", TB.walkingLightOutput[2], TB.walkingLightOutput[1], TB.dayTimeLightOutput[4], TB.dayTimeLightOutput[5], TB.walkingLightOutput[5], TB.walkingLightOutput[3]);
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                                 N1: %8b                      \n", n1);
                $fwrite(f, "                                 N2: %8b                      \n", n2);
                $fwrite(f, "                            S                                 \n");
                $fwrite(f, "                                                              \n");
                $fwrite(f, "---+---+-------+--------------+---+---+----+--------|---------\n");
                $fwrite(f, "CLK|RST|HOURSIN|dayNightSignal|PED|EMG|MODE|EMG_LANE|Countdown|DayLoad|NgtLoad|EmgLoad|PedLoad|ACTUAL_LOAD| down |Eload|loadIn | isZero |\n");
                $fwrite(f, "---+---+-------+--------------+---+---+----+--------|---------\n");
                $fwrite(f, "%1b  |%1b  |%5b  |%1b             |%1b  |%1b  |%2b  |%8b|%7b  |%7b|%7b|%7b|%7b|%7b    |  %b   |  %b  |  %4d |    %b   |\n", clk, rst, hoursIn, TB.dayNightSignal, pedSignal, emgSignal, TB.trafficMode, emgLane, TB.currentCount,
																								TB.dayLoadTime, TB.nightLoadTime, TB.emgLoadTime, TB.pedLoadTime, TB.loadIn, 1'b1, TB.emgLoad, TB.loadIn, TB.isZero);
                
            end
    end
    //  THREAD WITH INPUT STIMULUS
    initial
    begin
		w1 = 8'b00000000; w2 = 8'b00000000; s1 = 8'b01111111; s2 = 8'b00000000;
        e1 = 8'b00000000; e2 = 8'b00000000; n1 = 8'b00000111; n2 = 8'b00000000;
        #2
        #5 rst = 1; hoursIn = 5'b01100; pedSignal = 0; emgSignal = 0;
        #5 $fwrite(f, "+--------------+\n");
           $fwrite(f, "| RESET SIGNAL |\n");
           $fwrite(f, "+--------------+\n");
        #5 rst = 0;  pedSignal = 0; emgSignal = 0;
           
           emgLane = 8'b00001000;
		#60
           
        $fclose(f);
        $finish;
    end
endmodule