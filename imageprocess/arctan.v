`timescale  1 ns/1 ps
//  total delay 36 clks
module arctan(
    input clk,
	input rst,
	input  signed [17:0] arctan_i,   //  2^11
	output reg signed [17:0] arctan_o    //  2^11
	);
	
	reg signed [17:0] datain1 ,datain2 ,datain3 ,datain4 ,
                      datain5 ,datain6 ,datain7 ,datain8 ,
                      datain9 ,datain10,datain11,datain12,
                      datain13,datain14,datain15,datain16,
                      datain17,datain18,datain19,datain20,
                      datain21,datain22,datain23,datain24,
                      datain25,datain26,datain27,datain28,
                      datain29;
	always@(posedge clk)				  
	    begin
            datain1  <= arctan_i ;
            datain2  <= datain1  ;
            datain3  <= datain2  ;
            datain4  <= datain3  ;
            datain5  <= datain4  ;
            datain6  <= datain5  ;
            datain7  <= datain6  ;
            datain8  <= datain7  ;
            datain9  <= datain8  ;
            datain10 <= datain9  ;
            datain11 <= datain10 ;
            datain12 <= datain11 ;
            datain13 <= datain12 ;
            datain14 <= datain13 ;
            datain15 <= datain14 ;
            datain16 <= datain15 ;
            datain17 <= datain16 ;
            datain18 <= datain17 ;
            datain19 <= datain18 ;
            datain20 <= datain19 ;
            datain21 <= datain20 ;
            datain22 <= datain21 ;
            datain23 <= datain22 ;
            datain24 <= datain23 ;
            datain25 <= datain24 ;
            datain26 <= datain25 ;
            datain27 <= datain26 ;
            datain28 <= datain27 ;
            datain29 <= datain28 ;
        end				  

	wire signed [23:0] dividend_arctan ;
         assign  dividend_arctan = {1'b0,1'b1,22'b0};	// 2^22
//	wire signed [17:0] divisior_arctan ;
		wire signed [23:0] divisior_arctan ;
         assign  divisior_arctan = 	{6'b0,arctan_i};    // 2^11
    wire signed [23:0] quotient_arctan ;
    wire signed [17:0] quotient_arctan_s ;              // 2^11
	     assign quotient_arctan_s = quotient_arctan[17:0];
		 
    /* div_arctan div_arctan1 (                          // 28 clks
     .aclk(clk),                                      // input wire aclk
     .s_axis_divisor_tvalid(1'b1),                    // input wire s_axis_divisor_tvalid
     .s_axis_divisor_tdata(divisior_arctan),      // input wire [23 : 0] s_axis_divisor_tdata
     .s_axis_dividend_tvalid(1'b1),  // input wire s_axis_dividend_tvalid
     .s_axis_dividend_tdata(dividend_arctan),    // input wire [23 : 0] s_axis_dividend_tdata
     //.m_axis_dout_tvalid(m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
     .m_axis_dout_tdata(quotient_arctan)            // output wire [47 : 0] m_axis_dout_tdata
     ); */	
	div_arctan	lpm_div_arctan (
				.clock (clk),
				.denom (  divisior_arctan ),//fenmu
				.numer ( dividend_arctan ),//fenzi
				.quotient ( quotient_arctan ),
				.remain (  )
				);	 
    	
	reg signed [17:0] arctanin;
	reg en_1, en_2, en_3, en_4 ;
	
	reg en_dis ;
	always@(posedge clk)
	    if  (datain1 > 2048)                    // 1 clk
		  begin
	        arctanin <= quotient_arctan_s ;      // 1 clk
			en_dis  <= 1 ;
		  end
        else
		  begin
            arctanin <= datain1 ;			     // 1 clk
			en_dis  <= 0 ;
		  end

	// x--(0-0.4) or (2.5-+++)
	reg signed [17:0] arctan_in1;
	always@(posedge clk)                        // 2 clks
	    if  (arctanin > 0 && arctanin < 820)     // 1 clks
           begin
	          arctan_in1 <= arctanin ;           // 2 clks
	          en_1 <= 1 ;
	       end
        else
           begin
	          arctan_in1 <= 17'd0 ;
	          en_1 <= 0 ;
           end		  
  
	 // x--(0.4-0.55) or (1.818-2.5)
	reg signed [17:0] arctan_in2;
	always@(posedge clk)
	    if  (arctanin > 819 && arctanin < 1126)  
           begin
	          arctan_in2 <= arctanin ;
	          en_2 <= 1 ;
	       end
        else 
          begin
	          arctan_in2 <= 17'd0 ;
	          en_2 <= 0 ;
	      end
	  
	 // x--(0.55-0.75) or (1.334-1.818)
	reg signed [17:0] arctan_in3;
	always@(posedge clk)
	   if  (arctanin > 1125 && arctanin < 1536)  
          begin
		     arctan_in3 <= arctanin ;
			 en_3 <= 1 ;
		  end
       else
	      begin
		     arctan_in3 <= 17'd0 ;
			 en_3 <= 0 ;
		  end
		  
	 // x--(0.75-1.0) or (1.0-1.334)
    reg signed [17:0] arctan_in4;	 
	always@(posedge clk)
	   if  (arctanin > 1535 && arctanin < 2049)  
          begin
		     arctan_in4 <= arctanin ;
			 en_4 <= 1 ;
		  end
       else
	      begin
		     arctan_in4 <= 17'd0 ;
			 en_4 <= 0 ;
		  end
		  
    // pi/2 = 1.5708
	// 1.5708*2048 = 3217
	
	//  en_1,...,en_8 delay 8 clks
	wire [4:0] en_delay ;
	reg  [4:0] en_delay1, en_delay2,en_delay3,en_delay4,en_delay5;
	reg  [4:0] en_delay6,en_delay7;
	wire   en_16,en_26,en_36,en_46,en_dis6;	
	
	assign en_delay = {en_1,en_2,en_3,en_4,en_dis};
	always@(posedge clk)
	    begin
	        en_delay1 <= en_delay ;
			en_delay2 <= en_delay1 ;
			en_delay3 <= en_delay2 ;
			en_delay4 <= en_delay3 ;
			en_delay5 <= en_delay4 ;
			en_delay6 <= en_delay5 ;
		    en_delay7 <= en_delay6 ;
			// en_delay8 <= en_delay7 ;
			// en_delay9 <= en_delay8 ;
	    end
	assign en_16   = en_delay4[4];
	assign en_26   = en_delay4[3];
	assign en_36   = en_delay4[2];
	assign en_46   = en_delay4[1];
	assign en_dis6 = en_delay5[0];
	
	parameter  PI_2 = 17'd3217 ;  
	wire signed [17:0] arctano1 ,arctano2 ,arctano3 ,arctano4  ;
    		
	always@(posedge clk)
	    begin
		    case ({en_16,en_dis6,en_26,en_dis6,en_36,en_dis6,en_46,en_dis6})
              8'b10_00_00_00: 
						arctan_o  <= arctano1   ;			        
              8'b11_01_01_01: 
			       		arctan_o  <= PI_2 - arctano1   ;
              8'b00_10_00_00: 
						arctan_o  <= arctano2   ;
              8'b01_11_01_01: 
						arctan_o  <= PI_2 - arctano2   ;
              8'b00_00_10_00: 
						arctan_o  <= arctano3   ;			        
              8'b01_01_11_01: 
						arctan_o  <= PI_2 - arctano3   ;
              8'b00_00_00_10: 
						arctan_o  <= arctano4   ;
              8'b01_01_01_11: 
						arctan_o  <= PI_2 - arctano4   ;
			  default:
			        begin
						arctan_o  <= 17'd0 ;							
			         end				  
            endcase		
		end
		
	arctan_1   aratan_1_1(   
    .clk(clk),
	.rst(rst),
	.arctan_i(arctan_in1),   
	.arctan_o(arctano1) 
	);
	
	arctan_2   aratan_2_1(   
    .clk(clk),
	.rst(rst),
	.arctan_i(arctan_in2),   
	.arctan_o(arctano2) 
	);
	
	arctan_3   aratan_3_1(   
    .clk(clk),
	.rst(rst),
	.arctan_i(arctan_in3),   
	.arctan_o(arctano3) 
	);
	
	arctan_4   aratan_4_1(   
    .clk(clk),
	.rst(rst),
	.arctan_i(arctan_in4),   
	.arctan_o(arctano4) 
	);
endmodule





//  delay  clks
module arctan_1(   
    input clk,
	input rst,
	input  signed [17:0] arctan_i,   // 2^11
	output reg signed [17:0] arctan_o 
   );
   
   // x < 0.4
   // y =  arctan 
   // y =  x -(x^3)/3 ;
   reg  signed [35:0] arctan_i2 ;
   reg  signed [17:0] arctan_idly1 ; // 2^11  1clk
    always@(posedge clk)             // 2^22  1clk
	  begin
       arctan_i2     <= arctan_i * arctan_i ;   
	   arctan_idly1  <= arctan_i  ;
	   end

   wire signed [25:0] arctan_i2_s;
   assign  arctan_i2_s = arctan_i2[35:10];   // 2^12  2clks
   wire signed [15:0] arctan_idly1_s;
   assign  arctan_idly1_s = arctan_idly1[17:2];      // 2^9   1clks
   
   reg  signed [40:0] arctan_i3 ;                    // 2^21  2clks    
    always@(posedge clk)             
       arctan_i3 <= arctan_i2_s * arctan_idly1_s ;
    //   (X^3)/3 =  ((X^3)*1.333333)/4 
    //           =  ((X^3)*1.333333*256)/(4*256)
	//           =  ((X^3)*341)/(2^10)
	
	wire signed [30:0] arctan_i3_s ;
	assign arctan_i3_s = arctan_i3[40:10];           // 2^11  2clks 
	
   parameter signed THREE2FOUR = 10'd341 ;
   reg signed [40:0] arctan_i3_div3 ;                // 2^21  3clks 
	always@(posedge clk) 
	   arctan_i3_div3 <= THREE2FOUR * arctan_i3_s ;
	   
    wire signed [17:0] arctan_i3_div3_s ;
	assign arctan_i3_div3_s = arctan_i3_div3[27:10] ;
	
	reg signed [17:0] arctan_i_dly1, arctan_i_dly2, arctan_i_dly3;
	always@(posedge clk)  
        begin
		   arctan_i_dly1 <= arctan_i ;
		   arctan_i_dly2 <= arctan_i_dly1 ;
		   arctan_i_dly3 <= arctan_i_dly2 ;
		end
	
	always@(posedge clk)                             // 2^11  4clks
	    arctan_o <= arctan_i_dly3 - arctan_i3_div3_s ;
	
endmodule


module arctan_2(
    input clk,
	input rst,
	input  signed [17:0] arctan_i,   // enlarge by 2^11
	output reg signed [17:0] arctan_o 
   );

   // 0.4 < x <0.55
   // y = arctan =  0.845*x + 0.0405 ;
   // 0.845*1024 = 865;
   // X*2048 
   // 0.0405 * 1024 * 2048 = 84935 ;   
   parameter  signed  COEFF_ARCTAN_2_1 = 11'd865   ;
   parameter  signed  COEFF_ARCTAN_2_2 = 22'd84935 ;
   
   reg signed [30:0] arctan_coe; 
   always@(posedge clk)              // 2^21  1clk
        arctan_coe <= arctan_i * COEFF_ARCTAN_2_1 ; 
		
   wire signed [30:0] coeff_arctan_l ;
   assign coeff_arctan_l = {9'b0,COEFF_ARCTAN_2_2};
   reg  signed [30:0] arctan_temp ;
    always@(posedge clk)              // 2^21  2clk
        arctan_temp <= arctan_coe + coeff_arctan_l ; 
   
   wire signed [17:0] arctan_o_dly1;
   reg signed [17:0] arctan_o_dly2;  // arctan_o_dly3;   
    assign   arctan_o_dly1 = arctan_temp[27:10] ;
    always@(posedge clk) 
        begin
		    arctan_o_dly2 <= arctan_o_dly1 ;
//			arctan_o_dly3 <= arctan_o_dly2 ;
		end
    
	always@(posedge clk)            // 2^21  4clk
	    arctan_o <= arctan_o_dly2 ;
	
endmodule

module arctan_3(
    input clk,
	input rst,
	input  signed [17:0] arctan_i,   // enlarge by 2^11
	output reg signed [17:0] arctan_o 
   );
   // 0.55 < x <0.75   
   // y = arctan = 0.7000*x + 0.1196 ;
   // 0.700*1024 = 717;
   // X*2048 
   // 0.1196 * 1024 * 2048 = 250819 ; 
   parameter  signed  COEFF_ARCTAN_3_1 = 11'd717    ;
   parameter  signed  COEFF_ARCTAN_3_2 = 22'd250819 ;
   
   reg signed [30:0] arctan_coe; 
   always@(posedge clk)              // 2^21  1clk
        arctan_coe <= arctan_i * COEFF_ARCTAN_3_1 ; 
		
   wire signed [30:0] coeff_arctan_l ;
   assign coeff_arctan_l = {9'b0,COEFF_ARCTAN_3_2};
   reg  signed [30:0] arctan_temp ;
    always@(posedge clk)              // 2^21  2clk
        arctan_temp <= arctan_coe + coeff_arctan_l ; 
		
   wire signed [17:0] arctan_o_dly1;
   reg signed [17:0] arctan_o_dly2;  //arctan_o_dly3;   
    assign   arctan_o_dly1 = arctan_temp[27:10] ;
    always@(posedge clk) 
        begin
		    arctan_o_dly2 <= arctan_o_dly1 ;
		//	arctan_o_dly3 <= arctan_o_dly2 ;
		end
    
	always@(posedge clk)            // 2^21  4clk
	    arctan_o <= arctan_o_dly2 ;
      
endmodule

module arctan_4(
    input clk,
	input rst,
	input  signed [17:0] arctan_i,   // enlarge by 2^11
	output reg signed [17:0] arctan_o 
   );
   // 0.75 < x <1.0   
   // y = arctan = 0.5630*x + 0.2223
   // 0.5630*1024 = 577;
   // X*2048 
   // 0.2223 * 1024 * 2048 = 466197 ; 
   parameter  signed  COEFF_ARCTAN_4_1 = 11'd577    ;
   parameter  signed  COEFF_ARCTAN_4_2 = 22'd466197 ;
   
   reg signed [30:0] arctan_coe; 
   always@(posedge clk)              // 2^21  1clk
        arctan_coe <= arctan_i * COEFF_ARCTAN_4_1 ; 
		
   wire signed [30:0] coeff_arctan_l ;
   assign coeff_arctan_l = {9'b0,COEFF_ARCTAN_4_2};
   reg  signed [30:0] arctan_temp ;
    always@(posedge clk)              // 2^21  2clk
        arctan_temp <= arctan_coe + coeff_arctan_l ; 
   
   wire signed [17:0] arctan_o_dly1;
   reg  signed [17:0] arctan_o_dly2;  //arctan_o_dly3;   
    assign   arctan_o_dly1 = arctan_temp[27:10] ;
    always@(posedge clk) 
        begin
		    arctan_o_dly2 <= arctan_o_dly1 ;
		//	arctan_o_dly3 <= arctan_o_dly2 ;
		end
    
	always@(posedge clk)            // 2^21  4clk
	    arctan_o <= arctan_o_dly2 ;
   
endmodule