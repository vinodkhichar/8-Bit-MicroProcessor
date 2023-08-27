module DTU(
    input clk, mem_write_tb, mem_read_tb,
    input[7:0] data, mem_write_data_tb,
    input[7:0] access_addr_im, 
    input[3:0] access_addr_tb,
    output reg[7:0] write_data,// read_data
    output reg[3:0] mem_access_addr
);

always @(posedge clk) 
begin
    if(mem_write_tb || mem_read_tb) begin
        mem_access_addr <= access_addr_tb;
        write_data <= mem_write_data_tb;
    end
    else begin
        mem_access_addr <= access_addr_im[3:0];
        write_data <= data;
    end
    // $display("%b %b %b",mem_write_tb,mem_access_addr , write_data);
end

endmodule