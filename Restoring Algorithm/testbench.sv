`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2020 10:15:20
// Design Name: 
// Module Name: testbench
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

module testbench();
  parameter n = 64;
  reg clk, reset;
  reg [n-1:0] dividend, divisor;
  wire [n-1:0] quotient, remainder;
  
  restore_algo #(n) inst(clk, reset, dividend, divisor, quotient, remainder);
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(1);
    clk = 0;
    reset = 0;
    dividend = 11;
    divisor = 3;
    
    #5
    reset = 1;
    //#5
    //reset = 1;
    #10
    dividend = 12;
    divisor = 3;
    
    #10
    dividend = 15;
    divisor = 5;
    
    #10
    dividend = 100;
    divisor = -99;
    
    #10
    dividend = -100;
    divisor = 99;
    
    #10
    dividend = -100;
    divisor = -99;
    
    #10
    dividend = -11;
    divisor = 3;
    
    #10
    dividend = 11;
    divisor = -3;
    
    #10
    dividend = -11;
    divisor = -3;
    
  end
  
  always #5 clk = ~clk;
endmodule