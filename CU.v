`include "Decoder.v"

module Control_Unit(
    input[7:0] inst, //instruction
    input reset, clk,
    output[3:0] opcode,
    output reg[1:0] rd, rs, prevrd,
    output reg mem_read, mem_write, reg_write,
    output[7:0] immediate_value
);
reg isim4;
Decoder decoder(.clk(clk), .isim4(isim4), .inst(inst), .imm8(immediate_value), .opcode(opcode));

 always @(*)  
 begin 
      if(reset == 1'b1) begin  
                // opcode <= 4'd0;
                rd <= 2'b00;
                rs <= 2'b00;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b0;
      end  
      else begin  
      case(inst[7:4])   
       4'b0000: begin // LD  
                rd <= 2'b00;
                rs <= 2'bxx;
                isim4 <= 1'b1;
                mem_read <= 1'b1;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

      4'b0001:  begin // ST 
                rd <= 2'b00;
                rs <= 2'bxx;
                isim4 <= 1'b1;
                mem_read <= 1'b0;
                mem_write <= 1'b1;
                reg_write <= 1'b0;
                end

     4'b0011:   begin // MR  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b0010:   begin // MI  
                rd <= inst[3:2];
                rs <= 2'b00;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b0100:   begin // SUM  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b1100:   begin // SMI  
                rd <= inst[3:2];
                rs <= 2'b00;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

    4'b0101:    begin // SB  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b1101:   begin // SBI  
                rd <= inst[3:2];
                rs <= 2'bxx;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b0111:   begin // CM  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b1111:   begin // CMI  
                rd <= inst[3:2];
                rs <= 2'bxx;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b0110:   begin // ANR  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end

     4'b1110:   begin // ANI  
                rd <= inst[3:2];
                rs <= 2'bxx;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end  

     4'b1000:   begin // ORR  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end  

     4'b1001:   begin // ORI  
                rd <= inst[3:2];
                rs <= 2'bxx;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end  

     4'b1010:   begin // XRR  
                rd <= inst[3:2];
                rs <= inst[1:0];
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end 

     4'b1011:   begin // XRI  
                rd <= inst[3:2];
                rs <= 2'bxx;
                isim4 <= 1'b0;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b1;
                end  

     default:   begin //DEFAULT  
                rd <= 2'b00;
                rs <= 2'b00;
                mem_read <= 1'b0;
                mem_write <= 1'b0;
                reg_write <= 1'b0;
                end                        
      endcase
      
      end
    //   $display(rd);
end
endmodule


