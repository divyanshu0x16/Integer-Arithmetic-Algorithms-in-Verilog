module testbench();
  parameter n = 64;
  reg clk, reset;
  reg  [63:0] multiplicand, multiplier;
  wire [127:0] product;
  
  booths #(n) inst(clk, reset, multiplicand, multiplier, product);
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(1);
    clk = 0;
    reset = 0;
    
    multiplicand = 11;
    multiplier = 3;
    
    #5
    reset = 1;
    
    #10
    multiplicand = 15;
    multiplier = -5;
    
    #10
    multiplicand = -6;
    multiplier = 2;
    
    #10
    multiplicand = -20;
    multiplier = -5;
    
    #10
    multiplicand = 14356;
    multiplier = 10000;
    
    #10
    multiplicand = 15356;
    multiplier = -10000;
   
   
    
  end
  
  always #5 clk = ~clk;
endmodule