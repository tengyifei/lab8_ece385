
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_ballsize, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
	  
	  
module  color_mapper ( input [9:0] Ball1X, Ball1Y,Ball2X, Ball2Y,
							  input [9:0] ch1X, ch1Y, ch2X, ch2Y, DrawX, DrawY,
							  input [9:0] Ball1_size, Ball2_size, 
							  input [9:0] ch1_sizeX, ch1_sizeY,ch2_sizeX,ch2_sizeY,
							  input [8:0] health_p1, health_p2,
							  input [1:0] game_turn,
							  input weapon_mode_p1, weapon_mode_p2,
							  input weapon_display_p1, weapon_display_p2,
                       output [7:0]  Red, Green, Blue );
    
    logic ball_on,ch1_on,ch2_on, /*character_p_on,*/ left_turn, right_turn;
	 
	 
	 
	 
	// logic for getting color of sprites
	logic [10:0] sprite_addr,sprite_addr_font;
	logic [383:0] sprite_data;
	logic [7:0] sprite_data_font;
	logic [10:0] p_font_x = 20;
	logic [10:0] p_font_y = 20;
	logic [7:0] sprite_red,sprite_green,sprite_blue;
	//part that is used to store the sprites
	font_rom_32_bit sprite_mem(
	.addr(sprite_addr),
	.data(sprite_data)
	);
	
	
	// piece of memory that is used to store alphanumerical fonts
	 font_rom font_mem(
	.addr(sprite_addr_font),
	.data(sprite_data_font)
	);
	
	colortable table1(
	.ch_on(ch1_on),
	.color(sprite_data[3*(DrawX-ch1X)-:3]),
	.red(sprite_red),
	.green(sprite_green),
	.blue(sprite_blue)
	);
	
	
    int BALL1_DistX, BALL1_DistY,BALL2_DistX, BALL2_DistY, ch1_DistX,ch1_DistY, ball1size,ball2size,ch1sizeX,ch1sizeY;
	 assign BALL1_DistX = DrawX - Ball1X;
    assign BALL1_DistY = DrawY - Ball1Y;
    assign BALL2_DistX = DrawX - Ball2X;
    assign BALL2_DistY = DrawY - Ball2Y;
 
	 assign ch1_DistX = DrawX - ch1X;
    assign ch1_DistY = DrawY - ch1Y;
    assign ballsize = Ball1_size;
	 assign bal2size = Ball2_size;
    assign ch1sizeX=ch1_sizeX;
	 assign ch1sizeY=ch1_sizeY;
	  
    always_comb
    begin:Ball1_on_proc
        if ( ( BALL1_DistX*BALL1_DistX + BALL_DistY*BALL_DistY) <= (ballsize * ballsize) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
	 
	 always_comb
    begin:ch1_on_proc
        if ( DrawX >= ch1X  && DrawX <ch1X+11'd16 && DrawY>=ch1Y && DrawY <ch1Y+11'd24  ) 
			  begin
					ch1_on = 1'b1;
					sprite_addr=((DrawY - ch1Y));
			  end
		  else 
				begin
					ch1_on = 1'b0;
					sprite_addr=11'b0;
				end
     end
	  
	   always_comb
    begin:ch2_on_proc
        if ( DrawX >= ch2X  && DrawX <ch1X+11'd16 && DrawY>=ch2Y && DrawY <ch2Y+11'd24  ) 
			  begin
					ch2_on = 1'b1;
					//sprite_addr=((DrawY - ch1Y));
			  end
		  else 
				begin
					ch2_on = 1'b0;
					//sprite_addr=11'b0;
				end
     end
	  
	  
	  
	  
	/* 
	 always_comb
    begin:p
        if ( DrawX >= p_font_x  && DrawX <p_font_x+11'd8 && DrawY>=p_font_y && DrawY <p_font_y+11'd16   ) 
			  begin			
					sprite_addr_font=(DrawY-p_font_y+16*11'h50);
					character_p_on = 1'b1;
			  end
		  else 
				begin
					character_p_on = 1'b0;
					sprite_addr_font=11'b0;
				end
	  end  
       
		 
	*/	 
		 
		 
		 
		 
		 
    always_comb
    begin:RGB_Display
		if ((character_p_on == 1'b1) && sprite_data_font[DrawX-p_font_x]==1'b1) 
        begin 
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end 
		
    	else if ((ch1_on == 1'b1)) 
        begin 
            //Red = sprite_data[(10'd383-24*(DrawX-ch1X))+:8];
            //Green = sprite_data[383-24*(DrawX-ch1X)-9+:8];
            //Blue = sprite_data[383-24*(DrawX-ch1X)-17+:8];
				Red=sprite_red;
				Green=sprite_green;
				Blue=sprite_blue;
        end 
		else if ((ch2_on == 1'b1)) 
        begin 
            //Red = sprite_data[(10'd383-24*(DrawX-ch1X))+:8];
            //Green = sprite_data[383-24*(DrawX-ch1X)-9+:8];
            //Blue = sprite_data[383-24*(DrawX-ch1X)-17+:8];
				 Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end 
        else if ((ball_on == 1'b1)) 
        begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
        end       
        else 
        begin
				// draw the sky
				if(DrawY <= 10'd400 )
				begin
					Red = 8'h00; 
					Green = 8'hbf;
					Blue = 8'hff;
				end
				//draw the grass
				else if (DrawY <= 10'd420 )
				begin
					Red = 8'h00; 
					Green = 8'hcc;
					Blue = 8'h00;
				end
				else
				//the mud
				begin
					Red = 8'h99; 
					Green = 8'h33;
					Blue = 8'h00;
				end
		  end      
    end 
    
endmodule
