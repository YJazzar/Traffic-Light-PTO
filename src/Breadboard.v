

module Breadboard (clk, rst, timeSignal, pedSignal, emgSignal, emgLane);
    //  INPUT
    input clk, rst;
    input timeSignal, pedSignal, emgSignal;
    input [7:0] emgLane;

    //  LOCAL VARIABLES
    wire [1:0] trafficMode;
    wire [3:0] trafficModeOneHot;
    wire [7:0] walkingLightOutput;
    wire [7:0] emergencyLightOutput;
    wire [7:0] pedestrianLightOutput;
    wire [7:0] nightTimeLightOutput;
    wire [7:0] dayTimeLightOutput;
    //  LOCAL VARIABLE TRAFFIC LIGHT OUTPUT
    wire [7:0] trafficLightOutput;

    //  TRAFFIC MODE MODULES
    Pedestrian PedestrianModule(pedSignal, walkingLightOutput, pedestrianLightOutput);
    Emergency  EmergencyModule (emgLane, emergencyLightOutput);
    DayTime    DayTimeModule   (clk, lane, dayTimeLightOutput, loadTimer);
    NightTime  NightTimeModule (clk, rst, nightTimeLightOutput);

    //  TRAFFIC MODE STATE MACHINE
    TrafficMode TM (clk, rst, timeSignal, pedSignal, emgSignal, trafficMode);

    //  DECODE TRAFFIC MODE
    Decoder TrafficModeDecoder (trafficMode, trafficModeOneHot);

    //  SELECT MODULE OUTPUT TO USE
    Mux4 #(8) LightOutputMux (emergencyLightOutput, pedestrianLightOutput, nightTimeLightOutput, dayTimeLightOutput, trafficModeOneHot, trafficLightOutput);
endmodule