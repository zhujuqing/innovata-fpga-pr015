////////////地址部分/////////////////
`define IDEL 	0
`define START 	1
`define SLAADDR	2,3,4,5,6,7,8,9
`define SLAACK  10
`define SUBADDR	11,12,13,14,15,16,17,18
`define SUBACK  19

////////////写数据部分/////////////////
`define WDATA	20,21,22,23,24,25,26,27
`define WACK	28
`define WSTOP	29

////////////读数据部分/////////////////
`define RESTART 20
`define RESLAADDR 21,22,23,24,25,26,27,28
`define RACK	 29
`define RDATA	 30,31,32,33,34,35,36,37
`define MACK	 38
`define RSTOP	 39
module i2c_diver
(
input clk,
input rst_n,
inout sda,
input [7:0]sla_addr,
input [7:0]sub_addr,
input wt_req,
input rd_req,
input [7:0]data_w,
output reg scl,
output reg [7:0]data_r,
output reg busy,
output reg sucess
);
reg sda_out;
reg sda_en;
reg byte_count_add;
reg byte_count_flag;
reg state_count_flag;
reg count_rst;
reg wr_flag;//1write 0read

reg ack_n;
reg [1:0]state_s;
reg [7:0]state_b;
reg [7:0]write_reg;
reg [2:0]byte_count;
assign sda=sda_en ? sda_out : 1'bz;		//三态门，数据总线读写
always @ (posedge clk or negedge rst_n)
    begin:state_change_lsm
	if(!rst_n)
	    begin
		state_s<=1'b0;
		state_b<=1'b0;
		end
	else if(!state_count_flag)
	    begin
		state_s<=1'b0;
		state_b<=1'b0;
		end
	else 
	    begin
		if(state_s==3)
		    begin
			state_s<=2'b0;
			state_b<=state_b+8'b1;
			end
		else
		    begin
			state_b<=state_b;
			state_s<=state_s+2'b1;
			end
		end
	end
always @(posedge clk or negedge rst_n)
    begin:byte_count_lsm
	if(!rst_n)
	    begin
		byte_count<=3'b0;
		end
	else if(!byte_count_flag)
	    byte_count<=3'b0;
	else
	    begin
	    if(byte_count_add)
			byte_count<=byte_count+3'b1;
		else
		    byte_count<=byte_count;
		end
	end
always @ (posedge clk or negedge rst_n)
    begin:state_small
	if(!rst_n)
	    begin
		task_reset;
		end
	else
	    begin
		    case(state_b)
			`IDEL:
			    task_idel;
			`START:
			    begin
			    task_start;
				write_reg<=sla_addr;
				end
			`SLAADDR:
			    begin
			    task_write;
				end
			`SLAACK:
			    begin
			    task_ack;
				write_reg<=sub_addr;
				end
			`SUBADDR:
			    begin
				if(ack_n)
					task_stop;
				else
					task_write;
				end
			`SUBACK:
			    begin
				task_ack;
				write_reg<=data_w;
				end
			default:
			    if(wr_flag) 
				    task_data_w; 
				else
				    task_data_r;
			endcase
				
			
		end
	
	end
	task task_data_w;
	    case (state_b)
			`WDATA	:	if (ack_n)
                			task_stop;
						else 
							task_write;
			`WACK	:	task_ack;
			`WSTOP	:	begin
								if (!ack_n) 
									sucess <= 1'b1;
								else
									sucess <= 1'b0;
								task_stop;
							end
		endcase
		
	endtask
	task task_data_r;
		case (state_b)
			`RESTART	:	if (ack_n)	
									task_stop;
								else
									begin
										task_start;
										write_reg <=sla_addr&8'b1;
									end		
			`RESLAADDR	: 	task_write;
			`RACK		:	task_ack;
			`RDATA		:	if(ack_n)
                			    task_stop;
							else 
							    task_read;
			`MACK		:	task_no_ack;
			`RSTOP		:	begin
									task_stop;
									if (ack_n) 
										sucess <= 0;
									else
										sucess <= 1;
								end	
		endcase
	endtask
	task task_reset;
	begin	
		sda_out <= 1'b1;
		sda_en <= 1;
		state_count_flag <= 1'b0;
		byte_count_flag <= 1'b0;
		byte_count_add<=1'b0;
		scl<= 1'b1;
		busy <= 1'b0;
		sucess<= 1'b0;
		ack_n <= 0;
		write_reg <= 8'b0;
		wr_flag <= 0;
	end	
	endtask
    task task_idel;
		if (wt_req||rd_req) 
		    begin
			sda_en <= 1;  //三态门使能信号
			sda_out <= 1; //三态门输入端高
			wr_flag <=wt_req;	
			state_count_flag <= 1'b1;	
			byte_count_flag <= 1'b1;
			busy <= 1'b1;			
			sucess <= 1'b0;	
			end
	endtask
    task task_start;
		case (state_s)
			0	:	scl <= 1'b0;
			1	:	begin 
			        sda_en <= 1'b1; 
			        sda_out <= 1'b1;
					end
			2	:	scl <= 1'b1;
			3	:	sda_out <= 1'b0;
		endcase
	endtask
	
	task task_stop;
		case (state_s)
			0	:	scl <= 1'b0;
			1	:	begin 
			        sda_en <= 1'b1; 
					sda_out <= 1'b0; 
					end
			2	:	scl <= 1'b1;
			3	:	task_reset;	
		endcase
	endtask
		
	task task_write;
		case (state_s)
			0	:	scl <= 1'b0;
			1	:	begin
					sda_en <= 1'b1;
					sda_out <= write_reg[3'd7-byte_count];
					byte_count_add <=1'b1;
					end
			2	:	begin
						scl <= 1'b1;
						byte_count_add <=1'b0;
					end
		endcase
	endtask

	task task_read;
		case (state_s)
			0	:	begin 
			        scl <= 1'b0;
					byte_count_add <= 1'b0; end
			1	:	sda_en <= 1'b0;
			2	:	scl <= 1'b1;
			3	:	begin
					data_r[3'd7-byte_count] <=sda;
					byte_count_add <= 1'b1;
					end
		endcase
	endtask
	
	task task_no_ack;
		case (state_s)
			0	:	scl <= 1'b0;
			1	:	begin 
			        sda_en <= 1'b1; 
			        sda_out <= 1'b1;
					end
			2	:	scl <= 1'b1;
		endcase
	endtask
	
	task task_ack;
		case (state_s)
			0	:	begin scl <= 1'b0; byte_count_flag <= 0; end
			1	:	begin sda_en <= 1'b0; byte_count_flag <= 1; end
			2	:	scl <= 1'b1;
			3	:	ack_n <=sda;	
		endcase
	endtask

endmodule