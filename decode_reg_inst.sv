
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_reg_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);

    logic [2:0]func_3 ;
    logic [6:0]func_7 ;


always_comb 
    begin 
    
         rd [4:0] = instruction_code [11:7] ;
         rs1 [4:0] = instruction_code [19:15] ;
         rs2 [4:0] = instruction_code [24:20] ;
         func_3 [2:0] =  instruction_code [14:12] ;
         func_7 [6:0] = instruction_code [31:25] ;


    if(func_3 == 3'h0)
        begin
            if(func_7 == 7'h0)
                begin
                    alu_control = `ADD;
                end
            else
                begin
                    alu_control = `SUB;
                end
        end
    else begin
    
    if(func_3 == 3'h1)
        begin
            alu_control = `SLL;
        end
    else begin
    if(func_3 == 3'h2)
        begin 
            alu_control = `SLT;
        end
    else begin
    if(func_3 == 3'h3)
        begin
            alu_control = `SLTU;
        end
    else begin
    if(func_3 == 3'h4)
        begin
            alu_control = `XOR;
        end
    else begin
    if(func_3 == 3'h5)
        begin 
            if(func_7 == 7'h0)
                begin
                    alu_control = `SRL;
                end
            else
                begin 
                    alu_control = `SRA;
                end
        end
    else begin
    if(func_3 == 3'h6)
        begin
            alu_control = `OR;
        end
    else 
        begin
            alu_control = `AND;
        end
    end
    end    
    end   
    end
    end
    end
    end

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/decode_reg_inst.vcd");
        $dumpvars(0, decode_reg_inst);
     end
 `endif

endmodule
