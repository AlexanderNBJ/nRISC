module ExtensorSigned(entrada, saida);
    input [2:0] entrada;
    output reg[7:0] saida;

    always@ (entrada) begin
        saida = { {5{entrada[2]}}, entrada[2:0] };
    end

endmodule