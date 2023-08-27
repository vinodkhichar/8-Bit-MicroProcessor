module Decoder(
    input isim4, clk,
     input[7:0] inst, 
    output reg[7:0] imm8,
    output reg[3:0] opcode
);
integer i;
always @(*)
begin
    
    opcode = inst[7:4];

    if(isim4) begin
        imm8[3:0] <= inst[3:0];
        for(i=4;i<8;i=i+1) begin
            imm8[i] <= inst[3];
        end
    end 
    else begin
        imm8[1:0] <= inst[1:0];
        for(i=2;i<8;i=i+1) begin
            imm8[i] <= inst[1];
        end
    end
    // #0.5 $display("%b",imm8);
end
endmodule