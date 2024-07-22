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

 memory #(.WIDTH(WIDTH),.DEPTH(DEPTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (clk,rst,addr,wr_rd,w_data,r_data,valid,ready);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin 
rst=1;
reset();
#10;
rst=0;
write(0,DEPTH);
read(0,DEPTH);
end
//reset task
task reset();
	begin 
		addr=0;
		wdata=0;
		valid=0;
		wr_rd=0;
	end
//FRONTDOOR WRITE
task write(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH-1:0]en);
begin 
	for(i=in;i<en;i=i+1)begin 
		@(posedge clk);
			addr=i;
			w_data=$random;
			wr_rd=1;
			valid=1;
			wait(ready==1);
	end
	@(posedge clk);
	reset();
end
endtask
//FRONTDOOR READ
task read(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH-1:0]en);
begin 
	for(i=in;i<en;i=i+1)begin 
		@(posedge clk);
			addr=i;
			wr_rd=0;
			valid=1;
			wait(ready==1);
	end
	@(posedge clk);
	reset();
end
endtask
initial begin 
#1000;
$finish();
end
endmodule
