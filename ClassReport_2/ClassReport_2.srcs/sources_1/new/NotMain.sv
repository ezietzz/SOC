`timescale 1ns / 1ps



module NotMain(
    //input logic [15:0] mscount,
    input logic clk,
    input logic reset_n,
    input logic  btnc, btnu, btnd,
    output [7:0] sseg,
    output [7:0] an 
    );
    //output logic [15:0] count
    parameter ZERO   = 4'b0000;
    parameter ONE    = 4'b0001;
    parameter TWO    = 4'b0010;
    parameter THREE  = 4'b0011;
    parameter FOUR   = 4'b0100;
    parameter FIVE   = 4'b0101;
    parameter SIX    = 4'b0110;
    parameter SEVEN  = 4'b0111;
    parameter EIGHT  = 4'b1000;
    parameter NINE   = 4'b1001;
    parameter H      = 4'b1010;
    parameter I      = 4'b1011;
    parameter BLANK  = 4'b1100;

    
    typedef enum logic [2:0] {INIT, TIMING, TEST, LATE, DONE} State;
    State curr_state, next_state;
    
    logic first;
    logic [15:0] display, stopped, decimal;

    logic btnc_db, btnu_db, btnd_db;
    logic btnu_press, btnc_press, btnd_press;
    logic [7:0] ss0, ss1, ss2, ss3;
    logic timer_enable, timer_rst;
    
    logic rst;
    assign rst = !reset_n;
    
    logic [31:0] ms_ticks;
    
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
    .sw(btnd),
    .db(btnd_db)
   );
   
   ms_timer COUNTER1(
        .clk(clk),
        .rst(timer_rst),
        .en(timer_enable),
        .count(),
        .ms_ticks(ms_ticks)
    );
    
    BDC Converter(
        .binary(ms_ticks),
        .thousands(decimal[15:12]),
        .hundreds(decimal[11:8]),
        .tens(decimal[7:4]),
        .ones(decimal[3:0])
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
    
   //$urandom_range(2,15);
   
   
   always_ff @(posedge clk, negedge reset_n)
        if(!reset_n)
            curr_state <=INIT; 
        else
            curr_state <=next_state;
                
   always_comb@(posedge clk)
   case(curr_state)
   INIT:
        begin
            display = {BLANK,BLANK,H,I};
            if(btnu_db)
            begin
                next_state = TEST;
                timer_rst = 1;
            end
            else if(btnd_db)
                next_state = INIT;
        end
   RUNNING:
       begin     
            display = decimal;   
            timer_rst = 0;
            timer_enable = 1;        
            if(btnc_db)
                begin
                next_state = STOP;
                timer_enable = 0;
                stopped = decimal;
                end
            else if(btnd_db)
                next_state = INIT;
//            else if(btnu_db)
//                next_state = RUNNING;//do nothing
        end     
    STOP:
        begin
            display = stopped;
            if(btnd_db)
                next_state = INIT;
        end
    DONE:
        begin
        display = stopped;
            if(btnd_db)
                next_state = INIT;
        end
    ERROR:
        begin
            display = {NINE,NINE,NINE,NINE};
        end 
    endcase
    
    endmodule