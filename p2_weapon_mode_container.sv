module p2_weapon_mode_container(input frame_clk, Reset, is_in_turn, 
											input [7:0] keycode,input is_run, 
											output weapon_mode);


	logic weapon_mode_internal;//act as the internal register

	
	always_ff @(posedge frame_clk, posedge Reset)
	begin
		if(Reset)
			weapon_mode_internal = 1'b0;
		else if (is_in_turn==1'b1)
		begin
			 if(keycode == 8'd56 )
			 // button "?"
				begin
					if(is_run)
						weapon_mode_internal = weapon_mode_internal;
					else
						weapon_mode_internal = ~weapon_mode_internal;
				end
			else
				weapon_mode_internal = weapon_mode_internal;
		end
		else 
			weapon_mode_internal = weapon_mode_internal;
	
	end
	
	
	assign weapon_mode = weapon_mode_internal;
	
											
											
endmodule
