module Somador(entrada1, entrada2, resultado);
    input [7:0] entrada1, entrada2;
    output reg signed [7:0] resultado;
    reg signed[7:0] dado1, dado2;

    always@ (*) begin
        dado1 = entrada1;
        dado2 = entrada2;
        resultado = dado1 + dado2;
    end

endmodule