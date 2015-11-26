module counter_reg (input Clk, Reset, Load,
              output logic [9:0]  Data_Out);

	logic [9:0] data;			  
    always_ff @ (posedge Clk or negedge Reset)
    begin
	 
    if (Reset==1'b0) 
        data <= 9'h0;
	 else if (Load)
        data <= data+9'b1;
		else 
			data<=data;
	 end
	
    assign Data_Out = data;

endmodule
