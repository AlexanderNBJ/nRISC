`include "MemoriaDeDados.v"
`include "nRISC.v"
`include "MemoriaDeInstrucoes.v"

module main();
    reg clock, reset;

    // fios da memória de instruções
    wire[7:0] enderecoInstrucao, instrucao;

    // fios da memória de dados
    wire[7:0] enderecoDado, dadoEscr, dadoLido;
    wire MemWrite, MemLoad;

    // módulos principais
    nRISC                processador(clock, reset, dadoLido, instrucao, enderecoInstrucao,dadoEscr, enderecoDado, memWrite, memLoad);
    MemoriaDeDados       dataBank(clock, reset, memWrite, memLoad, enderecoDado, dadoEscr, dadoLido);
    MemoriaDeInstrucoes  instBank(clock, enderecoInstrucao, instrucao);

   initial begin
        reset = 1;

        // inicializa a memória de dados
        for (integer i = 0; i < 256; i = i + 1) begin
            dataBank.Mem[i] = 8'b0;
        end

        $readmemb("inicializaMem.txt", dataBank.Mem, 5);
        $readmemb("inicializaInst.txt", instBank.MemID);

        #1
        reset = 0;
		clock = 0;
		forever begin
            $display("Clock: %d\t PC:%d\t      Instrucao Atual: %b", clock, processador.pc.pc, instrucao);
            $display("Registradores:\ts0 =%d\t t0 =%d   t1 =%d   t2 =%d", processador.bancoReg.Register[0],processador.bancoReg.Register[1],processador.bancoReg.Register[2],processador.bancoReg.Register[3]);
            $display("Mem[0]:%d Mem[1]:%d Mem[2]:%d Mem[3]:%d Mem[4]:%d", dataBank.Mem[0], dataBank.Mem[1], dataBank.Mem[2], dataBank.Mem[3], dataBank.Mem[4]);
            $display("Vetor: %d %d %d %d %d %d %d %d %d %d", dataBank.Mem[5], dataBank.Mem[6], dataBank.Mem[7], dataBank.Mem[8], dataBank.Mem[9], dataBank.Mem[10], dataBank.Mem[11], dataBank.Mem[12], dataBank.Mem[13], dataBank.Mem[14]);
            $display("Tempo de Execucao:%d", $time);
            $display("---------------------------------------------------------");
			#1
			clock = ~clock;
		end
	end


	always @(clock) begin
		if(processador.instrucao[7:4] == 4'b1111) begin
			$finish;
		end

        // Para mostrar o vetor original

        // if($time == 10) begin
        //    $finish;
        // end

        // Para mostrar trocas do BubbleSort

        // if($time == 100) begin
        //     $finish;
        // end

        // Para mostrar o final do for interno

        // if($time == 350) begin
        //     $finish;
        // end
	end

endmodule