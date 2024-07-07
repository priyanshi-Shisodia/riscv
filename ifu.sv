
module ifu(
    input logic i_clk,
    input logic i_rst,
    input logic stall_pc,
    input logic pc_update_control,
    input logic [31:0] pc_update_val,
    output logic [31:0] pc,
    output logic [31:0] prev_pc
);

always@ (posedge i_clk or negedge i_rst)
   begin
      if(~i_rst)
         begin 
            pc = 'b0;
            prev_pc = 'b0;
         end

      else
         begin


            if(stall_pc)
               begin
                  prev_pc <= pc ;
                  
               end

            else
            

            if(pc_update_control)
               begin
                  pc <= pc_update_val ;
                  prev_pc <= pc ;
               end
            
            else 
               begin
                  pc <= pc + 4 ; 
                  prev_pc <= pc;

               end

            
            



         end









   end

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/ifu.vcd");
        $dumpvars(0, ifu);
     end
`endif

endmodule
