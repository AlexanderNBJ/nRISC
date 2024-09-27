module MUX1bit(controle, entrada1, entrada2, saida);
    input controle;
    input [7:0] entrada1, entrada2;
    output reg[7:0] saida;

    always @(*) begin
        if(!controle) begin
            saida = entrada1;
        end
        else begin
            saida = entrada2;
        end
    end

endmodule