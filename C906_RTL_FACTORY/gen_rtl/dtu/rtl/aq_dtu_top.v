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
module aq_dtu_top(
  cp0_dtu_addr,
  cp0_dtu_debug_info,
  cp0_dtu_icg_en,
  cp0_dtu_mexpt_vld,
  cp0_dtu_pcfifo_frz,
  cp0_dtu_rreg,
  cp0_dtu_satp,
  cp0_dtu_wdata,
  cp0_dtu_wreg,
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  dtu_cp0_dcsr_mprven,
  dtu_cp0_dcsr_prv,
  dtu_cp0_rdata,
  dtu_cp0_wake_up,
  dtu_hpcp_dcsr_stopcount,
  dtu_ifu_debug_inst,
  dtu_ifu_debug_inst_vld,
  dtu_ifu_halt_info0,
  dtu_ifu_halt_info1,
  dtu_ifu_halt_info_vld,
  dtu_ifu_halt_on_reset,
  dtu_lsu_addr_trig_en,
  dtu_lsu_data_trig_en,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  dtu_rtu_async_halt_req,
  dtu_rtu_dpc,
  dtu_rtu_ebreak_action,
  dtu_rtu_int_mask,
  dtu_rtu_pending_tval,
  dtu_rtu_resume_req,
  dtu_rtu_step_en,
  dtu_rtu_sync_flush,
  dtu_rtu_sync_halt_req,
  dtu_tdt_dm_halted,
  dtu_tdt_dm_havereset,
  dtu_tdt_dm_itr_done,
  dtu_tdt_dm_retire_debug_expt_vld,
  dtu_tdt_dm_rx_data,
  dtu_tdt_dm_wr_ready,
  forever_cpuclk,
  idu_dtu_debug_info,
  ifu_dtu_addr_vld0,
  ifu_dtu_addr_vld1,
  ifu_dtu_data_vld0,
  ifu_dtu_data_vld1,
  ifu_dtu_debug_info,
  ifu_dtu_exe_addr0,
  ifu_dtu_exe_addr1,
  ifu_dtu_exe_data0,
  ifu_dtu_exe_data1,
  iu_dtu_debug_info,
  lsu_dtu_debug_info,
  lsu_dtu_halt_info,
  lsu_dtu_last_check,
  lsu_dtu_ldst_addr,
  lsu_dtu_ldst_addr_vld,
  lsu_dtu_ldst_bytes_vld,
  lsu_dtu_ldst_data,
  lsu_dtu_ldst_data_vld,
  lsu_dtu_ldst_type,
  lsu_dtu_mem_access_size,
  mmu_dtu_debug_info,
  pad_yy_icg_scan_en,
  rtu_dtu_debug_info,
  rtu_dtu_dpc,
  rtu_dtu_halt_ack,
  rtu_dtu_pending_ack,
  rtu_dtu_retire_chgflw,
  rtu_dtu_retire_debug_expt_vld,
  rtu_dtu_retire_halt_info,
  rtu_dtu_retire_mret,
  rtu_dtu_retire_next_pc,
  rtu_dtu_retire_sret,
  rtu_dtu_retire_vld,
  rtu_dtu_tval,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_int,
  rtu_yy_xx_expt_vec,
  rtu_yy_xx_expt_vld,
  sys_apb_clk,
  sys_apb_rst_b,
  tdt_dm_dtu_ack_havereset,
  tdt_dm_dtu_async_halt_req,
  tdt_dm_dtu_halt_on_reset,
  tdt_dm_dtu_halt_req,
  tdt_dm_dtu_itr,
  tdt_dm_dtu_itr_vld,
  tdt_dm_dtu_resume_req,
  tdt_dm_dtu_wdata,
  tdt_dm_dtu_wr_flg,
  tdt_dm_dtu_wr_vld,
  vidu_dtu_debug_info,
  vpu_dtu_dbg_info
);

// &Ports; @21
input   [11:0]  cp0_dtu_addr;                    
input   [5 :0]  cp0_dtu_debug_info;              
input           cp0_dtu_icg_en;                  
input           cp0_dtu_mexpt_vld;               
input           cp0_dtu_pcfifo_frz;              
input           cp0_dtu_rreg;                    
input   [63:0]  cp0_dtu_satp;                    
input   [63:0]  cp0_dtu_wdata;                   
input           cp0_dtu_wreg;                    
input           cp0_yy_clk_en;                   
input   [1 :0]  cp0_yy_priv_mode;                
input           cpurst_b;                        
input           forever_cpuclk;                  
input   [14:0]  idu_dtu_debug_info;              
input           ifu_dtu_addr_vld0;               
input           ifu_dtu_addr_vld1;               
input           ifu_dtu_data_vld0;               
input           ifu_dtu_data_vld1;               
input   [20:0]  ifu_dtu_debug_info;              
input   [39:0]  ifu_dtu_exe_addr0;               
input   [39:0]  ifu_dtu_exe_addr1;               
input   [31:0]  ifu_dtu_exe_data0;               
input   [31:0]  ifu_dtu_exe_data1;               
input   [8 :0]  iu_dtu_debug_info;               
input   [93:0]  lsu_dtu_debug_info;              
input   [21:0]  lsu_dtu_halt_info;               
input           lsu_dtu_last_check;              
input   [39:0]  lsu_dtu_ldst_addr;               
input           lsu_dtu_ldst_addr_vld;           
input   [15:0]  lsu_dtu_ldst_bytes_vld;          
input   [63:0]  lsu_dtu_ldst_data;               
input           lsu_dtu_ldst_data_vld;           
input   [1 :0]  lsu_dtu_ldst_type;               
input   [2 :0]  lsu_dtu_mem_access_size;         
input   [15:0]  mmu_dtu_debug_info;              
input           pad_yy_icg_scan_en;              
input   [14:0]  rtu_dtu_debug_info;              
input   [63:0]  rtu_dtu_dpc;                     
input           rtu_dtu_halt_ack;                
input           rtu_dtu_pending_ack;             
input           rtu_dtu_retire_chgflw;           
input           rtu_dtu_retire_debug_expt_vld;   
input   [21:0]  rtu_dtu_retire_halt_info;        
input           rtu_dtu_retire_mret;             
input   [39:0]  rtu_dtu_retire_next_pc;          
input           rtu_dtu_retire_sret;             
input           rtu_dtu_retire_vld;              
input   [63:0]  rtu_dtu_tval;                    
input           rtu_yy_xx_dbgon;                 
input           rtu_yy_xx_expt_int;              
input   [4 :0]  rtu_yy_xx_expt_vec;              
input           rtu_yy_xx_expt_vld;              
input           sys_apb_clk;                     
input           sys_apb_rst_b;                   
input           tdt_dm_dtu_ack_havereset;        
input           tdt_dm_dtu_async_halt_req;       
input           tdt_dm_dtu_halt_on_reset;        
input           tdt_dm_dtu_halt_req;             
input   [31:0]  tdt_dm_dtu_itr;                  
input           tdt_dm_dtu_itr_vld;              
input           tdt_dm_dtu_resume_req;           
input   [63:0]  tdt_dm_dtu_wdata;                
input   [1 :0]  tdt_dm_dtu_wr_flg;               
input           tdt_dm_dtu_wr_vld;               
input   [7 :0]  vidu_dtu_debug_info;             
input   [28:0]  vpu_dtu_dbg_info;                
output          dtu_cp0_dcsr_mprven;             
output  [1 :0]  dtu_cp0_dcsr_prv;                
output  [63:0]  dtu_cp0_rdata;                   
output          dtu_cp0_wake_up;                 
output          dtu_hpcp_dcsr_stopcount;         
output  [31:0]  dtu_ifu_debug_inst;              
output          dtu_ifu_debug_inst_vld;          
output  [21:0]  dtu_ifu_halt_info0;              
output  [21:0]  dtu_ifu_halt_info1;              
output          dtu_ifu_halt_info_vld;           
output          dtu_ifu_halt_on_reset;           
output          dtu_lsu_addr_trig_en;            
output          dtu_lsu_data_trig_en;            
output  [21:0]  dtu_lsu_halt_info;               
output          dtu_lsu_halt_info_vld;           
output          dtu_rtu_async_halt_req;          
output  [63:0]  dtu_rtu_dpc;                     
output          dtu_rtu_ebreak_action;           
output          dtu_rtu_int_mask;                
output  [63:0]  dtu_rtu_pending_tval;            
output          dtu_rtu_resume_req;              
output          dtu_rtu_step_en;                 
output          dtu_rtu_sync_flush;              
output          dtu_rtu_sync_halt_req;           
output          dtu_tdt_dm_halted;               
output          dtu_tdt_dm_havereset;            
output          dtu_tdt_dm_itr_done;             
output          dtu_tdt_dm_retire_debug_expt_vld; 
output  [63:0]  dtu_tdt_dm_rx_data;              
output          dtu_tdt_dm_wr_ready;             

// &Regs; @22

// &Wires; @23
wire            async_halt_req_wakeup;           
wire    [11:0]  cp0_dtu_addr;                    
wire    [5 :0]  cp0_dtu_debug_info;              
wire            cp0_dtu_icg_en;                  
wire            cp0_dtu_mexpt_vld;               
wire            cp0_dtu_pcfifo_frz;              
wire            cp0_dtu_rreg;                    
wire    [63:0]  cp0_dtu_satp;                    
wire    [63:0]  cp0_dtu_wdata;                   
wire            cp0_dtu_wreg;                    
wire            cp0_yy_clk_en;                   
wire    [1 :0]  cp0_yy_priv_mode;                
wire            cpurst_b;                        
wire            dcsr_mprven;                     
wire    [1 :0]  dcsr_prv;                        
wire            dcsr_step;                       
wire            dcsr_stopcount;                  
wire    [63:0]  dpc;                             
wire    [63:0]  dscratch0;                       
wire            dtu_cp0_dcsr_mprven;             
wire    [1 :0]  dtu_cp0_dcsr_prv;                
wire    [63:0]  dtu_cp0_rdata;                   
wire            dtu_cp0_wake_up;                 
wire            dtu_hpcp_dcsr_stopcount;         
wire    [31:0]  dtu_ifu_debug_inst;              
wire            dtu_ifu_debug_inst_vld;          
wire    [21:0]  dtu_ifu_halt_info0;              
wire    [21:0]  dtu_ifu_halt_info1;              
wire            dtu_ifu_halt_info_vld;           
wire            dtu_ifu_halt_on_reset;           
wire            dtu_lsu_addr_trig_en;            
wire            dtu_lsu_data_trig_en;            
wire    [21:0]  dtu_lsu_halt_info;               
wire            dtu_lsu_halt_info_vld;           
wire            dtu_rtu_async_halt_req;          
wire    [63:0]  dtu_rtu_dpc;                     
wire            dtu_rtu_ebreak_action;           
wire            dtu_rtu_int_mask;                
wire    [63:0]  dtu_rtu_pending_tval;            
wire            dtu_rtu_resume_req;              
wire            dtu_rtu_step_en;                 
wire            dtu_rtu_sync_flush;              
wire            dtu_rtu_sync_halt_req;           
wire            dtu_tdt_dm_halted;               
wire            dtu_tdt_dm_havereset;            
wire            dtu_tdt_dm_itr_done;             
wire            dtu_tdt_dm_retire_debug_expt_vld; 
wire    [63:0]  dtu_tdt_dm_rx_data;              
wire            dtu_tdt_dm_wr_ready;             
wire            ebreak_action;                   
wire            forever_cpuclk;                  
wire            icount_enable;                   
wire    [14:0]  idu_dtu_debug_info;              
wire            ifu_dtu_addr_vld0;               
wire            ifu_dtu_addr_vld1;               
wire            ifu_dtu_data_vld0;               
wire            ifu_dtu_data_vld1;               
wire    [20:0]  ifu_dtu_debug_info;              
wire    [39:0]  ifu_dtu_exe_addr0;               
wire    [39:0]  ifu_dtu_exe_addr1;               
wire    [31:0]  ifu_dtu_exe_data0;               
wire    [31:0]  ifu_dtu_exe_data1;               
wire            int_mask;                        
wire    [8 :0]  iu_dtu_debug_info;               
wire    [39:0]  latest_pc;                       
wire            ldst_addr_mcontrol;              
wire            ldst_data_mcontrol;              
wire            low_power_wakeup;                
wire    [93:0]  lsu_dtu_debug_info;              
wire    [21:0]  lsu_dtu_halt_info;               
wire            lsu_dtu_last_check;              
wire    [39:0]  lsu_dtu_ldst_addr;               
wire            lsu_dtu_ldst_addr_vld;           
wire    [15:0]  lsu_dtu_ldst_bytes_vld;          
wire    [63:0]  lsu_dtu_ldst_data;               
wire            lsu_dtu_ldst_data_vld;           
wire    [1 :0]  lsu_dtu_ldst_type;               
wire    [2 :0]  lsu_dtu_mem_access_size;         
wire    [15:0]  mmu_dtu_debug_info;              
wire            pad_yy_icg_scan_en;              
wire    [14:0]  rtu_dtu_debug_info;              
wire    [63:0]  rtu_dtu_dpc;                     
wire            rtu_dtu_halt_ack;                
wire            rtu_dtu_pending_ack;             
wire            rtu_dtu_retire_chgflw;           
wire            rtu_dtu_retire_debug_expt_vld;   
wire    [21:0]  rtu_dtu_retire_halt_info;        
wire            rtu_dtu_retire_mret;             
wire    [39:0]  rtu_dtu_retire_next_pc;          
wire            rtu_dtu_retire_sret;             
wire            rtu_dtu_retire_vld;              
wire    [63:0]  rtu_dtu_tval;                    
wire            rtu_yy_xx_dbgon;                 
wire            rtu_yy_xx_expt_int;              
wire    [4 :0]  rtu_yy_xx_expt_vec;              
wire            rtu_yy_xx_expt_vld;              
wire            sys_apb_clk;                     
wire            sys_apb_rst_b;                   
wire            tdt_dm_dtu_ack_havereset;        
wire            tdt_dm_dtu_async_halt_req;       
wire            tdt_dm_dtu_halt_on_reset;        
wire            tdt_dm_dtu_halt_req;             
wire    [31:0]  tdt_dm_dtu_itr;                  
wire            tdt_dm_dtu_itr_vld;              
wire            tdt_dm_dtu_resume_req;           
wire    [63:0]  tdt_dm_dtu_wdata;                
wire    [1 :0]  tdt_dm_dtu_wr_flg;               
wire            tdt_dm_dtu_wr_vld;               
wire    [63:0]  tdt_dm_wdata;                    
wire    [1 :0]  tdt_dm_wr_flg;                   
wire            tdt_dm_wr_vld;                   
wire    [7 :0]  vidu_dtu_debug_info;             
wire    [28:0]  vpu_dtu_dbg_info;                


//XLEN
parameter XLEN = `TDT_DM_CORE_MAX_XLEN;
//halt_info parameter
parameter CANCLE         = `TDT_HINFO_CANCEL;
parameter MATCH          = `TDT_HINFO_MATCH;
parameter ACTION         = `TDT_HINFO_ACTION;
parameter ACTION_01      = `TDT_HINFO_ACTION01;
parameter TIMING         = `TDT_HINFO_TIMING;
parameter PENDING_HALT   = `TDT_HINFO_PENDING_HALT;
parameter CAUSE          = `TDT_HINFO_CAUSE;
parameter MATCH_TRIGGER  = `TDT_HINFO_TRIGGER;

parameter HINFO_WIDTH    = `TDT_HINFO_WIDTH;
//===============================================================
//assign output
//===============================================================

// CP0
// &Force("input","cp0_dtu_wreg"); @43
// &Force("input","cp0_dtu_rreg"); @44
// //&Force("input","cp0_dtu_addr",); @45
// //&Force("input","cp0_dtu_wdata"); @46
// //&Force("input","cp0_yy_priv_mode"); @47
// &Force("input","cp0_dtu_mexpt_vld"); @48
assign dtu_cp0_dcsr_mprven      = dcsr_mprven;
assign dtu_cp0_dcsr_prv[1:0]    = dcsr_prv[1:0];
assign dtu_cp0_wake_up = low_power_wakeup;

//IFU
// &Force("input","ifu_dtu_addr_vld0"); @54
// &Force("input","ifu_dtu_data_vld0"); @55
// &Force("input","ifu_dtu_exe_addr0");&Force("bus","ifu_dtu_exe_addr0",39,0); @56
// &Force("input","ifu_dtu_exe_data0");&Force("bus","ifu_dtu_exe_data0",31,0); @57
// &Force("input","ifu_dtu_addr_vld1"); @58
// &Force("input","ifu_dtu_data_vld1"); @59
// &Force("input","ifu_dtu_exe_addr1");&Force("bus","ifu_dtu_exe_addr1",39,0); @60
// &Force("input","ifu_dtu_exe_data1");&Force("bus","ifu_dtu_exe_data1",31,0); @61

//LSU
assign dtu_lsu_addr_trig_en = ldst_addr_mcontrol;
assign dtu_lsu_data_trig_en = ldst_data_mcontrol;
// //&Force("input","lsu_dtu_ldst_addr_vld"); @66
// //&Force("input","lsu_dtu_st_type"); @67
// //&Force("input","lsu_dtu_ldst_addr"); @68
// //&Force("input","lsu_dtu_ldst_data_vld"); @69
// //&Force("input","lsu_dtu_ldst_data"); @70
// //&Force("input","lsu_dtu_mem_access_size"); @71
// //&Force("input","lsu_dtu_halt_info"); @72

//RTU
// //&Force("input","rtu_dtu_retire_halt_info"); @75
// //&Force("input","rtu_dtu_retire_halt_info");&Force("bus","rtu_dtu_retire_halt_info",`TDT_HINFO_WIDTH-1,0); @76
// &Force("input","rtu_yy_xx_expt_int"); @77
// &Force("input","rtu_yy_xx_expt_vld"); @78
// &Force("input","rtu_yy_xx_expt_vec");&Force("bus","rtu_yy_xx_expt_vec",4,0); @79
// //&Force("input","rtu_yy_xx_dbgon"); @80
// //&Force("input","rtu_dtu_retire_vld"); @81
// //&Force("input","rtu_dtu_retire_debug_expt_vld"); @82
assign dtu_rtu_ebreak_action  = ebreak_action; 
assign dtu_rtu_int_mask       = int_mask; 
assign dtu_rtu_step_en        = dcsr_step;
assign dtu_rtu_sync_flush     = icount_enable;
assign dtu_rtu_dpc[XLEN-1:0]  = dpc[XLEN-1:0];
//assign dtu_rtu_sync_halt_req
//assign dtu_rtu_async_halt_req
//assign dtu_rtu_resume_req

//HPCP
assign dtu_hpcp_dcsr_stopcount = dcsr_stopcount;

// &Instance("aq_dtu_ctrl"); @95
aq_dtu_ctrl  x_aq_dtu_ctrl (
  .async_halt_req_wakeup    (async_halt_req_wakeup   ),
  .cp0_dtu_addr             (cp0_dtu_addr            ),
  .cp0_dtu_debug_info       (cp0_dtu_debug_info      ),
  .cp0_dtu_icg_en           (cp0_dtu_icg_en          ),
  .cp0_dtu_mexpt_vld        (cp0_dtu_mexpt_vld       ),
  .cp0_dtu_pcfifo_frz       (cp0_dtu_pcfifo_frz      ),
  .cp0_dtu_rreg             (cp0_dtu_rreg            ),
  .cp0_dtu_satp             (cp0_dtu_satp            ),
  .cp0_dtu_wdata            (cp0_dtu_wdata           ),
  .cp0_dtu_wreg             (cp0_dtu_wreg            ),
  .cp0_yy_clk_en            (cp0_yy_clk_en           ),
  .cp0_yy_priv_mode         (cp0_yy_priv_mode        ),
  .cpurst_b                 (cpurst_b                ),
  .dcsr_mprven              (dcsr_mprven             ),
  .dcsr_prv                 (dcsr_prv                ),
  .dcsr_step                (dcsr_step               ),
  .dcsr_stopcount           (dcsr_stopcount          ),
  .dpc                      (dpc                     ),
  .dscratch0                (dscratch0               ),
  .dtu_cp0_rdata            (dtu_cp0_rdata           ),
  .dtu_ifu_halt_info0       (dtu_ifu_halt_info0      ),
  .dtu_ifu_halt_info1       (dtu_ifu_halt_info1      ),
  .dtu_ifu_halt_info_vld    (dtu_ifu_halt_info_vld   ),
  .dtu_lsu_halt_info        (dtu_lsu_halt_info       ),
  .dtu_lsu_halt_info_vld    (dtu_lsu_halt_info_vld   ),
  .dtu_rtu_async_halt_req   (dtu_rtu_async_halt_req  ),
  .dtu_rtu_pending_tval     (dtu_rtu_pending_tval    ),
  .dtu_rtu_sync_halt_req    (dtu_rtu_sync_halt_req   ),
  .ebreak_action            (ebreak_action           ),
  .forever_cpuclk           (forever_cpuclk          ),
  .icount_enable            (icount_enable           ),
  .idu_dtu_debug_info       (idu_dtu_debug_info      ),
  .ifu_dtu_addr_vld0        (ifu_dtu_addr_vld0       ),
  .ifu_dtu_addr_vld1        (ifu_dtu_addr_vld1       ),
  .ifu_dtu_data_vld0        (ifu_dtu_data_vld0       ),
  .ifu_dtu_data_vld1        (ifu_dtu_data_vld1       ),
  .ifu_dtu_debug_info       (ifu_dtu_debug_info      ),
  .ifu_dtu_exe_addr0        (ifu_dtu_exe_addr0       ),
  .ifu_dtu_exe_addr1        (ifu_dtu_exe_addr1       ),
  .ifu_dtu_exe_data0        (ifu_dtu_exe_data0       ),
  .ifu_dtu_exe_data1        (ifu_dtu_exe_data1       ),
  .int_mask                 (int_mask                ),
  .iu_dtu_debug_info        (iu_dtu_debug_info       ),
  .latest_pc                (latest_pc               ),
  .ldst_addr_mcontrol       (ldst_addr_mcontrol      ),
  .ldst_data_mcontrol       (ldst_data_mcontrol      ),
  .low_power_wakeup         (low_power_wakeup        ),
  .lsu_dtu_debug_info       (lsu_dtu_debug_info      ),
  .lsu_dtu_halt_info        (lsu_dtu_halt_info       ),
  .lsu_dtu_last_check       (lsu_dtu_last_check      ),
  .lsu_dtu_ldst_addr        (lsu_dtu_ldst_addr       ),
  .lsu_dtu_ldst_addr_vld    (lsu_dtu_ldst_addr_vld   ),
  .lsu_dtu_ldst_bytes_vld   (lsu_dtu_ldst_bytes_vld  ),
  .lsu_dtu_ldst_data        (lsu_dtu_ldst_data       ),
  .lsu_dtu_ldst_data_vld    (lsu_dtu_ldst_data_vld   ),
  .lsu_dtu_ldst_type        (lsu_dtu_ldst_type       ),
  .lsu_dtu_mem_access_size  (lsu_dtu_mem_access_size ),
  .mmu_dtu_debug_info       (mmu_dtu_debug_info      ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .rtu_dtu_debug_info       (rtu_dtu_debug_info      ),
  .rtu_dtu_dpc              (rtu_dtu_dpc             ),
  .rtu_dtu_halt_ack         (rtu_dtu_halt_ack        ),
  .rtu_dtu_pending_ack      (rtu_dtu_pending_ack     ),
  .rtu_dtu_retire_chgflw    (rtu_dtu_retire_chgflw   ),
  .rtu_dtu_retire_halt_info (rtu_dtu_retire_halt_info),
  .rtu_dtu_retire_mret      (rtu_dtu_retire_mret     ),
  .rtu_dtu_retire_next_pc   (rtu_dtu_retire_next_pc  ),
  .rtu_dtu_retire_sret      (rtu_dtu_retire_sret     ),
  .rtu_dtu_retire_vld       (rtu_dtu_retire_vld      ),
  .rtu_dtu_tval             (rtu_dtu_tval            ),
  .rtu_yy_xx_dbgon          (rtu_yy_xx_dbgon         ),
  .rtu_yy_xx_expt_int       (rtu_yy_xx_expt_int      ),
  .rtu_yy_xx_expt_vec       (rtu_yy_xx_expt_vec      ),
  .rtu_yy_xx_expt_vld       (rtu_yy_xx_expt_vld      ),
  .tdt_dm_wdata             (tdt_dm_wdata            ),
  .tdt_dm_wr_flg            (tdt_dm_wr_flg           ),
  .tdt_dm_wr_vld            (tdt_dm_wr_vld           ),
  .vidu_dtu_debug_info      (vidu_dtu_debug_info     ),
  .vpu_dtu_dbg_info         (vpu_dtu_dbg_info        )
);


// &Instance("aq_dtu_cdc"); @97
aq_dtu_cdc  x_aq_dtu_cdc (
  .async_halt_req_wakeup            (async_halt_req_wakeup           ),
  .cp0_dtu_satp                     (cp0_dtu_satp                    ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cpurst_b                         (cpurst_b                        ),
  .dscratch0                        (dscratch0                       ),
  .dtu_ifu_debug_inst               (dtu_ifu_debug_inst              ),
  .dtu_ifu_debug_inst_vld           (dtu_ifu_debug_inst_vld          ),
  .dtu_ifu_halt_on_reset            (dtu_ifu_halt_on_reset           ),
  .dtu_rtu_async_halt_req           (dtu_rtu_async_halt_req          ),
  .dtu_rtu_resume_req               (dtu_rtu_resume_req              ),
  .dtu_rtu_sync_halt_req            (dtu_rtu_sync_halt_req           ),
  .dtu_tdt_dm_halted                (dtu_tdt_dm_halted               ),
  .dtu_tdt_dm_havereset             (dtu_tdt_dm_havereset            ),
  .dtu_tdt_dm_itr_done              (dtu_tdt_dm_itr_done             ),
  .dtu_tdt_dm_retire_debug_expt_vld (dtu_tdt_dm_retire_debug_expt_vld),
  .dtu_tdt_dm_rx_data               (dtu_tdt_dm_rx_data              ),
  .dtu_tdt_dm_wr_ready              (dtu_tdt_dm_wr_ready             ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .latest_pc                        (latest_pc                       ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .rtu_dtu_retire_debug_expt_vld    (rtu_dtu_retire_debug_expt_vld   ),
  .rtu_dtu_retire_vld               (rtu_dtu_retire_vld              ),
  .rtu_yy_xx_dbgon                  (rtu_yy_xx_dbgon                 ),
  .sys_apb_clk                      (sys_apb_clk                     ),
  .sys_apb_rst_b                    (sys_apb_rst_b                   ),
  .tdt_dm_dtu_ack_havereset         (tdt_dm_dtu_ack_havereset        ),
  .tdt_dm_dtu_async_halt_req        (tdt_dm_dtu_async_halt_req       ),
  .tdt_dm_dtu_halt_on_reset         (tdt_dm_dtu_halt_on_reset        ),
  .tdt_dm_dtu_halt_req              (tdt_dm_dtu_halt_req             ),
  .tdt_dm_dtu_itr                   (tdt_dm_dtu_itr                  ),
  .tdt_dm_dtu_itr_vld               (tdt_dm_dtu_itr_vld              ),
  .tdt_dm_dtu_resume_req            (tdt_dm_dtu_resume_req           ),
  .tdt_dm_dtu_wdata                 (tdt_dm_dtu_wdata                ),
  .tdt_dm_dtu_wr_flg                (tdt_dm_dtu_wr_flg               ),
  .tdt_dm_dtu_wr_vld                (tdt_dm_dtu_wr_vld               ),
  .tdt_dm_wdata                     (tdt_dm_wdata                    ),
  .tdt_dm_wr_flg                    (tdt_dm_wr_flg                   ),
  .tdt_dm_wr_vld                    (tdt_dm_wr_vld                   )
);

// &Force("output","dtu_rtu_sync_halt_req"); @98
// &Force("output","dtu_rtu_async_halt_req"); @99

// &ModuleEnd; @101
endmodule


