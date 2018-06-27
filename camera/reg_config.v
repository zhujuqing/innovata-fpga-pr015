//camera中寄存器的配置程序
     module reg_config(clk_25M,
                  i2c_sclk,
                  i2c_sdat,
                  reset,
						reg_index,
						config_step,
						clock_20k,
						reg_conf_done);
     input clk_25M;
     input reset;
	  output reg_conf_done;
     output i2c_sclk;
	  output [8:0] reg_index; 
     output [1:0] config_step;	  
     inout i2c_sdat;
	  output clock_20k;
    
     reg clock_20k;
     reg [15:0]clock_20k_cnt;
     reg [1:0]config_step;
     reg [8:0]reg_index;
     reg [23:0]i2c_data;
     reg [15:0]dout;
     reg start;
	  reg reg_conf_done_reg;
    wire ack;
	wire tr_end;
     i2c_com u1(.clock_i2c(clock_20k),
               .reset(reset),
               .ack(ack),
               .i2c_data(i2c_data),
               .start(start),
               .tr_end(tr_end),
               .i2c_sclk(i2c_sclk),
               .i2c_sdat(i2c_sdat));

assign reg_conf_done=reg_conf_done_reg;
//产生i2c控制时钟-20khz    
always@(posedge clk_25M)   
begin
   if(reset)
      begin
        clock_20k<=0;
        clock_20k_cnt<=0;
      end
   else if(clock_20k_cnt<625)
      clock_20k_cnt<=clock_20k_cnt+1'b1;
   else
      begin
         clock_20k<=!clock_20k;
         clock_20k_cnt<=0;
      end
end


	

////OV7670需要配置的寄存器值 24Mhz input clock 30fps PCLK=24Mhz  			
always@(reg_index)   
 begin
    case(reg_index)
		//Read Data Index

    0 :        dout    =    {8'h1C, 8'h7F};    //Manufacturer ID Byte - High (Read only)
1 :        dout    =    {8'h1D, 8'hA2};    //Manufacturer ID Byte - Low (Read only)
//Write Data Index
2    :     dout    =     {8'h12, 8'h80};    // BIT[7]-Reset all the Reg 

3     :     dout    =     {8'h3d, 8'h03};    //DC offset for analog process
4     :     dout    =     {8'h15, 8'h02};    //COM10: hrefsync/pclk/data reverse(Vsync H valid)
5     :     dout    =     {8'h17, 8'h22};    //VGA:    8'h22;    QVGA:    8'h3f;
6     :     dout    =     {8'h18, 8'ha4};    //VGA:    8'ha4;    QVGA:    8'h50;
7     :     dout    =     {8'h19, 8'h07};    //VGA:    8'h07;    QVGA:    8'h03;
8     :     dout    =     {8'h1a, 8'hf0};    //VGA:    8'hf0;    QVGA:    8'h78;
9     :     dout    =     {8'h32, 8'h00};    //HREF    / 8'h80
10    :    dout     =     {8'h29, 8'hA0};    //VGA:    8'hA0;    QVGA:    8'hF0
11    :    dout     =     {8'h2C, 8'hF0};    //VGA:    8'hF0;    QVGA:    8'h78
12    :    dout    =      {8'h0d, 8'h41};    //Bypass PLL
13    :     dout    =     {8'h11, 8'h01};    //CLKRC,Finternal clock = Finput clk*PLL multiplier/[(CLKRC[5:0]+1)*2] = 25MHz*4/[(x+1)*2]
                                        //00: 50fps, 01:25fps, 03:12.5fps    (50Hz Fliter)
14    :     dout    =     {8'h12, 8'h06};    //BIT[6]:    0:VGA; 1;QVGA
                                        //BIT[3:2]:    01:RGB565
                                        //VGA:    00:YUV; 01:Processed Bayer RGB; 10:RGB;    11:Bayer RAW; BIT[7]-Reset all the Reg  
15     :     dout    =     {8'h0C, 8'h10};    //COM3: Bit[7:6]:Vertical/Horizontal mirror image ON/OFF, Bit[0]:Color bar; Default:8'h10
//DSP control
16     :     dout    =     {8'h42, 8'h7f};    //BLC Blue Channel Target Value, Default: 8'h80
17     :     dout    =     {8'h4d, 8'h09};    //BLC Red Channel Target Value, Default: 8'h80
18    :     dout    =     {8'h63, 8'he0};    //AWB Control
19    :     dout    =     {8'h64, 8'hff};    //DSP_Ctrl1:
20    :     dout    =     {8'h65, 8'h20};    //DSP_Ctrl2:    
21    :     dout    =     {8'h66, 8'h00};    //{COM3[4](0x0C), DSP_Ctrl3[7]}:00:YUYV;    01:YVYU;    [10:UYVY]    11:VYUY    
22     :     dout    =     {8'h67, 8'h00};    //DSP_Ctrl4:00/01: YUV or RGB; 10: RAW8; 11: RAW10    
//AGC AEC AWB
23    :    dout    =    {8'h13, 8'hf0};   
24    :    dout    =    {8'h0f, 8'hc5};
25    :    dout    =    {8'h14, 8'h11};
26    :    dout    =    {8'h22, 8'h7f};    //Banding Filt er Minimum AEC Value; Default: 8'h09
27    :    dout    =    {8'h23, 8'h03};    //Banding Filter Maximum Step
28    :    dout    =    {8'h24, 8'h40};    //AGC/AEC - Stable Operating Region (Upper Limit)
29    :    dout    =    {8'h25, 8'h30};    //AGC/AEC - Stable Operating Region (Lower Limit)
30    :    dout    =    {8'h26, 8'ha1};    //AGC/AEC Fast Mode Operating Region
31    :    dout    =    {8'h2b, 8'h00};    //TaiWan: 8'h00:60Hz Filter; Mainland: 8'h9e:50Hz Filter
32    :    dout    =    {8'h6b, 8'haa};    //AWB Control 3
33    :    dout    =    {8'h13, 8'hff};    //8'hff: AGC AEC AWB Enable; 8'hf0: AGC AEC AWB Disable;
//matrix sharpness brightness contrast UV    
34     :     dout    =     {8'h90, 8'h05};    
35     :     dout    =     {8'h91, 8'h01};
36     :     dout    =     {8'h92, 8'h03};
37     :     dout    =     {8'h93, 8'h00};
38     :     dout    =     {8'h94, 8'hb0};
39     :     dout    =     {8'h95, 8'h9d};
40     :     dout    =     {8'h96, 8'h13};
41     :     dout    =     {8'h97, 8'h16};
42     :     dout    =     {8'h98, 8'h7b};
43     :     dout    =     {8'h99, 8'h91};
44     :     dout    =     {8'h9a, 8'h1e};
45     :     dout    =     {8'h9b, 8'h08};    //Brightness 
46     :     dout    =     {8'h9c, 8'h20};
47     :     dout    =     {8'h9e, 8'h81};    
48     :     dout    =     {8'ha6, 8'h06};
49     :     dout    =     {8'ha7, 8'h65};
50     :     dout    =     {8'ha8, 8'h65};
51     :     dout    =     {8'ha9, 8'h80};
52     :     dout    =     {8'haa, 8'h80};
//Gamma correction
53     :     dout    =     {8'h7e, 8'h0c};
54     :     dout    =     {8'h7f, 8'h16};    //
55     :     dout    =     {8'h80, 8'h2a};
56     :     dout    =     {8'h81, 8'h4e};
57     :     dout    =     {8'h82, 8'h61};
58     :     dout    =     {8'h83, 8'h6f};
59     :     dout    =     {8'h84, 8'h7b};
60     :     dout    =     {8'h85, 8'h86};
61     :     dout    =     {8'h86, 8'h8e};
62     :     dout    =     {8'h87, 8'h97};
63     :     dout    =     {8'h88, 8'ha4};
64     :     dout    =     {8'h89, 8'haf};
65     :     dout    =     {8'h8a, 8'hc5};
66     :     dout    =     {8'h8b, 8'hd7};
67     :     dout    =     {8'h8c, 8'he8};
68     :     dout    =     {8'h8d, 8'h20};
//Others
69    :    dout    =    {8'h0e, 8'h65};
	 
	 
//	 70 : 	reg_data	<= 16'h7419;
//	 71 : 	reg_data	<= 16'h8d4f;
//	 72 : 	reg_data	<= 16'h8e00;
//	 73 : 	reg_data	<= 16'h8f00;
//	 74 : 	reg_data	<= 16'h9000;
//	 75 : 	reg_data	<= 16'h9100;
//	 76 : 	reg_data	<= 16'h9200;
//	 77 : 	reg_data	<= 16'h9600;
//	 78 : 	reg_data	<= 16'h9a80;
//	 79 : 	reg_data	<= 16'hb084;
//	 80 : 	reg_data	<= 16'hb10c;
//	 81 : 	reg_data	<= 16'hb20e;
//	 82 : 	reg_data	<= 16'hb382;
//	 83 : 	reg_data	<= 16'hb80a;
//    84  :	reg_data	<=	16'h4314;
//	 85  :	reg_data	<=	16'h44f0;
//	 86  :	reg_data	<=	16'h4534;
//	 87  :	reg_data	<=	16'h4658;
//	 88  :	reg_data	<=	16'h4728;
//	 89  :	reg_data	<=	16'h483a;
//	 90  :	reg_data	<=	16'h5988;
//	 91  :	reg_data	<=	16'h5a88;
//	 92  :	reg_data	<=	16'h5b44;
//	 93  :	reg_data	<=	16'h5c67;
//	 94  :	reg_data	<=	16'h5d49;
//	 95  :	reg_data	<=	16'h5e0e;
//	 96  :	reg_data	<=	16'h6404;
//	 97  :	reg_data	<=	16'h6520;
//	 98  :	reg_data	<=	16'h6605;
//	 99  :	reg_data	<=	16'h9404;
//	 100 :	reg_data	<=	16'h9508;
//	 101 :	reg_data	<=	16'h6c0a;
//	 102 :	reg_data	<=	16'h6d55;
//	 103 :	reg_data	<=	16'h4f80;	 
//	 104 :	reg_data	<=	16'h5080;
//	 105 :	reg_data	<= 16'h5100;
//	 106 :	reg_data	<= 16'h5222;
//	 107 :	reg_data	<= 16'h535e;
//	 108 :	reg_data	<= 16'h5480;
//	 109 :	reg_data	<= 16'h0903;	 
//	 110 :	reg_data	<=	16'h6e11;
//	 111 :	reg_data	<=	16'h6f9f;
//	 112 :	reg_data	<=	16'h5500;
//	 113 :	reg_data	<=	16'h5640;
//	 114 :	reg_data	<=	16'h5740;
//	 115 :	reg_data	<=	16'h6a40;
//	 116 :	reg_data	<=	16'h0140;
//	 117 :	reg_data	<=	16'h0240;
//	 118 :	reg_data	<=	16'h13e7;
//	 119 :	reg_data	<=	16'h1500;
//	 120 :	reg_data	<= 16'h589e;
//	 121 : 	reg_data	<=	16'h4108;
//	 122 : 	reg_data	<=	16'h3f00;             
//	 123 : 	reg_data	<=	16'h7505;
//	 124 : 	reg_data	<=	16'h76e1;
//	 125 : 	reg_data	<=	16'h4c00;
//	 126 : 	reg_data	<=	16'h7701;
//	 127 : 	reg_data	<=	16'h4b09;
//	 128 : 	reg_data	<=	16'hc9f0;                  //16'hc960;
//	 129 : 	reg_data	<=	16'h4138;
//	 130 : 	reg_data	<=	16'h3411;
////	 131 : 	reg_data	<=	16'h3b02;
//	 131 : 	reg_data	<=	16'h3b0a;
//	 132 : 	reg_data	<=	16'ha489;
//	 133 : 	reg_data	<=	16'h9600;
//	 134 : 	reg_data	<=	16'h9730;
//	 135 : 	reg_data	<=	16'h9820;
//	 136 : 	reg_data	<=	16'h9930;
//	 137 : 	reg_data	<=	16'h9a84;
//	 138 : 	reg_data	<=	16'h9b29;
//	 139 : 	reg_data	<=	16'h9c03;
//	 140 : 	reg_data	<=	16'h9d4c;
//	 141 : 	reg_data	<=	16'h9e3f;
//	 142 : 	reg_data	<=	16'h7804;
//	 143 :	reg_data	<=	16'h7901;
//	 144 :	reg_data	<= 16'hc8f0;
//	 145 :	reg_data	<= 16'h790f;
//	 146 :	reg_data	<= 16'hc800;
//	 147 :	reg_data	<= 16'h7910;
//	 148 :	reg_data	<= 16'hc87e;
//	 149 :	reg_data	<= 16'h790a;
//	 150 :	reg_data	<= 16'hc880;
//	 151 :	reg_data	<= 16'h790b;
//	 152 :	reg_data	<= 16'hc801;
//	 153 :	reg_data	<= 16'h790c;
//	 154 :	reg_data	<= 16'hc80f;
//	 155 :	reg_data	<= 16'h790d;
//	 156 :	reg_data	<= 16'hc820;
//	 157 :	reg_data	<= 16'h7909;
//	 158 :	reg_data	<= 16'hc880;
//	 159 :	reg_data	<= 16'h7902;
//	 160 :	reg_data	<= 16'hc8c0;
//	 161 :	reg_data	<= 16'h7903;
//	 162 :	reg_data	<= 16'hc840;
//	 163 :	reg_data	<= 16'h7905;
//	 164 :	reg_data	<= 16'hc830; 
//	 165 :	reg_data	<= 16'h7926;
//	 166 :	reg_data	<= 16'h2a00;  
//	 167 :	reg_data	<= 16'h2b00; 	 
//	 168 :	reg_data	<= 16'h9300; 
	 
	 default:dout <= {8'h1C, 8'h7F} ;
    endcase      
end	 


////iic寄存器配置过程控制    
always@(posedge clock_20k)    
begin
   if(reset) begin
       config_step<=0;
       start<=0;
       reg_index<=0;
		 reg_conf_done_reg<=0;
   end
   else begin
       if(reg_index<70) begin                     //一共配置165个寄存器       
             case(config_step)
             0:begin
               i2c_data<={8'h42,dout};       //OV7670 IIC Device address is 0x42   
               start<=1;
               config_step<=1;
               end
             1:begin
               if(tr_end) begin                  //IIC发送结束  
 					    start<=0;
                   config_step<=2;
                 end
               end
             2:begin
                 reg_index<=reg_index+1'b1;
                 config_step<=0;
               end
             endcase
          end
		 else
         reg_conf_done_reg<=1'b1;	 
     end
 end

endmodule

