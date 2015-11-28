
	  
	  
module  color_mapper_1 ( input [9:0] Ball1X, Ball1Y,Ball2X, Ball2Y,
							  input [9:0] ch1X, ch1Y, ch2X, ch2Y, DrawX, DrawY,
							  input [9:0] Ball1_size, Ball2_size, 
							  input [9:0] ch1_sizeX, ch1_sizeY,ch2_sizeX,ch2_sizeY,
							  input [8:0] health_p1, health_p2,
							  input [1:0] game_turn,
							  input weapon_mode_p1, weapon_mode_p2,
							  input weapon_display_p1, weapon_display_p2,
                       output [7:0]  Red, Green, Blue );
    
    logic ball1_on,ball2_on,ch1_on,ch2_on, /*character_p_on,*/ left_turn, right_turn;
	 logic p_on_p1, one_on_p1, p_on_p2, two_on_p2; // display p1, p2
	 logic h_on_p1, p_on_hp1, h_on_p2, p_on_hp2, semi_one, semi_two; // display p1,p2
	 logic hp1_1, hp1_2, hp1_3, hp2_1, hp2_2, hp2_3; //display hp info
	 logic wp1_1, wp1_2, wp1_3, wp1_4, wp2_1, wp2_2, wp2_3, wp2_4; //display info about weapon
	 logic arrow_1, arrow_2; // used to signify user's turn
	 
	// logic for getting color of sprites
	logic [10:0] sprite_addr1,sprite_addr2,sprite_addr_font;
	logic [383:0] sprite_data1,sprite_data2;
	logic [0:7] sprite_data_font;
	logic [10:0] p_font_x = 20;
	logic [10:0] p_font_y = 20;
	logic [7:0] sprite_red,sprite_green,sprite_blue;
	//part that is used to store the sprites
	font_rom_32_bit sprite_mem(
	.addr1(sprite_addr1),
	.addr2(sprite_addr2),
	.data1(sprite_data1),
	.data2(sprite_data2)
	);
	
	
	// piece of memory that is used to store alphanumerical fonts
	 font_rom font_mem(
	.addr(sprite_addr_font),
	.data(sprite_data_font)
	);
	
	colortable table1(
	.ch_on(ch1_on),
	.color(sprite_data1[3*(DrawX-ch1X)-:3]),
	.red(sprite_red),
	.green(sprite_green),
	.blue(sprite_blue)
	);
	
	
    int BALL1_DistX, BALL1_DistY, BALL2_DistX, BALL2_DistY,ch1_DistX,ch1_DistY, ballsize1,ballsize2,ch1sizeX,ch1sizeY;
	 assign BALL1_DistX = DrawX - Ball1X;
    assign BALL1_DistY = DrawY - Ball1Y;
	 assign BALL2_DistX = DrawX - Ball2X;
    assign BALL2_DistY = DrawY - Ball2Y;
    assign ch1_DistX = DrawX - ch1X;
    assign ch1_DistY = DrawY - ch1Y;
    assign ballsize1 = Ball1_size;
	 assign ballsize2 = Ball2_size;
    assign ch1sizeX=ch1_sizeX;
	 assign ch1sizeY=ch1_sizeY;
	  
	  
	  
	  always_comb
	  begin
	  
	  //first display the "P1"
	   if ( DrawX >= 11'd20 && DrawX < 11'd28 && DrawY >= 11'd20 && DrawY < 11'd36 ) 
			  begin			
					sprite_addr_font=(DrawY-11'd20+16*11'h50);
					p_on_p1 = 1'b1;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			  end	  
		else if ( DrawX >= 11'd28 && DrawX < 11'd36 && DrawY >= 11'd20 && DrawY < 11'd36 )
			begin
				sprite_addr_font=(DrawY-11'd20+16*11'h31);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b1;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		//display the "P2"
		else if ( DrawX >= 11'd604 && DrawX < 11'd612 && DrawY >= 11'd20 && DrawY < 11'd36 ) 
			  begin			
					sprite_addr_font=(DrawY-11'd20+16*11'h50);

					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b1;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			  end	  
		else if ( DrawX >= 11'd612 && DrawX < 11'd620 && DrawY >= 11'd20 && DrawY < 11'd36 )
			begin
				sprite_addr_font=(DrawY-11'd20+16*11'h32);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b1;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		//display "HP:xx" for P1
		else if ( DrawX >= 11'd20 && DrawX < 11'd28 && DrawY >= 11'd40 && DrawY < 11'd56 ) 
			  begin			
					sprite_addr_font=(DrawY-11'd40+16*11'h48);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b1;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			  end	  
		else if ( DrawX >= 11'd28 && DrawX < 11'd36 && DrawY >= 11'd40 && DrawY < 11'd56 )
			begin
				sprite_addr_font=(DrawY-11'd40+16*11'h50);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b1;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		else if ( DrawX >= 11'd36 && DrawX < 11'd44 && DrawY >= 11'd40 && DrawY < 11'd56 )
			begin
				sprite_addr_font=(DrawY-11'd40+16*11'h3a);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b1;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		// fill in the HP data of hp1
		else if ( DrawX >= 11'd44 && DrawX < 11'd52 && DrawY >= 11'd40 && DrawY < 11'd56 )
		begin
			if (health_p1 >= 9'd100)
				sprite_addr_font=(DrawY-11'd40+16*11'h31);// display 1
			else 
				sprite_addr_font=(DrawY-11'd40+16*11'h30); // display 0
		
			p_on_p1 = 1'b0;
			one_on_p1 = 1'b0;
			p_on_p2 = 1'b0;
			two_on_p2 = 1'b0;
			h_on_p1 = 1'b0;
			p_on_hp1 = 1'b0;
			h_on_p2 = 1'b0;
			p_on_hp2 = 1'b0;
			semi_one =1'b0;
			semi_two =1'b0;
			hp1_1=1'b1;
			hp1_2=1'b0;
			hp1_3=1'b0;
			hp2_1=1'b0;
			hp2_2=1'b0;
			hp2_3=1'b0;
			wp1_1=1'b0;
			wp1_2=1'b0;
			wp1_3=1'b0;
			wp1_4=1'b0;
			wp2_1=1'b0; 
			wp2_2=1'b0;
			wp2_3=1'b0;
			wp2_4=1'b0;
			arrow_1=1'b0;
			arrow_2=1'b0;
		end
		
		else if ( DrawX >= 11'd52 && DrawX < 11'd60 && DrawY >= 11'd40 && DrawY < 11'd56 )
		begin
		 
			sprite_addr_font = DrawY-11'd40 +16*( ((health_p1 % 9'd100)/9'd10)+11'h30);
			p_on_p1 = 1'b0;
			one_on_p1 = 1'b0;
			p_on_p2 = 1'b0;
			two_on_p2 = 1'b0;
			h_on_p1 = 1'b0;
			p_on_hp1 = 1'b0;
			h_on_p2 = 1'b0;
			p_on_hp2 = 1'b0;
			semi_one =1'b0;
			semi_two =1'b0;
			hp1_1=1'b0;
			hp1_2=1'b1;
			hp1_3=1'b0;
			hp2_1=1'b0;
			hp2_2=1'b0;
			hp2_3=1'b0;
			wp1_1=1'b0;
			wp1_2=1'b0;
			wp1_3=1'b0;
			wp1_4=1'b0;
			wp2_1=1'b0; 
			wp2_2=1'b0;
			wp2_3=1'b0;
			wp2_4=1'b0;
			arrow_1=1'b0;
			arrow_2=1'b0;
		end
		
		else if ( DrawX >= 11'd60 && DrawX < 11'd68 && DrawY >= 11'd40 && DrawY < 11'd56 )
		begin
		sprite_addr_font = DrawY-11'd40 +16*( (health_p1 % 9'd10)+11'h30);
			p_on_p1 = 1'b0;
			one_on_p1 = 1'b0;
			p_on_p2 = 1'b0;
			two_on_p2 = 1'b0;
			h_on_p1 = 1'b0;
			p_on_hp1 = 1'b0;
			h_on_p2 = 1'b0;
			p_on_hp2 = 1'b0;
			semi_one =1'b0;
			semi_two =1'b0;
			hp1_1=1'b0;
			hp1_2=1'b0;
			hp1_3=1'b1;
			hp2_1=1'b0;
			hp2_2=1'b0;
			hp2_3=1'b0;
			wp1_1=1'b0;
			wp1_2=1'b0;
			wp1_3=1'b0;
			wp1_4=1'b0;
			wp2_1=1'b0; 
			wp2_2=1'b0;
			wp2_3=1'b0;
			wp2_4=1'b0;
			arrow_1=1'b0;
			arrow_2=1'b0;
		end
		
		//display "HP:xx" for P2
		else if ( DrawX >= 11'd572 && DrawX < 11'd580 && DrawY >= 11'd40 && DrawY < 11'd56 ) 
			  begin			
					sprite_addr_font=(DrawY-11'd40+16*11'h48);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b1;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			  end	  
		else if ( DrawX >= 11'd580 && DrawX < 11'd588 && DrawY >= 11'd40 && DrawY < 11'd56 )
			begin
				sprite_addr_font=(DrawY-11'd40+16*11'h50);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b1;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		else if ( DrawX >= 11'd588 && DrawX < 11'd596 && DrawY >= 11'd40 && DrawY < 11'd56 )
			begin
				sprite_addr_font=(DrawY-11'd40+16*11'h3a);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b1;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		// fill in the HP data of hp2
		else if ( DrawX >= 11'd596 && DrawX < 11'd604 && DrawY >= 11'd40 && DrawY < 11'd56 )
		begin
			if (health_p2 >= 9'd100)
				sprite_addr_font=(DrawY-11'd40+16*11'h31);// display 1
			else 
				sprite_addr_font=(DrawY-11'd40+16*11'h30); // display 0
		
			p_on_p1 = 1'b0;
			one_on_p1 = 1'b0;
			p_on_p2 = 1'b0;
			two_on_p2 = 1'b0;
			h_on_p1 = 1'b0;
			p_on_hp1 = 1'b0;
			h_on_p2 = 1'b0;
			p_on_hp2 = 1'b0;
			semi_one =1'b0;
			semi_two =1'b0;
			hp1_1=1'b0;
			hp1_2=1'b0;
			hp1_3=1'b0;
			hp2_1=1'b1;
			hp2_2=1'b0;
			hp2_3=1'b0;
			wp1_1=1'b0;
			wp1_2=1'b0;
			wp1_3=1'b0;
			wp1_4=1'b0;
			wp2_1=1'b0; 
			wp2_2=1'b0;
			wp2_3=1'b0;
			wp2_4=1'b0;
			arrow_1=1'b0;
			arrow_2=1'b0;
		end
		
		else if ( DrawX >= 11'd604 && DrawX < 11'd612 && DrawY >= 11'd40 && DrawY < 11'd56 )
		begin
		 
			sprite_addr_font = DrawY-11'd40 +16*( ((health_p2 % 9'd100)/9'd10)+11'h30);
			p_on_p1 = 1'b0;
			one_on_p1 = 1'b0;
			p_on_p2 = 1'b0;
			two_on_p2 = 1'b0;
			h_on_p1 = 1'b0;
			p_on_hp1 = 1'b0;
			h_on_p2 = 1'b0;
			p_on_hp2 = 1'b0;
			semi_one =1'b0;
			semi_two =1'b0;
			hp1_1=1'b0;
			hp1_2=1'b0;
			hp1_3=1'b0;
			hp2_1=1'b0;
			hp2_2=1'b1;
			hp2_3=1'b0;
			wp1_1=1'b0;
			wp1_2=1'b0;
			wp1_3=1'b0;
			wp1_4=1'b0;
			wp2_1=1'b0; 
			wp2_2=1'b0;
			wp2_3=1'b0;
			wp2_4=1'b0;
			arrow_1=1'b0;
			arrow_2=1'b0;
		end
		
		else if ( DrawX >= 11'd612 && DrawX < 11'd620 && DrawY >= 11'd40 && DrawY < 11'd56 )
		begin
		sprite_addr_font = DrawY-11'd40 +16*( (health_p2 % 9'd10)+11'h30);
			p_on_p1 = 1'b0;
			one_on_p1 = 1'b0;
			p_on_p2 = 1'b0;
			two_on_p2 = 1'b0;
			h_on_p1 = 1'b0;
			p_on_hp1 = 1'b0;
			h_on_p2 = 1'b0;
			p_on_hp2 = 1'b0;
			semi_one =1'b0;
			semi_two =1'b0;
			hp1_1=1'b0;
			hp1_2=1'b0;
			hp1_3=1'b0;
			hp2_1=1'b0;
			hp2_2=1'b0;
			hp2_3=1'b1;
			wp1_1=1'b0;
			wp1_2=1'b0;
			wp1_3=1'b0;
			wp1_4=1'b0;
			wp2_1=1'b0; 
			wp2_2=1'b0;
			wp2_3=1'b0;
			wp2_4=1'b0;
			arrow_1=1'b0;
			arrow_2=1'b0;
		end
		
		//draw WP1:
		else if ( DrawX >= 11'd20 && DrawX < 11'd28 && DrawY >= 11'd60 && DrawY < 11'd76 ) 
			  begin			
					sprite_addr_font=(DrawY-11'd60+16*11'h57);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b1;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			  end	  
		else if ( DrawX >= 11'd28 && DrawX < 11'd36 && DrawY >= 11'd60 && DrawY < 11'd76 )
			begin
				sprite_addr_font=(DrawY-11'd60+16*11'h50);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b1;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		else if ( DrawX >= 11'd36 && DrawX < 11'd44 && DrawY >= 11'd60 && DrawY < 11'd76 )
			begin
				sprite_addr_font=(DrawY-11'd60+16*11'h3a);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b1;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b1;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		else if ( DrawX >= 11'd44 && DrawX < 11'd52 && DrawY >= 11'd60 && DrawY < 11'd76 )
			begin
					//sprite_addr_font=(DrawY-11'd40+16*11'h31);// display 1
					sprite_addr_font=(DrawY-11'd60+16*11'h31+16*weapon_mode_p1); // display 0
			
				p_on_p1 = 1'b0;
				one_on_p1 = 1'b0;
				p_on_p2 = 1'b0;
				two_on_p2 = 1'b0;
				h_on_p1 = 1'b0;
				p_on_hp1 = 1'b0;
				h_on_p2 = 1'b0;
				p_on_hp2 = 1'b0;
				semi_one =1'b0;
				semi_two =1'b0;
				hp1_1=1'b0;
				hp1_2=1'b0;
				hp1_3=1'b0;
				hp2_1=1'b0;
				hp2_2=1'b0;
				hp2_3=1'b0;
				wp1_1=1'b0;
				wp1_2=1'b0;
				wp1_3=1'b0;
				wp1_4=1'b1;
				wp2_1=1'b0; 
				wp2_2=1'b0;
				wp2_3=1'b0;
				wp2_4=1'b0;
				arrow_1=1'b0;
				arrow_2=1'b0;
			end
			
			//draw WP2:
		else if ( DrawX >= 11'd572 && DrawX < 11'd580 && DrawY >= 11'd60 && DrawY < 11'd76 ) 
			  begin			
					sprite_addr_font=(DrawY-11'd60+16*11'h57);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b1; 
					wp2_2=1'b0;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			  end	  
		else if ( DrawX >= 11'd580 && DrawX < 11'd588 && DrawY >= 11'd60 && DrawY < 11'd76 )
			begin
				sprite_addr_font=(DrawY-11'd60+16*11'h50);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b0;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b1;
					wp2_3=1'b0;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		else if ( DrawX >= 11'd588 && DrawX < 11'd596 && DrawY >= 11'd60 && DrawY < 11'd76 )
			begin
				sprite_addr_font=(DrawY-11'd60+16*11'h3a);
					p_on_p1 = 1'b0;
					one_on_p1 = 1'b0;
					p_on_p2 = 1'b0;
					two_on_p2 = 1'b0;
					h_on_p1 = 1'b0;
					p_on_hp1 = 1'b0;
					h_on_p2 = 1'b0;
					p_on_hp2 = 1'b0;
					semi_one =1'b0;
					semi_two =1'b0;
					hp1_1=1'b0;
					hp1_2=1'b0;
					hp1_3=1'b0;
					hp2_1=1'b0;
					hp2_2=1'b0;
					hp2_3=1'b0;
					wp1_1=1'b0;
					wp1_2=1'b0;
					wp1_3=1'b1;
					wp1_4=1'b0;
					wp2_1=1'b0; 
					wp2_2=1'b0;
					wp2_3=1'b1;
					wp2_4=1'b0;
					arrow_1=1'b0;
					arrow_2=1'b0;
			end
		else if ( DrawX >= 11'd596 && DrawX < 11'd604 && DrawY >= 11'd60 && DrawY < 11'd76 )
			begin
					//sprite_addr_font=(DrawY-11'd40+16*11'h31);// display 1
					sprite_addr_font=(DrawY-11'd60+16*11'h31+16*weapon_mode_p2); // display 0
			
				p_on_p1 = 1'b0;
				one_on_p1 = 1'b0;
				p_on_p2 = 1'b0;
				two_on_p2 = 1'b0;
				h_on_p1 = 1'b0;
				p_on_hp1 = 1'b0;
				h_on_p2 = 1'b0;
				p_on_hp2 = 1'b0;
				semi_one =1'b0;
				semi_two =1'b0;
				hp1_1=1'b0;
				hp1_2=1'b0;
				hp1_3=1'b0;
				hp2_1=1'b0;
				hp2_2=1'b0;
				hp2_3=1'b0;
				wp1_1=1'b0;
				wp1_2=1'b0;
				wp1_3=1'b0;
				wp1_4=1'b0;
				wp2_1=1'b0; 
				wp2_2=1'b0;
				wp2_3=1'b0;
				wp2_4=1'b1;
				arrow_1=1'b0;
				arrow_2=1'b0;
				
			end
		
	
	  //display arrow 1 and arrow 2 depending on the current game turn
		else if ( DrawX >= 11'd20 && DrawX < 11'd28 && DrawY >= 11'd80 && DrawY < 11'd96 )
			begin
			  if(game_turn==2'b01)
					begin
						sprite_addr_font=(DrawY-11'd80+16*11'h1a);// display arrow
						arrow_1= 1'b1;
					end
				else 
					begin
						sprite_addr_font=(DrawY-11'd80+16*11'h1a);// display arrow
						arrow_1= 1'b0;
					end
				p_on_p1 = 1'b0;
				one_on_p1 = 1'b0;
				p_on_p2 = 1'b0;
				two_on_p2 = 1'b0;
				h_on_p1 = 1'b0;
				p_on_hp1 = 1'b0;
				h_on_p2 = 1'b0;
				p_on_hp2 = 1'b0;
				semi_one =1'b0;
				semi_two =1'b0;
				hp1_1=1'b0;
				hp1_2=1'b0;
				hp1_3=1'b0;
				hp2_1=1'b0;
				hp2_2=1'b0;
				hp2_3=1'b0;
				wp1_1=1'b0;
				wp1_2=1'b0;
				wp1_3=1'b0;
				wp1_4=1'b0;
				wp2_1=1'b0; 
				wp2_2=1'b0;
				wp2_3=1'b0;
				wp2_4=1'b0;
				arrow_2=1'b0;
				
			end
			
		else if ( DrawX >= 11'd612 && DrawX < 11'd620 && DrawY >= 11'd80 && DrawY < 11'd96 )
			begin
			  if(game_turn==2'b10)
					begin
						sprite_addr_font=(DrawY-11'd80+16*11'h1b);// display arrow
						arrow_2= 1'b1;
					end
				else 
					begin
						sprite_addr_font=(DrawY-11'd80+16*11'h1b);// display arrow
						arrow_2= 1'b0;
					end
				p_on_p1 = 1'b0;
				one_on_p1 = 1'b0;
				p_on_p2 = 1'b0;
				two_on_p2 = 1'b0;
				h_on_p1 = 1'b0;
				p_on_hp1 = 1'b0;
				h_on_p2 = 1'b0;
				p_on_hp2 = 1'b0;
				semi_one =1'b0;
				semi_two =1'b0;
				hp1_1=1'b0;
				hp1_2=1'b0;
				hp1_3=1'b0;
				hp2_1=1'b0;
				hp2_2=1'b0;
				hp2_3=1'b0;
				wp1_1=1'b0;
				wp1_2=1'b0;
				wp1_3=1'b0;
				wp1_4=1'b0;
				wp2_1=1'b0; 
				wp2_2=1'b0;
				wp2_3=1'b0;
				wp2_4=1'b0;
				arrow_1=1'b0;
			
				
			end
			
		else 
		begin
				sprite_addr_font=11'd0;
				p_on_p1 = 1'b0;
				one_on_p1 = 1'b0;
				p_on_p2 = 1'b0;
				two_on_p2 = 1'b0;
				h_on_p1 = 1'b0;
				p_on_hp1 = 1'b0;
				h_on_p2 = 1'b0;
				p_on_hp2 = 1'b0;
				semi_one =1'b0;
				semi_two =1'b0;
				hp1_1=1'b0;
				hp1_2=1'b0;
				hp1_3=1'b0;
				hp2_1=1'b0;
				hp2_2=1'b0;
				hp2_3=1'b0;
				wp1_1=1'b0;
				wp1_2=1'b0;
				wp1_3=1'b0;
				wp1_4=1'b0;
				wp2_1=1'b0; 
				wp2_2=1'b0;
				wp2_3=1'b0;
				wp2_4=1'b0;
				arrow_1=1'b0;
				arrow_2=1'b0;
		end
				  
	  
	end
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  

	  
	  
	  
    
	 
	 

	 
	 always_comb
    begin:ch1_on_proc
        if ( DrawX >= ch1X  && DrawX <ch1X+11'd16 && DrawY>=ch1Y && DrawY <ch1Y+11'd24  ) 
			  begin
					ch1_on = 1'b1;
					sprite_addr1=((DrawY - ch1Y));
			  end
		  else 
				begin
					ch1_on = 1'b0;
					sprite_addr1=11'b0;
				end
     end
	  
	  always_comb
    begin:ch2_on_proc
        if ( DrawX >= ch2X  && DrawX <ch2X+11'd16 && DrawY>=ch2Y && DrawY <ch2Y+11'd24  ) 
			  begin
					ch2_on = 1'b1;
					sprite_addr2=((DrawY - ch2Y));
			  end
		  else 
				begin
					ch2_on = 1'b0;
					sprite_addr2=11'b0;
				end
     end
	  
	  
	always_comb
    begin:Ball1_on_proc
        if ( ( BALL1_DistX*BALL1_DistX + BALL1_DistY*BALL1_DistY) <= (ballsize1 * ballsize1) && weapon_display_p1==1'b1 ) 
            ball1_on = 1'b1;
        else 
            ball1_on = 1'b0;
     end 
	  
	always_comb
    begin:Ball2_on_proc
        if ( ( BALL2_DistX*BALL2_DistX + BALL2_DistY*BALL2_DistY) <= (ballsize2 * ballsize2) && weapon_display_p2==1'b1 ) 
            ball2_on = 1'b1;
        else 
            ball2_on = 1'b0;
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
	 // P
		if(p_on_p1==1'b1 && sprite_data_font[DrawX-10'd20]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// 1	
		else if(one_on_p1==1'b1 && sprite_data_font[DrawX-10'd28]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//p	
		else if(p_on_p2==1'b1 && sprite_data_font[DrawX-10'd604]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//2 
		else if(two_on_p2==1'b1 && sprite_data_font[DrawX-10'd612]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//H
		else if(h_on_p1==1'b1 && sprite_data_font[DrawX-10'd20]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//P
		else if(p_on_hp1==1'b1 && sprite_data_font[DrawX-10'd28]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//:
		else if(semi_one==1'b1 && sprite_data_font[DrawX-10'd36]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// X	
	 else if(hp1_1==1'b1 && sprite_data_font[DrawX-10'd44]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// X	
	 else if(hp1_2==1'b1 && sprite_data_font[DrawX-10'd52]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// X	
	 else if(hp1_3==1'b1 && sprite_data_font[DrawX-10'd60]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// H
	 else if(h_on_p2==1'b1 && sprite_data_font[DrawX-10'd572]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// P
	 else if(p_on_hp2==1'b1 && sprite_data_font[DrawX-10'd580]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// :
	 else if(semi_two==1'b1 && sprite_data_font[DrawX-10'd588]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// X	
	 else if(hp2_1==1'b1 && sprite_data_font[DrawX-10'd596]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// X	
	 else if(hp2_2==1'b1 && sprite_data_font[DrawX-10'd604]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// X	
	 else if(hp2_3==1'b1 && sprite_data_font[DrawX-10'd612]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//W
	 else if(wp1_1==1'b1 && sprite_data_font[DrawX-10'd20]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//P
		else if(wp1_2==1'b1 && sprite_data_font[DrawX-10'd28]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//:
		else if(wp1_3==1'b1 && sprite_data_font[DrawX-10'd36]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// num
		else if(wp1_4==1'b1 && sprite_data_font[DrawX-10'd44]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// W
		else if(wp2_1==1'b1 && sprite_data_font[DrawX-10'd572]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//P
		else if(wp2_2==1'b1 && sprite_data_font[DrawX-10'd580]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//:
		else if(wp2_3==1'b1 && sprite_data_font[DrawX-10'd588]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// num
		else if(wp2_4==1'b1 && sprite_data_font[DrawX-10'd596]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	
	//arrow 1
		else if(arrow_1==1'b1 && sprite_data_font[DrawX-10'd20]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	//arrow 2
		else if(arrow_2==1'b1 && sprite_data_font[DrawX-10'd612]==1'b1)
		begin
				Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
		end
	// character 1 
	else if ((ch1_on == 1'b1)) 
        begin 
            //Red = sprite_data[(10'd383-24*(DrawX-ch1X))+:8];
            //Green = sprite_data[383-24*(DrawX-ch1X)-9+:8];
            //Blue = sprite_data[383-24*(DrawX-ch1X)-17+:8];
				Red=sprite_red;
				Green=sprite_green;
				Blue=sprite_blue;
        end 
	// character 2 	  
		else if ((ch2_on == 1'b1)) 
        begin 
            //Red = sprite_data[(10'd383-24*(DrawX-ch1X))+:8];
            //Green = sprite_data[383-24*(DrawX-ch1X)-9+:8];
            //Blue = sprite_data[383-24*(DrawX-ch1X)-17+:8];
				 Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end 
    // weapon 1   
		else if ((ball1_on == 1'b1)) 
        begin 
            Red = 8'h00;
            Green = 8'h00;
            Blue = 8'h00;
        end
	// weapon 2 
	else if ((ball2_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
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
	 
	 
	 
	 
	 
	 
	 
	/* 
		if ((character_p_on == 1'b1) && sprite_data_font[DrawX-p_font_x]==1'b1) 
        begin 
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end 
	*/	
    	
    
endmodule
