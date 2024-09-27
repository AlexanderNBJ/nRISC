module MemoriaDeDados(clock, reset, memWrite, memLoad, endereco, dadoEscr, dadoLido);
    input[7:0] endereco, dadoEscr;
    input clock, reset, memWrite, memLoad;
    output reg[7:0] dadoLido;
    reg signed [7:0] Mem [255:0];
    reg[7:0] saida;

    always@ (negedge clock) begin
        if(memWrite) begin
            Mem[endereco] = dadoEscr;
        end
    end

    always@ (*) begin
        if(memLoad) begin
            dadoLido = Mem[endereco];
        end
    end

endmodule