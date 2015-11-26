module game_state (input frame_clk, Reset, restart,
						 input [8:0] harm_by_1,harm_by_2,
						 input end_set_1, end_set_2,
						 output [8:0] health_of_p1, health_of_p2,
						 output [1:0] game_turn					
						);
	
	enum logic [3:0] {START,P1_TURN, P2_TURN, 
							P1_ATTACK_UPDATE,
							P2_ATTACK_UPDATE,
							P1_WIN,P2_WIN} state, next_state;
	
	logic p1_die, p2_die;	
	logic [1:0] game_turn_wire;
	logic init_p1, init_p2, update_p1, update_p2;
	logic [8:0] p1_health_wire , p2_health_wire; 
	
	
	//two registers to store the health of two players
	health_reg p1_health(
	.frame_clk(frame_clk), 
	.Reset(Reset), 
	.initialize(init_p1), 
	.update(update_p1),
	.harm(harm_by_2),
	.die(p1_die),
	.health_out(p1_health_wire)
	 );
	

	health_reg p2_health(
	.frame_clk(frame_clk), 
	.Reset(Reset), 
	.initialize(init_p2), 
	.update(update_p2),
	.harm(harm_by_1),
	.die(p2_die),
	.health_out(p2_health_wire)
	 );	
	
		

	
	always_ff @ (posedge frame_clk , posedge Reset)
	begin
		if(Reset==1'b1)
			state <=START;
		else
			state <= next_state;
	end
	
	
	always_comb 
	begin
		next_state = state;
		unique case (state)
		
			START:
			  next_state <=	P1_TURN;
			
			P1_TURN:
			begin
				if(end_set_1==1'b1)
					next_state <= P1_ATTACK_UPDATE;
				else
					next_state <= P1_TURN; //have not finished an attack, still waiting
			end
			
			P2_TURN:
			begin
				if(end_set_2==1'b1)
					next_state <= P2_ATTACK_UPDATE;
				else
					next_state <= P2_TURN; //have not finished an attack, still waiting
			end
			P1_ATTACK_UPDATE:
			begin
				if(p2_health_wire > harm_by_1)
					next_state <= P2_TURN;
				else
					next_state <= P1_WIN;
			end
			
			P2_ATTACK_UPDATE:
			begin
				if(p1_health_wire > harm_by_2)
					next_state <= P1_TURN;
				else
					next_state <= P2_WIN;
			end
			
			P1_WIN:
			begin
				if(restart)
					next_state <= START;
				else
					next_state <= P1_WIN;
			end
			
			P2_WIN:
			begin
				if(restart)
					next_state <= START;
				else
					next_state <= P2_WIN;
			end
			default:
			begin
				next_state =state;
			end
		endcase
	
	end
		

always_comb /*always_ff @ (posedge frame_clk or posedge Reset)*/

begin

	init_p1 = 1'b0;
	init_p2 = 1'b0;
	update_p1 = 1'b0;
	update_p2 = 1'b0;
	p1_die = 1'b0;
	p2_die = 1'b0;
	unique case (state)
	
		START:
		begin
			init_p1 =1'b1; //initialize their health to 100
			init_p2 = 1'b1;
			game_turn_wire = 2'b01; // this would be player 1's turn;
		end
		
		P1_TURN:
		begin
			init_p1 = 1'b0;
			init_p2 = 1'b0;
			update_p1 = 1'b0;
			update_p1 = 1'b0;
			game_turn_wire = 2'b01;
			p1_die = 1'b0;
			p2_die = 1'b0;
		end
		
		P2_TURN:
		begin
			init_p1 = 1'b0;
			init_p2 = 1'b0;
			update_p1 = 1'b0;
			update_p1 = 1'b0;
			game_turn_wire = 2'b10; // 2 represents P2's turn
		end
		
		P1_ATTACK_UPDATE:
		begin
		if(p2_health_wire > harm_by_1)	
			begin
				update_p1= 1'b0;
				update_p2 = 1'b1;
				game_turn_wire= 2'b10;
			end
		else 
			begin
				update_p1= 1'b0;
				update_p2 = 1'b0;
				p1_die = 1'b0;
				p2_die = 1'b1;
				game_turn_wire= 2'b00;
			end

		end
		
		P2_ATTACK_UPDATE:
		begin
			if(p1_health_wire > harm_by_2)
			begin
				update_p1= 1'b1;
				update_p2 = 1'b0;
				game_turn_wire= 2'b01;	
			end
			else
			begin
				update_p1= 1'b0;
				update_p2 = 1'b0;
				p1_die = 1'b1;
				p2_die = 1'b0;
				game_turn_wire= 2'b00;
			end
			
		end
		
		P1_WIN:
		begin
			p2_die=1'b1;
			init_p1 = 1'b0;
			init_p2 = 1'b0;
			update_p1 = 1'b0;
			update_p1 = 1'b0;
			game_turn_wire = 2'b00;		
		end
		
		P2_WIN:
		begin
			p1_die =1'b1;
			init_p1 = 1'b0;
			init_p2 = 1'b0;
			update_p1 = 1'b0;
			update_p1 = 1'b0;
			game_turn_wire = 2'b00;
		end
	
	endcase

end		
						
						
						
		assign health_of_p1 = p1_health_wire;	
		assign health_of_p2 = p2_health_wire;	
		assign game_turn = game_turn_wire;
						

						
						
						
endmodule
