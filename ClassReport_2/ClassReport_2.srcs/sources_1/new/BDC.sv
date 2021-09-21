`timescale 1ns / 1ps



module BDC(
    input logic [15:0] binary,
    output logic [3:0] thousands,
    output logic [3:0] hundreds,
    output logic [3:0] tens,
    output logic [3:0] ones
    );
    
    integer i;
    always_comb
    begin
        thousands = 4'd0;
        hundreds = 4'd0;
        tens = 4'd0;
        ones = 4'd0;
        
        for(i=15; i>=0; i--)
        begin
        //Add 3 to those > 5, to convert base 16 to base 10 after shift (+6)
            if(thousands >= 5)
                thousands+=3;
            if(hundreds >= 5)
                hundreds+=3;
            if(tens >= 5)
                tens+=3;
            if(ones >= 5)
                ones+=3;
            //Shift Left
            thousands = thousands << 1;
            thousands[0] = hundreds[3];
            hundreds = hundreds << 1;
            hundreds [0] = tens[3];
            tens = tens << 1;
            tens[0] = ones[3];
            ones = ones << 1;
            ones[0] = binary[i];
        end
    end
endmodule
