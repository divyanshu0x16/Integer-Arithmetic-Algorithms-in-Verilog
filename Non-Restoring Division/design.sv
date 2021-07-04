module non_restoring_division #(parameter n =32) (clk, reset, dividend, divisor, quotient, remainder);
  
  input clk, reset;
  input [n-1:0] dividend, divisor;
  
  output reg [n-1:0] quotient, remainder;
  reg [n-1:0] q, a;
  // a stores remainder. q stores quotient
  
  
  always @(posedge clk, negedge reset)
    begin
      
      if(!reset) begin
        quotient <= 0;
        remainder <= 0;
      	end
      
      else begin
        quotient <= q;
        remainder <= a;
      end
      
    end
  
  integer i;
  
  always @ (*)
    begin
      q = dividend;
  	  a = 0;
      
      //This loop will rum times the number of bits in dividend
      for(i = 0; i < n; i++)
        begin  
          // By default after left shift, new int is 0. OR with q[n-1] will set the value of LSB
          a = (a<<1) | q[n-1];
          q = q<<1;
          
          //Check the sign bit of a
          if(a[n-1])
            a = a+divisor;
          else
            // 2's complement subtraction
            a = a+(~divisor+1);
          
          //If sign bit is zero, set LSB to 1
          if(!a[n-1])
            q = q | 1;
        end
      
      if(a[n-1])
        a = a+divisor;
    end
  
endmodule