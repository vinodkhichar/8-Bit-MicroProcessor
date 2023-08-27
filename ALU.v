module ALU(
  input clk,
  input  [7:0] a,  //src1
  input  [7:0] b, immv,  //src2
  input  [3:0] alu_control, //function selection
  output reg [7:0] alu_result, flag  //alu_result
);

always @(posedge clk)
begin 
 case(alu_control)
//  4'b0000: alu_result = 0; // LD
//  4'b0001: alu_result = 0; // ST
 4'b0011: begin alu_result = b; flag = 8'dx; end    // MR
 4'b0010: begin alu_result = immv; flag = 8'dx; end  //MI
 4'b0100: begin alu_result = a + b; flag = 8'dx; end  // SUM
 4'b1100: begin alu_result = a + immv; flag = 8'dx; end // SMI
 4'b0101: begin alu_result = a - b; flag = 8'dx; end // SB
 4'b1101: begin alu_result = a - immv; flag = 8'dx; end // SBI
 4'b0111: begin alu_result = a; flag = (a > b) ? 8'b1:8'b0; end // CM
 4'b1111: begin alu_result = a; flag = (a > immv) ? 8'b1:8'b0; end // CMI
 4'b0110: begin alu_result = a & b; flag = 8'dx; end    // ANR
 4'b1110: begin alu_result = a & immv; flag = 8'dx; end  // ANI
 4'b1000: begin alu_result = a | b; flag = 8'dx; end  // ORR
 4'b1001: begin alu_result = a | immv; flag = 8'dx; end // ORI
 4'b1010: begin alu_result = a ^ b; flag = 8'dx; end  // XRR
 4'b1011: begin alu_result = a ^ immv; flag = 8'dx; end // XRI
 default: begin alu_result <= alu_result; flag = 8'dx; end // DEFAULT
 endcase
//  $display("%b %b %b", a, b, immv);
//  $display("%b", alu_control);
end
 
endmodule