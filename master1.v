module masterckt1(datawrite,outdata,data1,data2,clock,reset,func1);
   reg ack1;
   reg nack1;
   reg startx;
   reg stopx; 
   output reg [7:0] outdata;    
   input [7:0] data1,data2;
   input [11:0] func1;
   wire [11:0] func1; 
   input clock;
   input reset;
   reg [7:0] psw1;
   output [11:0] datawrite; 
   reg [3:0]adreg;
   integer x = 0;
   reg start;
   reg stop;
   reg [11:0] datawrite;
   reg [11:0] datax;
   reg [3:0] func2;
   reg check = 1'b0;
   integer k = 0;
 initial 
begin
psw1 = 0;
nack1 = 1'b1;
ack1 = 1'b1;
startx = 1'b1;
stopx = 1'b1;
adreg = 4'b0010;
#30 adreg = 4'b001;
end

/*
psw register bits
psw[0] = carry
psw[1] = na;
psw[2] = parity
psw[3] = na
psw[4] = auxilliary carry
psw[5] = na
psw[6] = zero
psw[7] = sign


module alu (op,a,b,opcode);

  output reg [7:0] op;     //output of alu
   input [7:0]     a,b;    //inputs to alu
   input [3:0] opcode;     //control signal for different operation



   4'b0000 : add
   4'b0001 : subtract
   4'b0010 : compare
   4'b0011 : parity
   4'b0100 : remainder
   4'b0101 : bitwise AND
   4'b0110 : bitwise OR
   4'b0111 : logical AND
   4'b1000 : logical OR
   4'b1001 : bitwise XOR
   4'b1010 : bitwise NOT
   4'b1011 : logical NOT
   4'b1100 : right shift 
   4'b1101 : left shift 
   4'b1110 : increment
   4'b1111 : decrement
 
*/

always @(posedge clock)
begin
for (k = 0; k < 4; k = k + 1)
   func2[k] = func1[k+2]; 
if (reset == 1)
begin 
outdata <= 0;
psw1 <= 0;
end
else 
begin
 case (func2)
   4'b0000 :  
        begin 
        outdata = data1 + data2;
        if (data1+data2 > 8'b11111111)
         psw1[0] <= 1'b1;
        else if (data1 <00001111 && data2 < 00001111)
         psw1[4] <= outdata[4];
        else 
        psw1[0] <= 1'b0;
        end

   4'b0001 : 
       begin 
        if(data1 > data2) 
        begin
        outdata = data1 - data2;
        psw1[6] <= 1'b0; 
        end
        else 
        begin
        outdata = data1 - data2;
        psw1[6] <= 1'b1;
        end 
       end
 
  4'b0010 : 
       begin  
       if (data1 > data2)
        begin
        outdata = data1;
        psw1[0] <= 1'b0;
        psw1[6] <= 1'b0; 
        end
       else if (data1 == data2)
        begin
        outdata = data2;
        psw1[6] <= 1'b1;
        end
       else 
        begin 
        outdata = data2;
        psw1[0] <= 1'b1;
        end 

       end 

   4'b0011 :  
       begin 
       outdata = data1;
       psw1[2] <= ^data1;
       end
 
  4'b0100 : 
       begin
       outdata = data1 % data2;
       end
 
  4'b0101 :
       begin
       outdata = data1 & data2;
       end
 
  4'b0110 :
       begin
       outdata = data1 | data2;
       end

   4'b0111 :
       begin 
       outdata = data1 && data2;
       end

   4'b1000 : 
       begin
       outdata = data1 || data2;
       end

   4'b1001 : 
       begin
       outdata = data1 ^ data2;
       end

   4'b1010 :
       begin
       outdata = ~ data1;
       end

   4'b1011 :
       begin
       outdata = ! data1;
       end

   4'b1100 :  
       begin
       outdata = data1 >> 1;
       end

   4'b1101 :
      begin
      outdata = data1 << 1;
      end

   4'b1110 :

      begin
      outdata = data1 + 1;
      end

   4'b1111 :
      begin
      outdata = data1 - 1;
      end

   default:outdata = 8'bXXXXXXXX;
 endcase
end
for (x = 0; x < 8; x = x + 1)
   begin
   datawrite[x+2] <= outdata[x];
   datawrite[0] = 1'b1;
   datawrite[1] = ack1;
   datawrite[10] = nack1;
   datawrite[11] = 1'b1;
  end 
end

   write w1(.startbit(startx),.endbit(stopx),.clk1(clock),.maindata(datawrite),.addreg(adreg));
   readins r1(.inssend(func1),.ins(func2),.startins(startx),.clkins(clock),.addins(adreg));
endmodule

module tb_check();
reg [7:0]ax1,ay1;
reg [11:0]opx;
reg c;
reg r;
wire [7:0]az1;
wire [11:0] dm;
masterckt1 a1(.datawrite(dm),.outdata(az1),.data1(ax1),.data2(ay1),.func1(opx),.clock(c),.reset(r));
initial 
begin 
c = 1'b0;
r = 1'b1;
ax1 = 8'b11001100;
ay1 = 8'b11111111;
opx = 12'b110101000011;
#10 r = 1'b0;
end
always 
#5 c = ~c;
endmodule  