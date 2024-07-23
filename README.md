# PROJECT-Memory-write-and-read
Design Description of memory
Module Name: memory
Ports:
clk: Clock input
rst: Reset input
addr: Address input ( ADDR_WIDTH bits wide)
wr_rd: Write/Read control input (1 bit wide)
w_data: Write data input (WIDTH bits wide)
r_data: Read data output (WIDTH bits wide)
valid: Valid input (1 bit wide)
ready: Ready output (1 bit wide)
Parameters:
WIDTH: Data width (16 bits in this case)
DEPTH: Memory depth (16 locations in this case)
ADDR_WIDTH: Address width (calculated as $clog2(DEPTH))
Internal Signals:
mem: Memory array (DEPTH locations, each WIDTH bits wide)
i: Integer variable used for initialization
Behavior:
The module implements a simple synchronous memory with the following behavior:
When rst is high, the module resets:
ready is set to 0
r_data is set to 0
The entire memory array mem is initialized to 0
When valid is high and rst is low, the module operates as follows:
If wr_rd is high, the module writes the w_data to the location specified by addr in the memory array mem.
If wr_rd is low, the module reads the data from the location specified by addr in the memory array mem and assigns it to r_data.
ready is set to 1 to indicate that the operation is complete.          

Testbench Description :-
In the testbench we are using all the input as reg (as we are generating inputs) and output as wire(as we are just checking the output)
initially clock is generated using forever loop
then reset task has been made in the reset task all the reg data types we made zero
then frontdoor write task we made in that task for every posedge of clk using for loop we generated the address and we assigned random values to that address
made valid =1 && ready=1 i.e handshaking 
reverse we made for read task. i.e we are reading from memory
as for frontdoor it needs time to perform the operation i.e delay
if we want to do operation at 0 time steps we use backdoor which needs 0 time step to perform operations
we made 2 backdoor task
1] b_write
2] b_read
for this wr use 2 system task function
for write -$readmemh("file_name",dut,start_address,end_address)
for read -$writememh("file_name",dut,start_address,end_address)
Here ends the programm
