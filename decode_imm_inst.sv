`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif
module decode_imm_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [4:0] alu_control
);

logic [2:0] func_3;

always_comb
    begin

         rd [4:0] = instruction_code [11:7] ;
         rs1 [4:0] = instruction_code [19:15] ;
         func_3 [2:0] =  instruction_code [14:12] ;
         imm [11:0] = instruction_code [31:20] ;

        case(func_3)
            3'h0 : alu_control = `ADDI;
            3'h1 : alu_control = `SLLI;
            3'h2 : alu_control = `SLTI;
            3'h3 : alu_control = `SLTIU;
            3'h4 : alu_control = `XORI;
            3'h5 : alu_control = `SRAI;
            3'h6 : alu_control = `ORI;
            3'h7 : alu_control = `ANDI;

        endcase

    end
endmodule
