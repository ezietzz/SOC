`timescale 1ns / 1ps


module RotatingSquare(
    input logic clk,
    input logic rst,
    output logic [7:0] ss0,
    output logic [7:0] ss1,
    output logic [7:0] ss2,
    output logic [7:0] ss3
    );
    
    logic [2:0] count;
    
    parameter TOP_SQUARE =8'b10011100;
    parameter BOT_SQUARE =8'b10100011;
    parameter EMPTY      =8'b11111111;
    
    counter#(.N(30),.M(3)) mycounter1(
    .clk(clk),
    .rst(rst),
    .count(count)
    );
    
    always_comb 
        case(count)
        0:begin
            ss0 = EMPTY;
            ss1 = EMPTY;
            ss2 = EMPTY;
            ss3 = TOP_SQUARE;
           end
        1:begin
            ss0 = EMPTY;
            ss1 = EMPTY;
            ss2 = TOP_SQUARE;
            ss3 = EMPTY;
           end
        2:begin
            ss0 = EMPTY;
            ss1 = TOP_SQUARE;
            ss2 = EMPTY;
            ss3 = EMPTY;
           end
        3:begin
            ss0 = TOP_SQUARE;
            ss1 = EMPTY;
            ss2 = EMPTY;
            ss3 = EMPTY;
           end
        4:begin
            ss0 = BOT_SQUARE;
            ss1 = EMPTY;
            ss2 = EMPTY;
            ss3 = EMPTY;
          end
        5:begin
            ss0 = EMPTY;
            ss1 = BOT_SQUARE;
            ss2 = EMPTY;
            ss3 = EMPTY;
          end
        6:begin
            ss0 = EMPTY;
            ss1 = EMPTY;
            ss2 = BOT_SQUARE;
            ss3 = EMPTY;
          end
        7:begin
            ss0 = EMPTY;
            ss1 = EMPTY;
            ss2 = EMPTY;
            ss3 = BOT_SQUARE;
          end
        endcase    
endmodule
