module  ball_state_machine( 
									input Reset, frame_clk, 
									input  [7:0] keycode, 
									input  end_set,
									input [9:0] ch_pos_x, ch_pos_y, Ball_Y_new, Ball_X_new,
									output [9:0]  BallX, BallY, BallS,
									output weapon_display,is_run
									);
    

enum logic [3:0] {WAIT, RUN, FIRE} state, next_state;


logic [9:0] counter_wire;
logic LD_COUNTER, CLEAR_COUNTER;
logic weapon_display_wire;
logic [9:0] Ball_X_Pos,Ball_Y_Pos,  Ball_Size;

assign Ball_Size=4;



 counter_reg  counter0(
	.Clk(frame_clk), 
	.Reset(CLEAR_COUNTER), 
	.Load(LD_COUNTER),
	.Data_Out(counter_wire)
	);

	


// state transition block
always_ff @ (posedge frame_clk, posedge Reset)
begin
	if (Reset == 1'b1) 
		begin
			state <= WAIT;
		end 
	else 
		begin
			state <= next_state;
		end
end


// transition block 2 
always_comb 
begin
	next_state = state;
	case (state)
		WAIT: 
		begin
			if(keycode==8'd13)//J
				next_state= RUN;
			else
				next_state= state;
		
			is_run=1'b0;
		end
		
		RUN: 
		begin
			if (end_set==1'b1)
				next_state = FIRE;
			else
				next_state = state;
			is_run=1'b1;
		end
		
		FIRE: 
		begin
			next_state = WAIT;
			is_run=1'b0;
		end
	endcase
end

	
//the always block handling outputs
always_comb 
begin
	CLEAR_COUNTER=1'b0;
	LD_COUNTER=1'b0;
	weapon_display_wire =1'b0;
	case (state)
		WAIT: 
		begin
			CLEAR_COUNTER = 1'd1;
			LD_COUNTER=1'b0;
			weapon_display_wire =1'b0;
			Ball_X_Pos = ch_pos_x  ;
			Ball_Y_Pos = ch_pos_y  ;
		end
		
		RUN: 
		begin
			CLEAR_COUNTER=1'b0;
			LD_COUNTER=1'b1;
			weapon_display_wire =1'b1;
			Ball_X_Pos = Ball_X_new;
			Ball_Y_Pos = Ball_Y_new ;
		end
		
		FIRE: 
		begin
			CLEAR_COUNTER=1'b1;
			LD_COUNTER=1'b0;
			weapon_display_wire =1'b0;
			Ball_X_Pos = ch_pos_x  ;
			Ball_Y_Pos = ch_pos_y  ;
		end
	endcase
end


assign weapon_display = weapon_display_wire;
assign BallX = Ball_X_Pos;
assign BallY = Ball_Y_Pos;
assign BallS = Ball_Size;


	  
endmodule

