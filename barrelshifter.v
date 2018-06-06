module barrel_shifter(d,out,q,c); // Main module of 8-Bit Barrel shifter
  input [7:0]d;
  output [7:0]out,q;
  input[2:0]c;
  mux m1(q[0],d,c);
  mux m2(q[1],{d[0],d[7:1]},c);
  mux m3(q[2],{d[1:0],d[7:2]},c);
  mux m4(q[3],{d[2:0],d[7:3]},c);
  mux m5(q[4],{d[3:0],d[7:4]},c);
  mux m6(q[5],{d[4:0],d[7:5]},c);
  mux m7(q[6],{d[5:0],d[7:6]},c);
  mux m8(q[7],{d[6:0],d[7:7]},c);
  assign out=q;
endmodule

module mux(y,d,c); // Sub module of 8-Bit barrel shifter
  input[7:0]d;
  output y;
  reg y;
  input [2:0]c;
  always @ (c)
  begin
    if (c==3'b000)
      y = d[0];
    else if (c==3'b001)
      y = d[1];
      else if (c==3'b010)
      y = d[2];
      else if (c==3'b011)
      y = d[3];
      else if (c==3'b100)
      y = d[4];
      else if (c==3'b101)
      y = d[5];
      else if (c==3'b110)
      y = d[6];
      else if (c==3'b111)
      y = d[7];
    end
  endmodule 

module tb_barrel();
reg [7:0]p;
reg [2:0]t;
wire [7:0]r,s;
barrel_shifter b1(p,r,s,t);
initial
begin 
p = 8'b11001100;
t= 3'b101;
end 
endmodule 
