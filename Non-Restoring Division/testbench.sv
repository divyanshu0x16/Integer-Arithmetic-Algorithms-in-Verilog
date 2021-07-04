module testbench();
  parameter n = 64;
  reg clk, reset;
  reg [n-1:0] dividend, divisor;
  wire [n-1:0] quotient, remainder;
  
  non_restoring_division #(n) inst(clk, reset, dividend, divisor, quotient, remainder);
  
  initial begin
    //$dumpfile("dump.vcd"); 
    //$dumpvars(1);
    clk = 0;
    reset = 0;
    dividend = 11;
    divisor = 3;
    #5
    reset = 1;
    
    #10
    dividend = 15;
    divisor = 5;
    
    #10
    dividend = 100;
    divisor = 3;
    
    #10
    dividend = 2147483647;
    divisor = 1505034;
    
    #10
    dividend = 2147483647;
    divisor = 2147483647;
    
    #10
    dividend = 49;
    divisor = 100;
    
    
  end
  
  always #5 clk = ~clk;
endmodule