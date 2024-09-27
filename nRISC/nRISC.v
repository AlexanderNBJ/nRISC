`include "PC.v"
`include "BancoDeRegistradores.v"
`include "ULA.v"
`include "Controle.v"
`include "ExtensorSigned.v"
`include "ExtensorUnsigned.v"
`include "MUX1bit.v"
`include "MUX2bits.v"
`include "Somador.v"

module nRISC(clock, reset, dadoLido, instrucao, pcSaida, dadoEscr, enderecoDado, MemWrite, MemLoad);
	input clock, reset;
	input [7:0] instrucao, dadoLido;
	output[7:0] dadoEscr;

	assign dadoEscr = dado1;

	// fios do PC
	wire [7:0] pcEntrada;
	output[7:0] pcSaida;

	// fios do Controle
	wire [1:0] Reg1src, ULAop;
	wire PcWrite, Jump, Bnez, ULAsrc, RegWrite;
	output MemWrite, MemLoad;

	// fios do Banco de Registradores
	wire [7:0] dado1, dado2, dado3;

	// fios da ULA
	wire notzero;
	wire [7:0] resultado;

	// Módulos Principais

	PC pc(clock, reset,PcWrite, pcEntrada, pcSaida);
	BancoDeRegistradores bancoReg(RegWrite, clock, reset, instrucao[1:0], instrucao[3:2], saidaMuxreg, dado1, dado2, dado3);
	ULA ula(dado1, saidaMuxULA, ULAop, notzero, resultado);
	Controle controle(clock, instrucao[7:5], instrucao[4], PcWrite, Reg1src, Jump, Bnez, ULAsrc, ULAop, MemWrite, MemLoad,RegWrite);

	// fios dos Extensores de Bits
	wire [7:0] saidaSigned, saidaUnsigned;

	// Extensores de bits
	ExtensorSigned   extSig(instrucao[4:2], saidaSigned);
	ExtensorUnsigned extUnsig(instrucao[4:2], saidaUnsigned);

	// fios dos MUXES
	wire portaAND;
	assign portaAND = notzero & Bnez;

	wire[7:0] saidaMuxBnez, saidaMuxULA, saidaMuxreg;

	// Muxes
	MUX1bit muxBNEZ(portaAND,somaPC,somaPCBNEZ, saidaMuxBnez);
	MUX1bit muxJUMP(Jump,saidaMuxBnez, dado1, pcEntrada);
	MUX1bit muxULA2(ULAsrc,dado2, saidaSigned, saidaMuxULA);
	MUX2bits muxREG1(Reg1src, resultado,saidaSigned, dadoLido, dadoLido, saidaMuxreg);

	// fios dos somadores
	wire [7:0] somaPC, somaPCBNEZ;
	output[7:0] enderecoDado;

	// Somadores
	Somador somaPC1(pcSaida,8'b00000001,somaPC);
	Somador somaBNEZ(somaPC,saidaUnsigned,somaPCBNEZ);
	Somador somaMEM(dado3, saidaSigned,enderecoDado);

endmodule