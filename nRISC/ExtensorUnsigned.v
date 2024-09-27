module ExtensorUnsigned(entrada, saida);
    input [2:0] entrada;
    output reg[7:0] saida;

    always@ (entrada) begin
        saida = { {5{1'b0}}, entrada[2:0] };
    end

endmodule