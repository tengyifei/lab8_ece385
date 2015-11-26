module colortable(input ch_on,input [2:0] color, output [7:0] red,green,blue);

logic [7:0] red_wire, green_wire,blue_wire;




always_comb 

begin
	if (ch_on==1'b1)
	begin
	unique case (color)
		3'h0:
		begin
			red_wire=8'h33;
			green_wire=8'h99;
			blue_wire=8'hff;
		end
		3'h1:
		begin
			red_wire=8'hff;
			green_wire=8'hff;
			blue_wire=8'hff;
		end
		3'h2:
		begin
			red_wire=8'h00;
			green_wire=8'h00;
			blue_wire=8'h00;
		end
		3'h3:
		begin
			red_wire=8'h33;
			green_wire=8'h99;
			blue_wire=8'h00;
		end
		3'h4:
		begin
			red_wire=8'h99;
			green_wire=8'h33;
			blue_wire=8'h00;
		end
		3'h5:
		begin
			red_wire=8'hff;
			green_wire=8'h00;
			blue_wire=8'h00;
		end
		3'h6:
		begin
			red_wire=8'hc0;
			green_wire=8'hc0;
			blue_wire=8'hc0;
		end
		3'h7:
		begin
			red_wire=8'h80;
			green_wire=8'h80;
			blue_wire=8'h80;
		end
	
	endcase
	end
	else
	  begin
		red_wire=8'h33;
			green_wire=8'h99;
			blue_wire=8'hff;
	  
	  end

	
end


assign red=red_wire;
assign green = green_wire;
assign blue = blue_wire;






endmodule


