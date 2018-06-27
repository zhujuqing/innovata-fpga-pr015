module div_freq
(
input clk_in,
input rst_n,
output reg start,
output reg clk_out1,
output reg clk_out2
);
parameter freq750k=22;
parameter freq785k=21;
parameter delay=1000;
reg [4:0]count1;
reg [4:0]count2;
reg [11:0]count3;
always @(posedge clk_in or negedge rst_n)
begin
    if(!rst_n)
	    begin
	    count1<=1'b0;
		clk_out1<=1'b0;
		end
	else
	    begin
		if(count1==freq750k-1)
		    begin
			count1<=1'b0;
			clk_out1<=~clk_out1;
			end
		else
		    count1<=count1+1'b1;
		end
end
always @(posedge clk_in or negedge rst_n)
begin
    if(!rst_n)
	    begin
	    count2<=1'b0;
		clk_out2<=1'b0;
		end
	else
	    begin
		if(count2==freq785k-1)
		    begin
			count2<=1'b0;
			clk_out2<=~clk_out2;
			end
		else
		    count2<=count2+1'b1;
		end
end
always @(posedge clk_in or negedge rst_n)
begin
    if(!rst_n)
	    begin
	    count3<=1'b0;
		start<=1'b0;
		end
	else
	    begin
		if(count3>delay-1)
			start<=1'b1;
		else
		    count3<=count3+1'b1;
		end
end
endmodule