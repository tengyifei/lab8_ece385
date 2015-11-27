

module  ch1 ( input Reset, frame_clk, is_in_turn, input  [7:0] keycode,
               output [9:0]  ch1X, ch1Y, chsizeX, chsizeY );
    
    logic [9:0] X_POS, X_Motion, Y_POS, ch_sizeX,ch_sizeY;
	 
    parameter [9:0] X_Center=320;  // Center position on the X axis
    parameter [9:0] Y_Center=240;  // Center position on the Y axis
    parameter [9:0] X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] X_Step=1;      // Step size on the X axis
    parameter [9:0] Y_Step=1;      // Step size on the Y axis
	
	 assign ch_sizeY = 12;
    assign ch_sizeX = 12;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 
	 assign Y_POS = 10'd380;
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Character
        if (Reset)  // Asynchronous Reset
        begin 
           // Y_Motion <= 10'd0; //Y_Step;
				X_Motion <= 10'd0; //X_Step;
				X_POS <= 10'd100;
        end
           
        else 
        begin 
				 if ( (X_POS + ch_sizeX) >= X_Max )  // Ball is at the rightmost edge, BOUNCE!
					  begin
					  X_Motion <= (~ (X_Step) + 1'b1);  // 2's complement.
					  end
				 else if ( (X_POS - ch_sizeX) <= X_Min )  // Ball is at the leftmost edge, BOUNCE!
				 begin
					  X_Motion <= X_Step;
				 end
				 else 
					begin
					  X_Motion <= X_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  
						case (keycode)
							8'h0004 :
								 begin
								 X_Motion <= (~ (X_Step) + 1'b1); // A
								 end
							8'h0007 :
								begin
								X_Motion <= X_Step;// D
								 end
							default : 
								begin
								X_Motion <= 10'd0;
								end
						endcase
					  end
				if(is_in_turn)	  
				 X_POS <= (X_POS + X_Motion);
				else
				 X_POS <= X_POS;
			
			
		end  
    end
       
    assign ch1X = X_POS;
   
    assign ch1Y = Y_POS;
   
    assign chsizeX = ch_sizeX;
	 assign chsizeY = ch_sizeY;
    

endmodule
