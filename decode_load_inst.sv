
module decode_load_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [2:0] load_control
);

logic [2:0] func_3;

always_comb
    begin

         rd [4:0] = instruction_code [11:7] ;
         rs1 [4:0] = instruction_code [19:15] ;
         func_3 [2:0] =  instruction_code [14:12] ;
         imm [11:0] = instruction_code [31:20] ;
    end

endmodule
