`include"memory_project.v"
module tb;
parameter WIDTH=16;
parameter DEPTH=16;
parameter ADDR_WIDTH=$clog2(DEPTH);
reg clk,rst,wr_rd,valid;
reg [WIDTH-1:0] w_data;
reg [ADDR_WIDTH-1:0] addr;
wire ready;
wire [WIDTH-1:0] r_data;
integer i;

 memory #(.WIDTH(WIDTH),.DEPTH(DEPTH)) dut (clk,rst,addr,wr_rd,w_data,r_data,valid,ready);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin 
rst=1;
#10;
rst=0;
//FRONTDOOR WRITE
for(i=0;i<DEPTH;i=i+1)begin 
	@(posedge clk);
	addr=i;
	w_data=$random;
	wr_rd=1;
	valid=1;
	wait(ready==1);
end
//FRONTDOOR READ
for(i=0;i<DEPTH;i=i+1)begin 
	@(posedge clk);
	addr=i;
	wr_rd=0;
	valid=1;
	wait(ready==1);
end
end
initial begin 
#500;
$finish();
end
endmodule
