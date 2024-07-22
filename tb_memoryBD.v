`include"memory_project.v"
module tb;
parameter WIDTH=8*20;
parameter DEPTH=1;
parameter ADDR_WIDTH=$clog2(DEPTH);
reg clk,rst,wr_rd,valid;
reg [WIDTH-1:0] w_data;
reg [ADDR_WIDTH-1:0] addr;
wire ready;
wire [WIDTH-1:0] r_data;
integer i,a,b,j;
reg [WIDTH-1:0]mem[DEPTH-1:0];
reg [50*8:0]testcase;
reg [8*100:0] str;
 memory #(.WIDTH(WIDTH),.DEPTH(DEPTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (clk,rst,addr,wr_rd,w_data,r_data,valid,ready);

initial begin 
clk=1;
forever #5 clk=~clk;
end

initial begin 
rst=1;
reset();
#6;
rst=0;
//$value$plusargs("a=%d",a);
//$value$plusargs("b=%d",b);
$value$plusargs("testcase=%s",testcase);
	case(testcase)
		"Full_fw_fr":begin
			write(0,DEPTH);
			read(0,DEPTH);
		end
		"Half_fw_fr":begin
			write(0,DEPTH/2);
			read(0,DEPTH/2);
		end
		"Quater_fw_fr":begin
			write(0,DEPTH/4);
			read(0,DEPTH/4);
		end
		"Concurrent_fw_fr":begin
			fork 
				write(0,DEPTH);
				read(0,DEPTH);
			join
		end
		"fw_br":begin
			write(0,DEPTH);
			b_read(0,DEPTH);
		end
		"Half_fw_br":begin
			write(0,DEPTH/2);
			b_read(0,DEPTH/2);
		end
		"Quater_fw_br":begin
			write(0,DEPTH/4);
			b_read(0,DEPTH/4);
		end
		"Concurrent_fw_br":begin
			fork 
				write(0,DEPTH);
				b_read(0,DEPTH);
			join
		end
		"bw_fr":begin
			b_write(0,DEPTH);
			read(0,DEPTH);
		end
		"Half_bw_fr":begin
			b_write(0,DEPTH/2);
			read(0,DEPTH/2);
		end
		"Quater_bw_fr":begin
			b_write(0,DEPTH/4);
			read(0,DEPTH/4);
		end
		"Concurrent_bw_fr":begin
			fork 
				b_write(0,DEPTH);
				read(0,DEPTH);
			join
		end
		"bw_br":begin
			b_write(0,DEPTH);
			b_read(0,DEPTH);
		end
		"Half_bw_br":begin
			b_write(0,DEPTH/2);
			b_read(0,DEPTH/2);
		end
		"Quater_bw_br":begin
			b_write(0,DEPTH/4);
			b_read(0,DEPTH/4);
		end
		"Concurrent_bw_br":begin
			fork 
				b_write(0,DEPTH);
				b_read(0,DEPTH);
			join
		end
		"user_input":begin 
			$value$plusargs("a=%d",a);
			$value$plusargs("b=%d",b);
			write(a,b);
			read(a,b);
		end
		"random_values":begin 
			write($random,$random);
			read($random,$random);
		end
		"string":begin 
			$value$plusargs("str=%s",str);
			write(0,DEPTH);
			read(0,DEPTH);
		end
	endcase
end


//RESET TASK
task reset();
	begin 
		addr=0;
		w_data=0;
		wr_rd=0;
		valid=0;
	end
endtask


//FRONTDOOR WRITE  :- string
/*task write(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH:0]en);
begin 
	for(i=in;i<en;i=i+1)begin 
		@(posedge clk);
			addr=i;
			//for (j=0;j<WIDTH;j=j+1)begin
				w_data=str;
				wr_rd=1;
				valid=1;
				wait(ready==1);
		$display("w_data=%s",w_data);
			//	end
	end
	@(posedge clk);
	reset();
end
endtask*/

//FRONTDOOR WRITE :-$random 
task write(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH:0]en);
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
task read(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH:0]en);
begin 
	for(i=in;i<en;i=i+1)begin 
		@(posedge clk);
			addr=i;
			wr_rd=0;
			valid=1;
			wait(ready==1);
		$display("wr_rd=%b",wr_rd);
	end
	@(posedge clk);
	reset();
end
endtask


//BACKDOOR WRITE
task b_write(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH:0]en);
begin 
		$readmemh("mem.h",dut.mem,in,en);
end
endtask


//BACKDOOR READ
task b_read(input [ADDR_WIDTH-1:0]in,input [ADDR_WIDTH:0]en);
begin 
		$writememh("memory.h",dut.mem,in,en);
end
endtask

initial begin 
#1000;
$finish();
end
endmodule
