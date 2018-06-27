/*-------------------------------------------------------------------------
Filename			:		ov5640_ddr_vga.v
Description		:		read picture from sd, and store in ddr, display on VGA.
===========================================================================*/
`timescale 1ns / 1ps
module de10_huanshi
(
   // Differential system clocks
     input                                        clk_50M,
     input                                        sys_rstn,
     // input                                        key_up,
	 // input                                        key_down,
	 // input                                        key_left,
	 // input                                        key_right,
	 // output                                       led_up,
	 // output                                       led_down,
	 // output                                       led_left,
	 // output                                       led_right,
	 
  
	 
	
	//HDMI port	
	 output                                       hdmi_clk,         //vga clock
     output                                       hdmi_en,          //vga black enable
	 output			                              hdmi_hs,		   //horizontal sync 
	 output			                              hdmi_vs,		   //vertical sync
	 output  [23:0]	                              hdmi_data,		   //VGA R data
	 output                                       hdmi_tx_scl,
	 inout                                        hdmi_tx_sda,

	
	//cmos1 interface
     output                                       cmos1_scl,         //cmos i2c clock
     inout                                        cmos1_sda,         //cmos i2c data
     input                                        cmos1_vsync,       //cmos vsync
     input                                        cmos1_href,        //cmos hsync refrence
     input                                        cmos1_pclk,        //cmos pxiel clock
     input   [7:0]                                cmos1_d,           //cmos data
     output                                       cmos1_reset,       //cmos reset
     output                                       cmos1_pwdn,
     output                                       cmos1_xclk,

	//cmos2 interface
     output                                       cmos2_scl,         //cmos i2c clock
     inout                                        cmos2_sda,         //cmos i2c data
     input                                        cmos2_vsync,       //cmos vsync
     input                                        cmos2_href,        //cmos hsync refrence
     input                                        cmos2_pclk,        //cmos pxiel clock
     input   [7:0]                                cmos2_d,          //cmos data
     output                                       cmos2_reset,       //cmos reset
     output                                       cmos2_pwdn,
     output                                       cmos2_xclk,
	 
	 //cmos3 interface
     output                                       cmos3_scl,         //cmos i2c clock
     inout                                        cmos3_sda,         //cmos i2c data
     input                                        cmos3_vsync,       //cmos vsync
     input                                        cmos3_href,        //cmos hsync refrence
     input                                        cmos3_pclk,        //cmos pxiel clock
     input   [7:0]                                cmos3_d,           //cmos data
     output                                       cmos3_reset,       //cmos reset
     output                                       cmos3_pwdn,
     output                                       cmos3_xclk,
	 
	 //cmos4 interface
     output                                       cmos4_scl,         //cmos i2c clock
     inout                                        cmos4_sda,         //cmos i2c data
     input                                        cmos4_vsync,       //cmos vsync
     input                                        cmos4_href,        //cmos hsync refrence
     input                                        cmos4_pclk,        //cmos pxiel clock
     input   [7:0]                                cmos4_d,           //cmos data
     output                                       cmos4_reset,       //cmos reset
     output                                       cmos4_pwdn,
     output                                       cmos4_xclk
	
);

reg clk_25M;
parameter fish_delay = 8'd24;
parameter comb_delay = 8'd1;

assign cmos1_pwdn = 1'b0;
assign cmos1_reset  = 1'b1;
assign cmos1_xclk = clk_25M;

assign cmos2_pwdn = 1'b0;
assign cmos2_reset  = 1'b1;
assign cmos2_xclk = clk_25M;

assign cmos3_pwdn = 1'b0;
assign cmos3_reset  = 1'b1;
assign cmos3_xclk = clk_25M;

assign cmos4_pwdn = 1'b0;
assign cmos4_reset  = 1'b1;
assign cmos4_xclk = clk_25M;




//------------------------------pll----------------------//

 parameter CLK_DIV =1;            //定义chipscoe的分频系￯/reg clk27m;
    reg [3:0] scope_counter;

    always @(posedge clk_50M)
    begin
       if (scope_counter == CLK_DIV-1) 
	    begin
	       scope_counter<=0;
		   clk_25M <= ~ clk_25M;  
	    end
       else
    	   scope_counter<=scope_counter+1'b1;
	end
//-----------------------------------------------------//	

wire Cmos1_Config_Done;
wire Cmos2_Config_Done;
wire Cmos3_Config_Done;
wire Cmos4_Config_Done;
 
//-------------------------------------
//CMOS1 Camera��ʼ������

reg_config	reg_config_inst1(
	.clk_25M                 (clk_25M),
	.reset                   (~sys_rstn),	
	.i2c_sclk                (cmos1_scl),
	.i2c_sdat                (cmos1_sda),
	.reg_conf_done           (Cmos1_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);

//-------------------------------------
//CMOS2 Camera��ʼ������

reg_config	reg_config_inst2(
	.clk_25M                 (clk_25M),
	.reset                   (~sys_rstn),		
	.i2c_sclk                (cmos2_scl),
	.i2c_sdat                (cmos2_sda),
	.reg_conf_done           (Cmos2_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);

//-------------------------------------
//CMOS3 Camera��ʼ������

reg_config	reg_config_inst3(
	.clk_25M                 (clk_25M),
	.reset                   (~sys_rstn),		
	.i2c_sclk                (cmos3_scl),
	.i2c_sdat                (cmos3_sda),
	.reg_conf_done           (Cmos3_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);

//-------------------------------------
//CMOS4 Camera��ʼ������

reg_config	reg_config_inst4(
	.clk_25M                 (clk_25M),
	.reset                   (~sys_rstn),		
	.i2c_sclk                (cmos4_scl),
	.i2c_sdat                (cmos4_sda),
	.reg_conf_done           (Cmos4_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);

//................................................................
//............cmos1 camera
//...........................................................
wire [11:0] cmos1_data12;
wire cmos1_buff_wr;
wire [16:0] cmos1_addr_wr;

camera_capture	camera_capture_cmos1(
	.rst                  (~sys_rstn),	       //external reset  
	//.init_done               (init_calib_complete & (Cmos1_Config_Done | Cmos2_Config_Done)),	   // init done
	.pclk             (clk_25M),	   //cmos pxiel clock
	.href             (cmos1_href),	   //cmos hsync refrence
	.vsync            (cmos1_vsync),    //cmos vsync
	.camera_data      (cmos1_d),        //cmos data
	.data12           (cmos1_data12),
	//.data12           (12'b111100000000),
	.href_count       (),
	.vs_count         (),
	.addr_wr          (cmos1_addr_wr),
	.buff_wr          (cmos1_buff_wr)
);


//................................................................
//............cmos2 camera
//...........................................................
wire [11:0] cmos2_data12;
wire cmos2_buff_wr;
wire [16:0] cmos2_addr_wr;

camera_capture	camera_capture_cmos2(
	.rst                  (~sys_rstn),	       //external reset  
	//.init_done               (init_calib_complete & (Cmos1_Config_Done | Cmos2_Config_Done)),	   // init done
	.pclk             (clk_25M),	   //cmos pxiel clock
	.href             (cmos2_href),	   //cmos hsync refrence
	.vsync            (cmos2_vsync),    //cmos vsync
	.camera_data      (cmos2_d),        //cmos data
	.data12           (cmos2_data12),
	//.data12           (12'b000000001111),
	.href_count       (),
	.vs_count         (),
	.addr_wr          (cmos2_addr_wr),
	.buff_wr          (cmos2_buff_wr)
);

//................................................................
//............cmos3 camera
//...........................................................
wire [11:0] cmos3_data12;

wire        cmos3_buff_wr;
wire [16:0] cmos3_addr_wr;

camera_capture	camera_capture_cmos3(
	.rst                  (~sys_rstn),	       //external reset  
	//.init_done               (init_calib_complete & (Cmos1_Config_Done | Cmos2_Config_Done)),	   // init done
	.pclk             (clk_25M),	   //cmos pxiel clock
	.href             (cmos3_href),	   //cmos hsync refrence
	.vsync            (cmos3_vsync),    //cmos vsync
	.camera_data      (cmos3_d),        //cmos data
	.data12           (cmos3_data12),
	//.data12           (12'b111100000000),
	.href_count       (),
	.vs_count         (),
	.addr_wr          (cmos3_addr_wr),
	.buff_wr          (cmos3_buff_wr)
);

//................................................................
//............cmos4 camera
//...........................................................
wire [11:0] cmos4_data12;
wire        cmos4_buff_wr;
wire [16:0] cmos4_addr_wr;
//assign cmos4_data12 = 12'b111100000000;
camera_capture	camera_capture_cmos4(
	.rst                  (~sys_rstn),	       //external reset  
	//.init_done               (init_calib_complete & (Cmos1_Config_Done | Cmos2_Config_Done)),	   // init done
	.pclk             (clk_25M),	   //cmos pxiel clock
	.href             (cmos4_href),	   //cmos hsync refrence
	.vsync            (cmos4_vsync),    //cmos vsync
	.camera_data      (cmos4_d),        //cmos data
	.data12           (cmos4_data12),
	.href_count       (),
	.vs_count         (),
	.addr_wr          (cmos4_addr_wr),
	.buff_wr          (cmos4_buff_wr)
);



//-------------------------------------
// hdmi display
//-------------------------------------
wire [10:0] x_cnt;
wire [10:0] y_cnt;
wire [11:0] dataout_comb;
wire [7:0]  vga_delay;
assign vga_delay = fish_delay + comb_delay;

wire start;
wire clk_750Khz;

div_freq div_freq_inst
(
    .clk_in(clk_50M),
    .rst_n(~sys_rstn),
    .start(start),
    .clk_out1(clk_750Khz),
    .clk_out2()
);

adv7511_i2c adv7511_i2c_inst
(
    .clk(clk_750Khz),
    .rst_n(~sys_rstn),
	 .start(start),
    .sda(hdmi_tx_scl),
    .scl(hdmi_tx_sda),
    .config_done()
	 );
	
	
hdmi_display	   hdmi_display_inst
  (
	//global clock
	.hdmi_clk_i			   (clk_25M),			    //vga clock
	.hdmi_rst			   (~sys_rstn),		        //global reset
    .ddr_data              (dataout_comb),
    .number_delay          (vga_delay),
	//vga port
	.hdmi_clk              (hdmi_clk),
	.hdmi_en               (hdmi_en),
	.hdmi_hsync			   (hdmi_hs),		        //vga horizontal sync 
	.hdmi_vsync			   (hdmi_vs),		        //vga vertical sync
	.hdmi_data			   (hdmi_data),			    //vga red data	
	.x_cnt(x_cnt),
	.y_cnt(y_cnt)

);

/* //.................................................................................
//                                      model select
//.................................................................................

wire[20:0]cmos1_addr_rd_single;
wire[20:0]cmos2_addr_rd_single;
wire[20:0]cmos3_addr_rd_single;
wire[20:0]cmos4_addr_rd_single;

wire [2:0]model_count;


assign vga_delay= (model_count==3'b101)? (fish_delay+comb_delay) : 8'b0 ;//93+15

model_select  model_select
    (
	.clk(clk_25M),
	.rstn(sys_rstn),
	//.comb_delay(comb_delay),
	.key_up(key_up),
	.key_down(key_down),
	.key_left(key_left),
	.key_right(key_right),
	.led_up(led_up),
	.led_down(led_down),
	.led_left(led_left),
	.led_right(led_right),
	.x_cnt(x_cnt),
	.y_cnt(y_cnt),
	.model_count(model_count),
	.cmos1_addr_rd (cmos1_addr_rd_single ),
	.cmos2_addr_rd (cmos2_addr_rd_single ),
	.cmos3_addr_rd (cmos3_addr_rd_single ),
	.cmos4_addr_rd (cmos4_addr_rd_single )
	); */
//.................................................................................
//                                      comb
//.................................................................................
wire[2:0] img1;
wire[2:0] img2;
wire[10:0]x1_cnt_comb;
wire[10:0]y1_cnt_comb;
wire[10:0]x2_cnt_comb;
wire[10:0]y2_cnt_comb;
wire [10:0] Q1;
wire [10:0] Q2;
comb    comb(
                        .Clk(clk_25M),
						.Rstn(sys_rstn),
						.Cline(y_cnt),
						.Cpixel(x_cnt),
						.X1_delay(x1_cnt_comb),
						.X2_delay(x2_cnt_comb),
						.Y1_delay(y1_cnt_comb),
						.Y2_delay(y2_cnt_comb),
						.img1_delay(img1),
						.img2_delay(img2),
						.Q1(Q1),
						.Q2(Q2)
						);
////......................................................................
////                     fish selsect
////..........................................................................
reg [10:0]x_cnt_comb_up;
reg [10:0]y_cnt_comb_up;
reg [10:0]x_cnt_comb_down;
reg [10:0]y_cnt_comb_down;
reg [10:0]x_cnt_comb_left;
reg [10:0]y_cnt_comb_left;
reg [10:0]x_cnt_comb_right;
reg [10:0]y_cnt_comb_right;


always@(posedge clk_25M)
begin
   if(img1==3'd1)
        begin
            x_cnt_comb_up <= x1_cnt_comb;
            y_cnt_comb_up <= y1_cnt_comb;
        end
	else if (img2 == 3'd1)
		begin
            x_cnt_comb_up <= x2_cnt_comb;
            y_cnt_comb_up <= y2_cnt_comb;
        end               
	else;
end

always@(posedge clk_25M)
begin
   if(img1==3'd2)
        begin
            x_cnt_comb_left <= x1_cnt_comb;
            y_cnt_comb_left <= y1_cnt_comb;
        end
	else if (img2 == 3'd2)
		begin
            x_cnt_comb_left <= x2_cnt_comb;
            y_cnt_comb_left <= y2_cnt_comb;
        end
	else;
end

always@(posedge clk_25M)
begin
   if(img1==3'd3)
        begin
            x_cnt_comb_right <= x1_cnt_comb;
            y_cnt_comb_right <= y1_cnt_comb;
        end
	else if (img2 == 3'd3)
		begin
            x_cnt_comb_right <= x2_cnt_comb;
            y_cnt_comb_right <= y2_cnt_comb;
        end
	else;
end

always@(posedge clk_25M)
begin
   if(img1==3'd4)
        begin
            x_cnt_comb_down <= x1_cnt_comb;
            y_cnt_comb_down <= y1_cnt_comb;
        end
	else if (img2 == 3'd4)
		begin
            x_cnt_comb_down <= x2_cnt_comb;
            y_cnt_comb_down <= y2_cnt_comb;
        end
	else;
end

//...........................................................................
//                                        fish_up
//.........................................................................
wire [20:0] cmos1_addr_rd_comb;
fish_up   fish_up
  (
  .clk(clk_25M),
  .rstn(sys_rstn),
  .x_cnt_comb(y_cnt_comb_up),
  .y_cnt_comb(x_cnt_comb_up),
  .addr_rd_select(cmos1_addr_rd_comb)
  );
  //...........................................................................
//                                        fish_left
//.........................................................................
wire [20:0] cmos2_addr_rd_comb;
fish_left   fish_left
  (
  .clk(clk_25M),
  .rstn(sys_rstn),
  .x_cnt_comb(y_cnt_comb_left),
  .y_cnt_comb(x_cnt_comb_left),
  .addr_rd_select(cmos2_addr_rd_comb)

  );
  //...........................................................................
//                                        fish_right
//.........................................................................
wire [20:0] cmos3_addr_rd_comb;
fish_right   fish_right
  (
  .clk(clk_25M),
  .rstn(sys_rstn),
  .x_cnt_comb(y_cnt_comb_right),
  .y_cnt_comb(x_cnt_comb_right),
  .addr_rd_select(cmos3_addr_rd_comb)

  );
  //...........................................................................
//                                        fish_down
//.........................................................................
wire [20:0] cmos4_addr_rd_comb;
fish_down   fish_down
  (
  .clk(clk_25M),
  .rstn(sys_rstn),
  .x_cnt_comb(y_cnt_comb_down),
  .y_cnt_comb(x_cnt_comb_down),
  .addr_rd_select(cmos4_addr_rd_comb)

  );

  
  //.............................................................................
  //                                  ram 1
  //..............................................................................
  wire [11:0]cmos1_dataout;
  wire [11:0]cmos2_dataout;
  wire [11:0]cmos3_dataout;
  wire [11:0]cmos4_dataout;
  
  
             
  reg [16:0] cmos1_addr_rd;
  reg [16:0] cmos2_addr_rd;
  reg [16:0] cmos3_addr_rd;
  reg [16:0] cmos4_addr_rd;
  
  
  // always@(*)
  // begin
        // if(model_count==3'b101)
			// begin
				// cmos1_addr_rd<=cmos1_addr_rd_comb;
				// cmos2_addr_rd<=cmos2_addr_rd_comb;
				// cmos3_addr_rd<=cmos3_addr_rd_comb;
				// cmos4_addr_rd<=cmos4_addr_rd_comb;
			// end
		// else 
			// begin
				// cmos1_addr_rd<=cmos1_addr_rd_single;
				// cmos2_addr_rd<=cmos2_addr_rd_single;
				// cmos3_addr_rd<=cmos3_addr_rd_single;
				// cmos4_addr_rd<=cmos4_addr_rd_single;
			// end
	// end

  ram	ram_cmos1 (
	.clock          ( clk_25M ),
	.data           ( cmos1_data12 ),
	.rdaddress      ( cmos1_addr_rd_comb ),
	//.rdaddress      (  cmos1_addr_wr),
	.wraddress      ( cmos1_addr_wr ),
	.wren           ( cmos1_buff_wr ),
	.q              ( cmos1_dataout )
	);
  
//.............................................................................
//                                  ram 2
//..............................................................................
ram	ram_cmos2 (
	.clock          ( clk_25M ),
	.data           ( cmos2_data12 ),
	.rdaddress      ( cmos2_addr_rd_comb ),
	.wraddress      ( cmos2_addr_wr ),
	.wren           ( cmos2_buff_wr ),
	.q              ( cmos2_dataout )
	);

//.............................................................................
//                                  ram 3
//..............................................................................
ram	ram_cmos3 (
	.clock          ( clk_25M ),
	.data           ( cmos3_data12 ),
	.rdaddress      ( cmos3_addr_rd_comb ),
	.wraddress      ( cmos3_addr_wr ),
	.wren           ( cmos3_buff_wr ),
	.q              ( cmos3_dataout )
	);

//.............................................................................
//                                  ram 4
//..............................................................................
ram	ram_cmos4 (
	.clock          ( clk_25M ),
	.data           ( cmos4_data12 ),
	.rdaddress      ( cmos4_addr_rd_comb ),
	.wraddress      ( cmos4_addr_wr ),
	.wren           ( cmos4_buff_wr ),
	.q              ( cmos4_dataout )
	);

/////////////Q1Q1  delay 2 clk   .............................//
wire[7:0] Q_delay;
assign Q_delay = fish_delay +8'd2;
wire [10:0]Q1_delay;
wire [10:0]Q2_delay;

data_delay  #(
    .data_width(11) 
)
    Q1_delay_inst
    (
	    .clk(clk_25M),
		.reset_n(sys_rstn),
		.data_in(Q1),
		.data_delay_out(Q1_delay),
		.delay_clk_num(Q_delay)
	);
	

data_delay  #(
    .data_width(11) 
)
    Q2_delay_inst
    (
	    .clk(clk_25M),
		.reset_n(sys_rstn),
		.data_in(Q2),
		.data_delay_out(Q2_delay),
		.delay_clk_num(Q_delay)
	);


/////////////img  delay 2 clk   .............................//

wire [2:0]img_delay1;
wire [2:0]img_delay2;

data_delay  #(
    .data_width(3) 
)
    img_data_delay1
    (
	    .clk(clk_25M),
		.reset_n(sys_rstn),
		.data_in(img1),
		.data_delay_out(img_delay1),
		.delay_clk_num(fish_delay)
	);
	

data_delay  #(
    .data_width(3) 
)
    img_data_delay2
    (
	    .clk(clk_25M),
		.reset_n(sys_rstn),
		.data_in(img2),
		.data_delay_out(img_delay2),
		.delay_clk_num(fish_delay)
	);

reg [2:0]img_delay1_1;
reg [2:0]img_delay1_2;
reg [2:0]img_delay2_1;
reg [2:0]img_delay2_2;
always@(posedge clk_25M)
begin
     img_delay1_1 <=  img_delay1;
     img_delay2_1 <=  img_delay2;
     img_delay1_2 <=  img_delay1_1;
     img_delay2_2 <=  img_delay2_1;
end
//-------------------------------------------------------------------
//          data ronghe                                          
//-------------------------------------------------------------------
reg [22:0] mux_dataout_comb;
wire [3:0]r1_fish;
wire [3:0]g1_fish;
wire [3:0]b1_fish;
assign r1_fish = cmos1_dataout[3:0];
assign g1_fish = cmos1_dataout[7:4];
assign b1_fish = cmos1_dataout[11:8];

wire [3:0]r2_fish;
wire [3:0]g2_fish;
wire [3:0]b2_fish;
assign r2_fish = cmos2_dataout[3:0];
assign g2_fish = cmos2_dataout[7:4];
assign b2_fish = cmos2_dataout[11:8];

wire [3:0]r3_fish;
wire [3:0]g3_fish;
wire [3:0]b3_fish;
assign r3_fish = cmos3_dataout[3:0];
assign g3_fish = cmos3_dataout[7:4];
assign b3_fish = cmos3_dataout[11:8];

wire [3:0]r4_fish;
wire [3:0]g4_fish;
wire [3:0]b4_fish;
assign r4_fish = cmos4_dataout[3:0];
assign g4_fish = cmos4_dataout[7:4];
assign b4_fish = cmos4_dataout[11:8];

reg [8:0]r_comb;
reg [8:0]g_comb;
reg [8:0]b_comb; 
           

always@(posedge clk_25M)
begin
        case({img_delay1_2,img_delay2_2})
        6'b001_001: begin r_comb <={r1_fish,5'b0};
						  g_comb <={g1_fish,5'b0};
						  b_comb <={b1_fish,5'b0};	
					end					 
        6'b010_001: begin r_comb <= r1_fish * Q2_delay + r2_fish * Q1_delay;
						  g_comb <= g1_fish * Q2_delay + g2_fish * Q1_delay;
						  b_comb <= b1_fish * Q2_delay + b2_fish * Q1_delay;	
					end
		6'b011_001: begin r_comb <= r1_fish * Q2_delay + r3_fish * Q1_delay;
						  g_comb <= g1_fish * Q2_delay + g3_fish * Q1_delay;
						  b_comb <= b1_fish * Q2_delay + b3_fish * Q1_delay;	
					end
		//6'b001_100: mux_dataout_comb <= cmos1_dataout*Q1 +cmos4_dataout * Q2 ;
		
		//6'b010_001: mux_dataout_comb <= cmos2_dataout*Q1 +cmos1_dataout * Q2;
        6'b010_010: begin r_comb <={r2_fish,5'b0};
						  g_comb <={g2_fish,5'b0};
						  b_comb <={b2_fish,5'b0};	
					end	                    
        //6'b010_011: mux_dataout_comb <= cmos2_dataout*Q1 +cmos3_dataout * Q2 ;
       // 6'b010_100: mux_dataout_comb <= cmos2_dataout*Q1 +cmos4_dataout * Q2;
        
        //6'b011_001: mux_dataout_comb <= cmos3_dataout*Q1 +cmos1_dataout * Q2;
        //6'b011_010: mux_dataout_comb <= cmos3_dataout*Q1 +cmos2_dataout * Q2;
        6'b011_011: begin r_comb <={r3_fish,5'b0};
						  g_comb <={g3_fish,5'b0};
						  b_comb <={b3_fish,5'b0};	
					end	                   
        //6'b011_100: mux_dataout_comb <= cmos3_dataout*Q1 +cmos4_dataout * Q2;
                
         //6'b100_001: mux_dataout_comb <= cmos4_dataout*Q1 +cmos1_dataout * Q2;
         6'b100_010: begin r_comb <= r2_fish * Q2_delay + r4_fish * Q1_delay;
						   g_comb <= g2_fish * Q2_delay + g4_fish * Q1_delay;
						   b_comb <= b2_fish * Q2_delay + b4_fish * Q1_delay;	
					end
         6'b100_011: begin r_comb <= r3_fish * Q2_delay + r4_fish * Q1_delay;
						   g_comb <= g3_fish * Q2_delay + g4_fish * Q1_delay;
						   b_comb <= b3_fish * Q2_delay + b4_fish * Q1_delay;	
					end
         6'b100_100: begin r_comb <={r4_fish,5'b0};
						   g_comb <={g4_fish,5'b0};
						   b_comb <={b4_fish,5'b0};	
					end	                
		
        default: begin     r_comb <=9'b0;
						   g_comb <=9'b0;
						   b_comb <=9'b0;	
					end	  
        endcase
end

  
//   );
wire [3:0]r_ronghe;
wire [3:0]g_ronghe;
wire [3:0]b_ronghe;

assign r_ronghe = r_comb[8:5];
assign g_ronghe = g_comb[8:5];
assign b_ronghe = b_comb[8:5];


assign dataout_comb = {b_ronghe,g_ronghe,r_ronghe};

// always@(*)
// begin
        // case(model_count)
		// 3'd1: dataout <= cmos1_dataout;
		// 3'd2: dataout <= cmos2_dataout;
		// 3'd3: dataout <= cmos3_dataout;
		// 3'd4: dataout <= cmos4_dataout;
		// 3'd5: dataout <= dataout_comb;
		// default : dataout <= dataout_comb;
		// endcase
// end


endmodule


