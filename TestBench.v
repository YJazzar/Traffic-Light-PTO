
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

