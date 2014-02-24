
module ALU(output logic[8:0] out, input[8:0] a, b, input[3:0] opcode);


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

	always_comb
		if((opcode === S7) || (opcode === S9))
			begin
				binput = ~b;		
			end
		else binput = b;

		if((opcode === S3) || (opcode === S7) || (opcode === S8) || (opcode === S9))
			begin
				logic[8:0] G, P;
					G = a & binput;
					P = a ^ binput;
					logic [2:0] carries;
					logic cin, cout;
			end
		else

		casez(opcode)
			S0: out = a & b;
			S1: out = a ^ b;
			S2: out = ~a;
			S3, S8: begin
						cin = 0;
						CLA(carries, cout, P[2:0], G[2:0], cin);
						out[2:0] = carries;
						cin = cout;
						CLA(carries, cout, P[5:3], G[5:3], cin);
						out[5:3] = carries;
						cin = cout;
						CLA(carries, cout, P[8:6], G[8:6], cin);
						out[8:6] = carries;
						out = out ^ P;
					end //of S3,S8 case
			S4: out = a;
			S5: out = a << 1;
			S6: out = a >> 1;
			S7, S9: begin
						cin = 1; 
						CLA(carries, cout, P[2:0], G[2:0], cin);
						out[2:0] = carries;
						cin = cout;
						CLA(carries, cout, P[5:3], G[5:3], cin);
						out[5:3] = carries;
						cin = cout;
						CLA(carries, cout, P[8:6], G[8:6], cin);
						out[8:6] = carries;
						out = out ^ P;
					end //of S7,s9 case
			S10: out = binput; 
			S11: out = '0;
			S15: $stop; //HALT (for now, we shouldn't actually be using stop)
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