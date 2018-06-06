module readins (inssend,ins,startins,clkins,addins);
   input [3:0] ins;
   output [11:0] inssend;
   input startins;
   input clkins;
   input [3:0] addins;
  wire [3:0] ins;
  reg [11:0] inssend;
  wire startins;
  integer i = 0;
   
always @(posedge clkins)
begin 
   if (startins == 1'b0 | addins != 4'b0010)
      inssend = 8'bzzzzzzzz;
   else 
    begin 
    for (i = 0; i < 4 ; i = i + 1)
     inssend[i+2] <= ins[i];
     inssend[0] = startins;
     inssend[1] = 1'b1;
     inssend[6] = 1'b0;
     inssend[7] = 1'b0;
     inssend[8] = 1'b0;
     inssend[9] = 1'b0;
     inssend[10] = 1'b1;
     inssend[11] = 1'b1;
    end
end 
endmodule 