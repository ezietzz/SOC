`timescale 1ns / 1ps


module Main(
    input clk,
    input reset_n,
    input  btnc, btnu, btnd,
    output [7:0] sseg,
    output [7:0] an,  
    output LED0  
    );
    
    
    logic [7:0] ss0, ss1, ss2, ss3;
    logic [15:0] display;

    
    ButtonState Machine(
        .clk(clk),
        .rst(!reset_n),
        .btnc(btnc),
        .btnu(btnu),
        .btnd(btnd),
        .display(display),
        .led0(LED0)
    );
    
    ssegDecoder decoder(
        .in(display),
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
