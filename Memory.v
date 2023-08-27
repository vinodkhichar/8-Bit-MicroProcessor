module Instruction_Memory  
(
     input  clk, mem_read, mem_write,
     input[7:0]  access_addr, write_data,  
     output [7:0] read_data  
);  
     integer i; 
     reg [7:0] ram [255:0]; 
     initial begin  
          for(i=0;i<256;i=i+1)  
               ram[i] <= 8'dx;  
     end  
     always @(posedge clk) begin  
          if (mem_write) 
          begin 
               ram[access_addr] <= write_data;
          end
     end  
     assign read_data = (mem_read==1'b1) ? ram[access_addr]: 8'dx;   
endmodule 

module Data_Memory  
(
     input  clk, mem_read, mem_write, mem_write_tb,mem_read_tb,
     input[3:0]  access_addr, 
     input[7:0]  write_data,  
     output [7:0] read_data  
);  
     integer i; 
     reg [7:0] ram [255:0]; 
     initial begin  
          for(i=0;i<256;i=i+1)  
               ram[i] <= 8'd0;  
     end  
     always @(negedge clk) begin  
          if (mem_write || mem_write_tb)
               ram[access_addr] <= write_data;  
               // $monitor("%b", access_addr);
     end  
     assign read_data = (mem_read==1'b1 || mem_read_tb==1'b1) ? ram[access_addr]: 8'd0;   
endmodule 