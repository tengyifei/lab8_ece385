module health_reg (input frame_clk, Reset, initialize, update,
						 input [8:0] harm,
						 input die,
						 output [8:0] health_out
						 );
						 
	logic [8:0] health;
	
	logic [8:0] new_health;
	assign new_health= health-harm;
	
	always_ff @ (posedge frame_clk or posedge Reset)
	begin
		if(Reset)
			health <= 9'd100;
		else if (initialize)
			health <= 9'd100;
		else if (die)
			health <= 9'd0;
		else if (update)
			health <= new_health;
		else
			health <= health;		
	end
						 
	assign health_out = health;
						 
endmodule
