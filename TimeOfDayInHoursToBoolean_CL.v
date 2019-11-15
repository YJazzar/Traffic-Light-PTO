//converts the 5 bit hour of day (0 to 23) input to a boolean
//where Day = 1 and Night = 0
//6am to 8pm is daytime,[6:00, 20:00) == [6:00, 19:59]
module TimeOfDayInHoursToBoolean_CL (hoursIn, boolOut);
  input [4:0] hoursIn;
  output boolOut;

  assign boolOut = 
  //H4'H2H1 + H3 +H4H2'
  (~hoursIn[4] & hoursIn[2] & hoursIn[1])
	| (hoursIn[3])
	| (hoursIn[4] & ~hoursIn[2]);
endmodule  
//----------------------------------------------------------------------

module testbench();

  reg [4:0] i;
  reg [4:0] hoursIn1; 
  wire  DayNight;
  
  TimeOfDayInHoursToBoolean_CL timeCL(hoursIn1, DayNight);
  
  initial begin
   	
  //$display acts like a classic C printf command.
  $display ("|##|HoursIn|DayNight|");
  $display ("|==+=======+========|");
  
    //A for loop, with register i being the loop control variable.
	for (i = 0; i < 24; i = i + 1) 
	begin//Open the code blook of the for loop
		hoursIn1 = i;
		#5


		
		$display ("|%2d| %5b | %1b      |",i,hoursIn1,DayNight);
		if(i%4==3) //Every fourth row of the table, put in a marker for easier reading.
		 $display ("|--+-------+--------|");
  
  
	end
 
	#10
	$finish;
  end
  
endmodule

