module ALU(output logic[8:0] out, input[8:0] a, b, input[3:0] opcode);

logic binput;

parameter S0 = 4'b0000; //AND
parameter S1 = 4'b0001; //OR
parameter S2 = 4'b0010; //NOT
parameter S3 = 4'b0011; //ADD
parameter S4 = 4'b0100; //MOV
parameter S5 = 4'b0101; //SLL
parameter S6 = 4'b0110; //SRL
parameter S7 = 4'b0111; //SUB
parameter S8 = 4'b1000; //ADDI
parameter S9 = 4'b1001; //SUBI
parameter S10 = 4'b1010; //MOVI
parameter S11 = 4'b1011; //NOP
parameter S15 = 4'b1111; //HALT


logic[8:0] G, P;
logic [2:0] carries;
logic [2:0] cin, cout;

CLA myCLA1(carries[2:0], cout[0], P[2:0], G[2:0], 1'b0);

CLA myCLA2(carries[5:3], cout[1], P[5:3], G[5:3], cout[0]);

CLA myCLA3(carries[8:6], cout[2], P[8:6], G[8:6], cout[1]);


always_comb
if((opcode === S7) || (opcode === S9))
binput = ~b+1'b1;
else binput = b;

assign 	ps = a ^ binput;
 assign	gs = a & binput;

always @(*) begin
    if((opcode === S3) || (opcode === S7) || (opcode === S8) || (opcode === S9)) begin
        G = a & binput;
        P = a ^ binput;
    end
else

case(opcode)
S0: out = a & b;
S1: out = a | b;
S2: out = ~a;
S3: out = a ^ binput ^ carries;
S4: out = a;
S5: out = a << 1;
S6: out = a >> 1;
S7: out = a ^ binput ^ carries;
S8: out = a ^ binput ^ carries;
S9: out = a ^ binput ^ carries;

S10: out = binput;
endcase

endmodule


module CLA(output logic[2:0] carries, output logic cout,
						input logic[2:0] ps, gs, input cin);
	always_comb
		carries[0] = cin;
		carries[1] = gs[0] | (ps[0] & cin);
		carries[2] = gs[1] | (ps[1] & gs[0]) | (ps[1] & ps[0] & cin);
		cout = gs[2] | (ps[2] & gs[1]) | (ps[2]  & ps[1] & gs[0]) |
									(ps[2] & ps[1] & ps[0] & cin);


endmodule 

module mux8 //mux8
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


module PC(output [9:0] output_addr, input logic reset, clock)
	always_ff @(posedge clock, reset)
		if(reset)
			output_addr=10b'0000000000;
		else
			output_addr=output_addr+1;
endmodule


module mux8 
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


module register_bank (output logic[8:0] R1, R2, R3, R4, R5, R6, input logic clock, );

endmodule



module CPU();

endmodule

