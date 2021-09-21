`timescale 1ns / 1ps



module Main2(
    //input logic [15:0] mscount,
    input logic clk,
    input logic reset_n,
    input logic  btnc, btnu, btnd,
    output [7:0] sseg,
    output [7:0] an 
    );
    //output logic [15:0] count
    parameter H      = 8'b10001001;
    parameter I      = 8'b11001111;
    parameter ZERO   = 8'b11000000;
    parameter ONE    = 8'b11111001;
    parameter TWO    = 8'b10100100;
    parameter THREE  = 8'b10110000;
    parameter FOUR   = 8'b10011001;
    parameter FIVE   = 8'b10010010;
    parameter SIX    = 8'b10000010;
    parameter SEVEN  = 8'b11111000;
    parameter EIGHT  = 8'b10000000;
    parameter NINE   = 8'b10011000;
    parameter BLANK  = 8'b11111111;
    
//    parameter INIT= 3'b000;
//    parameter RUNNING= 3'b001;
//    parameter STOP= 3'b011;
//    parameter DONE= 3'b010;
//    parameter ERROR= 3'b110;
    
    logic first;
    logic[15:0] display, stopped;
    logic [2:0] state, nstate;
    logic timer;
    logic btnc_db, btnu_db, btnd_db;
    logic [7:0] ss0, ss1, ss2, ss3;
    
    
    logic rst;
    assign rst = !reset_n;
    
    db_fsm DB_BTNU
   (
    .clk(clk), 
    .reset(!reset_n),
    .sw(btnu),
    .db(btnu_db)
   );
   
   db_fsm DB_BTNC
   (
    .clk(clk), 
    .reset(!reset_n),
    .sw(btnc),
    .db(btnc_db)
   );
   db_fsm DB_BTND
   (
    .clk(clk), 
    .reset(!reset_n),
    .sw(btnc),
    .db(btnd_db)
   );
   
    //logic [2:0] state, nstate;
    parameter INIT= 3'b000;
    parameter RUNNING= 3'b001;
    parameter STOP= 3'b011;
    parameter DONE= 3'b010;
    parameter ERROR= 3'b110;
   
//   always_ff @(posedge clk, posedge rst)
//        if(rst)
//            state<=INIT; 
//        else
//            state<=nstate;
        
//   always_comb
      
//   case(state)
//   INIT:
//   begin
//        ss0 = I;
//        ss1 = H;
//        ss2 = BLANK;
//        ss3 = BLANK;
//        if(btnu_db)
//            nstate = RUNNING;
//        if(btnd_db)
//            nstate = INIT;
//   end
//   RUNNING:
//   begin
//        ss0 = ONE;
//        ss1 = TWO;
//        ss2 = THREE;
//        ss3 = FOUR;
//        if(btnc_db)
//            nstate = DONE;
//        if(btnd_db)
//            nstate = INIT;
//    end
//    STOP:
//    begin
//        ss0 = SIX;
//        ss1 = NINE;
//        ss2 = SIX;
//        ss3 = NINE;
//    end
//    DONE:
//    begin
//        ss0 = SIX;
//        ss1 = SIX;
//        ss2 = SIX;
//        ss3 = SIX;
//        if(btnd_db)
//            nstate = INIT;
//    end
//    ERROR:
//    begin
//        ss0 = H;
//        ss1 = H;
//        ss2 = H;
//        ss3 = H;
//    end
//    endcase
   
   always_comb
  
   if(btnc_db)
   begin
   ss0 = NINE;
   ss1 = NINE;
   ss2 = NINE;
   ss3 = NINE;
   end
   else
   begin
   ss0 = ZERO;
   ss1 = ZERO;
   ss2 = ZERO;
   ss3 = ZERO;
   end
   
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

    // assign output state of led
			  
    endmodule