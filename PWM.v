`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2026 15:30:14
// Design Name: 
// Module Name: PWM
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
module timer(
    input [7:0] finalValue,
    input clk,
    input reset,
    output reg done
    );
    
    reg [7:0] valueNow;
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            valueNow <= 0;
            done <= 0;
        end
        else if (valueNow == finalValue) begin
            valueNow <= 0;
            done <= 1;
            end
        else begin
            valueNow <= valueNow + 1;
            done <= 0;
            end
        end  
endmodule

module counter(
    input in,
    input clk,
    input rst,
    output reg [7:0] out
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst == 1)begin
            out <= 0;
        end
        else begin
            if (in == 1'b1) begin 
                out <= out + 1;
            end
        end
     end   
endmodule


module comparator(
    input [7:0] count,
    input [8:0] duty,
    output reg pwm
);
    always @(*) begin
        if (count < duty) begin
            pwm = 1;
        end
        else begin
            pwm = 0;
        end
    end

endmodule 


module dff(
    input outCom,
    input clk,
    input res,
    output reg pwmOut
);
    always @(posedge clk or posedge res) begin
        if (res == 1) begin
            pwmOut <= 0;
        end
        else begin
            pwmOut <= outCom;
        end
    end
endmodule 


module PWM_Gen(
    input clk,
    input reset,
    input [7:0] finalValue,
    input [8:0] duty,
    output pwmOut
);

    wire timer_to_counter;
    wire [7:0] count_to_comp;
    wire comp_to_dff;
    
    timer Module_timer(
        .finalValue(finalValue),
        .clk(clk),
        .reset(reset),
        .done(timer_to_counter)
    );
    
    counter Module_count(
         .clk(clk),
         .rst(reset),
         .in(timer_to_counter),
         .out(count_to_comp)
    );
    
    comparator Module_comp(
        .count(count_to_comp),
        .duty(duty),
        .pwm(comp_to_dff)
    );
    
    dff Module_dff(
        .clk(clk),
        .res(reset),
        .outCom(comp_to_dff),
        .pwmOut(pwmOut)
    );
    
endmodule 