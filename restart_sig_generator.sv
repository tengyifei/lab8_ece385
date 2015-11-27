module restart_sig_generator (input frame_clk, Reset,
										input [7:0] keycode,
									   output restart	);
										
										
										
logic restart_sig;

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
		restart_sig <=1'b0;
	else if(keycode == 8'd21)//"R"
		begin
			if(prev_1==prev_2)
				restart_sig <= 1'b0;
			else
				restart_sig <= 1'b1;
		end
	else
		restart_sig <= 1'b0;
	
	end
										
	assign restart = restart_sig;							
										
endmodule
