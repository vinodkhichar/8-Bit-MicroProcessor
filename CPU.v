`include "Memory.v"
`include "CU.v"
`include "ALU.v"
`include "DataTransfer.v"


module CPU(
    input clk, reset,
    input ins_write, ins_read, mem_read_tb,
    input[7:0] instruction_write_data, mem_write_data_tb,
    input[3:0] access_addr_tb,
    output[7:0] alu_result, flag, instruction, mem_read_data,
    output reg[7:0] pc,
    output reg[31:0] register
);


// registers
// reg[7:0] pc;
// reg[7:0] register[3:0];
wire[7:0] immediate_value;

//memory interface
wire mem_read, mem_write;
// reg ins_write;
// assign ins_write = ins_write_in;
// assign ins_read = ~ins_write;
wire[3:0] mem_access_addr;
wire[7:0] mem_write_data;//, mem_read_data;


// Control Unit interface
wire [3:0] opcode;
wire [1:0] rd, rs, prevrd;
wire alu_src, immediate, reg_write;

//ALU interfacw
reg[7:0] alu_a, alu_b;


//initializing register
integer i;
// RegisterDecoder RD(.r(rd), .s(rds), .e(rde));
// RegisterDecoder RS(.r(rs), .s(rss), .e(rse));

initial 
begin  
    pc <= 8'hff; 
    register <= 32'h00000000;

    // for(i=0;i<4;i=i+1)  
    // register[i] <= 8'd0; 
end 

// controlling program counter
always @(negedge clk or posedge reset)  
 begin
    if(ins_write==1'b0)  begin 
      if(reset)  
      begin 
           pc <= 8'd0; 
      end
      else begin
        if(pc < 255) pc <= pc + 1;
        else pc <= pc;  
      end
    end
    else  begin
        // pc <= pc + 1;
    end
 end 


always @(instruction_write_data)  
 begin
        pc <= pc + 1;
 end 


always @(rd or instruction) begin
    case(rd)
    2'b00:begin
      alu_a <= register[7:0];
    end

    2'b01:begin
      alu_a <= register[15:8];
    end
    
    2'b10:begin
      alu_a <= register[23:16];
    end
    
    2'b11:begin
      alu_a <= register[31:24];
    end
    endcase
 end
always @(rs or instruction) begin
    case(rs)
    2'b00:begin
      alu_b <= register[7:0];
    end

    2'b01:begin
      alu_b <= register[15:8];
    end
    
    2'b10:begin
      alu_b <= register[23:16];
    end
    
    2'b11:begin
      alu_b <= register[31:24];
    end
    endcase
 end

always @(negedge clk) begin
    if(reg_write) begin
      if(mem_read) register[7:0] <= mem_read_data;
      else
        begin case(rd)
        2'b00:begin
          register[7:0] <= alu_result;
        end

        2'b01:begin
          register[15:8] <= alu_result;
        end
        
        2'b10:begin
          register[23:16] <= alu_result;
        end
        
        2'b11:begin
          register[31:24] <= alu_result;
        end
        endcase
        end
    end
 end

Instruction_Memory instruction_memory(.clk(clk),.mem_read(ins_read),.mem_write(ins_write),
                .access_addr(pc),.write_data(instruction_write_data),
                .read_data(instruction));

 Data_Memory data_memory(.clk(clk),.mem_read(mem_read),.mem_write(mem_write), .mem_write_tb(ins_write),
                .access_addr(mem_access_addr),.write_data(mem_write_data), .mem_read_tb(mem_read_tb),
                .read_data(mem_read_data));
 
 Control_Unit control_unit(.inst(instruction), .reset(reset), .opcode(opcode), .rd(rd), .rs(rs), .prevrd(prevrd),
            .mem_read(mem_read), .mem_write(mem_write),
             .reg_write(reg_write), .immediate_value(immediate_value));

ALU alu(.clk(clk), .a(alu_a), .b(alu_b), .immv(immediate_value),
        .alu_control(opcode), .alu_result(alu_result), .flag(flag));

DTU dtu(.clk(clk),.mem_write_tb(ins_write), .data(register[7:0]), 
        .access_addr_tb(access_addr_tb), .mem_write_data_tb(mem_write_data_tb), .mem_read_tb(mem_read_tb),
        .access_addr_im(immediate_value), .write_data(mem_write_data),// read_data, 
        .mem_access_addr(mem_access_addr));

endmodule