

module Breadboard (clk, rst, hoursIn, pedSignal, emgSignal, emgLane, lanes);
    //  INPUT
    input clk, rst; // clk is a 1 second clock
	input [4:0] hoursIn;
    input pedSignal, emgSignal;
    input [7:0] emgLane;
    input [7:0][7:0] lanes;
	
	
    //  LOCAL VARIABLES
    wire isZero;
    wire [1:0] trafficMode;
    wire [3:0] trafficModeOneHot;
    wire [7:0] walkingLightOutput;
    wire [7:0] emergencyLightOutput;
    wire [7:0] pedestrianLightOutput;
    wire [7:0] nightTimeLightOutput;
    wire [7:0] dayTimeLightOutput;
    //  LOCAL VARIABLE TRAFFIC LIGHT OUTPUT
    wire [7:0] trafficLightOutput;

    // LOCAL VARIABLE FOR MODULE INPUTS
    wire [6:0] loadIn;
    wire [6:0] currCount;
	
	// LOCAL VARIABLE FOR hoursIN -> dayNightSignal
	wire dayNightSignal;
	TimeOfDayInHoursToBoolean_CL (hoursIn, dayNightSignal);

    //  TRAFFIC MODE MODULES
    SaturationTimer TimerModule (clk, down, loadIn, currCount, isZero);
    Pedestrian PedestrianModule (pedSignal, walkingLightOutput, pedestrianLightOutput);
    Emergency  EmergencyModule  (emgLane, emergencyLightOutput);
    DayTime    DayTimeModule    (isZero, lanes, dayTimeLightOutput, loadTimer);
    NightTime  NightTimeModule  (isZero, nightTimeLightOutput);

    //  TRAFFIC MODE STATE MACHINE
    TrafficMode TM (clk, rst, dayNightSignal, pedSignal, emgSignal, trafficMode);

    //  DECODE TRAFFIC MODE
    Decoder TrafficModeDecoder (trafficMode, trafficModeOneHot);

    //  SELECT MODULE OUTPUT TO USE
    Mux4 #(8) LightOutputMux (emergencyLightOutput, pedestrianLightOutput, nightTimeLightOutput, dayTimeLightOutput, trafficModeOneHot, trafficLightOutput);
endmodule