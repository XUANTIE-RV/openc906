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
// &ModuleBeg; @24
module aq_ifu_pred(
  bht_top_cur_st,
  btb_pred_tar_pc,
  btb_pred_tar_vld,
  cp0_ifu_bht_en,
  cp0_ifu_bht_inv,
  cp0_ifu_icg_en,
  cp0_ifu_ras_en,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_ifu_halt_info0,
  dtu_ifu_halt_info1,
  forever_cpuclk,
  ibuf_ipack_stall,
  ibuf_pred_hungry,
  ibuf_pred_stall,
  icache_pred_inst_vld,
  icache_pred_inst_vld_gate,
  ifu_cp0_bht_inv_done,
  ifu_dtu_addr_vld0,
  ifu_dtu_addr_vld1,
  ifu_dtu_data_vld0,
  ifu_dtu_data_vld1,
  ifu_dtu_exe_addr0,
  ifu_dtu_exe_addr1,
  ifu_dtu_exe_data0,
  ifu_dtu_exe_data1,
  ifu_iu_ex1_pc_pred,
  ipack_pred_h0_create,
  ipack_pred_h0_vld,
  ipack_pred_inst0,
  ipack_pred_inst0_expt,
  ipack_pred_inst0_vld,
  ipack_pred_inst1,
  ipack_pred_inst1_expt,
  ipack_pred_inst1_vld,
  ipack_pred_unalign,
  iu_ifu_bht_cur_pc,
  iu_ifu_bht_mispred,
  iu_ifu_bht_mispred_gate,
  iu_ifu_bht_pred,
  iu_ifu_bht_taken,
  iu_ifu_br_vld,
  iu_ifu_br_vld_gate,
  iu_ifu_link_vld,
  iu_ifu_link_vld_gate,
  iu_ifu_pc_mispred,
  iu_ifu_pc_mispred_gate,
  iu_ifu_ret_vld,
  iu_ifu_ret_vld_gate,
  pad_yy_icg_scan_en,
  pcgen_pred_flush_vld,
  pcgen_pred_ifpc,
  pred_btb_chgflw_vld,
  pred_btb_cur_pc,
  pred_btb_inst_vld,
  pred_btb_mis_pred,
  pred_btb_mis_predg,
  pred_btb_stall,
  pred_btb_tar_pc,
  pred_btb_upd_vld,
  pred_btb_upd_vldg,
  pred_ctrl_stall,
  pred_ibuf_br_taken0,
  pred_ibuf_br_taken1,
  pred_ibuf_chgflw_vld0,
  pred_ibuf_halt_info0,
  pred_ibuf_halt_info1,
  pred_ipack_chgflw_vld0,
  pred_ipack_delay_stall,
  pred_ipack_mask,
  pred_ipack_ret_stall,
  pred_pcgen_chgflw_pc,
  pred_pcgen_chgflw_vld,
  pred_pcgen_chgflw_vld_gate,
  pred_pcgen_curflw_pc,
  pred_pcgen_curflw_vld,
  pred_pcgen_curflw_vld_gate,
  pred_top_delay_chgflw,
  pred_top_ras_st,
  rtu_ifu_flush_fe
);

// &Ports; @25
input   [39:0]  btb_pred_tar_pc;           
input           btb_pred_tar_vld;          
input           cp0_ifu_bht_en;            
input           cp0_ifu_bht_inv;           
input           cp0_ifu_icg_en;            
input           cp0_ifu_ras_en;            
input           cp0_yy_clk_en;             
input           cpurst_b;                  
input   [21:0]  dtu_ifu_halt_info0;        
input   [21:0]  dtu_ifu_halt_info1;        
input           forever_cpuclk;            
input           ibuf_ipack_stall;          
input           ibuf_pred_hungry;          
input           ibuf_pred_stall;           
input           icache_pred_inst_vld;      
input           icache_pred_inst_vld_gate; 
input           ipack_pred_h0_create;      
input           ipack_pred_h0_vld;         
input   [31:0]  ipack_pred_inst0;          
input           ipack_pred_inst0_expt;     
input           ipack_pred_inst0_vld;      
input   [15:0]  ipack_pred_inst1;          
input           ipack_pred_inst1_expt;     
input           ipack_pred_inst1_vld;      
input           ipack_pred_unalign;        
input   [39:0]  iu_ifu_bht_cur_pc;         
input           iu_ifu_bht_mispred;        
input           iu_ifu_bht_mispred_gate;   
input   [1 :0]  iu_ifu_bht_pred;           
input           iu_ifu_bht_taken;          
input           iu_ifu_br_vld;             
input           iu_ifu_br_vld_gate;        
input           iu_ifu_link_vld;           
input           iu_ifu_link_vld_gate;      
input           iu_ifu_pc_mispred;         
input           iu_ifu_pc_mispred_gate;    
input           iu_ifu_ret_vld;            
input           iu_ifu_ret_vld_gate;       
input           pad_yy_icg_scan_en;        
input           pcgen_pred_flush_vld;      
input   [39:0]  pcgen_pred_ifpc;           
input           rtu_ifu_flush_fe;          
output  [1 :0]  bht_top_cur_st;            
output          ifu_cp0_bht_inv_done;      
output          ifu_dtu_addr_vld0;         
output          ifu_dtu_addr_vld1;         
output          ifu_dtu_data_vld0;         
output          ifu_dtu_data_vld1;         
output  [39:0]  ifu_dtu_exe_addr0;         
output  [39:0]  ifu_dtu_exe_addr1;         
output  [31:0]  ifu_dtu_exe_data0;         
output  [31:0]  ifu_dtu_exe_data1;         
output  [39:0]  ifu_iu_ex1_pc_pred;        
output          pred_btb_chgflw_vld;       
output  [39:0]  pred_btb_cur_pc;           
output          pred_btb_inst_vld;         
output          pred_btb_mis_pred;         
output          pred_btb_mis_predg;        
output          pred_btb_stall;            
output  [39:0]  pred_btb_tar_pc;           
output          pred_btb_upd_vld;          
output          pred_btb_upd_vldg;         
output          pred_ctrl_stall;           
output  [1 :0]  pred_ibuf_br_taken0;       
output  [1 :0]  pred_ibuf_br_taken1;       
output          pred_ibuf_chgflw_vld0;     
output  [21:0]  pred_ibuf_halt_info0;      
output  [21:0]  pred_ibuf_halt_info1;      
output          pred_ipack_chgflw_vld0;    
output          pred_ipack_delay_stall;    
output          pred_ipack_mask;           
output          pred_ipack_ret_stall;      
output  [39:0]  pred_pcgen_chgflw_pc;      
output          pred_pcgen_chgflw_vld;     
output          pred_pcgen_chgflw_vld_gate; 
output  [39:0]  pred_pcgen_curflw_pc;      
output          pred_pcgen_curflw_vld;     
output          pred_pcgen_curflw_vld_gate; 
output          pred_top_delay_chgflw;     
output          pred_top_ras_st;           

// &Regs; @26
reg     [39:0]  chgflw_pc_ff;              
reg             delay_chgflw;              
reg             h0_br_vld;                 
reg     [39:0]  pred_cur_pc;               
reg     [39:0]  pred_h0_pc;                
reg     [39:0]  pred_idpc;                 
reg             ras_cur_st;                
reg             ras_nxt_st;                
reg     [39:0]  ras_pred_pc;               

// &Wires; @27
wire            bht_pred_mem_taken;        
wire    [1 :0]  bht_pred_rslt;             
wire    [1 :0]  bht_top_cur_st;            
wire            btb_mis_pred;              
wire    [39:0]  btb_pred_tar_pc;           
wire            btb_pred_tar_vld;          
wire            cp0_ifu_bht_en;            
wire            cp0_ifu_bht_inv;           
wire            cp0_ifu_icg_en;            
wire            cp0_ifu_ras_en;            
wire            cp0_yy_clk_en;             
wire            cpurst_b;                  
wire    [39:0]  delay_tar;                 
wire    [21:0]  dtu_ifu_halt_info0;        
wire    [21:0]  dtu_ifu_halt_info1;        
wire            forever_cpuclk;            
wire            ibuf_ipack_stall;          
wire            ibuf_pred_hungry;          
wire            ibuf_pred_stall;           
wire            icache_pred_inst_vld;      
wire            icache_pred_inst_vld_gate; 
wire            id_ras_clk;                
wire            id_ras_icg_en;             
wire            idpc_icg_en;               
wire            ifu_cp0_bht_inv_done;      
wire            ifu_dtu_addr_vld0;         
wire            ifu_dtu_addr_vld1;         
wire            ifu_dtu_data_vld0;         
wire            ifu_dtu_data_vld1;         
wire    [39:0]  ifu_dtu_exe_addr0;         
wire    [39:0]  ifu_dtu_exe_addr1;         
wire    [31:0]  ifu_dtu_exe_data0;         
wire    [31:0]  ifu_dtu_exe_data1;         
wire    [39:0]  ifu_iu_ex1_pc_pred;        
wire            ipack_pred_h0_create;      
wire            ipack_pred_h0_vld;         
wire    [31:0]  ipack_pred_inst0;          
wire            ipack_pred_inst0_expt;     
wire            ipack_pred_inst0_vld;      
wire    [15:0]  ipack_pred_inst1;          
wire            ipack_pred_inst1_expt;     
wire            ipack_pred_inst1_vld;      
wire            ipack_pred_unalign;        
wire    [39:0]  iu_ifu_bht_cur_pc;         
wire            iu_ifu_bht_mispred;        
wire            iu_ifu_bht_mispred_gate;   
wire    [1 :0]  iu_ifu_bht_pred;           
wire            iu_ifu_bht_taken;          
wire            iu_ifu_br_vld;             
wire            iu_ifu_br_vld_gate;        
wire            iu_ifu_link_vld;           
wire            iu_ifu_link_vld_gate;      
wire            iu_ifu_pc_mispred;         
wire            iu_ifu_pc_mispred_gate;    
wire            iu_ifu_ret_vld;            
wire            iu_ifu_ret_vld_gate;       
wire            pad_yy_icg_scan_en;        
wire            pcgen_pred_flush_vld;      
wire    [39:0]  pcgen_pred_ifpc;           
wire            pred_bht_br_vld;           
wire    [2 :0]  pred_bht_pc;               
wire    [39:0]  pred_br_imm;               
wire    [1 :0]  pred_br_rslt0;             
wire    [1 :0]  pred_br_rslt1;             
wire            pred_br_taken;             
wire            pred_br_taken0;            
wire            pred_br_taken1;            
wire    [39:0]  pred_br_tar;               
wire            pred_br_vld0;              
wire            pred_br_vld1;              
wire            pred_br_vld1_raw;          
wire            pred_btb_chgflw_vld;       
wire    [39:0]  pred_btb_cur_pc;           
wire            pred_btb_inst_vld;         
wire            pred_btb_mis_pred;         
wire            pred_btb_mis_predg;        
wire            pred_btb_stall;            
wire    [39:0]  pred_btb_tar_pc;           
wire            pred_btb_upd_vld;          
wire            pred_btb_upd_vldg;         
wire            pred_chgflw;               
wire            pred_chgflw_fin;           
wire    [39:0]  pred_chgflw_fin_tar;       
wire            pred_chgflw_vld0;          
wire            pred_clk;                  
wire            pred_ctrl_stall;           
wire            pred_curflw;               
wire            pred_delay_br;             
wire            pred_delay_br1_taken;      
wire            pred_delay_br_raw;         
wire            pred_delay_reissue;        
wire            pred_delay_taken;          
wire    [1 :0]  pred_ibuf_br_taken0;       
wire    [1 :0]  pred_ibuf_br_taken1;       
wire            pred_ibuf_chgflw_vld0;     
wire    [21:0]  pred_ibuf_halt_info0;      
wire    [21:0]  pred_ibuf_halt_info1;      
wire            pred_icg_en;               
wire            pred_id_stall;             
wire            pred_idpc_clk;             
wire    [39:0]  pred_imm0;                 
wire    [39:0]  pred_imm1;                 
wire            pred_inst0_32;             
wire            pred_inst0_bjtype;         
wire    [39:0]  pred_inst0_bkpt_pc;        
wire            pred_inst0_taken;          
wire            pred_inst1_bjtype;         
wire    [39:0]  pred_inst1_bkpt_pc;        
wire            pred_inst1_taken;          
wire            pred_ipack_chgflw_vld0;    
wire            pred_ipack_delay_stall;    
wire            pred_ipack_mask;           
wire            pred_ipack_ret_stall;      
wire            pred_jmp_vld0;             
wire            pred_jmp_vld1;             
wire            pred_link_vld0;            
wire            pred_link_vld1;            
wire    [39:0]  pred_nxt_offset;           
wire    [39:0]  pred_nxt_pc;               
wire    [39:0]  pred_pcgen_chgflw_pc;      
wire            pred_pcgen_chgflw_vld;     
wire            pred_pcgen_chgflw_vld_gate; 
wire    [39:0]  pred_pcgen_curflw_pc;      
wire            pred_pcgen_curflw_vld;     
wire            pred_pcgen_curflw_vld_gate; 
wire    [23:0]  pred_ras_link_pc;          
wire            pred_ras_link_vld;         
wire            pred_ras_link_vld0;        
wire            pred_ras_link_vld1;        
wire            pred_ras_ret_chgflw;       
wire            pred_ras_ret_vld;          
wire            pred_ras_ret_vld0;         
wire            pred_ras_ret_vld1;         
wire    [39:0]  pred_ras_tar;              
wire            pred_ret_stall;            
wire            pred_ret_vld0;             
wire            pred_ret_vld1;             
wire    [39:0]  pred_tar;                  
wire            pred_top_delay_chgflw;     
wire            pred_top_ras_st;           
wire            ras_cur_idle;              
wire    [23:0]  ras_link_offset;           
wire    [23:0]  ras_pred_tar_pc;           
wire            rtu_ifu_flush_fe;          


//==========================================================
// ID Stage Predication Module
// 1. Instance ICG Cell
// 2. ID Pre-decode for prediction
// 3. Current PC Generation
// 4. Branch Taken Result
// 5. RAS Target Result
// 6. ID Prediction Address Generation
// 7. Inst bkpt judgement
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign pred_icg_en = ipack_pred_h0_create || h0_br_vld
                  || pred_br_vld0 || delay_chgflw;

// &Instance("gated_clk_cell", "x_aq_ifu_pred_icg_cell"); @46
gated_clk_cell  x_aq_ifu_pred_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pred_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (pred_icg_en       ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @47
//          .external_en (1'b0), @48
//          .global_en   (cp0_yy_clk_en), @49
//          .module_en   (cp0_ifu_icg_en), @50
//          .local_en    (pred_icg_en), @51
//          .clk_out     (pred_clk)  @52
// ); @53

assign id_ras_icg_en = pred_ras_ret_vld
                    || !ras_cur_idle;
// &Instance("gated_clk_cell", "x_aq_ifu_id_ras_icg_cell"); @57
gated_clk_cell  x_aq_ifu_id_ras_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (id_ras_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (id_ras_icg_en     ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @58
//          .external_en (1'b0), @59
//          .global_en   (cp0_yy_clk_en), @60
//          .module_en   (cp0_ifu_icg_en), @61
//          .local_en    (id_ras_icg_en), @62
//          .clk_out     (id_ras_clk)  @63
// ); @64

assign idpc_icg_en = icache_pred_inst_vld_gate || pred_delay_br_raw;
// &Instance("gated_clk_cell", "x_ifu_pred_idpc_icg_cell"); @67
gated_clk_cell  x_ifu_pred_idpc_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pred_idpc_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (idpc_icg_en       ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @68
//          .external_en (1'b0), @69
//          .global_en   (cp0_yy_clk_en), @70
//          .module_en   (cp0_ifu_icg_en), @71
//          .local_en    (idpc_icg_en), @72
//          .clk_out     (pred_idpc_clk) @73
//        ); @74
//------------------------------------------------
// 2. ID Pre-decode for prediction
//------------------------------------------------
// &Instance("aq_ifu_pre_decd", "x_aq_ifu_pre_decd"); @78
aq_ifu_pre_decd  x_aq_ifu_pre_decd (
  .ipack_pred_inst0     (ipack_pred_inst0    ),
  .ipack_pred_inst0_vld (ipack_pred_inst0_vld),
  .ipack_pred_inst1     (ipack_pred_inst1    ),
  .ipack_pred_inst1_vld (ipack_pred_inst1_vld),
  .pred_br_vld0         (pred_br_vld0        ),
  .pred_br_vld1         (pred_br_vld1        ),
  .pred_br_vld1_raw     (pred_br_vld1_raw    ),
  .pred_imm0            (pred_imm0           ),
  .pred_imm1            (pred_imm1           ),
  .pred_inst0_32        (pred_inst0_32       ),
  .pred_jmp_vld0        (pred_jmp_vld0       ),
  .pred_jmp_vld1        (pred_jmp_vld1       ),
  .pred_link_vld0       (pred_link_vld0      ),
  .pred_link_vld1       (pred_link_vld1      ),
  .pred_ret_vld0        (pred_ret_vld0       ),
  .pred_ret_vld1        (pred_ret_vld1       )
);


//------------------------------------------------
// 3. Current PC Generation
//------------------------------------------------
always @ (posedge pred_idpc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pred_idpc[39:0] <= 40'b0;
  else if(icache_pred_inst_vld && !pred_id_stall)
    pred_idpc[39:0] <= pcgen_pred_ifpc[39:0];
  else if(pred_delay_br)
    pred_idpc[39:0] <= {pred_idpc[39:2], 2'b10};
  else
    pred_idpc[39:0] <= pred_idpc[39:0];
end

always @ (posedge pred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pred_h0_pc[39:0] <= 40'b0;
  else if(ipack_pred_h0_create)
    pred_h0_pc[39:0] <= {pred_idpc[39:2], 2'b10};
  else
    pred_h0_pc[39:0] <= pred_h0_pc[39:0];
end

// &CombBeg; @105
always @( pred_h0_pc[39:0]
       or pred_idpc[39:0]
       or pred_ras_link_vld1
       or pred_delay_br_raw
       or pred_br_taken1
       or pred_br_taken0
       or ipack_pred_h0_vld)
begin
if(pred_br_taken0)
  if(ipack_pred_h0_vld)
    pred_cur_pc[39:0] = pred_h0_pc[39:0];
  else
    pred_cur_pc[39:0] = pred_idpc[39:0];
else if(pred_br_taken1 || pred_ras_link_vld1 || pred_delay_br_raw)
  pred_cur_pc[39:0] = {pred_idpc[39:2], 2'b10};
else
  pred_cur_pc[39:0] = pred_idpc[39:0];
// &CombEnd; @115
end

assign pred_nxt_offset[39:0] = (ipack_pred_unalign || pred_delay_br_raw) ? 40'h2 : 40'h4;
assign pred_nxt_pc[39:0] = pred_cur_pc[39:0] + pred_nxt_offset[39:0];

//------------------------------------------------
// 4. Branch Taken Result
// a. BHT Access Signal
// b. Instance BHT
// c. BHT Result
//------------------------------------------------
// a. BHT Access Signal
assign pred_bht_br_vld   = (pred_br_vld0 || pred_br_vld1)
                           && !ibuf_ipack_stall;

always @ (posedge pred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    h0_br_vld <= 1'b0;
  else if(pcgen_pred_flush_vld)
    h0_br_vld <= 1'b0;
  else if(ipack_pred_h0_create)
    h0_br_vld <= pred_br_vld1_raw;
  else if(h0_br_vld && !ibuf_ipack_stall)
    h0_br_vld <= 1'b0;
  else
    h0_br_vld <= h0_br_vld;
end

assign pred_bht_pc[2:0]  = h0_br_vld ? pred_h0_pc[3:1]
                        : (ipack_pred_unalign || !pred_br_vld0) ? {pred_idpc[3:2], 1'b1}
                        : pred_idpc[3:1];
                           
//assign pred_bht_mem_pc[2:0] = {pred_idpc[3:2], 1'b1};

// b. Instance BHT
// &Instance("aq_ifu_bht", "x_aq_ifu_bht"); @151
aq_ifu_bht  x_aq_ifu_bht (
  .bht_pred_mem_taken      (bht_pred_mem_taken     ),
  .bht_pred_rslt           (bht_pred_rslt          ),
  .bht_top_cur_st          (bht_top_cur_st         ),
  .cp0_ifu_bht_en          (cp0_ifu_bht_en         ),
  .cp0_ifu_bht_inv         (cp0_ifu_bht_inv        ),
  .cp0_ifu_icg_en          (cp0_ifu_icg_en         ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_cp0_bht_inv_done    (ifu_cp0_bht_inv_done   ),
  .iu_ifu_bht_cur_pc       (iu_ifu_bht_cur_pc      ),
  .iu_ifu_bht_mispred      (iu_ifu_bht_mispred     ),
  .iu_ifu_bht_mispred_gate (iu_ifu_bht_mispred_gate),
  .iu_ifu_bht_pred         (iu_ifu_bht_pred        ),
  .iu_ifu_bht_taken        (iu_ifu_bht_taken       ),
  .iu_ifu_br_vld           (iu_ifu_br_vld          ),
  .iu_ifu_br_vld_gate      (iu_ifu_br_vld_gate     ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pred_bht_br_vld         (pred_bht_br_vld        ),
  .pred_bht_pc             (pred_bht_pc            )
);


assign pred_delay_br_raw = pred_br_vld0 && !bht_pred_rslt[1]
                        && pred_br_vld1;
assign pred_delay_br = pred_delay_br_raw
                       && !ibuf_ipack_stall;
assign pred_delay_br1_taken = pred_br_vld0 && !bht_pred_rslt[1]
                       && pred_br_vld1 && bht_pred_mem_taken
                       && !ibuf_ipack_stall;
assign pred_delay_reissue = pred_br_vld0 && !bht_pred_rslt[1]
                         && pred_br_vld1 //&& ipack_pred_new_vld
                         && !ibuf_ipack_stall;
assign pred_delay_taken = pred_delay_br1_taken || pred_delay_reissue;

assign delay_tar[39:0] = pred_delay_br1_taken
                       ? pred_br_tar[39:0]
                       : pred_nxt_pc[39:0];

always @ (posedge pred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    delay_chgflw <= 1'b0;
  else if(pcgen_pred_flush_vld)
    delay_chgflw <= 1'b0;
  else if(pred_delay_taken)
    delay_chgflw <= 1'b1;
  else if(delay_chgflw && !ibuf_ipack_stall)
    delay_chgflw <= 1'b0;
  else
    delay_chgflw <= delay_chgflw;
end
always @ (posedge pred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    chgflw_pc_ff[39:0] <= 40'b0;
  else if(pred_delay_br)
    chgflw_pc_ff[39:0] <= delay_tar[39:0];
end

// c. BHT Result
// all branch and jump taken result
assign pred_inst0_bjtype = pred_br_vld0 || pred_jmp_vld0;
assign pred_inst1_bjtype = pred_br_vld1 || pred_jmp_vld1;
assign pred_inst0_taken  = pred_br_vld0 && bht_pred_rslt[1]
                           || pred_jmp_vld0;
assign pred_inst1_taken  = !pred_inst0_bjtype
                            && pred_br_vld1 && bht_pred_rslt[1]
                           || !pred_inst0_taken && pred_jmp_vld1;
assign pred_br_taken0    = pred_inst0_taken && !delay_chgflw;
assign pred_br_taken1    = pred_inst1_taken;
assign pred_br_taken     = pred_br_taken0 || pred_br_taken1;

assign pred_br_imm[39:0] = pred_inst0_taken ? pred_imm0[39:0]
                                            : pred_imm1[39:0];
assign pred_br_tar[39:0] = pred_cur_pc[39:0] + pred_br_imm[39:0];
assign pred_br_rslt0[1:0] = {2{pred_br_vld0}} & bht_pred_rslt[1:0];
assign pred_br_rslt1[1:0] = {2{pred_br_vld1 && !pred_inst0_bjtype}} & bht_pred_rslt[1:0];

//------------------------------------------------
// 5. RAS Target Result
// a. RAS Access Signal
// b. Instance RAS
// c. RAS Result
// d. RAS Stall FSM
//------------------------------------------------

// a. RAS Access Signal
assign pred_ras_link_vld0 = pred_link_vld0;
assign pred_ras_link_vld1 = pred_link_vld1 && !pred_inst0_taken;
assign pred_ras_link_vld  = (pred_ras_link_vld0 || pred_ras_link_vld1)
                            && cp0_ifu_ras_en
                            && !ibuf_ipack_stall;

assign pred_ras_ret_vld0  = pred_ret_vld0 && !delay_chgflw;
assign pred_ras_ret_vld1  = pred_ret_vld1 && !pred_inst0_taken;
//assign pred_ras_ret_req1  = pred_ret_vld1 && !pred_inst0_taken;
assign pred_ras_ret_chgflw = (pred_ras_ret_vld0 || pred_ras_ret_vld1);
//assign pred_ras_ret_req   = (pred_ras_ret_vld0 || pred_ras_ret_req1);

assign pred_ras_ret_vld = pred_ras_ret_chgflw && !ibuf_ipack_stall;

assign ras_link_offset[23:0] = pred_ras_link_vld0 && pred_inst0_32 
                             ? 24'h4 : 24'h2;

assign pred_ras_link_pc[23:0] = pred_cur_pc[23:0] + ras_link_offset[23:0];

// b. Instance RAS
// &Instance("aq_ifu_ras", "x_aq_ifu_ras"); @238
aq_ifu_ras  x_aq_ifu_ras (
  .cp0_ifu_icg_en          (cp0_ifu_icg_en         ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .iu_ifu_bht_mispred      (iu_ifu_bht_mispred     ),
  .iu_ifu_bht_mispred_gate (iu_ifu_bht_mispred_gate),
  .iu_ifu_link_vld         (iu_ifu_link_vld        ),
  .iu_ifu_link_vld_gate    (iu_ifu_link_vld_gate   ),
  .iu_ifu_pc_mispred       (iu_ifu_pc_mispred      ),
  .iu_ifu_pc_mispred_gate  (iu_ifu_pc_mispred_gate ),
  .iu_ifu_ret_vld          (iu_ifu_ret_vld         ),
  .iu_ifu_ret_vld_gate     (iu_ifu_ret_vld_gate    ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pred_ras_link_pc        (pred_ras_link_pc       ),
  .pred_ras_link_vld       (pred_ras_link_vld      ),
  .pred_ras_ret_vld        (pred_ras_ret_vld       ),
  .ras_cur_st              (ras_cur_st             ),
  .ras_pred_tar_pc         (ras_pred_tar_pc        ),
  .rtu_ifu_flush_fe        (rtu_ifu_flush_fe       )
);


// c. RAS Result
assign pred_ras_tar[39:0] = cp0_ifu_ras_en ? {pred_idpc[39:24], ras_pred_tar_pc[23:0]}
                                           : pred_idpc[39:0];

// d. RAS Stall FSM
parameter RAS_IDLE = 1'b0;
parameter RAS_WAIT = 1'b1;

always @ (posedge id_ras_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ras_cur_st <= RAS_IDLE;
  else if(pcgen_pred_flush_vld || rtu_ifu_flush_fe)
    ras_cur_st <= RAS_IDLE;
  else
    ras_cur_st <= ras_nxt_st;
end

// &CombBeg; @258
always @( iu_ifu_ret_vld
       or pred_ras_ret_vld
       or ras_cur_st)
begin
case(ras_cur_st)
  RAS_IDLE:
    if(pred_ras_ret_vld)
      ras_nxt_st = RAS_WAIT;
    else
      ras_nxt_st = RAS_IDLE;
  RAS_WAIT:
    if(iu_ifu_ret_vld)
      ras_nxt_st = RAS_IDLE;
    else
      ras_nxt_st = RAS_WAIT;
  default:
      ras_nxt_st = RAS_IDLE;
endcase
// &CombEnd; @273
end

assign ras_cur_idle   = ras_cur_st == RAS_IDLE;
assign pred_ret_stall = ras_cur_st == RAS_WAIT && pred_ras_ret_vld;

always @ (posedge id_ras_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ras_pred_pc[39:0] <= 40'b0;
  else if(pred_ras_ret_vld && ras_cur_st == RAS_IDLE)
    ras_pred_pc[39:0] <= pred_ras_tar[39:0];
  else
    ras_pred_pc[39:0] <= ras_pred_pc[39:0];
end

//------------------------------------------------
// 6. ID Prediction Address Generation
// a. ID Prediction Change Flow
// b. IF Miss-Prediction Judgement
//------------------------------------------------
assign pred_chgflw_vld0 = pred_br_taken0 || pred_ras_ret_vld0;
//assign pred_chgflw_vld1 = pred_br_taken1 || pred_ras_ret_req1;
//assign pred_chgflw_vld  = pred_chgflw_vld0 || pred_chgflw_vld1;
//assign pred_chgflw_tar[39:0] = pred_ras_ret_req ? pred_ras_tar[39:0]
//                                                : pred_br_tar[39:0];

// b. IF Miss-Prediction Judgement
assign btb_mis_pred = (pred_br_tar[39:0] 
                    != btb_pred_tar_pc[39:0]
                    || !pred_br_taken) && btb_pred_tar_vld
                      && ipack_pred_inst0_vld;

assign pred_chgflw  = btb_pred_tar_vld ? btb_mis_pred && !pred_delay_br_raw
                                       : pred_br_taken;
assign pred_tar[39:0] = pred_br_taken
                      ? pred_br_tar[39:0]
                      : pred_nxt_pc[39:0];

//assign pred_chgflw_fin   = pred_ras_ret_chgflw || pred_chgflw;
assign pred_chgflw_fin   = pred_chgflw && !pred_curflw //&& !ibuf_pred_stall
                        && !pred_ras_ret_vld1;

assign pred_chgflw_fin_tar[39:0] = pred_tar[39:0];

// chgflw in cur cycle
assign pred_curflw           = pred_ras_ret_chgflw
                            || delay_chgflw;// && !ibuf_pred_stall;

assign pred_id_stall     = pred_ret_stall || pred_delay_br || ibuf_pred_stall;

//------------------------------------------------
// 7. Inst bkpt judgement
//------------------------------------------------
assign pred_inst0_bkpt_pc[39:0] = ipack_pred_h0_vld ? pred_h0_pc[39:0]
                                : pred_idpc[39:0];
assign pred_inst1_bkpt_pc[39:0] = {pred_idpc[39:2], 2'b10};

assign ifu_dtu_addr_vld0  = ipack_pred_inst0_vld;
assign ifu_dtu_data_vld0  = ipack_pred_inst0_vld && !ipack_pred_inst0_expt;
assign ifu_dtu_exe_addr0[39:0] = pred_inst0_bkpt_pc[39:0];
assign ifu_dtu_exe_data0[31:0] = ipack_pred_inst0[31:0];

assign ifu_dtu_addr_vld1  = ipack_pred_inst1_vld;
assign ifu_dtu_data_vld1  = ipack_pred_inst1_vld && !ipack_pred_inst1_expt;
assign ifu_dtu_exe_addr1[39:0] = pred_inst1_bkpt_pc[39:0];
assign ifu_dtu_exe_data1[31:0] = {16'b0, ipack_pred_inst1[15:0]};


//==========================================================
// Rename for Output
//==========================================================

// Output to Ctrl
assign pred_ctrl_stall = pred_id_stall;

// Output to pcgen
assign pred_pcgen_chgflw_vld      = pred_chgflw_fin;
assign pred_pcgen_chgflw_vld_gate = btb_pred_tar_vld
                                 || pred_inst0_bjtype
                                 || pred_inst1_bjtype;
assign pred_pcgen_chgflw_pc[39:0] = pred_chgflw_fin_tar[39:0];
assign pred_pcgen_curflw_vld      = pred_curflw;
assign pred_pcgen_curflw_vld_gate = delay_chgflw || pred_ret_vld0 || pred_ret_vld1;
assign pred_pcgen_curflw_pc[39:0] = pred_ras_ret_chgflw ? pred_ras_tar[39:0]
                                                        : chgflw_pc_ff[39:0];

// Output to ipack
assign pred_ipack_chgflw_vld0 = pred_chgflw_vld0; 
assign pred_ipack_ret_stall   = pred_ret_stall;
assign pred_ipack_delay_stall = pred_delay_br_raw;
assign pred_ipack_mask        = pred_delay_br_raw;

// Output to ibuf
assign pred_ibuf_chgflw_vld0     = pred_chgflw_vld0;
assign pred_ibuf_br_taken0[1:0]  = pred_br_rslt0[1:0];
assign pred_ibuf_br_taken1[1:0]  = pred_br_rslt1[1:0];
assign pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0] = dtu_ifu_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0] = dtu_ifu_halt_info1[`TDT_HINFO_WIDTH-1:0];


// Output to btb
assign pred_btb_chgflw_vld   = pred_chgflw_fin;
assign pred_btb_upd_vld      = pred_br_taken && !btb_mis_pred 
                               && ibuf_pred_hungry;
assign pred_btb_upd_vldg     = pred_br_taken  
                               && ibuf_pred_hungry;
assign pred_btb_mis_pred     = btb_mis_pred;
assign pred_btb_mis_predg    = btb_pred_tar_vld
                             && (ipack_pred_inst0_vld
                                 || ipack_pred_inst1_vld);
assign pred_btb_inst_vld     = ipack_pred_inst0_vld;
assign pred_btb_cur_pc[39:0] = {ipack_pred_unalign ? pcgen_pred_ifpc[39:2] : pred_idpc[39:2], 2'b0};
assign pred_btb_tar_pc[39:0] = pred_br_tar[39:0];
assign pred_btb_stall        = pred_id_stall;

// Output to top
assign pred_top_delay_chgflw = delay_chgflw;
assign pred_top_ras_st       = ras_cur_st;

// Output to IU
assign ifu_iu_ex1_pc_pred[39:0] = ras_pred_pc[39:0];


// &ModuleEnd; @406
endmodule


