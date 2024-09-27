module PC(clock, reset, PcWrite, pcEntrada, pcSaida);
	reg[7:0] pc;

	input clock, reset, PcWrite;
	input[7:0] pcEntrada;
	output reg[7:0] pcSaida;

	always@ (negedge clock) begin
		if(PcWrite)begin
			pc = pcEntrada;
			pcSaida = pc;
		end
	end

	always@ (reset) begin
		if(reset) begin
			pc = 8'b00000000;
			pcSaida = pc; 
		end
	end
	
endmodule