
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module load(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] imm,
    input logic [31:0] mem_data,
    input logic [4:0] rd_in,
    input logic [2:0] load_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic rd_write_control,
    output logic [4:0] rd_out,
    output logic [31:0] rd_write_val,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr
);

logic state,next_state ;
logic [1:0] mem_addr_lsbs;
logic [2:0] load_control_reg ;
logic [31:0] final_mem_value ;

always_comb 
    begin
        case(state)
        begin
            0 : begin
                if(load_control != `LOAD_NOPE)
                    begin
                        next_state = 'b1 ;
                        stall_pc = 'b1;
                        mem_addr = rs1_val + imm ;

                    end
                
                else 
                    begin
                        next_state = 'b0 ;
                        stall_pc = 'b1 ;
                        mem_addr = rs1_val + imm ;
                    end

                end
            1 : begin
                    

                end
            
        end
        else
            begin
                //stall_pc = 'b0 ;
                rd_write_control = 'b1;
                rd_write_val = mem_data;

            end

    end

always@(posedge i_clk or negedge i_rst) 
    begin
        if(~i_rst)
            begin
                state <= 0;
            end
        else 
            begin
                next_state <= state ;
            end 
    end





    

    



    

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/load.vcd");
        $dumpvars(0, load);
     end
 `endif

endmodule
