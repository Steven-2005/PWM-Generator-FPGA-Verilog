`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2026 15:32:48
// Design Name: 
// Module Name: PWM_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PWM_tb;
    reg clk_tb;
    reg reset_tb;
    reg [7:0] finalValue;
    reg [8:0] duty;
    wire pwmOut_tb;
    
    PWM_Gen DUT(
        .clk(clk_tb),
        .reset(reset_tb),
        .finalValue(finalValue),
        .duty(duty),
        .pwmOut (pwmOut_tb)
    );
    
    
    always begin
        #5 clk_tb = ~clk_tb;
    end
    
    initial begin
        clk_tb = 0;
        reset_tb = 1;
        finalValue = 8'd1;
        duty = 9'd64;
        #20 reset_tb = 0;
        #25000; 
        duty = 9'd128;
        #25000;
        duty = 9'd25;
        #30000;
        $finish;
    end
   
endmodule
