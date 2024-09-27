module BancoDeRegistradores(regWrite,clock, reset, reg1, reg2, dadoEscr, dado1, dado2, dado3);
	input regWrite, clock, reset;
	input [1:0] reg1, reg2;
	input [7:0] dadoEscr;
	output reg [7:0] dado1, dado2, dado3;
	reg [7:0] Register[3:0];
	
	
	always@ (negedge clock) begin
		if(regWrite) begin
			Register[reg1] = dadoEscr;
		end
	end
	
	always@ (posedge clock) begin
		dado1 = Register[reg1];
		dado2 = Register[reg2];
		dado3 = Register[0];
	end
	
	always@ (reset) begin
		if(reset) begin
			Register[3] = 8'b0;
			Register[2] = 8'b0;
			Register[1] = 8'b0;
			Register[0] = 8'b0;
		end
	end
	
endmodule