module memory(clk,rst,addr,wr_rd,w_data,r_data,valid,ready);
parameter WIDTH=16;
parameter DEPTH=16;
parameter ADDR_WIDTH=$clog2(DEPTH);
input clk,rst,wr_rd,valid;
input [WIDTH-1:0] w_data;
input [ADDR_WIDTH-1:0] addr;
output reg ready;
output reg [WIDTH-1:0] r_data;
reg [WIDTH-1:0]mem[DEPTH-1:0];
integer i;

always@(posedge clk)begin 
	if(rst)begin
		ready=0;
		r_data=0;
		for(i=0;i<WIDTH;i=i+1) mem[i]=0;
	end
	else begin 
		if(valid)begin 
			ready=1;
			if(wr_rd)begin 
				mem[addr]=w_data;
			end
			else begin 
			 r_data=mem[addr];
			 end
		end
	end
end
endmodule
