`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2020 10:14:15
// Design Name: 
// Module Name: design
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


// Code your design here
module restore_algo #(parameter n= 64)(clk,reset,Dividend,Divisor,Quotient,Remainder);
  input clk, reset;
  input [n-1:0] Dividend, Divisor;
  
  output reg [n-1:0] Quotient, Remainder;
  
  reg [n-1:0] p,a,temp,b, sign;
  integer i;
  
  always @(posedge clk, negedge reset)
    begin
      if(!reset) begin
      	Quotient <= Dividend;
        Remainder <= 0;
      end
      else begin
		Quotient <= a;
        Remainder <= p;      	
      end
    end
  
  always @(*)
    begin
      a = Dividend;
      p=0;
      b= Divisor;
      //Sign will decide the sign of our quotient
      sign = a[n-1]^b[n-1];
      
      if(a[n-1]) a = ~a+1;
      
      if(b[n-1]) b = ~b+1;
      
      for(i=0; i<n; i=i+1)
        begin
          p=(p<<1)|a[n-1];//shifting left by 1 bit carraing a's MSB as p's LSB
          a=a<<1; // left shift by 1 bit a for latter bit & LSB is 0
          
          p=p - b; // p-M subtract
          
          if(p[n-1])//p<0 
            begin
              p = p + b;//restore p
            end
          else begin
          	a=a|1;//already left shifted just set LSB to 1
          end 
        end
       
       if(sign) a = ~a+1;
       //If dividend is negative divisor will be negative
       if(Dividend[n-1]) p = ~p+1; 
      
    end
endmodule
  
