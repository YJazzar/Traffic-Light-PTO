//left arbiter
module LeftArbiter9bit (in, oneHotOut);
  input  [8:0] in;
  output [8:0] oneHotOut;

  assign oneHotOut = {in[8], 
					~in[8]&in[7], 
					~in[8]&~in[7]&in[6], 
					~in[8]&~in[7]&~in[6]&in[5],
					~in[8]&~in[7]&~in[6]&~in[5]&in[4],
					~in[8]&~in[7]&~in[6]&~in[5]&~in[4]&in[3],
					~in[8]&~in[7]&~in[6]&~in[5]&~in[4]&~in[3]&in[2],
					~in[8]&~in[7]&~in[6]&~in[5]&~in[4]&~in[3]&~in[2]&in[1],
					~in[8]&~in[7]&~in[6]&~in[5]&~in[4]&~in[3]&~in[2]&~in[1]&in[0]};
endmodule  
//----------------------------------------------------------------------

/*
module testbench();
  reg  [8:0] i;
  reg Emergency;
  reg Pedestrian; 
  reg DayNight;
  wire [3:0] loadMaxTimeSelect;
  
  LeftArbiter4bit loadMaxTimeArbiter({Emergency, Pedestrian, DayNight, ~DayNight}, loadMaxTimeSelect);
  
  initial begin
   	
  //$display acts like a classic C printf command.
  $display ("|##|Emergency|Pedestrian|DayNight|~DayNight|intoArbiter|outofArbiter|");
  $display ("|==+=========+==========+========+=========+===========+============|");
  
    //A for loop, with register i being the loop control variable.
	for (i = 0; i < 8; i = i + 1) 
	begin//Open the code blook of the for loop
		Emergency=(i/4)%2; //High bit
		Pedestrian=(i/2)%2;
		DayNight=(i)%2;    //Low bit
		#5
		
		$display ("|%2d|     %1b   |      %1b   |    %1b   |     %1b   |     %4b  |      %4b  |",i,Emergency,Pedestrian,DayNight,~DayNight,{Emergency, Pedestrian, DayNight, ~DayNight}, loadMaxTimeSelect);
	end
 
	#10
	$finish;
  end
  
endmodule
*/

