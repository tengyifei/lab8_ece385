
module nios_system (
	ball1_pos_export,
	ball2_pos_export,
	clk_clk,
	key2_wire_export,
	key3_wire_export,
	keycode_export,
	new_pos_to_hw_export,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_r_export,
	otg_hpi_w_export,
	p1_old_pos_to_sw_export,
	p2_old_pos_to_sw_export,
	power_angle_export,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	vsync_export);	

	input	[19:0]	ball1_pos_export;
	input	[19:0]	ball2_pos_export;
	input		clk_clk;
	input		key2_wire_export;
	input		key3_wire_export;
	output	[15:0]	keycode_export;
	output	[31:0]	new_pos_to_hw_export;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output		otg_hpi_r_export;
	output		otg_hpi_w_export;
	input	[19:0]	p1_old_pos_to_sw_export;
	input	[19:0]	p2_old_pos_to_sw_export;
	input	[15:0]	power_angle_export;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		vsync_export;
endmodule
