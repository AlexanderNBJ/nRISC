module Controle(clock, opCode, funct, PcWrite, Reg1src, Jump, Bnez, ULAsrc, ULAop, MemWrite, MemLoad, RegWrite);
    input clock, funct;
    input[2:0] opCode;
    output reg[1:0] Reg1src, ULAop;
    output reg PcWrite, Jump, Bnez, ULAsrc, MemWrite, MemLoad, RegWrite;

    always@ (posedge clock) begin

        /*
            opCode == 000, funct = 0 : soma de registradores
            opCode == 000, funct = 1 : subtração de registradores
            opCode == 001, funct = X : adição com imediato
            opCode == 010, funct = X : load word 
            opCode == 011, funct = X : store word
            opCode == 100, funct = X : bnez 
            opCode == 101, funct = X : set value 
            opCode == 110, funct = X : set on less than 
            opCode == 111, funct = 0 : jump register
            opCode == 111, funct = 1 : halt
        */

        case(opCode)

            // aritméticas com registradores
            3'b000: begin
                PcWrite  = 1'b1;
                Reg1src  = 2'b00;
                Jump     = 1'b0;
                Bnez     = 1'b0;
                ULAsrc   = 1'b0;
                MemWrite = 1'b0;
                MemLoad  = 1'b0;
                RegWrite = 1'b1;
                
                if(funct == 1'b0) begin
                    ULAop = 2'b00;
                end
                else begin
                    ULAop = 2'b01;
                end
            end

            // adição com imediato
            3'b001: begin
                PcWrite  = 1'b1;
                Reg1src  = 2'b00;
                Jump     = 1'b0;
                Bnez     = 1'b0;
                ULAsrc   = 1'b1;
                ULAop    = 2'b00;
                MemWrite = 1'b0;
                MemLoad  = 1'b0;
                RegWrite = 1'b1;
            end

            // load word
            3'b010: begin
                PcWrite  = 1'b1;
                Reg1src  = 2'b10;
                Jump     = 1'b0;
                Bnez     = 1'b0;
                MemWrite = 1'b0;
                MemLoad  = 1'b1;
                RegWrite = 1'b1;
            end

            // store word
            3'b011: begin
                PcWrite  = 1'b1;
                Jump     = 1'b0;
                Bnez     = 1'b0;
                MemWrite = 1'b1;
                MemLoad  = 1'b0;
                RegWrite = 1'b0;
            end

            // bnez
            3'b100: begin
                PcWrite = 1'b1;
                Jump = 1'b0;
                Bnez = 1'b1;
                MemWrite = 1'b0;
                MemLoad = 1'b0;
                RegWrite = 1'b0;
            end

            // set value
            3'b101: begin
                PcWrite = 1'b1;
                Reg1src = 2'b01;
                Jump = 1'b0;
                Bnez = 1'b0;
                MemWrite = 1'b0;
                MemLoad = 1'b0;
                RegWrite = 1'b1;
            end

            // set on less than
            3'b110: begin
                PcWrite = 1'b1;
                Reg1src = 2'b00;
                Jump = 1'b0;
                Bnez = 1'b0;
                ULAsrc = 1'b0;
                ULAop = 2'b10;
                MemWrite = 1'b0;
                MemLoad = 1'b0;
                RegWrite = 1'b1;
            end

            // jr ou halt
            3'b111: begin
                if(funct == 1'b1) begin
                    PcWrite = 1'b0;
                end
                else begin
                    PcWrite = 1'b1;
                    Jump = 1'b1;
                    MemWrite = 1'b0;
                    MemLoad = 1'b0;
                    RegWrite = 1'b0;
                end
            end
        endcase    
    end


endmodule