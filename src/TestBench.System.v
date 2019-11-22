/**********************************************
    THESE ARE TESTS FOR THE TEST BENCH
***********************************************/


module TestTestBench ();
    integer f;  // File 
    //  SIGNALS
    reg clk, rst;
    reg timeSignal, pedSignal, emgSignal;

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

    //  BREADBOARD
    Breadboard TB(clk, rst, timeSignal, pedSignal, emgSignal, emgLane, {w1, w2, s1, s2, e1, e2, n1, n2});

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
                $fwrite(f, "---+---+---+-----+---+---+----+--------+----+---+---+---+---+---+----+---+---+---\n");
                $fwrite(f, "---+---+---+-----+---+---+----+--------+----+---+---+---+---+---+----+---+---+---\n");
                $fwrite(f, "                                                              \n");
                $fwrite(f, "                            N                                 \n");
                $fwrite(f, "            S1: %8b                                           \n", s1);
                $fwrite(f, "            S2: %8b                                           \n", s2);
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                %1b%1b|   |   |###| %1b | %1b |%1b%1b         \n", TB.walkingLightOutput[6], TB.walkingLightOutput[0], TB.trafficLightOutput[0], TB.trafficLightOutput[1], TB.walkingLightOutput[4], TB.walkingLightOutput[7]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                 %1b                     W1: %8b              \n", TB.trafficLightOutput[6], w1);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                 %1b                     W2: %8b              \n", TB.trafficLightOutput[7], w2);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                  |   |   |###|       |                       \n");
                $fwrite(f, "  W               |   |   |###|       |                E      \n");
                $fwrite(f, "                  |   |   |###|       |                       \n");
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "     E1: %8b                      %1b                         \n", e1, TB.trafficLightOutput[2]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "     E2: %8b                      %1b                         \n", e2, TB.trafficLightOutput[3]);
                $fwrite(f, "     -------------         ---         -------------          \n");
                $fwrite(f, "                %1b%1b| %1b | %1b |###|   |   |%1b%1b         \n", TB.walkingLightOutput[2], TB.walkingLightOutput[1], TB.trafficLightOutput[4], TB.trafficLightOutput[5], TB.walkingLightOutput[5], TB.walkingLightOutput[3]);
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                  |   |   |###|   |   |                       \n");
                $fwrite(f, "                                 N1: %8b                      \n", n1);
                $fwrite(f, "                                 N2: %8b                      \n", n2);
                $fwrite(f, "                            S                                 \n");
                $fwrite(f, "                                                              \n");
                $fwrite(f, "---+---+---+-----+---+---+----+--------+----+---+---+---+---+---+----+---+---+---\n");
                $fwrite(f, "CLK|RST|DAY|NIGHT|PED|EMG|MODE|EMG_LANE\n");
                $fwrite(f, "---+---+---+-----+---+---+----+--------\n");
                $fwrite(f, "%1b  |%1b  |%1b   |%1b   |%1b  |%1b  |%2b  |%8b\n", clk, rst, ~rst, timeSignal, pedSignal, emgSignal, TB.trafficMode, emgLane);
                
            end
    end

    //  THREAD WITH INPUT STIMULUS
    initial
    begin
        #2
        #5 rst = 1; timeSignal = 0; pedSignal = 0; emgSignal = 0;
        #5 $fwrite(f, "+--------------+\n");
           $fwrite(f, "| RESET SIGNAL |\n");
           $fwrite(f, "+--------------+\n");
        #5 rst = 0; timeSignal = 0; pedSignal = 0; emgSignal = 1;
           w1 = 8'b00000000; w2 = 8'b00000000; s1 = 8'b00000000; s2 = 8'b00000000;
           e1 = 8'b00000000; e2 = 8'b00000000; n1 = 8'b10000000; n2 = 8'b00000000;
           emgLane = 8'b00001000;
        #5 $fwrite(f, "+------------------+\n");
           $fwrite(f, "| EMERGENCY SIGNAL |\n");
           $fwrite(f, "+------------------+\n");
        #5 rst = 0; timeSignal = 0; pedSignal = 1; emgSignal = 0;
           w1 = 8'b00000000; w2 = 8'b00000000; s1 = 8'b00000000; s2 = 8'b00000000;
           e1 = 8'b00000000; e2 = 8'b00000000; n1 = 8'b10000000; n2 = 8'b00000000;
           emgLane = 8'b00001000;
        #5 $fwrite(f, "+-------------------+\n");
           $fwrite(f, "| PEDESTRIAN SIGNAL |\n");
           $fwrite(f, "+-------------------+\n");
           
            $fclose(f);
        $finish;
    end
endmodule