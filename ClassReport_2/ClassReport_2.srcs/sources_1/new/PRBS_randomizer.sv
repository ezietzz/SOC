`timescale 1ns / 1ps


module PRBS_randomizer#(parameter N = 25, parameter M=1)(
    input clk,
    input rst,
    output logic [M-1:0] rnd
    );
    
    logic[N-1:0] R, nR;
    logic TapOut;
    
    parameter START = 32'b01000111100011111010011000111011;
    
    assign rnd = R[M-1:0];
    
    always_ff@(posedge clk, posedge rst)
    if(rst)
        R <= START;
    else
        R <= nR;
        
    
    assign nR = {TapOut, R[N-1:1]};
    assign TapOut = R[N-1]^R[N-10]^R[1]^R[0];
    
        
        
    
endmodule
