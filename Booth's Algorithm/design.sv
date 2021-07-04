module booths #(parameter n = 64) (clk, reset, multiplicand, multiplier, product);
    input clk, reset;
    input [n-1:0] multiplicand, multiplier;
    
    output reg [2*n-1:0] product;
    
    reg [2*n:0] Product;
    reg [n-1:0] temp;
    reg [n-1:0] zeros;
    integer i;
    
    always @(posedge clk, negedge reset)
        begin
            if(!reset)
                product <= 0;
            else
                product <= Product[2*n:1];
        end
        
    always @(*)
        begin
            //Initially we concatanate multiplier bit 0's to left and a single 0 to the right
            zeros = 0;
            Product = {zeros, multiplier, 1'b0};
            
            for(i = 0; i < n; i = i+1)
                begin
                    //Check the last 2 LSBs
                    if(Product[1:0] == 1)
                        begin
                            //Add the multiplicand to the left side of the product
                            temp = Product[2*n:n+1]+multiplicand;
                            Product = { temp, Product[n:0] };
                        end
                    else if(Product[1:0] == 2)
                        begin
                            //Subtract the multiplicand from the left side of the product
                            temp = Product[2*n:n+1]-multiplicand;
                            Product = { temp, Product[n:0] };
                        end
                        
                    //Right shiftingt the product, but conserving the MSB
                    Product = {Product[2*n], Product[2*n:1]};
                end
        end
endmodule
