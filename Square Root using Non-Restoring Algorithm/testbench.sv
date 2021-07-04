module testbench();
  parameter n = 32;
  reg clk, reset;
  reg [n-1:0] number;
  wire [(n/2)-1:0] root, remainder;
  
  squareRoot #(n) inst(clk, reset, number, root, remainder);
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(1);
    clk = 0;
    reset = 0;
    number = 237;
 
    #5
    reset = 1;
    
    #10
    number = 4000000;
  
    #10
    number = 96100;

    #10
    number = 25;
    
    #10
    number = 100000000;
    
    #10
    number = 33;
    
    #10
    number = 3300;
    
    #10
    number = 330000;
    

  end
  
  always #5 clk = ~clk;
endmodule