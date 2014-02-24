module srlatch(input logic s, r, 
               output logic q, qbar);
   
   always_comb
   
      case({s,r}) 
        2'b01: {q,qbar} = 2'b01;
        2'b10: {q,qbar} = 2'b10;
        2'b11: {q,qbar} = 2'b00;
      endcase
      
      
endmodule           
          
              
      
