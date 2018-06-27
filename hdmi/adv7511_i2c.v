module adv7511_i2c
#(
parameter tx_reg_num=25
)
(
input clk,//750Khz
input rst_n,
input start,
inout sda,
output scl,
output reg config_done
);//
reg [7:0]sla_addr;
reg [7:0]sub_addr;
reg wt_req;
reg rd_req;
reg [7:0]data_w;
wire [7:0]data_r;
wire busy;
wire sucess;
reg [7:0]count;
reg [23:0]tx_reg[0:tx_reg_num-1];

always @ (*)
begin:init_value
tx_reg[0]<=24'h72_01_00;//_Set_N_Value(6144)Audio setup
tx_reg[1]<=24'h72_02_18;//_Set_N_Value(6144)
tx_reg[2]<=24'h72_03_00;//_Set_N_Value(6144)
tx_reg[3]<=24'h72_15_00; //RGB or YUV 4:4:4 8bit Separate syncs input id 0
tx_reg[4]<=24'h72_16_38;// 0 OUTPUT FORMAT 4:4:4 0 11 8bit input color depth 10 style1 23:16 1 input rising edge 0
//tx_reg[5]<=24'h72_18_46;//Disable CSC
tx_reg[5]<=24'h72_03_00;//_Set_N_Value(6144)
tx_reg[6]<=24'h72_40_80;//General_Control_Packet_Enable
tx_reg[7]<=24'h72_41_10;//_Power_Down_control
tx_reg[8]<=24'h72_48_00;//evenly distributed
tx_reg[9]<=24'h72_49_A8;//_Set_Dither_mode_-_12-to-10_bit ?????????????????????????????
tx_reg[10]<=24'h72_4C_04;// 8 bit Output
tx_reg[11]<=24'h72_55_00;//_Set_RGB 4 4 4_in_AVinfo_Frame
tx_reg[12]<=24'h72_56_88;//_Set active format Aspect Same as Aspect Ratio
tx_reg[13]<=24'h72_96_20;//_HPD_Interrupt_clear
tx_reg[14]<=24'h72_98_03;//_ADI_required_Write//Must be set to 0x03 for proper operation
tx_reg[15]<=24'h72_99_02;//_ADI_required_Write
tx_reg[16]<=24'h72_9C_30;//_ADI_required_Write
tx_reg[17]<=24'h72_9D_61;//_Set_clock_divide 1
tx_reg[18]<=24'h72_A2_A4;//_ADI_required_Write
tx_reg[19]<=24'h72_43_A4;//_ADI_required_Write
tx_reg[20]<=24'h72_AF_14;//_Set_DVI_Mode
tx_reg[21]<=24'h72_BA_60;//_No_clock_delay
tx_reg[22]<=24'h72_DE_9C;//_ADI_required_write
tx_reg[23]<=24'h72_E4_60;//_ADI_required_Write
tx_reg[24]<=24'h72_FA_7D;//_Nbr_of_times_to_search_for_good_phase
end

always @(posedge sucess or negedge rst_n)
begin
    if(!rst_n)
	    begin
		count<=1'b0;
		end
	else if(start)
	    begin
		if(sucess)
		    if(count<tx_reg_num)
		        count<=count+1'b1;
		end
end
always @(posedge clk or negedge rst_n)
begin:lsm1

    if(!rst_n)
	    begin
		config_done<=1'b0;
		sla_addr<=8'b0;
		sub_addr<=8'b0;
		data_w<=8'b0;
		wt_req<=1'b0;
		rd_req<=1'b0;
		end
	else if(start)
	    begin
		if(count>=tx_reg_num)
		    begin
		    config_done<=1'b1;
			wt_req<=1'b0;
			rd_req<=1'b0;
			end
		else
		    begin
		    if(!busy)
		        begin
			    sla_addr<=tx_reg[count][23:16];
	            sub_addr<=tx_reg[count][15:8];
	            data_w<=tx_reg[count][7:0];
	            wt_req<=1'b1;
			    rd_req<=1'b0;
			    end
		    end
		    
		end

end
i2c_diver i2c_diver_inst
(
.clk(clk),
.rst_n(rst_n),
.sda(sda),
.sla_addr(sla_addr),
.sub_addr(sub_addr),
.wt_req(wt_req),
.rd_req(rd_req),
.data_w(data_w),
.scl(scl),
.data_r(data_r),
.busy(busy),
.sucess(sucess)
);
endmodule