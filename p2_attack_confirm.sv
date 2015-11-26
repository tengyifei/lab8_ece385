module p2_attack_confirm(input [7:0] keycode,
							 input Reset, frame_clk, input is_in_turn,
							 output attack_start);
							 
	logic attack_start_wire;
							 
	always_comb
		begin
				if(is_in_turn == 1'b0)
					attack_start_wire=1'b0;
				else
					begin
						if(keycode == 8'd14)
						//press "K"
							attack_start_wire=1'b1;
						else
							attack_start_wire=1'b0;
					end		
		end
							 
		assign attack_start = attack_start_wire;	 
							 
				 

							 
							 
endmodule