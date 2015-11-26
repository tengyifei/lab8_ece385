module p1_weapon_state_machine(input frame_clk, Reset, is_in_turn,
										 input end_set, 
										 input [7:0] keycode,
										 input [9:0] ch_pos_x, ch_pos_y, Ball_Y_new, Ball_X_new,
										 output weapon_display, weapon_mode, 
										 output [9:0]  BallX, BallY,
										 output fire_on
										 );

										 
/* is_in_turn should be connected to the lower_bit of game_turn , since 2'b01 represents player 1's turn*/			 
/* end_set should be connected to the output of traject_calc, start_move should be connected to a specified hardware reading from keycode */


enum logic [1:0] {WAIT, READY, RUN, FIRE} state, next_state;

logic in_run;
logic start_move; 
logic weapon_display_wire, weapon_mode_wire, fire_on_wire;
logic [9:0] Ball_X_wire, Ball_Y_wire;

//hardware used to generate the start signal of an attack
p1_attack_confirm attack_confirm(
	.keycode(keycode[7:0]),
	.Reset(Reset), 
	.frame_clk(frame_clk), 
	.is_in_turn(is_in_turn),
	.attack_start(start_move)
	);
	
// hardware used to store the weapon mode choice

 p1_weapon_mode_container wp1(
 .frame_clk(frame_clk), 
 .Reset(Reset), 
 .is_in_turn(is_in_turn),
 .is_run(in_run),
 .keycode(keycode[7:0]),
 .weapon_mode(weapon_mode_wire)
 );	
	


	always_ff @( posedge frame_clk, posedge Reset)
	begin
		if(Reset)
			state <= WAIT;
		else
			state <= next_state;
	end

	
	always_comb 
	begin
	next_state = state;
	
	unique case (state)
		WAIT:
		begin
			if(is_in_turn)
				next_state = READY;
			else 
				next_state = WAIT;
		end
		READY:
		begin
			if(start_move)
				next_state = RUN;
			else
				next_state = READY;
		end
		RUN:
		begin
			if(end_set)
				next_state = FIRE;
			else
				next_state = RUN;
		end
		FIRE:
		begin
			next_state = WAIT;
		end
		
	
	
	
	endcase
	
	
	end
	
	
	always_ff @( posedge frame_clk, posedge Reset)
	begin
		unique case (state)
			WAIT:
			begin
				fire_on_wire =1'b0;
				weapon_display_wire =1'b0;
				Ball_X_wire = ch_pos_x;
				Ball_Y_wire = ch_pos_y;	
				in_run =1'b0;
			end
			READY:
			begin
				fire_on_wire =1'b0;
				weapon_display_wire =1'b0;
				Ball_X_wire = ch_pos_x;
				Ball_Y_wire = ch_pos_y;	
				in_run =1'b0;
			end
			
			RUN:
			begin
				fire_on_wire =1'b0;
				weapon_display_wire =1'b1;
				Ball_X_wire = Ball_X_new;
				Ball_Y_wire = Ball_Y_new;	
				in_run =1'b1;
			end
			
			FIRE:
			begin
				fire_on_wire =1'b1;
				weapon_display_wire =1'b0;
				Ball_X_wire = ch_pos_x;
				Ball_Y_wire = ch_pos_y;	
				in_run =1'b0;
			end
		
		
		endcase
	
	
	end













	assign weapon_mode = weapon_mode_wire;
	assign BallX = Ball_X_wire;
	assign BallY = Ball_Y_wire;
	assign fire_on= fire_on_wire;
	assign weapon_display = weapon_display_wire;










endmodule
