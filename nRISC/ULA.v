module ULA(dado1, dado2, ULAop, notzero, resultado);
    input signed [7:0] dado1, dado2;
    input[1:0] ULAop;
    output reg notzero;
    output reg signed[7:0] resultado;


    always@ (dado1, dado2, ULAop) begin
        if(dado1 == 8'b00000000) begin
            notzero = 0;
        end
        else begin
            notzero = 1;
        end

        case(ULAop) 
            // ULAop == 00, soma
            // ULAop == 01, subtração
            // ULAop == 1X, set on less than

            2'b00: begin
                resultado = dado1 + dado2;
            end

            2'b01: begin
                resultado = dado1 - dado2;
            end

            default: begin
                if(dado1 < dado2) begin
                    resultado = 1;
                end
                else begin
                    resultado = 0;
                end
            end
        endcase
    end

endmodule