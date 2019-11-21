// /**********************************************
//     THESE ARE TESTS FOR THE TEST BENCH
// ***********************************************/

// module TestBreadboard (clk, rst, timeSignal, pedSignal, emgSignal, emgLane);
//     //  INPUT
//     input clk, rst;
//     input timeSignal, pedSignal, emgSignal;
//     input [7:0] emgLane;

//     //  LOCAL VARIABLES
//     wire [1:0] trafficMode;
//     wire [3:0] trafficModeOneHot;
//     wire [7:0] walkingLightOutput;
//     wire [7:0] emergencyLightOutput;
//     wire [7:0] pedestrianLightOutput;
//     wire [7:0] nightTimeLightOutput;
//     wire [7:0] dayTimeLightOutput;
//     //  LOCA VARIABLE TRAFFIC LIGHT OUTPUT
//     wire [7:0] trafficLightOutput;

//     //  TRAFFIC MODE MODULES
//     Pedestrian PedestrianModule (pedSignal, walkingLightOutput, pedestrianLightOutput);
//     Emergency EmergencyModule (emgLane, emergencyLightOutput);
//     assign nightTimeLightOutput = 8'b00000000;
//     assign dayTimeLightOutput = 8'b00000000;
//     // NightTime NightTimeModule (clk, rst, nightTimeLightOutput);

//     //  TRAFFIC MODE STATE MACHINE
//     TrafficMode TM (clk, rst, timeSignal, pedSignal, emgSignal, trafficMode);

//     //  DECODE TRAFFIC MODE
//     Decoder TrafficModeDecoder (trafficMode, trafficModeOneHot);

//     //  SELECT MODULE OUTPUT TO USE
//     Mux4 #(8) LightOutputMux (emergencyLightOutput, pedestrianLightOutput, nightTimeLightOutput, dayTimeLightOutput, trafficModeOneHot, trafficLightOutput);
// endmodule

// module TestTestBench ();
//     //  SIGNALS
//     reg clk, rst;
//     reg timeSignal, pedSignal, emgSignal;

//     //  TRAFFIC LANE COUNT
//     reg [7:0] n1;
//     reg [7:0] n2;
//     reg [7:0] e1;
//     reg [7:0] e2;
//     reg [7:0] s1;
//     reg [7:0] s2;
//     reg [7:0] w1;
//     reg [7:0] w2;

//     //  WHICH LANE THE EMERGENCY IS IN
//     reg [7:0] emgLane;

//     //  BREADBOARD
//     TestBreadboard TB(clk, rst, timeSignal, pedSignal, emgSignal, emgLane);

//     //  THREAD WITH CLOCK CONTROL
//     initial
//     begin
//         forever
//             begin
//                 #5
//                 clk = 0;
//                 #5
//                 clk = 1;
//             end 
//     end

//     //  THREAD THAT DISPLAYS OUTPUTS
//     initial
//     begin
//         #2
//         forever
//             begin
//                 #5
//                 $display("---+---+---+-----+---+---+----+--------+----+---+---+---+---+---+----+---+---+---");
//                 $display("---+---+---+-----+---+---+----+--------+----+---+---+---+---+---+----+---+---+---");
//                 $display("                                                              ");
//                 $display("                            N                                 ");
//                 $display("            S1: %8b                                           ", s1);
//                 $display("            S2: %8b                                           ", s2);
//                 $display("                  |   |   |###|   |   |                       ");
//                 $display("                  |   |   |###|   |   |                       ");
//                 $display("                  |   |   |###|   |   |                       ");
//                 $display("                %1b%1b|   |   |###| %1b | %1b |%1b%1b         ", TB.walkingLightOutput[6], TB.walkingLightOutput[0], TB.trafficLightOutput[0], TB.trafficLightOutput[1], TB.walkingLightOutput[4], TB.walkingLightOutput[7]);
//                 $display("     -------------         ---         -------------          ");
//                 $display("                 %1b                     W1: %8b              ", TB.trafficLightOutput[6], w1);
//                 $display("     -------------         ---         -------------          ");
//                 $display("                 %1b                     W2: %8b              ", TB.trafficLightOutput[7], w2);
//                 $display("     -------------         ---         -------------          ");
//                 $display("                  |   |   |###|       |                       ");
//                 $display("  W               |   |   |###|       |                E      ");
//                 $display("                  |   |   |###|       |                       ");
//                 $display("     -------------         ---         -------------          ");
//                 $display("     E1: %8b                      %1b                         ", e1, TB.trafficLightOutput[2]);
//                 $display("     -------------         ---         -------------          ");
//                 $display("     E2: %8b                      %1b                         ", e2, TB.trafficLightOutput[3]);
//                 $display("     -------------         ---         -------------          ");
//                 $display("                %1b%1b| %1b | %1b |###|   |   |%1b%1b         ", TB.walkingLightOutput[2], TB.walkingLightOutput[1], TB.trafficLightOutput[4], TB.trafficLightOutput[5], TB.walkingLightOutput[5], TB.walkingLightOutput[3]);
//                 $display("                  |   |   |###|   |   |                       ");
//                 $display("                  |   |   |###|   |   |                       ");
//                 $display("                  |   |   |###|   |   |                       ");
//                 $display("                                 N1: %8b                      ", n1);
//                 $display("                                 N2: %8b                      ", n2);
//                 $display("                            S                                 ");
//                 $display("                                                              ");
//                 $display("---+---+---+-----+---+---+----+--------+----+---+---+---+---+---+----+---+---+---");
//                 $display("CLK|RST|DAY|NIGHT|PED|EMG|MODE|EMG_LANE");
//                 $display("---+---+---+-----+---+---+----+--------");
//                 $display("%1b  |%1b  |%1b   |%1b   |%1b  |%1b  |%2b  |%8b", clk, rst, ~rst, timeSignal, pedSignal, emgSignal, TB.trafficMode, emgLane);
                
//             end
//     end

//     //  THREAD WITH INPUT STIMULUS
//     initial
//     begin
//         #2
//         #5 rst = 1; timeSignal = 0; pedSignal = 0; emgSignal = 0;
//         #5 $display("+--------------+");
//            $display("| RESET SIGNAL |");
//            $display("+--------------+");
//         #5 rst = 0; timeSignal = 0; pedSignal = 0; emgSignal = 1;
//            w1 = 8'b00000000; w2 = 8'b00000000; s1 = 8'b00000000; s2 = 8'b00000000;
//            e1 = 8'b00000000; e2 = 8'b00000000; n1 = 8'b10000000; n2 = 8'b00000000;
//            emgLane = 8'b00001000;
//         #5 $display("+------------------+");
//            $display("| EMERGENCY SIGNAL |");
//            $display("+------------------+");
//         #5 rst = 0; timeSignal = 0; pedSignal = 1; emgSignal = 0;
//            w1 = 8'b00000000; w2 = 8'b00000000; s1 = 8'b00000000; s2 = 8'b00000000;
//            e1 = 8'b00000000; e2 = 8'b00000000; n1 = 8'b10000000; n2 = 8'b00000000;
//            emgLane = 8'b00001000;
//         #5 $display("+-------------------+");
//            $display("| PEDESTRIAN SIGNAL |");
//            $display("+-------------------+");
//         $finish;
//     end
// endmodule