`timescale 1ns / 1ps


module ssegDecoder(
    input logic [15:0] in,
    output logic  [7:0] ss0,
    output logic  [7:0] ss1,
    output logic  [7:0] ss2,
    output logic  [7:0] ss3
    );
    
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
    
    always_comb 
    begin
        case(in[15:12])
            0: ss3 = ZERO;
            1: ss3 = ONE;
            2: ss3 = TWO;
            3: ss3 = THREE;
            4: ss3 = FOUR;
            5: ss3 = FIVE;
            6: ss3 = SIX;
            7: ss3 = SEVEN;
            8: ss3 = EIGHT;
            9: ss3 = NINE;
            10: ss3 = H;
            11: ss3 = I;
            12: ss3 = BLANK;
        endcase
        case(in[11:8])
            0: ss2 = ZERO;
            1: ss2 = ONE;
            2: ss2 = TWO;
            3: ss2 = THREE;
            4: ss2 = FOUR;
            5: ss2 = FIVE;
            6: ss2 = SIX;
            7: ss2 = SEVEN;
            8: ss2 = EIGHT;
            9: ss2 = NINE;
            10: ss2 = H;
            11: ss2 = I;
            12: ss2 = BLANK;
        endcase
        case(in[7:4])
            0: ss1 = ZERO;
            1: ss1 = ONE;
            2: ss1 = TWO;
            3: ss1 = THREE;
            4: ss1 = FOUR;
            5: ss1 = FIVE;
            6: ss1 = SIX;
            7: ss1 = SEVEN;
            8: ss1 = EIGHT;
            9: ss1 = NINE;
            10: ss1 = H;
            11: ss1 = I;
            12: ss1 = BLANK;
        endcase
        case(in[3:0])
            0: ss0 = ZERO;
            1: ss0 = ONE;
            2: ss0 = TWO;
            3: ss0 = THREE;
            4: ss0 = FOUR;
            5: ss0 = FIVE;
            6: ss0 = SIX;
            7: ss0 = SEVEN;
            8: ss0 = EIGHT;
            9: ss0 = NINE;
            10: ss0 = H;
            11: ss0 = I;
            12: ss0 = BLANK;
        endcase
        end
        
endmodule
