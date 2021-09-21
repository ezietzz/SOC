`timescale 1ns / 1ps


module ButtonState(
    input logic clk,
    input logic rst,
    input logic  btnc, btnu, btnd,
    output logic [15:0] display,  
    output logic led0 
    );
    
    logic btnc_db, btnu_db, btnd_db;
    logic [15:0] stopped, decimal;
    logic [23:0] random, random_out;
    logic timer_rst, timer_enable;
    logic [15:0] ms_ticks;
    
    typedef enum logic [2:0] {INIT, TIMING, EARLY, TEST, LATE, DONE} State;
    State curr_state, next_state;
    
    
    
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
 
    db_fsm DB_BTNU
   (
    .clk(clk), 
    .reset(rst),
    .sw(btnu),
    .db(btnu_db)
   );
   
   db_fsm DB_BTNC
   (
    .clk(clk), 
    .reset(rst),
    .sw(btnc),
    .db(btnc_db)
   );
   
   db_fsm DB_BTND
   (
    .clk(clk), 
    .reset(rst),
    .sw(btnd),
    .db(btnd_db)
   );
   
   ms_timer COUNTER1(
        .clk(clk),
        .rst(timer_rst),
        .en(1'b1),
        .count(),
        .ms_ticks(ms_ticks)
    );
    
    PRBS_randomizer#(.N(32), .M(24)) Random(
        .clk(clk),
        .rst(rst),
        .rnd(random_out)
    );
    
    BDC Converter(
        .binary(ms_ticks),
        .thousands(decimal[15:12]),
        .hundreds(decimal[11:8]),
        .tens(decimal[7:4]),
        .ones(decimal[3:0])
    );
  always_ff @(posedge clk, posedge rst)
        if(rst)
            curr_state <=INIT; 
        else
            curr_state <=next_state;
            
  always_comb @(posedge clk)
      case(curr_state)
      INIT:
          begin
          led0 = 0;
          display = {BLANK,BLANK,H,I};
          if(btnu_db)
          begin
          timer_rst = 1;
          next_state = TIMING;
          random = random_out;
          //random = 16'b0000011111010000;
          end
          end
      TIMING:
          begin
          timer_rst = 0;
          display = {BLANK, BLANK, BLANK, BLANK};
          if(ms_ticks == random)
          begin
            led0 = 1;
            next_state = TEST;
            timer_rst = 1;
          end
          if(btnc_db)
            next_state = EARLY;
          end  
      EARLY:
          begin
            display = {NINE, NINE, NINE, NINE};
            if(btnd_db)
                next_state = INIT;
      end
      TEST:
          begin
            timer_rst = 0;
            display = decimal;
            if(btnc_db)
                begin
                next_state = DONE;
                stopped = decimal;
                end
            else if(btnd_db)
                next_state = INIT;
            if(ms_ticks >= 1000)
                next_state = LATE;
          end
      LATE:
          begin
          display = {ONE, ZERO, ZERO, ZERO};
          if(btnd_db)
            next_state = INIT;
          end
      DONE:
          begin
            display = stopped;
            if(btnd_db)
                next_state = INIT;
          end 
      endcase 
        
 
 
 
    
endmodule
