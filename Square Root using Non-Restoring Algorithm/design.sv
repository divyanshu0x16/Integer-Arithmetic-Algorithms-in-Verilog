module squareRoot #(parameter n=32) (clk, reset, number, root, remainder);
  input clk, reset;
  input [n-1:0] number;
  
  output reg [(n/2)-1:0] root, remainder;
  reg [(n/2)-1:0] r, rem;
  
  always @(posedge clk, negedge reset)
    begin
      
      if(!reset) begin
        root <= 0;
        remainder <= 0;
      end
      
      else begin
        root <= r;
        remainder <= rem;
      end
      
    end
  
  integer i;
  
  always @ (*)
    
    begin
      rem = 0;
      r = 0;
      
      for(i = (n/2)-1; i >= 0; i = i-1)begin
        
        //If remainder is greater than equal to 0
        
        if(!rem[(n/2)-1])begin
          rem = (rem << 2)|((number>>(i+i))&3); // At every iteration we get 2 bits, starting from right. 
          rem = rem - ((r<<2)|1); // - Q01
        end
        
        //If remainder is negative
        else begin
          rem = (rem << 2)|((number>>(i+i))&3); // At every iteration we get 2 bits, starting from right.
          rem = rem + ((r<<2)|3); // + Q11
        end
        
        if(!rem[(n/2)-1]) r = (r<<1)|1; // If remainder was positive, the current bit for answer will be 1.
        else r = (r<<1)|0; // else bit will be 0
        
      end
      
      if (rem[(n/2)-1]) rem = rem + ((r<<1)|1); //If lastly remainder is negative we add. 
    end
  
  
endmodule