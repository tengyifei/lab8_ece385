module restart_sig_generator (input frame_clk, Reset,
										input [7:0] keycode,
									   output restart	);
										
										
										
logic restart_sig;


	always_ff @ (posedge frame_clk, posedge Reset)
	begin
	if(Reset)
		restart_sig <=1'b0;
	else if(keycode == 8'd21)//"R"
		restart_sig <= 1'b1;
	else
		restart_sig <= 1'b0;
	
	end
										
	assign restart = restart_sig;							
										
endmodule
