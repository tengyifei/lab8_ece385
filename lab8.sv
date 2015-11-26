

module  lab8 		( input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1,// HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  //output [8:0]  LEDG,
							  //output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA virtical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
							  inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
							  output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
							  output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
							  output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
							  output			 DRAM_CAS_N,			// SDRAM Column Address Strobe
							  output			 DRAM_CKE,				// SDRAM Clock Enable
							  output			 DRAM_WE_N,				// SDRAM Write Enable
							  output			 DRAM_CS_N,				// SDRAM Chip Select
							  output			 DRAM_CLK				// SDRAM Clock
											);
    
    logic Reset_h, vssig, Clk;
	 assign vssig=VGA_VS;
    logic [9:0] drawxsig, drawysig, ball1xsig, ball1ysig, ball2xsig, ball2ysig, ball1sizesig,ball2sizesig;
	  logic [9:0] ch1xsig, ch1ysig, ch1sizesigX, ch1sizesigY, ch2xsig, ch2ysig, ch2sizesigX, ch2sizesigY;
	 logic [15:0] keycode;
    
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[0]);  // The push buttons are active low
	
	 
	 wire [1:0] hpi_addr;
	 wire [15:0] hpi_data_in, hpi_data_out;
	 wire hpi_r, hpi_w,hpi_cs;
	 
	 
	 
	 
	 //interconnected wires declared for the game
	 logic restart_wire;
	 logic [31:0] new_pos_to_hw_wire;
    logic [19:0] p2_old_pos_to_sw_export_wire, p1_old_pos_to_sw_export_wire;
	 logic [1:0] game_turn_wire;
	 logic weapon_display_p1_wire,weapon_display_p2_wire;
	 logic weapon_mode_p1_wire, weapon_mode_p2_wire;
	 logic fire_on_wire_1, fire_on_wire_2;
	 logic [8:0] health_p1_wire, health_p2_wire;
	 logic [3:0] power_p1_wire, angle_p1_wire, power_p2_wire, angle_p2_wire;
	 logic [15:0]  power_angle_export_wire;
	 logic vsync_export_wire;
	// logic [9:0] init_vx_player1_wire,init_vy_player1_wire;
	// logic [4:0] power_wire, angle_wire;
	// logic [5:0]  harm_wire; 
	 
	 
	 assign power_angle_export_wire = {angle_p2_wire, power_p2_wire,angle_p1_wire,power_p1_wire};
	 assign  p1_old_pos_to_sw_export_wire = {ch1ysig,ch1xsig};
	 assign  p2_old_pos_to_sw_export_wire = {ch2ysig,ch2xsig};
	 
	 hpi_io_intf hpi_io_inst(   .from_sw_address(hpi_addr),
										 .from_sw_data_in(hpi_data_in),
										 .from_sw_data_out(hpi_data_out),
										 .from_sw_r(hpi_r),
										 .from_sw_w(hpi_w),
										 .from_sw_cs(hpi_cs),
		 								 .OTG_DATA(OTG_DATA),    
										 .OTG_ADDR(OTG_ADDR),    
										 .OTG_RD_N(OTG_RD_N),    
										 .OTG_WR_N(OTG_WR_N),    
										 .OTG_CS_N(OTG_CS_N),    
										 .OTG_RST_N(OTG_RST_N),   
										 .OTG_INT(OTG_INT),
										 .Clk(Clk),
										 .Reset(Reset_h)
	 );
	 
	 //The connections for nios_system might be named different depending on how you set up Qsys
	 nios_system nios_system(
										 .clk_clk(Clk), 
										 .new_pos_to_hw_export(new_pos_to_hw_wire),
										 .vsync_export(vsync_export_wire),
										 .power_angle_export(power_angle_export_wire),
										 .p2_old_pos_to_sw_export(p2_old_pos_to_sw_export_wire),
										 .p1_old_pos_to_sw_export(p1_old_pos_to_sw_export_wire),
										 .reset_reset_n(KEY[0]),   
										 .sdram_wire_addr(DRAM_ADDR), 
										 .sdram_wire_ba(DRAM_BA),   
										 .sdram_wire_cas_n(DRAM_CAS_N),
										 .sdram_wire_cke(DRAM_CKE),  
										 .sdram_wire_cs_n(DRAM_CS_N), 
										 .sdram_wire_dq(DRAM_DQ),   
										 .sdram_wire_dqm(DRAM_DQM),  
										 .sdram_wire_ras_n(DRAM_RAS_N),
										 .sdram_wire_we_n(DRAM_WE_N), 
										 .sdram_clk_clk(DRAM_CLK),
										 .keycode_export(keycode),  
										 .otg_hpi_address_export(hpi_addr),
										 .otg_hpi_data_in_port(hpi_data_in),
										 .otg_hpi_data_out_port(hpi_data_out),
										 .otg_hpi_cs_export(hpi_cs),
										 .otg_hpi_r_export(hpi_r),
										 .otg_hpi_w_export(hpi_w));
	
	//Fill in the connections for the rest of the modules 
    vga_controller vgasync_instance(
	 
	 .Clk(Clk),
	 .Reset(Reset_h),
	 .hs(VGA_HS),
	 .vs(VGA_VS),
	 .pixel_clk(VGA_CLK),
	 .blank(VGA_BLANK_N),
	 .sync(VGA_SYNC_N),
	 .DrawX(drawxsig),
	 .DrawY(drawysig)
	  
	 );
	
	 
game_state main_state0(
 .frame_clk(vssig), 
 .Reset(Reset_h), 
 .restart(restart_wire),
 .harm_by_1(new_pos_to_hw_wire[24:20]),
 .harm_by_2(new_pos_to_hw_wire[29:25]),
 .end_set_1(new_pos_to_hw_wire[30]), 
 .end_set_2(new_pos_to_hw_wire[31]),
 .health_of_p1(health_p1_wire), 
 .health_of_p2(health_p2_wire),
 .game_turn(game_turn_wire)				
 );
	// the health outputs are used in color mapper to display the actual number

 power_angle_reg_p1 power_angle_1(
 .frame_clk(vssig), 
 .Reset(Reset_h), 
 .keycode(keycode[7:0]),
 .power(power_p1_wire), 
 .angle(angle_p1_wire),
 .is_in_turn(game_turn_wire[0])
 );
 
 power_angle_reg_p2 power_angle_2(
 .frame_clk(vssig), 
 .Reset(Reset_h), 
 .keycode(keycode[7:0]),
 .power(power_p2_wire), 
 .angle(angle_p2_wire),
 .is_in_turn(game_turn_wire[1])
 );
 
	 
 p1_weapon_state_machine p1_weapon(
    .Reset(Reset_h), 
	 .frame_clk(vssig),
	 .is_in_turn(game_turn_wire[0]),
	 .end_set(new_pos_to_hw_wire[30]),
	 .keycode(keycode[7:0]),
	 .ch_pos_x(ch1xsig), 
	 .ch_pos_y(ch1ysig), 
	 .Ball_Y_new(new_pos_to_hw_wire[19:10]), 
	 .Ball_X_new(new_pos_to_hw_wire[9:0]),
	 .weapon_display(weapon_display_p1_wire), 
	 .weapon_mode(weapon_mode_p1_wire),
	 .BallX(ball1xsig), 
	 .BallY(ball1ysig),
	 .fire_on(fire_on_wire_1)
	 );
	 
p2_weapon_state_machine p2_weapon(
    .Reset(Reset_h), 
	 .frame_clk(vssig),
	 .is_in_turn(game_turn_wire[1]),
	 .end_set(new_pos_to_hw_wire[31]),
	 .keycode(keycode[7:0]),
	 .ch_pos_x(ch2xsig), 
	 .ch_pos_y(ch2ysig), 
	 .Ball_Y_new(new_pos_to_hw_wire[19:10]), 
	 .Ball_X_new(new_pos_to_hw_wire[9:0]),
	 .weapon_display(weapon_display_p2_wire), 
	 .weapon_mode(weapon_mode_p2_wire),
	 .BallX(ball2xsig), 
	 .BallY(ball2ysig),
	 .fire_on(fire_on_wire_2)
	 );
	 
	 
	 
   
//take the input from keyboard and detect if the restart button "R" is pressed
 restart_sig_generator ( 
 .frame_clk(vssig), 
 .Reset(Reset_h),
 .keycode(keycode[7:0]),
 .restart(restart_wire)
 );
										

	
    ch1 ch1_instance1(
	 
	 .Reset(Reset_h), 
	 .frame_clk(vssig),
	 .ch1X(ch1xsig), 
	 .ch1Y(ch1ysig), 
	 .chsizeX(ch1sizesigX),
	 .chsizeY(ch1sizesigY),
	 .keycode(keycode[7:0]),
	 .is_in_turn(game_turn_wire[0])
	 );
	 
	 
	 
	 ch2 ch2_instance1(
	 
	 .Reset(Reset_h), 
	 .frame_clk(vssig),
	 .ch1X(ch2xsig), 
	 .ch1Y(ch2ysig), 
	 .chsizeX(ch2sizesigX),
	 .chsizeY(ch2sizesigY),
	 .keycode(keycode[7:0]),
	 .is_in_turn(game_turn_wire[1]) 
	 
	 );

	
	// modules used to calculate the trajectory of cannonball
/* trajectory_calc cannon_ball_traj_player1(
			.frame_clk(frame_clk), 
			.Reset(Reset_h),
			.weapon_type(),
			.rival_x(ch2xsig),
			.rival_y(ch2ysig),
			.ch_pos_x(ch1xsig), 
			.ch_pos_y(ch1ysig), 
			.init_vx(init_vx_player1_wire), 
			.init_vy(init_vx_playery_wire),
			.end_set(),
			.on_target(),
			.harm(harm_wire);
			.Ball_Y_next(),
			.Ball_X_next()
			);
*/
	
	/*power_angle_convert instance1(
			.angle(angle_wire), 
			.power(power_wire),
			.init_vx_out(init_vx_player1_wire),
			.init_vy_out(init_vy_player1_wire)
	);
*/					
	
	

	color_mapper color_instance(
	 
	 .Ball1X(ball1xsig), 
	 .Ball1Y(ball1ysig),
	 .Ball2X(ball2xsig), 
	 .Ball2Y(ball2ysig),
	 .ch1X(ch1xsig), 
	 .ch1Y(ch1ysig),
	 .ch2X(ch2xsig), 
	 .ch2Y(ch2ysig),
	 .DrawX(drawxsig), 
	 .DrawY(drawysig), 	 
	 .Ball1_size(ball1sizesig),
	 .Ball2_size(ballsizesig),	 
	 .ch1_sizeX(ch1sizesigX),
	 .ch1_sizeY(ch1sizesigY),
	 .ch2_sizeX(ch2sizesigX),
	 .ch2_sizeY(ch2sizesigY),
	 .health_p1(health_p1_wire), 
	 .health_p2(health_p1_wire),
	 .game_turn(game_turn_wire),
	 .weapon_mode_p1(weapon_mode_p1_wire), 
	 .weapon_mode_p2(weapon_mode_p2_wire),
	 .weapon_display_p1(weapon_display_p1_wire), 
	 .weapon_display_p2(weapon_display_p2_wire),
	 .Red(VGA_R), 
	 .Green(VGA_G), 
	 .Blue(VGA_B)
	 
	 );
				
	
	 HexDriver hex_inst_0 (keycode[3:0], HEX0);
	 HexDriver hex_inst_1 (keycode[7:4], HEX1);
    

endmodule
