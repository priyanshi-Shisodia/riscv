
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module jump(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [1:0] jump_control,
    output logic rd_write_control,
    output logic [31:0] rd_write_val,
    output logic pc_update_control,
    output logic [31:0] pc_update_val,
    output logic ignore_curr_inst
);
always_comb
    begin
        if(jump_control != `JMP_NOP)
                    begin
                        pc_update_control = 'b1 ;
                        rd_write_val = pc + 4 ;
                        rd_write_control = 'b1 ;
                    

                    if(jump_control == `JAL)
                        begin
                            pc_update_val = pc + imm ; 
                        end
                    
                    else
                        begin
                            pc_update_val = imm + rs1_val ; 
                        end
                    end
        else 
            begin
                pc_update_control = 'b0 ;
                pc_update_val = 'b0 ;
                rd_write_val = 'b0 ;
                rd_write_control ='b0 ;
            end
    end

always @(posedge i_clk or negedge i_rst)
    begin
        if(~i_rst)
            begin
                ignore_curr_inst <= 'b0 ;
            end
        else 
            begin
                ignore_curr_inst <= pc_update_control;
            end 
    
    end

                    

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/jump.vcd");
        $dumpvars(0, jump);
     end
 `endif

endmodule
