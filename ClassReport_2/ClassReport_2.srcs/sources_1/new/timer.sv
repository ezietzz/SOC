`timescale 1ns / 1ps


module ms_timer(
    input logic clk,
    input logic rst,
    input logic en,
    output logic [31:0] count,
    output logic [15:0] ms_ticks
    );
    
    logic [31:0] ncount;
    logic [15:0] ms_next;
    parameter MS = 20'b00011000011010100000;
    
    
    always_ff @(posedge clk, posedge rst)
      if(rst)
            begin
            count <=0; 
            ms_ticks <= 0;
            end
        else
            begin
            count<=ncount;
            ms_ticks <= ms_next;
            end
        
    always_comb
        if(en && count != MS)
            begin
            ncount = count + 1;
            ms_next = ms_ticks;
            end
        else if(en && count == MS)
            begin
            ms_next = ms_ticks + 1;
            ncount = 0;
            end
    
    
endmodule
