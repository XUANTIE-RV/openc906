/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// &Depend("aq_dtu_cfig.h"); @23
// &Depend("cpu_cfig.h"); @24
// &ModuleBeg; @25
module aq_rtu_dp(
  cp0_rtu_ex1_chgflw,
  cp0_rtu_ex1_chgflw_pc,
  cp0_rtu_ex1_cmplt_dp,
  cp0_rtu_ex1_expt_tval,
  cp0_rtu_ex1_expt_vec,
  cp0_rtu_ex1_expt_vld,
  cp0_rtu_ex1_flush,
  cp0_rtu_ex1_halt_info,
  cp0_rtu_ex1_inst_dret,
  cp0_rtu_ex1_inst_ebreak,
  cp0_rtu_ex1_inst_len,
  cp0_rtu_ex1_inst_mret,
  cp0_rtu_ex1_inst_split,
  cp0_rtu_ex1_inst_sret,
  cp0_rtu_icg_en,
  cp0_yy_clk_en,
  ctrl_dp_ex1_cmplt_dp,
  dp_ctrl_ex1_cmplt_dp,
  dp_int_ex2_inst_split,
  dp_misc_clk,
  dp_retire_ex2_cur_pc,
  dp_retire_ex2_fs_dirty,
  dp_retire_ex2_halt_info,
  dp_retire_ex2_inst_branch,
  dp_retire_ex2_inst_chgflw,
  dp_retire_ex2_inst_dret,
  dp_retire_ex2_inst_ebreak,
  dp_retire_ex2_inst_expt,
  dp_retire_ex2_inst_flush,
  dp_retire_ex2_inst_mret,
  dp_retire_ex2_inst_split,
  dp_retire_ex2_inst_sret,
  dp_retire_ex2_inst_vstart,
  dp_retire_ex2_next_pc,
  dp_retire_ex2_tval,
  dp_retire_ex2_vec,
  dp_retire_ex2_vs_dirty,
  dp_retire_ex2_vstart,
  dp_top_dbg_info,
  forever_cpuclk,
  ifu_rtu_warm_up,
  iu_rtu_depd_lsu_chgflow_vld,
  iu_rtu_depd_lsu_next_pc,
  iu_rtu_ex1_alu_cmplt_dp,
  iu_rtu_ex1_alu_inst_len,
  iu_rtu_ex1_alu_inst_split,
  iu_rtu_ex1_bju_cmplt_dp,
  iu_rtu_ex1_bju_inst_len,
  iu_rtu_ex1_branch_inst,
  iu_rtu_ex1_cur_pc,
  iu_rtu_ex1_div_cmplt_dp,
  iu_rtu_ex1_mul_cmplt_dp,
  iu_rtu_ex1_next_pc,
  lsu_rtu_ex1_cmplt_dp,
  lsu_rtu_ex1_expt_tval,
  lsu_rtu_ex1_expt_vec,
  lsu_rtu_ex1_expt_vld,
  lsu_rtu_ex1_fs_dirty,
  lsu_rtu_ex1_halt_info,
  lsu_rtu_ex1_inst_len,
  lsu_rtu_ex1_inst_split,
  lsu_rtu_ex1_tval2_vld,
  lsu_rtu_ex1_vs_dirty,
  lsu_rtu_ex1_vstart,
  lsu_rtu_ex1_vstart_vld,
  lsu_rtu_ex2_tval2,
  pad_yy_icg_scan_en,
  rtu_iu_ex1_inst_len,
  rtu_iu_ex1_inst_split,
  rtu_iu_ex2_cur_pc,
  rtu_iu_ex2_next_pc,
  vpu_rtu_ex1_cmplt_dp
);


// &Ports; @27
input           cp0_rtu_ex1_chgflw;         
input   [39:0]  cp0_rtu_ex1_chgflw_pc;      
input           cp0_rtu_ex1_cmplt_dp;       
input   [39:0]  cp0_rtu_ex1_expt_tval;      
input   [4 :0]  cp0_rtu_ex1_expt_vec;       
input           cp0_rtu_ex1_expt_vld;       
input           cp0_rtu_ex1_flush;          
input   [21:0]  cp0_rtu_ex1_halt_info;      
input           cp0_rtu_ex1_inst_dret;      
input           cp0_rtu_ex1_inst_ebreak;    
input           cp0_rtu_ex1_inst_len;       
input           cp0_rtu_ex1_inst_mret;      
input           cp0_rtu_ex1_inst_split;     
input           cp0_rtu_ex1_inst_sret;      
input           cp0_rtu_icg_en;             
input           cp0_yy_clk_en;              
input           ctrl_dp_ex1_cmplt_dp;       
input           dp_misc_clk;                
input           forever_cpuclk;             
input           ifu_rtu_warm_up;            
input           iu_rtu_depd_lsu_chgflow_vld; 
input   [39:0]  iu_rtu_depd_lsu_next_pc;    
input           iu_rtu_ex1_alu_cmplt_dp;    
input           iu_rtu_ex1_alu_inst_len;    
input           iu_rtu_ex1_alu_inst_split;  
input           iu_rtu_ex1_bju_cmplt_dp;    
input           iu_rtu_ex1_bju_inst_len;    
input           iu_rtu_ex1_branch_inst;     
input   [39:0]  iu_rtu_ex1_cur_pc;          
input           iu_rtu_ex1_div_cmplt_dp;    
input           iu_rtu_ex1_mul_cmplt_dp;    
input   [39:0]  iu_rtu_ex1_next_pc;         
input           lsu_rtu_ex1_cmplt_dp;       
input   [39:0]  lsu_rtu_ex1_expt_tval;      
input   [4 :0]  lsu_rtu_ex1_expt_vec;       
input           lsu_rtu_ex1_expt_vld;       
input           lsu_rtu_ex1_fs_dirty;       
input   [21:0]  lsu_rtu_ex1_halt_info;      
input           lsu_rtu_ex1_inst_len;       
input           lsu_rtu_ex1_inst_split;     
input           lsu_rtu_ex1_tval2_vld;      
input           lsu_rtu_ex1_vs_dirty;       
input   [6 :0]  lsu_rtu_ex1_vstart;         
input           lsu_rtu_ex1_vstart_vld;     
input   [39:0]  lsu_rtu_ex2_tval2;          
input           pad_yy_icg_scan_en;         
input           vpu_rtu_ex1_cmplt_dp;       
output          dp_ctrl_ex1_cmplt_dp;       
output          dp_int_ex2_inst_split;      
output  [39:0]  dp_retire_ex2_cur_pc;       
output          dp_retire_ex2_fs_dirty;     
output  [21:0]  dp_retire_ex2_halt_info;    
output          dp_retire_ex2_inst_branch;  
output          dp_retire_ex2_inst_chgflw;  
output          dp_retire_ex2_inst_dret;    
output          dp_retire_ex2_inst_ebreak;  
output          dp_retire_ex2_inst_expt;    
output          dp_retire_ex2_inst_flush;   
output          dp_retire_ex2_inst_mret;    
output          dp_retire_ex2_inst_split;   
output          dp_retire_ex2_inst_sret;    
output          dp_retire_ex2_inst_vstart;  
output  [39:0]  dp_retire_ex2_next_pc;      
output  [39:0]  dp_retire_ex2_tval;         
output  [4 :0]  dp_retire_ex2_vec;          
output          dp_retire_ex2_vs_dirty;     
output  [6 :0]  dp_retire_ex2_vstart;       
output  [2 :0]  dp_top_dbg_info;            
output          rtu_iu_ex1_inst_len;        
output          rtu_iu_ex1_inst_split;      
output  [39:0]  rtu_iu_ex2_cur_pc;          
output  [39:0]  rtu_iu_ex2_next_pc;         

// &Regs; @28
reg             dp_ex1_inst_len;            
reg             dp_ex1_inst_split;          
reg     [39:0]  dp_ex2_cur_pc;              
reg     [4 :0]  dp_ex2_expt_vec;            
reg             dp_ex2_fs_dirty;            
reg     [21:0]  dp_ex2_halt_info;           
reg             dp_ex2_inst_branch;         
reg             dp_ex2_inst_chgflw;         
reg             dp_ex2_inst_dret;           
reg             dp_ex2_inst_ebreak;         
reg             dp_ex2_inst_expt;           
reg             dp_ex2_inst_flush;          
reg             dp_ex2_inst_mret;           
reg             dp_ex2_inst_split;          
reg             dp_ex2_inst_sret;           
reg             dp_ex2_inst_vstart;         
reg     [39:0]  dp_ex2_next_pc;             
reg     [39:0]  dp_ex2_tval;                
reg             dp_ex2_tval2_vld;           
reg             dp_ex2_vs_dirty;            
reg     [6 :0]  dp_ex2_vstart;              

// &Wires; @29
wire            cp0_rtu_ex1_chgflw;         
wire    [39:0]  cp0_rtu_ex1_chgflw_pc;      
wire            cp0_rtu_ex1_cmplt_dp;       
wire    [39:0]  cp0_rtu_ex1_expt_tval;      
wire    [4 :0]  cp0_rtu_ex1_expt_vec;       
wire            cp0_rtu_ex1_expt_vld;       
wire            cp0_rtu_ex1_flush;          
wire    [21:0]  cp0_rtu_ex1_halt_info;      
wire            cp0_rtu_ex1_inst_dret;      
wire            cp0_rtu_ex1_inst_ebreak;    
wire            cp0_rtu_ex1_inst_len;       
wire            cp0_rtu_ex1_inst_mret;      
wire            cp0_rtu_ex1_inst_split;     
wire            cp0_rtu_ex1_inst_sret;      
wire            cp0_rtu_icg_en;             
wire            cp0_yy_clk_en;              
wire            ctrl_dp_ex1_cmplt_dp;       
wire    [6 :0]  dp_cmplt_source;            
wire            dp_ctrl_ex1_cmplt_dp;       
wire            dp_ex1_alu_cmplt_dp;        
wire            dp_ex1_bju_cmplt_dp;        
wire            dp_ex1_cmplt;               
wire            dp_ex1_cmplt_dp;            
wire    [39:0]  dp_ex1_cp0_chgflw_pc;       
wire            dp_ex1_cp0_cmplt_dp;        
wire    [39:0]  dp_ex1_cur_pc;              
wire            dp_ex1_div_cmplt_dp;        
wire    [4 :0]  dp_ex1_expt_vec;            
wire            dp_ex1_fs_dirty;            
wire    [21:0]  dp_ex1_halt_info;           
wire            dp_ex1_inst_branch;         
wire            dp_ex1_inst_chgflw;         
wire            dp_ex1_inst_dret;           
wire            dp_ex1_inst_ebreak;         
wire            dp_ex1_inst_expt;           
wire            dp_ex1_inst_flush;          
wire            dp_ex1_inst_mret;           
wire            dp_ex1_inst_sret;           
wire            dp_ex1_inst_vstart;         
wire            dp_ex1_lsu_cmplt_dp;        
wire            dp_ex1_mul_cmplt_dp;        
wire    [39:0]  dp_ex1_next_pc;             
wire            dp_ex1_trap_updt;           
wire    [39:0]  dp_ex1_tval;                
wire            dp_ex1_tval2_vld;           
wire            dp_ex1_vec_cmplt_dp;        
wire            dp_ex1_vs_dirty;            
wire    [6 :0]  dp_ex1_vstart;              
wire            dp_int_ex2_inst_split;      
wire            dp_misc_clk;                
wire    [39:0]  dp_retire_ex2_cur_pc;       
wire            dp_retire_ex2_fs_dirty;     
wire    [21:0]  dp_retire_ex2_halt_info;    
wire            dp_retire_ex2_inst_branch;  
wire            dp_retire_ex2_inst_chgflw;  
wire            dp_retire_ex2_inst_dret;    
wire            dp_retire_ex2_inst_ebreak;  
wire            dp_retire_ex2_inst_expt;    
wire            dp_retire_ex2_inst_flush;   
wire            dp_retire_ex2_inst_mret;    
wire            dp_retire_ex2_inst_split;   
wire            dp_retire_ex2_inst_sret;    
wire            dp_retire_ex2_inst_vstart;  
wire    [39:0]  dp_retire_ex2_next_pc;      
wire    [39:0]  dp_retire_ex2_tval;         
wire    [4 :0]  dp_retire_ex2_vec;          
wire            dp_retire_ex2_vs_dirty;     
wire    [6 :0]  dp_retire_ex2_vstart;       
wire    [2 :0]  dp_top_dbg_info;            
wire            dp_trap_clk;                
wire            dp_trap_clk_en;             
wire            forever_cpuclk;             
wire            ifu_rtu_warm_up;            
wire            iu_rtu_depd_lsu_chgflow_vld; 
wire    [39:0]  iu_rtu_depd_lsu_next_pc;    
wire            iu_rtu_ex1_alu_cmplt_dp;    
wire            iu_rtu_ex1_alu_inst_len;    
wire            iu_rtu_ex1_alu_inst_split;  
wire            iu_rtu_ex1_bju_cmplt_dp;    
wire            iu_rtu_ex1_bju_inst_len;    
wire            iu_rtu_ex1_branch_inst;     
wire    [39:0]  iu_rtu_ex1_cur_pc;          
wire            iu_rtu_ex1_div_cmplt_dp;    
wire            iu_rtu_ex1_mul_cmplt_dp;    
wire    [39:0]  iu_rtu_ex1_next_pc;         
wire            lsu_rtu_ex1_cmplt_dp;       
wire    [39:0]  lsu_rtu_ex1_expt_tval;      
wire    [4 :0]  lsu_rtu_ex1_expt_vec;       
wire            lsu_rtu_ex1_expt_vld;       
wire            lsu_rtu_ex1_fs_dirty;       
wire    [21:0]  lsu_rtu_ex1_halt_info;      
wire            lsu_rtu_ex1_inst_len;       
wire            lsu_rtu_ex1_inst_split;     
wire            lsu_rtu_ex1_tval2_vld;      
wire            lsu_rtu_ex1_vs_dirty;       
wire    [6 :0]  lsu_rtu_ex1_vstart;         
wire            lsu_rtu_ex1_vstart_vld;     
wire    [39:0]  lsu_rtu_ex2_tval2;          
wire            pad_yy_icg_scan_en;         
wire            rtu_iu_ex1_inst_len;        
wire            rtu_iu_ex1_inst_split;      
wire    [39:0]  rtu_iu_ex2_cur_pc;          
wire    [39:0]  rtu_iu_ex2_next_pc;         
wire            vpu_rtu_ex1_cmplt_dp;       


//==========================================================
//                        Inst Info
//==========================================================
assign dp_ex1_alu_cmplt_dp = iu_rtu_ex1_alu_cmplt_dp || ifu_rtu_warm_up;
assign dp_ex1_mul_cmplt_dp = iu_rtu_ex1_mul_cmplt_dp;
assign dp_ex1_bju_cmplt_dp = iu_rtu_ex1_bju_cmplt_dp;
assign dp_ex1_div_cmplt_dp = iu_rtu_ex1_div_cmplt_dp;
assign dp_ex1_lsu_cmplt_dp = lsu_rtu_ex1_cmplt_dp;
assign dp_ex1_cp0_cmplt_dp = cp0_rtu_ex1_cmplt_dp;
assign dp_ex1_vec_cmplt_dp = vpu_rtu_ex1_cmplt_dp;

parameter CBUS_ALU_SEL = 7'b100_0000;
parameter CBUS_MUL_SEL = 7'b010_0000;
parameter CBUS_BJU_SEL = 7'b001_0000;
parameter CBUS_DIV_SEL = 7'b000_1000;
parameter CBUS_LSU_SEL = 7'b000_0100;
parameter CBUS_CP0_SEL = 7'b000_0010;
parameter CBUS_VEC_SEL = 7'b000_0001;

assign dp_cmplt_source[6:0] = {dp_ex1_alu_cmplt_dp,
                               dp_ex1_mul_cmplt_dp,
                               dp_ex1_bju_cmplt_dp,
                               dp_ex1_div_cmplt_dp,
                               dp_ex1_lsu_cmplt_dp,
                               dp_ex1_cp0_cmplt_dp,
                               dp_ex1_vec_cmplt_dp};
assign dp_ex1_cmplt_dp = |dp_cmplt_source[6:0];
// TODO add assertion here: cmplt_dp is onehot.

//----------------------------------------------------------
//                            PC
//----------------------------------------------------------
assign dp_ex1_cur_pc[`PA_WIDTH-1:0]  = iu_rtu_ex1_cur_pc[`PA_WIDTH-1:0];
assign dp_ex1_next_pc[`PA_WIDTH-1:0] = dp_ex1_inst_chgflw ? dp_ex1_cp0_chgflw_pc[`PA_WIDTH-1:0]
                                                          : iu_rtu_ex1_next_pc[`PA_WIDTH-1:0];

//----------------------------------------------------------
//                           MISC
//----------------------------------------------------------
// &CombBeg; @70
always @( iu_rtu_ex1_bju_inst_len
       or cp0_rtu_ex1_inst_split
       or iu_rtu_ex1_alu_inst_split
       or lsu_rtu_ex1_inst_len
       or cp0_rtu_ex1_inst_len
       or lsu_rtu_ex1_inst_split
       or dp_cmplt_source[6:0]
       or iu_rtu_ex1_alu_inst_len)
begin
case(dp_cmplt_source[6:0])
  CBUS_ALU_SEL: begin
    dp_ex1_inst_len   = iu_rtu_ex1_alu_inst_len;
    dp_ex1_inst_split = iu_rtu_ex1_alu_inst_split;
  end
  CBUS_MUL_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = 1'b0;
  end
  CBUS_BJU_SEL: begin
    dp_ex1_inst_len   = iu_rtu_ex1_bju_inst_len;
    dp_ex1_inst_split = 1'b0;
  end
  CBUS_DIV_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = 1'b0;
  end
  CBUS_LSU_SEL: begin
    dp_ex1_inst_len   = lsu_rtu_ex1_inst_len;
    dp_ex1_inst_split = lsu_rtu_ex1_inst_split;
  end
  CBUS_CP0_SEL: begin
    dp_ex1_inst_len   = cp0_rtu_ex1_inst_len;
    dp_ex1_inst_split = cp0_rtu_ex1_inst_split;
  end
  CBUS_VEC_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = 1'b0;
  end
  default: begin
    dp_ex1_inst_len   = 1'bx;
    dp_ex1_inst_split = 1'bx;
  end
endcase
// &CombEnd; @105
end

assign dp_ex1_inst_branch = dp_ex1_bju_cmplt_dp && iu_rtu_ex1_branch_inst;
assign dp_ex1_inst_mret   = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_inst_mret;
assign dp_ex1_inst_sret   = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_inst_sret;
assign dp_ex1_inst_flush  = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_flush;

//----------------------------------------------------------
//                        Changeflow
//----------------------------------------------------------
assign dp_ex1_inst_chgflw = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_chgflw;
assign dp_ex1_cp0_chgflw_pc[`PA_WIDTH-1:0] = cp0_rtu_ex1_chgflw_pc[`PA_WIDTH-1:0];

//----------------------------------------------------------
//                          Debug
//----------------------------------------------------------
assign dp_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] = 
    {`TDT_HINFO_WIDTH{lsu_rtu_ex1_cmplt_dp}} & lsu_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0]
  | {`TDT_HINFO_WIDTH{cp0_rtu_ex1_cmplt_dp}} & cp0_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];

assign dp_ex1_inst_ebreak = cp0_rtu_ex1_cmplt_dp && cp0_rtu_ex1_inst_ebreak;
assign dp_ex1_inst_dret   = cp0_rtu_ex1_cmplt_dp && cp0_rtu_ex1_inst_dret;

//----------------------------------------------------------
//                           Trap
//----------------------------------------------------------
assign dp_ex1_inst_expt     = cp0_rtu_ex1_expt_vld
                           || lsu_rtu_ex1_expt_vld && lsu_rtu_ex1_cmplt_dp;
assign dp_ex1_tval2_vld     = lsu_rtu_ex1_tval2_vld && lsu_rtu_ex1_cmplt_dp;
assign dp_ex1_expt_vec[4:0] = cp0_rtu_ex1_cmplt_dp ? cp0_rtu_ex1_expt_vec[4:0]
                                                   : lsu_rtu_ex1_expt_vec[4:0];
assign dp_ex1_tval[`PA_WIDTH-1:0] = cp0_rtu_ex1_cmplt_dp ? cp0_rtu_ex1_expt_tval[`PA_WIDTH-1:0]
                                                         : lsu_rtu_ex1_expt_tval[`PA_WIDTH-1:0];

//----------------------------------------------------------
//                          VSTART
//----------------------------------------------------------
assign dp_ex1_inst_vstart = dp_ex1_lsu_cmplt_dp && lsu_rtu_ex1_vstart_vld;
assign dp_ex1_vstart[6:0] = lsu_rtu_ex1_vstart[6:0];

//----------------------------------------------------------
//                       FS VS DIRTY
//----------------------------------------------------------
assign dp_ex1_fs_dirty = dp_ex1_lsu_cmplt_dp && lsu_rtu_ex1_fs_dirty;
assign dp_ex1_vs_dirty = dp_ex1_lsu_cmplt_dp && lsu_rtu_ex1_vs_dirty;

//==========================================================
//                         Pipedown
//==========================================================
assign dp_ex1_cmplt = ctrl_dp_ex1_cmplt_dp;

always @ (posedge dp_misc_clk)
begin
  if (dp_ex1_cmplt || ifu_rtu_warm_up) begin
    dp_ex2_inst_split             <= dp_ex1_inst_split;
    dp_ex2_inst_branch            <= dp_ex1_inst_branch;
    dp_ex2_inst_mret              <= dp_ex1_inst_mret;
    dp_ex2_inst_sret              <= dp_ex1_inst_sret;
    dp_ex2_inst_flush             <= dp_ex1_inst_flush;
    dp_ex2_inst_chgflw            <= dp_ex1_inst_chgflw;
    dp_ex2_halt_info[`TDT_HINFO_WIDTH-1:0]
                                  <= dp_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];
    dp_ex2_inst_ebreak            <= dp_ex1_inst_ebreak;
    dp_ex2_inst_dret              <= dp_ex1_inst_dret;
    dp_ex2_inst_expt              <= dp_ex1_inst_expt;
    dp_ex2_cur_pc[`PA_WIDTH-1:0]  <= dp_ex1_cur_pc[`PA_WIDTH-1:0];
    dp_ex2_next_pc[`PA_WIDTH-1:0] <= dp_ex1_next_pc[`PA_WIDTH-1:0];
    dp_ex2_inst_vstart            <= dp_ex1_inst_vstart;
    dp_ex2_fs_dirty               <= dp_ex1_fs_dirty;
    dp_ex2_vs_dirty               <= dp_ex1_vs_dirty;
  end
end

// inst_expt timing is bad. use lsu_cmplt_dp instead.
// so trap_clk can also use for lsu info.
assign dp_ex1_trap_updt = cp0_rtu_ex1_cmplt_dp
                       || lsu_rtu_ex1_cmplt_dp;
always @ (posedge dp_trap_clk)
begin
  if (dp_ex1_cmplt && dp_ex1_trap_updt || ifu_rtu_warm_up) begin
    // lsu info
    dp_ex2_vstart[6:0]            <= dp_ex1_vstart[6:0];
    // trap info
    dp_ex2_tval2_vld           <= dp_ex1_tval2_vld;
    dp_ex2_expt_vec[4:0]       <= dp_ex1_expt_vec[4:0];
    dp_ex2_tval[`PA_WIDTH-1:0] <= dp_ex1_tval[`PA_WIDTH-1:0];
  end
end

//==========================================================
//                           ICG
//==========================================================
assign dp_trap_clk_en = dp_ex1_cmplt && dp_ex1_trap_updt
                     || ifu_rtu_warm_up;
// &Instance("gated_clk_cell", "x_dp_trap_clk"); @199
gated_clk_cell  x_dp_trap_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_trap_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_trap_clk_en    ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @200
//          .external_en (1'b0), @201
//          .global_en   (cp0_yy_clk_en), @202
//          .module_en   (cp0_rtu_icg_en), @203
//          .local_en    (dp_trap_clk_en), @204
//          .clk_out     (dp_trap_clk)); @205

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign dp_ctrl_ex1_cmplt_dp = dp_ex1_cmplt_dp;

assign dp_int_ex2_inst_split = dp_ex2_inst_split;

assign dp_retire_ex2_inst_split             = dp_ex2_inst_split;
assign dp_retire_ex2_inst_branch            = dp_ex2_inst_branch;
assign dp_retire_ex2_inst_mret              = dp_ex2_inst_mret;
assign dp_retire_ex2_inst_sret              = dp_ex2_inst_sret;
assign dp_retire_ex2_inst_flush             = dp_ex2_inst_flush;
assign dp_retire_ex2_inst_chgflw            = dp_ex2_inst_chgflw;
assign dp_retire_ex2_halt_info[`TDT_HINFO_WIDTH-1:0]
                                            = dp_ex2_halt_info[`TDT_HINFO_WIDTH-1:0];
assign dp_retire_ex2_inst_ebreak            = dp_ex2_inst_ebreak;
assign dp_retire_ex2_inst_dret              = dp_ex2_inst_dret;
assign dp_retire_ex2_inst_expt              = dp_ex2_inst_expt;
assign dp_retire_ex2_cur_pc[`PA_WIDTH-1:0]  = dp_ex2_cur_pc[`PA_WIDTH-1:0];
assign dp_retire_ex2_next_pc[`PA_WIDTH-1:0] = iu_rtu_depd_lsu_chgflow_vld ?
                                                      iu_rtu_depd_lsu_next_pc[`PA_WIDTH-1:0]
                                                    : dp_ex2_next_pc[`PA_WIDTH-1:0];
assign dp_retire_ex2_vec[4:0]               = dp_ex2_expt_vec[4:0];
assign dp_retire_ex2_tval[`PA_WIDTH-1:0]    = dp_ex2_tval2_vld ? lsu_rtu_ex2_tval2[`PA_WIDTH-1:0]
                                                               : dp_ex2_tval[`PA_WIDTH-1:0];

assign dp_retire_ex2_inst_vstart            = dp_ex2_inst_vstart;
assign dp_retire_ex2_vstart[6:0]            = dp_ex2_vstart[6:0];

assign dp_retire_ex2_fs_dirty               = dp_ex2_fs_dirty;
assign dp_retire_ex2_vs_dirty               = dp_ex2_vs_dirty;

assign dp_top_dbg_info[2:0] = {dp_ex2_inst_expt,
                               dp_ex2_inst_chgflw,
                               dp_ex2_inst_flush};

//----------------------------------------------------------
//                          For IU
//----------------------------------------------------------
assign rtu_iu_ex1_inst_split    = dp_ex1_inst_split;
assign rtu_iu_ex1_inst_len      = dp_ex1_inst_len;
assign rtu_iu_ex2_cur_pc[39:0]  = dp_ex2_cur_pc[39:0];
assign rtu_iu_ex2_next_pc[39:0] = dp_ex2_next_pc[39:0];


// &ModuleEnd; @265
endmodule



