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