module ex4_38(input logic clk, reset, up, output logic [2:0] q);
  
  typedef enum logic [2:0] {
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b011,
    S3 = 3'b010,
    S4 = 3'b110,
    S5 = 3'b111,
    S6 = 3'b101,
    S7 = 3'b100} statetype;
    
    statetype [2:0] state, nextstate;
    
    always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else       state <= nextstate;
      
      always_comb
        case (state)
          S0: if (up) nextstate = S1;
              else      nextstate = S7;
          S1: if (up) nextstate = S2;
              else      nextstate = S0;
          S2: if (up) nextstate = S3;
              else      nextstate = S1;
          S3: if (up) nextstate = S4;
              else      nextstate = S2;
          S4: if (up) nextstate = S5;
              else    nextstate = S3;
          S5: if (up) nextstate = S6;
              else    nextstate = S4;
          S6: if (up) nextstate = S7;
              else    nextstate = S5;
          S7: if (up) nextstate = S0;
              else    nextstate = S6;
          endcase

    assing q = state;
endmodule      
  
  
  }
