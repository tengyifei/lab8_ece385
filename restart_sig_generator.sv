module restart_sig_generator (input frame_clk, Reset,
										input [7:0] keycode,
									   output restart	);
										
										
										
logic restart_sig;


	always_ff @ (posedge frame_clk, posedge Reset)
	begin
	if(Reset)
		restart <=1'b0;
	else if(keycode == 8'd21)//"R"
		restart <= 1'b1;
	else
		restart <= 1'b0;
	
	end
										
	assign restart = restart_sig;							
										
endmodule
