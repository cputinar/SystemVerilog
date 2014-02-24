module mux8
  #(parameter width=4)
  (input logic [width-1:0] d0, d1, d2, d3, 
                           d4, d5, d6, d7,
  input logic [2:0] s, 
  output logic [width-1:0] y);
  
  always_comb
  case(s)
    0: y = d0;
    1: y = d1;
    2: y = d2;
    3: y = d3;
    4: y = d4;
    5: y = d5;
    6: y = d6;
    7: y = d7;
  endcase
endmodule

