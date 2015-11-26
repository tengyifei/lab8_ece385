//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input Reset, frame_clk, input  [7:0] keycode, input weapon_en,input [4:0] strengh, angle, input [9:0] ch_pos_x, ch_pos_y, rival_x,rival_y
               output [9:0]  BallX, BallY, BallS ,output weapon_display);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=3;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=3;      // Step size on the Y axis

    assign Ball_Size = 4;  
	 
	 
	 /*weapon_en determines if the ball will be displayed or not 
	   ch_pos_x,ch_pos_y get the position from the character
		rival_x,rival_y get the position of the rival
		strengh can vary from 1 to 15, so that the the total
		angle determines the ratio of intial horizontal and vertical 
	 	 
	 */
	 
	 logic weapon_show;
	 logic in_run;//change it to register!!!!!!!!
	 logic end_set;
	 
	 
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= ch_pos_y;
				Ball_X_Pos <= ch_pos_x;
				weapon_show <= 1'b0;
				in_run=0;
        end
           
        else 
			begin
				if(in_run== 1'b1)
					begin
						//this is the place that we need to display the ball
						weapon_show= 1'b1;
						//update the position
						Ball_X_Motion <= Ball_X_Step;
						Ball_Y_Motion <= Ball_Y_Step;
						if(end_set==1'b1)
							begin
								in_run=1'b0;
							end
						else
							in_run=1'b1;
					end
				else
					begin
						
						//need to detect from the keyboard wether we should start the shooting	
						case (keycode)
							8'37:
							begin
								in_run=1'b1;	
							end
						
						default:
							begin
								in_run=1'b0;
							end
					
						endcase
						end
					
					
					//update the posistion
					if(in_run==1'b1)
						begin
							// need to draw the postion relative to its previous position
							Ball_Y_Pos <= Ball_Y_Pos + Ball_Y_Motion;
							Ball_X_Pos <= Ball_X_Pos + Ball_X_Motion;
						end
					else
						begin
							Ball_Y_Pos <= init_y;
							Ball_X_Pos <= init_x;
						end
				
				
				
				
			end
		  
		  
		  
		  
		  
		  
		  
		  /*
        begin 
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  begin
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  Ball_X_Motion <= 10'b0;
					  end
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
				 begin
					  Ball_Y_Motion <= Ball_Y_Step;
					  Ball_X_Motion <= 10'b0;
					  end
				else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the rightmost edge, BOUNCE!
					  begin
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  Ball_Y_Motion <= 10'b0;
					  end
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the leftmost edge, BOUNCE!
				 begin
					  Ball_X_Motion <= Ball_X_Step;
						Ball_Y_Motion <= 10'b0;
				 end
				 else 
					begin
				   Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  Ball_X_Motion <= Ball_X_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  
						case (keycode)
							8'h001A : 
								begin
								 Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);	//W
								 Ball_X_Motion <= 10'b0;
								end 
							8'h0004 :
								 begin
								 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1); // A
								 Ball_Y_Motion <=10'b0;
								 end
							8'h0016 : 
								begin
								 Ball_Y_Motion <= Ball_Y_Step ;// S
								  Ball_X_Motion <= 10'b0; 
								end
							8'h0007 :
								begin
								Ball_X_Motion <= Ball_X_Step;// D
								 Ball_Y_Motion <=10'b0;
								 end
							default : 
								begin
								Ball_Y_Motion <= Ball_Y_Motion ;// do nothing
								Ball_X_Motion <= Ball_X_Motion;
								end
						endcase
					  end
					  
		 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			*/
			
		
      
				//end  
    
	 
	 
	 
	 end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
		
	assign weapon_display = weapon_show;

endmodule
