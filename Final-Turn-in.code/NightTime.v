 /*
 *  This Module will calculate the Lights Output if current state is nighttime
 *  @param:
 *      Inputs:
 *          clk -> Clock signal
 *
 *      Outputs:
 *          nightTimeLightOutput -> an 8-bit value for each traffic light, where:
 *                  out = 00110011 -> lane = N+S
 *                  out = 11001100 -> lane = E+W
 *			loadTime -> The time this module is requesting to load into timer
 * 
 */
 
module NightTime(clk, nightTimeLightOutput, loadTime);

	//---------------------------------------------
	//Parameters
	//---------------------------------------------
	input clk;
	output [7:0] nightTimeLightOutput;
	output [6:0] loadTime;
	
	//---------------------------------------------
	//Local Variables
	//---------------------------------------------
	wire [7:0] nextLights;
	wire [7:0] outDFF;//The outDFF from the D Flip-Flops
	wire [7:0] nextLaneOutput;//The output from the characteristic equations

	assign nextLights = ~outDFF;

	DFF  #(8, 8'b11001100) arrDFF (clk, nextLights, outDFF);

	assign nextLaneOutput = ~outDFF;
	
assign nightTimeLightOutput = outDFF;
	assign loadTime = 1;
endmodule
