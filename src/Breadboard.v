

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
    //  output [7:0] trafficLightOutput;

    // LOCAL VARIABLE FOR MODULE INPUTS
    wire [6:0] currentCount;
    wire emgLoad;
	
	// LOCAL VARIABLE FOR hoursIN -> dayNightSignal
	wire dayNightSignal;
	TimeOfDayInHoursToBoolean_CL ConverterCL (hoursIn, dayNightSignal);

    // LOCAL VARIABLES TO STORE HOW MUCH TIME TIMER NEEDS TO RESET TO
	wire [6:0] loadIn;
    wire [6:0] emgLoadTime, pedLoadTime, nightLoadTime, dayLoadTime;
	//selector for mux is 4 bit one hot where 0001 is day, 0010 is night, 0100 is pedestrian, 1000 is emergnecy
	Mux4 #(7) chooseLoadTimeForTimerModule(emgLoadTime, pedLoadTime, nightLoadTime, dayLoadTime, trafficModeOneHot, loadIn);

    // MASTER TIMER MODULE. This outputs the clk input to the traffic mode modules.
    SaturationTimer TimerModule (clk, 1'b1, emgLoad, loadIn, currentCount, isZero);
	
	// TRAFFIC MODE MODULES
    Pedestrian PedestrianModule (pedSignal, walkingLightOutput, pedestrianLightOutput, pedLoadTime);
    Emergency  EmergencyModule  (emgLane, emergencyLightOutput, emgLoad, emgLoadTime);
    DayTime    DayTimeModule    (clk, lanes, dayTimeLightOutput, dayLoadTime);
    NightTime  NightTimeModule  (clk, nightTimeLightOutput, nightLoadTime);

    //  TRAFFIC MODE STATE MACHINE
    TrafficMode TM (clk, rst, dayNightSignal, pedSignal, emgSignal, trafficMode);

    //  DECODE TRAFFIC MODE
    Decoder TrafficModeDecoder (trafficMode, trafficModeOneHot);

    //  SELECT MODULE OUTPUT TO USE
    // Mux4 #(8) LightOutputMux (emergencyLightOutput, pedestrianLightOutput, nightTimeLightOutput, dayTimeLightOutput, trafficModeOneHot, trafficLightOutput);
    //assign trafficLightOutput = dayTimeLightOutput;
endmodule