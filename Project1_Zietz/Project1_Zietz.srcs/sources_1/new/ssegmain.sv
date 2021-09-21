`timescale 1ns / 1ps


module ssegmain(
    input logic clk,
    input logic reset_n,
    output [7:0] sseg,
    output [7:0] an
    );
    
    
    logic [7:0] ss0;
    logic [7:0] ss1;
    logic [7:0] ss2;
    logic [7:0] ss3;
    
   RotatingSquare Display(
        .clk(clk),
        .rst(!reset_n),
        .ss0(ss0),
        .ss1(ss1),
        .ss2(ss2),
        .ss3(ss3)
    );
    
  
    ssegdrv SEGG(
        .clk(clk),
        .rst(!reset_n),
        .ss0(ss0),
        .ss1(ss1),
        .ss2(ss2),
        .ss3(ss3),
        .sseg(sseg),
        .an(an)
    );
    
endmodule
