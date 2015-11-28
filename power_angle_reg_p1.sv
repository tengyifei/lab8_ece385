module power_angle_reg_p1 (input frame_clk, Reset, is_in_turn,
									input [7:0] keycode,
									output [3:0] power, angle);


	logic [3:0] power_sig, angle_sig;
	
	//d38:W, d34:S used for power
	//d32:q, d8:e, used for angle adjustment
	
	logic [7:0] prev_1, prev_2; 
	
	always_ff @ (posedge frame_clk)
	begin
		prev_1 <= keycode;
	
	end
	
	always_ff @ (posedge frame_clk)
	begin
		prev_2 <= prev_1;
	
	end

	
	
	
	
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
		else if (keycode==8'd26)
		begin
			angle_sig <= angle_sig;
			if(prev_1==prev_2)
			begin
				power_sig <= power_sig;
			end
			else
			begin
				//power up
				if(power_sig >= 4'd14)
					power_sig <= 4'd14;
				else
					power_sig <= power_sig +4'b1;
			end
		end
		else if (keycode==8'd22)
		begin
			angle_sig <= angle_sig;
			if(prev_1==prev_2)
			begin
				power_sig <= power_sig;
			end
			else 
			begin
				//power down
				if(power_sig ==4'b0)
					power_sig <= 4'b0;
				else
					power_sig <= power_sig -1'b1;
			end
		end 
		else if (keycode == 8'd20)
		begin
			power_sig <= power_sig;
			if(prev_1==prev_2)
			begin
				angle_sig <= angle_sig;
			end
			else 
			begin
				//angle up
				if(angle_sig >=4'd14)
					angle_sig <= 4'd14;
				else
					angle_sig <= angle_sig +4'b1;
			end
		end
		else if (keycode == 8'd8)
		begin
			power_sig <= power_sig;
			if(prev_1==prev_2)
			begin
				angle_sig <= angle_sig;
			end
			else 
			begin
				//angle down
				if(angle_sig ==4'b0)
					angle_sig <= 4'b0;
				else
					angle_sig <= angle_sig -4'b1;
			end
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
