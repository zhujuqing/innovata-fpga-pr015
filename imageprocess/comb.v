`timescale 1ns / 1ps

module comb (
						Clk,
						Rstn,
						Cline,
						Cpixel,
						X1_delay,
						Y1_delay,
						X2_delay,
						Y2_delay,
						img1_delay,
						img2_delay,
						Q1,
						Q2
						);
						
						input Clk;
						input Rstn;
						input signed [10:0] Cline;
						input signed [10:0] Cpixel;
							
						output [10:0] X1_delay;
						output [10:0] Y1_delay;
						output [10:0] X2_delay;
						output [10:0] Y2_delay;
						output [2:0] img1_delay;
						output [2:0] img2_delay;
						output [10:0] Q1;
						output [10:0] Q2;
						
						
						reg [10:0] X1;
						reg [10:0] Y1;
						reg [10:0] X2;
						reg [10:0] Y2;
						reg [2:0] img1;
						reg [2:0] img2;
						
						
                        
parameter b_line = 11'd35;
parameter b_pixel = 11'd144;
parameter car_line = 11'd174;
parameter car_pixel = 11'd290;
parameter vga_line = 11'd406;
parameter vga_pixel = 11'd638;

parameter e_pixel = 11'd58;

wire [10:0] para_line,para_pixel;
assign para_line = vga_line - car_line;
assign para_pixel = vga_pixel - car_pixel;

wire [10:0] b_line1,b_line2,b_line3,b_pixel1,b_pixel2,b_pixel3;
assign b_line1 = {1'b0, para_line[10:1]} + b_line;
assign b_line2 = b_line1 + car_line;
assign b_line3 = b_line + vga_line;
assign b_pixel1 = {1'b0, para_pixel[10:1]} + b_pixel;
assign b_pixel2 = b_pixel1 + car_pixel;
assign b_pixel3 = b_pixel + vga_pixel;

wire [10:0] eb_pixel1,eb_pixel2;
assign eb_pixel1 = b_pixel + e_pixel;
assign eb_pixel2 = vga_pixel - e_pixel + b_pixel;

//wire [10:0] b_offset;
//assign b_offset = b_pixel - b_line;
//wire [10:0] b_offset2;
//assign b_offset2 = b_pixel + b_line;
						
always @ (posedge Clk)						
begin
			 if (Cline <= b_line)
			 begin
			 	    X1 <= 11'd0;
			 	    Y1 <= 11'd0;
			 	    X2 <= 11'd0;
			 	    Y2 <= 11'd0;
			      img1 <= 3'd0;
			      img2 <= 3'd0;
			 end
			 else
			 begin
	     		  if (Cline <= b_line1)
	     		  begin
	     		  	   if (Cpixel <= b_pixel)
	     		  	   begin
			 	              X1 <= 11'd0;
			 	              Y1 <= 11'd0;
			 	              X2 <= 11'd0;
			 	              Y2 <= 11'd0;
			                img1 <= 3'd0;
			                img2 <= 3'd0;		     		  	         
	     		       end
	     		  	   else
	     		  	   begin
	     		  	   	    if (Cpixel <= eb_pixel1)
			 	              begin
			 	                   X1 <= 11'd120 + Cpixel - b_pixel;
			 	                   Y1 <= 11'd523 - Cline + b_line;
			 	                   X2 <= 11'd120 + Cpixel - b_pixel;
			 	                   Y2 <= 11'd523 - Cline + b_line;
			                     img1 <= 3'd4;
			                     img2 <= 3'd4;			 	    	    
			 	              end
			 	              else
			 	              begin	     		  	    	   
	     		  	   		       if (Cpixel <= b_pixel1)
	     		  	   		       begin
	     		  	   		       	    X1 <= 11'd120 + Cpixel - b_pixel;
	     		  	   		            Y1 <= 11'd523 - Cline + b_line;
	     		  	   		            X2 <= 11'd178 +	Cline - b_line;
	     		  	   		            Y2 <= Cpixel - b_pixel;
	     		  	   		            img1 <= 3'd4;
	     		  	   		            img2 <= 3'd2;
	     		  	   		       end
	     		  	   		       else
	     		  	   		       begin
	     		  	   		            if (Cpixel <= b_pixel2)
	     		  	   		            begin
	     		  	   		       	         X1 <= 11'd178 +	Cline - b_line;
	     		  	   		                 Y1 <= Cpixel - b_pixel;
	     		  	   		                 X2 <= 11'd178 +	Cline - b_line;
	     		  	   		                 Y2 <= Cpixel - b_pixel;
	     		  	   		                 img1 <= 3'd2;
	     		  	   		                 img2 <= 3'd2;
	     		  	   		            end
	     		  	   		            else
	     		  	   		            begin
	     		  	   		            	   if (Cpixel <= eb_pixel2)
	     		  	   		       	   	     begin
	     		  	   		       	              X1 <= 11'd178 +	Cline - b_line;
	     		  	   		                      Y1 <= Cpixel - b_pixel;
	     		  	   		                      X2 <= 11'd758 - Cpixel + b_pixel;
	     		  	   		                      Y2 <= 11'd117 + Cline - b_line;
	     		  	   		                      img1 <= 3'd2;
	     		  	   		                      img2 <= 3'd1;	 
	     		  	   		                 end
	     		  	   		                 else
	     		  	   		                 begin
	     		  	   		            	   	    if (Cpixel <= b_pixel3)
	     		  	   		       	   	          begin
	     		  	   		       	                   X1 <= 11'd758 - Cpixel + b_pixel;
	     		  	   		                           Y1 <= 11'd117 + Cline - b_line;
	     		  	   		                           X2 <= 11'd758 - Cpixel + b_pixel;
	     		  	   		                           Y2 <= 11'd117 + Cline - b_line;
	     		  	   		                           img1 <= 3'd1;
	     		  	   		                           img2 <= 3'd1;
	     		  	   		                      end	 
	     		  	   		                      else
	     		  	   		       	              begin
			 	                                       X1 <= 11'd0;
			 	                                       Y1 <= 11'd0;
			 	                                       X2 <= 11'd0;
			 	                                       Y2 <= 11'd0;
			                                         img1 <= 3'd0;
			                                         img2 <= 3'd0;
			                                    end
	     		  					       		     end
	     		  					       		end	    	                
	     		  	   		       end
	     		  	   		  end
	     		  	   end
	     		  end
	     		  else
	     		  begin
	     		  	    if (Cline <= b_line2)
	     		  	    begin
	     		  	    	   if (Cpixel <= b_pixel)
	     		  	    		 begin
			 	                    X1 <= 11'd0;
			 	                    Y1 <= 11'd0;
			 	                    X2 <= 11'd0;
			 	                    Y2 <= 11'd0;
			                      img1 <= 3'd0;
			                      img2 <= 3'd0;
			                 end
	     		  	    	   else  
	     		  	    	   begin
	     		  	    	   			if (Cpixel <= b_pixel1)
	     		  	    	   			begin
	     		  	    	   					 X1 <= 11'd120 + Cpixel - b_pixel;
	     		  	         					 Y1 <= 11'd523 - Cline + b_line;
	     		  	    	   					 X2 <= 11'd120 + Cpixel - b_pixel;
	     		  	         					 Y2 <= 11'd523 - Cline + b_line;
	     		  	         					 img1 <= 3'd4;
	     		  	         					 img2 <= 3'd4;	     		  	         						
	     		  	         			end
	     		  	         			else
	     		  	         			begin
	     		  	         				    if (Cpixel <= b_pixel2)
	     		  	         				    begin
			 	                               X1 <= 11'd0;
			 	                               Y1 <= 11'd0;
			 	                               X2 <= 11'd0;
			 	                               Y2 <= 11'd0;
			                                 img1 <= 3'd0;
			                                 img2 <= 3'd0;
			                            end
	     		  	         				    else
	     		  	         				    begin
	     		  	         				    	   if (Cpixel <= b_pixel3)
	     		  	         				    	   begin
	     		  	         				    	   			X1 <= 11'd758 - Cpixel + b_pixel;
	     		  	    	   			          			Y1 <= 11'd117 + Cline - b_line;
	     		  	    	   			          			X2 <= 11'd758 - Cpixel + b_pixel;
	     		  	    	   			          			Y2 <= 11'd117 + Cline - b_line;
	     		  	    	   			          			img1 <= 3'd1;
	     		  	    	   			          			img2 <= 3'd1;	     		  	    	   			          		
	     		  	    	   			           end
	     		  	    	   			           else
	     		  	         				         begin
			 	                                    X1 <= 11'd0;
			 	                                    Y1 <= 11'd0;
			 	                                    X2 <= 11'd0;
			 	                                    Y2 <= 11'd0;
			                                      img1 <= 3'd0;
			                                      img2 <= 3'd0;
			                                 end
	     		  	    	   			      end
	     		  	    	   			end
	     		  	    	   end
	     		  	    end
	     		  	    else
	     		  	    begin 
	     		  	    	   if (Cline <= b_line3)
	     		  	    	   begin
                            if (Cpixel <= b_pixel)
                            begin
                                 X1 <= 11'd0;
                                 Y1 <= 11'd0;
                                 X2 <= 11'd0;
                                 Y2 <= 11'd0;
                                 img1 <= 3'd0;
                                 img2 <= 3'd0;		     		  	         
                            end
                            else
                            begin
                            	   if (Cpixel <= eb_pixel1)
                                 begin
                                      X1 <= 11'd120 + Cpixel - b_pixel;
                                      Y1 <= 11'd523 - Cline + b_line;
                                      X2 <= 11'd120 + Cpixel - b_pixel;
                                      Y2 <= 11'd523 - Cline + b_line;
                                      img1 <= 3'd4;
                                      img2 <= 3'd4;			 	    	    
                                 end
                                 else
                                 begin
                                 	    if (Cpixel <= b_pixel1)
                                 	    begin
                                           X1 <= 11'd120 + Cpixel - b_pixel;
                                           Y1 <= 11'd523 - Cline + b_line;
                                           X2 <= 11'd659 - Cline - b_line;
                                           Y2 <= 11'd641 - Cpixel + b_pixel;
                                           img1 <= 3'd4;
                                           img2 <= 3'd3;
                                      end
                                      else
                                      begin
                                      	   if (Cpixel <= b_pixel2) 
                                 	         begin
                                                X1 <= 11'd659 - Cline - b_line;
                                                Y1 <= 11'd641 - Cpixel + b_pixel;
                                                X2 <= 11'd659 - Cline - b_line;
                                                Y2 <= 11'd641 - Cpixel + b_pixel;
                                                img1 <= 3'd3;
                                                img2 <= 3'd3;
                                           end
                                           else
                                           begin
                                           	   if (Cpixel <= eb_pixel2)
                                           	   begin
                                                     X1 <= 11'd659 - Cline - b_line;
                                                     Y1 <= 11'd641 - Cpixel + b_pixel;
                                                     X2 <= 11'd758 - Cpixel + b_pixel;
                                                     Y2 <= 11'd117 + Cline - b_line;
                                                     img1 <= 3'd3;
                                                     img2 <= 3'd1;
                                                end
                                                else
                                                begin
                                                	    if (Cpixel <= b_pixel3)
	     		  	              				    	            begin
	     		  	              				    	            		 X1 <= 11'd758 - Cpixel + b_pixel;
	     		  	    	        			          	         		 Y1 <= 11'd117 + Cline - b_line;
	     		  	    	        			          	         		 X2 <= 11'd758 - Cpixel + b_pixel;
	     		  	    	        			          	         		  Y2 <= 11'd117 + Cline - b_line;
	     		  	    	        			          	         		 img1 <= 3'd1;
	     		  	    	        			          	         		 img2 <= 3'd1;	     		  	    	   			          		
	     		  	    	        			                    end 
	     		  	    	        			                    else
	     		  	    	        			                    begin
                                                          X1 <= 11'd0;
                                                          Y1 <= 11'd0;
                                                          X2 <= 11'd0;
                                                          Y2 <= 11'd0;
                                                          img1 <= 3'd0;
                                                          img2 <= 3'd0;		     		  	         
                                                      end
                                                end
                                           end
                                      end  	   
                                 end                                           	                             	   	    
                            end
                       end
                       else
                       begin       
                       	
                       	
                            X1 <= 11'd0;
                            Y1 <= 11'd0;
                            X2 <= 11'd0;
                            Y2 <= 11'd0;
                            img1 <= 3'd0;
                            img2 <= 3'd0;
                       end
                  end
       		  end
       end
end
reg [10:0] L1,L2,L3,L4;

always @ (posedge Clk)						
begin
			 if (Cline <= b_line)
			 begin
			 	    L1 <= 11'd0;
			 	    L2 <= 11'd0;
			 	    L3 <= 11'd0;
			 	    L4 <= 11'd0;
			 end
			 else
			 begin
	     		  if (Cline <= b_line1)
	     		  begin
	     		  	   if (Cpixel <= b_pixel)
	     		  	   begin
			 	              L1 <= 11'd0;
			 	              L2 <= 11'd0;
			 	              L3 <= 11'd0;
			 	              L4 <= 11'd0;
  		  	       end
	     		  	   else
	     		  	   begin
	     		  	   	    if (Cpixel <= eb_pixel1)
			 	              begin
			 	                   L1 <= 11'd0;
			 	                   L2 <= 11'd0;
			 	                   L3 <= 11'd0;
			 	                   L4 <= 11'd0;
			                end
			 	              else
			 	              begin	     		  	    	   
	     		  	   		       if (Cpixel <= b_pixel1)
	     		  	   		       begin
	     		  	   		       	    L1 <= b_line1 - Cline;
	     		  	   		            L2 <= Cpixel - eb_pixel1;
	     		  	   		            L3 <= Cline - b_line;
	     		  	   		            L4 <= b_pixel1 - Cpixel;
	     		  	   		       end
	     		  	   		       else
	     		  	   		       begin
	     		  	   		            if (Cpixel <= b_pixel2)
	     		  	   		            begin
	     		  	   		       	         L1 <= 11'd0;
	     		  	   		                 L2 <= 11'd0;
	     		  	   		                 L3 <= 11'd0;
	     		  	   		                 L4 <= 11'd0;
	     		  	   		            end
	     		  	   		            else
	     		  	   		            begin
	     		  	   		            	   if (Cpixel <= eb_pixel2)
	     		  	   		       	   	     begin
	     		  	   		       	              L1 <= Cpixel - b_pixel2;
	     		  	   		                      L2 <= Cline - b_line;
	     		  	   		                      L3 <= eb_pixel2 - Cpixel;
	     		  	   		                      L4 <= b_line1 - Cline;
	     		  	   		                 end
	     		  	   		                 else
	     		  	   		                 begin
	     		  	   		            	   	    if (Cpixel <= b_pixel3)
	     		  	   		       	   	          begin
	     		  	   		       	                   L1 <= 11'd0;
	     		  	   		                           L2 <= 11'd0;
	     		  	   		                           L3 <= 11'd0;
	     		  	   		                           L4 <= 11'd0;
	     		  	   		                     end	 
	     		  	   		                      else
	     		  	   		       	              begin
			 	                                       L1 <= 11'd0;
			 	                                       L2 <= 11'd0;
			 	                                       L3 <= 11'd0;
			 	                                       L4 <= 11'd0;
			                                    end
	     		  					       		     end
	     		  					       		end	    	                
	     		  	   		       end
	     		  	   		  end
	     		  	   end
	     		  end
	     		  else
	     		  begin
	     		  	    if (Cline <= b_line2)
	     		  	    begin
	     		  	    	   if (Cpixel <= b_pixel)
	     		  	    		 begin
			 	                    L1 <= 11'd0;
			 	                    L2 <= 11'd0;
			 	                    L3 <= 11'd0;
			 	                    L4 <= 11'd0;
			                 end
	     		  	    	   else  
	     		  	    	   begin
	     		  	    	   			if (Cpixel <= b_pixel1)
	     		  	    	   			begin
	     		  	    	   					 L1 <= 11'd0;
	     		  	         					 L2 <= 11'd0;
	     		  	    	   					 L3 <= 11'd0;
	     		  	         					 L4 <= 11'd0;
	     		  	         			end
	     		  	         			else
	     		  	         			begin
	     		  	         				    if (Cpixel <= b_pixel2)
	     		  	         				    begin
			 	                               L1 <= 11'd0;
			 	                               L2 <= 11'd0;
			 	                               L3 <= 11'd0;
			 	                               L4 <= 11'd0;
			                            end
	     		  	         				    else
	     		  	         				    begin
	     		  	         				    	   if (Cpixel <= b_pixel3)
	     		  	         				    	   begin
	     		  	         				    	   			L1 <= 11'd0;
	     		  	    	   			          			L2 <= 11'd0;
	     		  	    	   			          			L3 <= 11'd0;
	     		  	    	   			          			L4 <= 11'd0;
	     		  	    	   			          end
	     		  	    	   			           else
	     		  	         				         begin
			 	                                    L1 <= 11'd0;
			 	                                    L2 <= 11'd0;
			 	                                    L3 <= 11'd0;
			 	                                    L4 <= 11'd0;
			                                 end
	     		  	    	   			      end
	     		  	    	   			end
	     		  	    	   end
	     		  	    end
	     		  	    else
	     		  	    begin 
	     		  	    	   if (Cline <= b_line3)
	     		  	    	   begin
                            if (Cpixel <= b_pixel)
                            begin
                                 L1 <= 11'd0;
                                 L2 <= 11'd0;
                                 L3 <= 11'd0;
                                 L4 <= 11'd0;
                            end
                            else
                            begin
                            	   if (Cpixel <= eb_pixel1)
                                 begin
                                      L1 <= 11'd0;
                                      L2 <= 11'd0;
                                      L3 <= 11'd0;
                                      L4 <= 11'd0;
                                 end
                                 else
                                 begin
                                 	    if (Cpixel <= b_pixel1)
                                 	    begin
                                           L1 <= Cpixel - eb_pixel1;
                                           L2 <= Cline - b_line2;
                                           L3 <= b_pixel1 - Cpixel;
                                           L4 <= b_line3 - Cline;
                                      end
                                      else
                                      begin
                                      	   if (Cpixel <= b_pixel2) 
                                 	         begin
                                                L1 <= 11'd0;
                                                L2 <= 11'd0;
                                                L3 <= 11'd0;
                                                L4 <= 11'd0;
                                           end
                                           else
                                           begin
                                           	   if (Cpixel <= eb_pixel2)
                                           	   begin
                                                     L1 <= b_line3 - Cline;
                                                     L2 <= Cpixel - b_pixel2;
                                                     L3 <= Cline - b_line2;
                                                     L4 <= eb_pixel2 - Cpixel;
                                               end
                                                else
                                                begin
                                                	    if (Cpixel <= b_pixel3)
	     		  	              				    	            begin
	     		  	              				    	            		 L1 <= 11'd0;
	     		  	    	        			          	         		 L2 <= 11'd0;
	     		  	    	        			          	         		 L3 <= 11'd0;
	     		  	    	        			          	         		 L4 <= 11'd0;
	     		  	    	        			          	        end 
	     		  	    	        			                    else
	     		  	    	        			                    begin
                                                          L1 <= 11'd0;
                                                          L2 <= 11'd0;
                                                          L3 <= 11'd0;
                                                          L4 <= 11'd0;
                                                      end
                                                end
                                           end
                                      end  	   
                                 end                                           	                             	   	    
                            end
                       end
                       else
                       begin
                            L1 <= 11'd0;
                            L2 <= 11'd0;
                            L3 <= 11'd0;
                            L4 <= 11'd0;
                       end
                  end
       		  end
       end
end

wire [10:0] L5,L6,L7;
assign  L5 = (L1 > L2) ? L2 : L1;
assign  L6 = (L3 > L4) ? L4 : L3;
assign  L7 = L5 + L6;

wire  [7:0] quotient;
wire  [7:0] remain;
	
div	lpm_div_inst (
    .clock (Clk),
	.denom (  L7[7:0] ),//fenmu
	.numer ( {L5[7:0],5'b0} ),//fenzi
	.quotient ( quotient ),
	.remain ( remain )
	);

/* div_lifei your_instance_name (
  .aclk(Clk),                                      // input wire aclk
  .s_axis_divisor_tvalid(1'b1),    // input wire s_axis_divisor_tvalid
  .s_axis_divisor_tdata(L7[7:0]),      // input wire [15 : 0] s_axis_divisor_tdata
  //.s_axis_dividend_tvalid(s_axis_dividend_tvalid),  // input wire s_axis_dividend_tvalid
  .s_axis_dividend_tdata({L5[7:0],5'b0}),    // input wire [15 : 0] s_axis_dividend_tdata
 // .m_axis_dout_tvalid(m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(quotient)            // output wire [31 : 0] m_axis_dout_tdata
); */

// wire [10:0]quotient_final;
// assign quotient_final = quotient[18:8];


wire  [10:0] Q1,Q2;
assign  Q2 = quotient;
assign  Q1 = 11'd32 - quotient;

parameter number_delay = 1;
data_delay  #(
    .data_width(3) 
)
    img1_data_delay
    (
	    .clk(Clk),
		.reset_n(Rstn),
		.data_in(img1),
		.data_delay_out(img1_delay),
		.delay_clk_num(number_delay)
	);
	
data_delay  #(
        .data_width(3) 
    )
        img2_data_delay
        (
            .clk(Clk),
            .reset_n(Rstn),
            .data_in(img2),
            .data_delay_out(img2_delay),
            .delay_clk_num(number_delay)
        );
        
data_delay  #(
            .data_width(11) 
        )
            X1_data_delay
            (
                .clk(Clk),
                .reset_n(Rstn),
                .data_in(X1),
                .data_delay_out(X1_delay),
                .delay_clk_num(number_delay)
            );

data_delay  #(
            .data_width(11) 
        )
            X2_data_delay
            (
                .clk(Clk),
                .reset_n(Rstn),
                .data_in(X2),
                .data_delay_out(X2_delay),
                .delay_clk_num(number_delay)
            );


data_delay  #(
            .data_width(11) 
        )
            Y1_data_delay
            (
                .clk(Clk),
                .reset_n(Rstn),
                .data_in(Y1),
                .data_delay_out(Y1_delay),
                .delay_clk_num(number_delay)
            );	
            
data_delay  #(
                        .data_width(11) 
                    )
                        Y2_data_delay
                        (
                            .clk(Clk),
                            .reset_n(Rstn),
                            .data_in(Y2),
                            .data_delay_out(Y2_delay),
                            .delay_clk_num(number_delay)
                        );


                                                    
                          

endmodule						
						 