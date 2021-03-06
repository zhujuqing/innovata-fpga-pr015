`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    camera_capture 
//////////////////////////////////////////////////////////////////////////////////
module camera_capture(
	input rst,	
	input pclk,
    input href,
	input vsync,
	input [7:0] camera_data,
	output [11:0] data12,	
	output reg [10:0]href_count,
	output reg [10:0]vs_count,
	output reg [16:0] addr_wr,
	output reg buff_wr                            //ddr cameraд���ź�, ��д

);
  
reg [15:0]camera_data_reg;
reg [15:0] ddr_data_camera;
reg [1:0]counter;
always @(posedge pclk)
begin
	 if (rst ==1'b1) begin 
			camera_data_reg<=0;
			counter<=0;
	 end	
	 else if((href==1'b1) & (vsync==1'b1)) begin   //cmos������Ч
		   if(counter<3) begin                              //��ȡǰ31��camera����	  
				 camera_data_reg<={camera_data_reg[7:0],camera_data};
				 counter<=counter+1'b1;
				 ddr_data_camera<=ddr_data_camera;	
			end
			else begin                                       //��ȡ��32��camera����		  
			    ddr_data_camera<={camera_data_reg[7:0],camera_data};
				 camera_data_reg<=0;		
				 counter<=0; 			 
			end
	  end
	  else begin
				camera_data_reg<=0;
				ddr_data_camera<=0;
				counter<=0;
	  end
end

    // 16λת12λ����wr12,data12
  //  wire wr12 = wr16;
    //wire [11:0] data12 ;
    assign data12 = { ddr_data_camera[15:12] ,  ddr_data_camera[10:7] ,  ddr_data_camera[4:1] } ;

wire hs_posedge;
reg href_1;
always @ (posedge pclk) 
begin
    if ( rst ==1'b1 )
       href_1 <= 1'b0 ;
	else 
	   href_1 <= ~href ;
end
 assign hs_posedge = href&href_1 ;
    
//reg [10:0]href_count;	
 always @ (posedge pclk) 
  begin
    if ( rst ==1'b1  )    
     href_count <= 11'b0 ;
    else 
        begin
		if (hs_posedge ==1'b1)
		href_count <= 11'b0 ;
		else
		href_count<= href_count +1'b1 ;
        end
end	
    
wire vs_negedge;
reg vs_1;
always @ (posedge pclk) 
begin
    if ( rst ==1'b1 )
       vs_1 <= 1'b0 ;
	else 
	   vs_1 <= ~vsync ;
end
 assign vs_negedge = (vs_1==1'b0)&(vsync==1'b0) ;
    
//reg [10:0]vs_count;	
 always @ (posedge pclk) 
  begin
    if ( rst ==1'b1  )    
     vs_count <= 11'b0 ;
    else 
        begin
		if (vs_negedge ==1'b1)
		vs_count <= 11'b0 ;
		else if(hs_posedge==1'b1)
		vs_count<= vs_count +1'b1 ;
        end
end		


//parameter  x_min =  320;
//parameter  x_max =  960;
//parameter  y_min =  120;
//parameter  y_max =  360;
parameter  x_min =  160;
parameter  x_max =  1120;
parameter  y_min =  80;
parameter  y_max =  400;
reg  href_en ;
reg  vs_en ;
 always @ (posedge pclk) 
  begin
    if ( rst ==1'b1  )    
     href_en <= 1'b0 ;
    else 
        begin
		if (href_count ==x_min)
		href_en <= 1'b1 ;
		else if(href_count ==x_max)
		href_en <= 1'b0 ;
        end
 end
  always @ (posedge pclk) 
  begin
    if ( rst ==1'b1  )    
     vs_en <= 1'b0 ;
    else 
        begin
		if (vs_count ==y_min)
		vs_en <= 1'b1 ;
		else if(vs_count ==y_max)
		vs_en <= 1'b0 ;
        end
 end	
 wire hsvs_en;
 assign hsvs_en = vs_en && href_en ;
  
//................addr.........................//
 reg   buff_wr_1 ;
 
//   always@ (posedge pclk) 
//     begin
//        buff_wr_1 <= wr12      ;
//        buff_wr   <= buff_wr_1 ;
//      end
    always@ (posedge pclk) 
     begin
         if(rst ==1'b1)
              buff_wr <= 1'b0;
         else
          begin
            if(counter==2'b0)
                  buff_wr<=1'b1;
            else
                 buff_wr<=1'b0;
             end
       end
  always@ (posedge pclk) 
           begin
              buff_wr_1 <= buff_wr      ;
            
            end      
   

   //���ɵ�ַ�� buff_addr

   //output reg [18:0] buff_addr
// (* MARKDEBUG = "TRUE" *)   
//reg  vsyncrn ; 
//   always@(posedge pclk)vsyncrn <=vsyncn ;
   //��һ���ӳٽ���ΪΪ�˸���ʱ����

   always@ (posedge pclk)
       if ( ~vsync || rst )addr_wr<=17'd1;
       else if (buff_wr_1&& hsvs_en )addr_wr<=addr_wr+1'b1;
   else addr_wr <= addr_wr ;

		
endmodule

