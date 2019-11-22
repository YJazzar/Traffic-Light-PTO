 /*
 *  This Module will calculate the Lights Output if current state is nighttime
 *  @param:
 *      Inputs:
 *          clk -> Clock signal
 *          currentLightState -> an 8-bit outDFF value for each traffic light, where:
 *					out = WWSSEENN
 *                  out = 00110011 -> lane = N+S
 *                  out = 11001100 -> lane = E+W 
 *
 *      Outputs:
 *          nextLightState -> an 8-bit value for each traffic light, where:
 *                  out = 00110011 -> lane = N+S
 *                  out = 11001100 -> lane = E+W
 * 
 *      local variables:
 *          local variables
 */
 
module NightTime(clk, rst, laneOutput);

	//---------------------------------------------
	//Parameters
	//---------------------------------------------
	input clk;
	input rst;
	output laneOutput;
	
	//---------------------------------------------
	//Local Variables
	//---------------------------------------------
	reg  select; //The selection for the multiplexer
	wire [7:0] muxToDFF;
	wire [7:0] outDFF;//The outDFF from the D Flip-Flops
	wire [7:0] nextLaneOutput;//The output from the characteristic equations


	DFF  #(8, 8'b11001100) arrDFF (clk, muxToDFF, outDFF);

	//reset state (starting state) == 11001100
	//Mux2 arrMUX[7:0](8'b11001100, nextLaneOutput, {rst, ~rst}, muxToDFF);


	assign nextLaneOutput = ~outDFF;
	
	assign laneOutput = {arrDFF[7].out,arrDFF[6].out,arrDFF[5].out,arrDFF[4].out,arrDFF[3].out,arrDFF[2].out,arrDFF[1].out,arrDFF[0].out};//Set the state equal to the value of the flip flops


endmodule

/*
//=============================================
// Test Bench
//=============================================
module Test_FSM() ;

	//---------------------------------------------
	//Inputs
	//---------------------------------------------
	reg clk;
	reg rst;

	//---------------------------------------------
	//Declare FSM
	//---------------------------------------------  
	NightTime StateMachine(clk, rst, laneOutput);
	//---------------------------------------------
	//Clock Control
	//---------------------------------------------
	initial
	begin
		forever
			begin
				#5 
				clk = 0 ;
				#5
				clk = 1 ;
			end
	end	

	//---------------------------------------------
	//Display Thread
	//---------------------------------------------
   initial
    begin
	  #1 ///Offset the Square Wave
      $display("CLK|RST|CURRENT |NEXT    ");
      $display("---+---+--------+--------");
	  forever
		begin
		#5
			$display(" %b | %b |%8b|%8b",clk,rst,StateMachine.laneOutput,StateMachine.nextLaneOutput);
		end
   end	
   
	//---------------------------------------------   
	//Input Stimulous.
	//---------------------------------------------   
   
  initial 
	begin
	    #2 //Offset the Square Wave
		
		#10 rst = 1; //initial reset to begin system	
		#10 rst = 0; 
		#60
		
		$finish;
	end
endmodule
*/