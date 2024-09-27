module MemoriaDeInstrucoes(clock, pcSaida, instrucao);
    input clock;
    input[7:0] pcSaida;
    output reg[7:0] instrucao;

    reg[7:0] MemID[255:0];
    
    always@ (pcSaida)begin
        instrucao = MemID[pcSaida];
    end

endmodule