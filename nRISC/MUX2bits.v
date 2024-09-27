module MUX2bits(controle, entrada1, entrada2, entrada3, entrada4, saida);
    input [1:0]controle;
    input [7:0] entrada1, entrada2, entrada3, entrada4;
    output reg[7:0] saida;

    always @(*) begin
        case(controle)
            2'b00: saida = entrada1;
            2'b01: saida = entrada2;
            2'b10: saida = entrada3;
            3'b11: saida = entrada4;
        endcase
    end

endmodule