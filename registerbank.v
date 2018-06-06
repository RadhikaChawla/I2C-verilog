module register_bank(data,clk);

input [7:0] data;
input clk;

reg[7:0] a,b,c,d,h,l;
wire [7:0] data;
wire [7:0] pswdata;

always @(posedge clk)
begin
  if (a == 8'bxxxxxxxx)
   begin
   a <= data;
   end
  else if (b == 8'bxxxxxxxx)
   begin  
    b <= data;
  end
  else if (c == 8'bxxxxxxxx)
  begin
   c <= data;
   end
  else if (d == 8'bxxxxxxxx)
   begin
    d <= data;
   end

   else if (h == 8'bxxxxxxxx)
    begin
    h <= data;
   end

   else if (l == 8'bxxxxxxxx)
    begin
    l <= data;
   end

  else 
   $display ("no space");

end

endmodule 

/*module transreg(maindata,ack,nack,startreg,stopreg,indata,clkreg,addressreg); 
input [7:0] indata;
input startreg;
input stopreg;
input clkreg;
input addressreg;
output ack;
output nack;
output [11:0] maindata;
reg [11:0] maindata;
integer x = 0;
reg ack;
reg nack;
always @(posedge clkreg)
begin
  if (addressreg != 4'b0001 || startreg == 1'b0)
    $display ("wait");
  else 
     begin
      for (x = 0; x < 8; x = x + 1)
       maindata[x+2] <= indata[x];
     end
     maindata[0] <= startreg;
     maindata[1] <= ack;
     maindata[10] <= nack;
     maindata[11] <= stopreg;
end
recreg r1(.mainvalues(maindata),.tdata(indata),.startbit1(startreg),.endbit1(stopreg),.ack1(ack),.nack1(nack),.clk1(clkreg));
endmodule 

module recreg(mainvalues,tdata,startbit1,endbit1,ack1,nack1,clk1);
input startbit1;
input endbit1;
input ack1;
input nack1;
input clk1;
input [7:0]tdata;
output [11:0] mainvalues;
reg [11:0] mainvalues;
wire [7:0] tdata;
integer y = 0;
wire  starbit1;
wire endbit1;
wire ack1;
wire nack1;

always @(negedge clk1)
  begin
  for (y = 0; y < 8; y = y + 1)
  begin 
   mainvalues[y+2] = tdata[y]; 
  end
  mainvalues[0] = startbit1;
  mainvalues[1] = ack1;
  mainvalues[10] = nack1;
  mainvalues[11] = endbit1;
  end 
endmodule 

module test_idk();
*/

module write(startbit,endbit,clk1,maindata,addreg);
input startbit; 
input endbit;
reg ack = 1'b1;
reg nack = 1'b1;
input clk1;
input [3:0] addreg;
integer k = 0;
input [11:0] maindata;
wire [11:0] maindata;
reg [7:0] datain;

always @(negedge clk1)
begin
if (startbit == 1'b0 | addreg != 4'b0001)
$display ("wait");

else 
begin
for (k = 0; k < 8; k = k + 1)
   datain[k] <= maindata[k+2];
end
end
register_bank r1(.data(datain),.clk(clk1));
endmodule


module tb_idk();
reg s1;
reg e1;
reg c1;
reg [11:0] m1;
write wx(.startbit(s1),.endbit(e1),.clk1(c1),.maindata(m1));
initial
begin
s1 = 1'b1;
e1 = 1'b1;
c1 = 1'b0;
m1 = 12'b110011001111;
end

always 
#5 c1 = ~c1;
endmodule 