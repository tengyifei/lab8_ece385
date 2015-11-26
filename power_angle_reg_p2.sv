module power_angle_reg_p2 (input frame_clk, Reset, is_in_turn,
									input [7:0] keycode,
									output [3:0] power, angle);


	logic [3:0] power_sig, angle_sig;
	
	//d82:UP, d81:DOWN used for power
	//d54:<, d55: >, used for angle adjustment
	
	always_ff @ (posedge frame_clk, posedge Reset)
	begin
		if(Reset)
		begin
			power_sig <= 4'b0;
			angle_sig <= 4'b0;
		end
		else if (is_in_turn==1'b0)
		begin
			power_sig <= power_sig;
			angle_sig <= angle_sig;
		end
		else if (keycode==8'd82)
		begin
			//power up
			angle_sig <= angle_sig;
			if(power_sig >=4'd7)
				power_sig <= 4'd7;
			else
				power_sig <= power_sig +4'b1;
		end
		else if (keycode==8'd81)
		begin
			//power down
			angle_sig <= angle_sig;
			if(power_sig ==4'b0)
				power_sig <= 4'b0;
			else
				power_sig <= power_sig -1'b1;
		end 
		else if (keycode == 8'd54)
		begin
			//angle up
			power_sig <= power_sig;
			if(angle_sig >=4'd7)
				angle_sig <= 4'd7;
			else
				angle_sig <= angle_sig +4'b1;
		end
		else if (keycode == 8'd55)
		begin
			//angle down
			power_sig <= power_sig;
			if(angle_sig ==4'b0)
				angle_sig <= 4'b0;
			else
				angle_sig <= angle_sig -4'b1;
		end
		else
		begin
			power_sig <= power_sig;
			angle_sig <= angle_sig;
		end
	end
									

	assign power = power_sig;
	assign angle = angle_sig;






endmodule
