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
module aq_dtu_ctrl(
  async_halt_req_wakeup,
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
  dcsr_mprven,
  dcsr_prv,
  dcsr_step,
  dcsr_stopcount,
  dpc,
  dscratch0,
  dtu_cp0_rdata,
  dtu_ifu_halt_info0,
  dtu_ifu_halt_info1,
  dtu_ifu_halt_info_vld,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  dtu_rtu_async_halt_req,
  dtu_rtu_pending_tval,
  dtu_rtu_sync_halt_req,
  ebreak_action,
  forever_cpuclk,
  icount_enable,
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
  int_mask,
  iu_dtu_debug_info,
  latest_pc,
  ldst_addr_mcontrol,
  ldst_data_mcontrol,
  low_power_wakeup,
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
  tdt_dm_wdata,
  tdt_dm_wr_flg,
  tdt_dm_wr_vld,
  vidu_dtu_debug_info,
  vpu_dtu_dbg_info
);

// &Ports; @21
input           async_halt_req_wakeup;   
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
input           dtu_rtu_async_halt_req;  
input           dtu_rtu_sync_halt_req;   
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
input   [63:0]  tdt_dm_wdata;            
input   [1 :0]  tdt_dm_wr_flg;           
input           tdt_dm_wr_vld;           
input   [7 :0]  vidu_dtu_debug_info;     
input   [28:0]  vpu_dtu_dbg_info;        
output          dcsr_mprven;             
output  [1 :0]  dcsr_prv;                
output          dcsr_step;               
output          dcsr_stopcount;          
output  [63:0]  dpc;                     
output  [63:0]  dscratch0;               
output  [63:0]  dtu_cp0_rdata;           
output  [21:0]  dtu_ifu_halt_info0;      
output  [21:0]  dtu_ifu_halt_info1;      
output          dtu_ifu_halt_info_vld;   
output  [21:0]  dtu_lsu_halt_info;       
output          dtu_lsu_halt_info_vld;   
output  [63:0]  dtu_rtu_pending_tval;    
output          ebreak_action;           
output          icount_enable;           
output          int_mask;                
output  [39:0]  latest_pc;               
output          ldst_addr_mcontrol;      
output          ldst_data_mcontrol;      
output          low_power_wakeup;        

// &Regs; @22
reg     [2 :0]  dcsr_cause;              
reg             dcsr_ebreakm;            
reg             dcsr_ebreaks;            
reg             dcsr_ebreaku;            
reg             dcsr_mprven;             
reg     [1 :0]  dcsr_prv;                
reg             dcsr_step;               
reg             dcsr_stepie;             
reg             dcsr_stopcount;          
reg     [63:0]  dpc;                     
reg     [63:0]  dscratch0;               
reg     [63:0]  dscratch1;               
reg     [63:0]  dtu_cp0_rdata;           
reg     [3 :0]  haltcause;               

// &Wires; @23
wire            async_halt_req_wakeup;   
wire            core_debug_csr_clk;      
wire            core_debug_csr_clk_en;   
wire    [11:0]  cp0_dtu_addr;            
wire    [5 :0]  cp0_dtu_debug_info;      
wire            cp0_dtu_icg_en;          
wire            cp0_dtu_mexpt_vld;       
wire            cp0_dtu_pcfifo_frz;      
wire            cp0_dtu_rreg;            
wire    [63:0]  cp0_dtu_satp;            
wire    [63:0]  cp0_dtu_wdata;           
wire            cp0_dtu_wreg;            
wire            cp0_write_dcsr;          
wire            cp0_write_dpc;           
wire            cp0_write_dscratch0;     
wire            cp0_write_dscratch1;     
wire            cp0_yy_clk_en;           
wire    [1 :0]  cp0_yy_priv_mode;        
wire            cpurst_b;                
wire    [63:0]  dbgfifo_regs_data;       
wire    [31:0]  dcsr;                    
wire            dcsr_nmip;               
wire    [3 :0]  dcsr_xdebugver;          
wire    [3 :0]  dtu_cause;               
wire    [21:0]  dtu_ifu_halt_info0;      
wire    [21:0]  dtu_ifu_halt_info1;      
wire            dtu_ifu_halt_info_vld;   
wire    [21:0]  dtu_lsu_halt_info;       
wire            dtu_lsu_halt_info_vld;   
wire            dtu_rtu_async_halt_req;  
wire    [63:0]  dtu_rtu_pending_tval;    
wire            dtu_rtu_sync_halt_req;   
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
wire    [63:0]  mcontext;                
wire    [15:0]  mmu_dtu_debug_info;      
wire            pad_yy_icg_scan_en;      
wire    [63:0]  pcfifo_regs_data;        
wire            pending_halt;            
wire    [14:0]  rtu_dtu_debug_info;      
wire    [63:0]  rtu_dtu_dpc;             
wire            rtu_dtu_halt_ack;        
wire            rtu_dtu_pending_ack;     
wire            rtu_dtu_retire_chgflw;   
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
wire    [63:0]  scontext;                
wire    [63:0]  tcontrol;                
wire    [63:0]  tdata1;                  
wire    [63:0]  tdata2;                  
wire    [63:0]  tdata3;                  
wire    [63:0]  tdt_dm_wdata;            
wire    [1 :0]  tdt_dm_wr_flg;           
wire            tdt_dm_wr_vld;           
wire            tdt_dm_write_dscratch0;  
wire    [63:0]  tinfo;                   
wire    [63:0]  tselect;                 
wire            updata_tval;             
wire    [7 :0]  vidu_dtu_debug_info;     
wire    [28:0]  vpu_dtu_dbg_info;        


//XLEN
parameter XLEN = `TDT_DM_CORE_MAX_XLEN;

//dcsr parameter
parameter PRV = 1; 
parameter STEP = 2;
parameter MPRVEN = 4;
//parameter DCSR_CAUSE = 8;
//parameter STOPTIME = 9;
parameter STOPCOUNT = 10;
parameter STEPIE = 11;
parameter EBREAKU = 12;
parameter EBREAKS = 13;
parameter EBREAKM = 15;

//===============================================================
//Core Debug Register
//
//dcsr, dpc, dscratch0, dscratch1, hatlcause, dbginfo, pcfifo
//===============================================================

//core csr and write req
assign cp0_write_dcsr      = cp0_dtu_wreg && cp0_dtu_addr[11:0] == 12'h7b0 && rtu_yy_xx_dbgon;
assign cp0_write_dpc       = cp0_dtu_wreg && cp0_dtu_addr[11:0] == 12'h7b1 && rtu_yy_xx_dbgon;
assign cp0_write_dscratch0 = cp0_dtu_wreg && cp0_dtu_addr[11:0] == 12'h7b2 && rtu_yy_xx_dbgon;
assign cp0_write_dscratch1 = cp0_dtu_wreg && cp0_dtu_addr[11:0] == 12'h7b3 && rtu_yy_xx_dbgon;
assign tdt_dm_write_dscratch0  = tdt_dm_wr_vld && tdt_dm_wr_flg[1:0] == 2'b01 && rtu_yy_xx_dbgon;

//===============================================================
//                      Define the DCSR
//===============================================================
assign dcsr_nmip      = 1'b0;//nmip
assign dcsr_xdebugver = 4'b0100;//xdebugver

always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      dcsr_step       <= 1'b0;
      dcsr_mprven     <= 1'b0;
      dcsr_stopcount  <= 1'b0;
      dcsr_stepie     <= 1'b0;
      dcsr_ebreaku    <= 1'b0;
      dcsr_ebreaks    <= 1'b0;
      dcsr_ebreakm    <= 1'b0;
    end
  else if(cp0_write_dcsr)
    begin
      dcsr_step       <= cp0_dtu_wdata[STEP];
      dcsr_mprven     <= cp0_dtu_wdata[MPRVEN];
      dcsr_stopcount  <= cp0_dtu_wdata[STOPCOUNT];
      dcsr_stepie     <= cp0_dtu_wdata[STEPIE];
      dcsr_ebreaku    <= cp0_dtu_wdata[EBREAKU];
      dcsr_ebreaks    <= cp0_dtu_wdata[EBREAKS];
      dcsr_ebreakm    <= cp0_dtu_wdata[EBREAKM];
    end
end
// &Force("output","dcsr_mprven"); @82
// &Force("output","dcsr_stopcount"); @83
// &Force("output","dcsr_step"); @84

always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dcsr_prv[1:0] <= 2'b0;
  else if(rtu_dtu_halt_ack)
    dcsr_prv[1:0] <= cp0_yy_priv_mode[1:0];
  else if(cp0_write_dcsr)
    dcsr_prv[1:0] <= cp0_dtu_wdata[PRV:0];
end
// &Force("output","dcsr_prv"); @95

always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dcsr_cause[2:0] <= 3'b0;
  else if(rtu_dtu_halt_ack)
    dcsr_cause[2:0] <= dtu_cause[2:0];
end

assign dcsr[31:0] ={dcsr_xdebugver[3:0],{12{1'b0}},dcsr_ebreakm,1'b0,dcsr_ebreaks,dcsr_ebreaku,
              dcsr_stepie,dcsr_stopcount,1'b0,dcsr_cause[2:0],1'b0,dcsr_mprven,
              dcsr_nmip,dcsr_step,dcsr_prv[1:0]};
//generate int_mask and ebreak_action for rtu
assign int_mask = dcsr_step && !dcsr_stepie;
assign ebreak_action = cp0_yy_priv_mode[1:0] == 2'b00 && dcsr_ebreaku ||
                       cp0_yy_priv_mode[1:0] == 2'b01 && dcsr_ebreaks ||
                       cp0_yy_priv_mode[1:0] == 2'b11 && dcsr_ebreakm;

//===============================================================
//                      Define the DPC
//===============================================================
always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dpc[XLEN-1:0] <= {XLEN{1'b0}};
  else if(cp0_write_dpc)
    dpc[XLEN-1:0] <= cp0_dtu_wdata[XLEN-1:0];
  else if(rtu_dtu_halt_ack)
    dpc[XLEN-1:0] <= rtu_dtu_dpc[XLEN-1:0];
end
// &Force("output","dpc"); @126

//===============================================================
//                      Define the DSCRATCH0
//===============================================================
always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dscratch0[XLEN-1:0] <= {XLEN{1'b0}};
  else if(updata_tval)
    dscratch0[XLEN-1:0] <= rtu_dtu_tval[XLEN-1:0];
  else if(cp0_write_dscratch0)
    dscratch0[XLEN-1:0] <= cp0_dtu_wdata[XLEN-1:0];
  else if(tdt_dm_write_dscratch0)
    dscratch0[XLEN-1:0] <= tdt_dm_wdata[XLEN-1:0];
end
// &Force("output","dscratch0"); @142
assign dtu_rtu_pending_tval[XLEN-1:0] = dscratch0[XLEN-1:0];
//===============================================================
//                      Define the DSCRATCH1
//===============================================================
always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dscratch1[XLEN-1:0] <= {XLEN{1'b0}};
  else if(cp0_write_dscratch1)
    dscratch1[XLEN-1:0] <= cp0_dtu_wdata[XLEN-1:0];
end

//===============================================================
//                      Define the HALTCAUSE
//===============================================================
always @(posedge core_debug_csr_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    haltcause[3:0] <= {4{1'b0}};
  else if(rtu_dtu_halt_ack)
	haltcause[3:0] <= dtu_cause[3:0];
end

//===============================================================
//                      Define the pcfifo
//===============================================================
// &Instance("aq_dtu_pcfifo"); @170
aq_dtu_pcfifo  x_aq_dtu_pcfifo (
  .cp0_dtu_addr           (cp0_dtu_addr          ),
  .cp0_dtu_icg_en         (cp0_dtu_icg_en        ),
  .cp0_dtu_pcfifo_frz     (cp0_dtu_pcfifo_frz    ),
  .cp0_dtu_rreg           (cp0_dtu_rreg          ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .latest_pc              (latest_pc             ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .pcfifo_regs_data       (pcfifo_regs_data      ),
  .rtu_dtu_halt_ack       (rtu_dtu_halt_ack      ),
  .rtu_dtu_retire_chgflw  (rtu_dtu_retire_chgflw ),
  .rtu_dtu_retire_next_pc (rtu_dtu_retire_next_pc),
  .rtu_dtu_retire_vld     (rtu_dtu_retire_vld    )
);

// //&Connect(.pcfifo_clk (core_debug_csr_clk), @171
// //         .cpurst_b   (cpurst_b)); @172
// &Force("input","cp0_dtu_pcfifo_frz"); @174
// &Force("input","rtu_dtu_retire_chgflw"); @175
// &Force("input","rtu_dtu_retire_next_pc");&Force("bus","rtu_dtu_retire_next_pc",`PA_WIDTH-1,0); @176

//===============================================================
//                      Define the dbginfo
//===============================================================
// &Instance("aq_dtu_dbginfo"); @183
aq_dtu_dbginfo  x_aq_dtu_dbginfo (
  .cp0_dtu_addr           (cp0_dtu_addr          ),
  .cp0_dtu_debug_info     (cp0_dtu_debug_info    ),
  .cp0_dtu_icg_en         (cp0_dtu_icg_en        ),
  .cp0_dtu_rreg           (cp0_dtu_rreg          ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .dbgfifo_regs_data      (dbgfifo_regs_data     ),
  .dtu_rtu_async_halt_req (dtu_rtu_async_halt_req),
  .forever_cpuclk         (forever_cpuclk        ),
  .idu_dtu_debug_info     (idu_dtu_debug_info    ),
  .ifu_dtu_debug_info     (ifu_dtu_debug_info    ),
  .iu_dtu_debug_info      (iu_dtu_debug_info     ),
  .lsu_dtu_debug_info     (lsu_dtu_debug_info    ),
  .mmu_dtu_debug_info     (mmu_dtu_debug_info    ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .rtu_dtu_debug_info     (rtu_dtu_debug_info    ),
  .vidu_dtu_debug_info    (vidu_dtu_debug_info   ),
  .vpu_dtu_dbg_info       (vpu_dtu_dbg_info      )
);

// //&Connect(.dbginfo_clk (core_debug_csr_clk), @184
// //         .cpurst_b   (cpurst_b)); @185
// &Force("input","mmu_dtu_debug_info");&Force("bus","mmu_dtu_debug_info",15,0); @187
// &Force("input","cp0_dtu_debug_info");&Force("bus","cp0_dtu_debug_info",5,0); @188
// &Force("input","vpu_dtu_dbg_info");&Force("bus","vpu_dtu_dbg_info",28,0); @189
// &Force("input","rtu_dtu_debug_info");&Force("bus","rtu_dtu_debug_info",14,0); @190
// &Force("input","iu_dtu_debug_info");&Force("bus","iu_dtu_debug_info",8,0); @191
// &Force("input","lsu_dtu_debug_info");&Force("bus","lsu_dtu_debug_info",93,0); @192
// &Force("input","vidu_dtu_debug_info");&Force("bus","vidu_dtu_debug_info",7,0); @193
// &Force("input","idu_dtu_debug_info");&Force("bus","idu_dtu_debug_info",14,0); @194
// &Force("input","ifu_dtu_debug_info");&Force("bus","ifu_dtu_debug_info",20,0); @195
//csr and read req

//===============================================================
//                      Define the Trigger Module
//===============================================================
// &Instance("aq_dtu_trigger_module"); @202
aq_dtu_trigger_module  x_aq_dtu_trigger_module (
  .cp0_dtu_addr             (cp0_dtu_addr            ),
  .cp0_dtu_icg_en           (cp0_dtu_icg_en          ),
  .cp0_dtu_mexpt_vld        (cp0_dtu_mexpt_vld       ),
  .cp0_dtu_satp             (cp0_dtu_satp            ),
  .cp0_dtu_wdata            (cp0_dtu_wdata           ),
  .cp0_dtu_wreg             (cp0_dtu_wreg            ),
  .cp0_yy_clk_en            (cp0_yy_clk_en           ),
  .cp0_yy_priv_mode         (cp0_yy_priv_mode        ),
  .cpurst_b                 (cpurst_b                ),
  .dtu_cause                (dtu_cause               ),
  .dtu_ifu_halt_info0       (dtu_ifu_halt_info0      ),
  .dtu_ifu_halt_info1       (dtu_ifu_halt_info1      ),
  .dtu_ifu_halt_info_vld    (dtu_ifu_halt_info_vld   ),
  .dtu_lsu_halt_info        (dtu_lsu_halt_info       ),
  .dtu_lsu_halt_info_vld    (dtu_lsu_halt_info_vld   ),
  .forever_cpuclk           (forever_cpuclk          ),
  .icount_enable            (icount_enable           ),
  .ifu_dtu_addr_vld0        (ifu_dtu_addr_vld0       ),
  .ifu_dtu_addr_vld1        (ifu_dtu_addr_vld1       ),
  .ifu_dtu_data_vld0        (ifu_dtu_data_vld0       ),
  .ifu_dtu_data_vld1        (ifu_dtu_data_vld1       ),
  .ifu_dtu_exe_addr0        (ifu_dtu_exe_addr0       ),
  .ifu_dtu_exe_addr1        (ifu_dtu_exe_addr1       ),
  .ifu_dtu_exe_data0        (ifu_dtu_exe_data0       ),
  .ifu_dtu_exe_data1        (ifu_dtu_exe_data1       ),
  .ldst_addr_mcontrol       (ldst_addr_mcontrol      ),
  .ldst_data_mcontrol       (ldst_data_mcontrol      ),
  .lsu_dtu_halt_info        (lsu_dtu_halt_info       ),
  .lsu_dtu_last_check       (lsu_dtu_last_check      ),
  .lsu_dtu_ldst_addr        (lsu_dtu_ldst_addr       ),
  .lsu_dtu_ldst_addr_vld    (lsu_dtu_ldst_addr_vld   ),
  .lsu_dtu_ldst_bytes_vld   (lsu_dtu_ldst_bytes_vld  ),
  .lsu_dtu_ldst_data        (lsu_dtu_ldst_data       ),
  .lsu_dtu_ldst_data_vld    (lsu_dtu_ldst_data_vld   ),
  .lsu_dtu_ldst_type        (lsu_dtu_ldst_type       ),
  .lsu_dtu_mem_access_size  (lsu_dtu_mem_access_size ),
  .mcontext                 (mcontext                ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .pending_halt             (pending_halt            ),
  .rtu_dtu_halt_ack         (rtu_dtu_halt_ack        ),
  .rtu_dtu_pending_ack      (rtu_dtu_pending_ack     ),
  .rtu_dtu_retire_halt_info (rtu_dtu_retire_halt_info),
  .rtu_dtu_retire_mret      (rtu_dtu_retire_mret     ),
  .rtu_dtu_retire_sret      (rtu_dtu_retire_sret     ),
  .rtu_dtu_retire_vld       (rtu_dtu_retire_vld      ),
  .rtu_yy_xx_dbgon          (rtu_yy_xx_dbgon         ),
  .rtu_yy_xx_expt_int       (rtu_yy_xx_expt_int      ),
  .rtu_yy_xx_expt_vec       (rtu_yy_xx_expt_vec      ),
  .rtu_yy_xx_expt_vld       (rtu_yy_xx_expt_vld      ),
  .scontext                 (scontext                ),
  .tcontrol                 (tcontrol                ),
  .tdata1                   (tdata1                  ),
  .tdata2                   (tdata2                  ),
  .tdata3                   (tdata3                  ),
  .tinfo                    (tinfo                   ),
  .tselect                  (tselect                 ),
  .updata_tval              (updata_tval             )
);


// &CombBeg; @204
always @( dscratch1[63:0]
       or dpc[63:0]
       or tselect[63:0]
       or tinfo[63:0]
       or pcfifo_regs_data[63:0]
       or dscratch0[63:0]
       or dcsr[31:0]
       or tdata1[63:0]
       or tdata3[63:0]
       or scontext[63:0]
       or tcontrol[63:0]
       or tdata2[63:0]
       or haltcause[3:0]
       or cp0_dtu_addr[11:0]
       or dbgfifo_regs_data[63:0]
       or mcontext[63:0])
begin
case(cp0_dtu_addr[11:0])
  12'h7a0:
    dtu_cp0_rdata[XLEN-1:0] = tselect[XLEN-1:0];
  12'h7a1:
    dtu_cp0_rdata[XLEN-1:0] = tdata1[XLEN-1:0];
  12'h7a2:
    dtu_cp0_rdata[XLEN-1:0] = tdata2[XLEN-1:0];
  12'h7a3:
    dtu_cp0_rdata[XLEN-1:0] = tdata3[XLEN-1:0];
  12'h7a4:
    dtu_cp0_rdata[XLEN-1:0] = tinfo[XLEN-1:0];
  12'h7a5:
    dtu_cp0_rdata[XLEN-1:0] = tcontrol[XLEN-1:0];
  12'h7a8:
    dtu_cp0_rdata[XLEN-1:0] = mcontext[XLEN-1:0];
  12'h7aa:
    dtu_cp0_rdata[XLEN-1:0] = scontext[XLEN-1:0];

  12'h7b0:
    dtu_cp0_rdata[XLEN-1:0] = {{32{1'b0}},dcsr[31:0]};
  12'h7b1:
    dtu_cp0_rdata[XLEN-1:0] = dpc[XLEN-1:0];
  12'h7b2:
    dtu_cp0_rdata[XLEN-1:0] = dscratch0[XLEN-1:0];
  12'h7b3:
    dtu_cp0_rdata[XLEN-1:0] = dscratch1[XLEN-1:0];
  12'hfe0:
    dtu_cp0_rdata[XLEN-1:0] = {{XLEN-4{1'b0}},haltcause[3:0]};
  
  12'hfe1:
    dtu_cp0_rdata[XLEN-1:0] = dbgfifo_regs_data[XLEN-1:0];

  12'hfe2:
    dtu_cp0_rdata[XLEN-1:0] = pcfifo_regs_data[XLEN-1:0];

  default:
    dtu_cp0_rdata[XLEN-1:0] = {XLEN{1'bx}};
endcase
// &CombEnd; @291
end

//low power wakeup
assign low_power_wakeup = dtu_rtu_sync_halt_req || 
                          async_halt_req_wakeup ||
                          dcsr_step ||
                          pending_halt;
                        
//==========================================================
//                     gate clk
//==========================================================
assign core_debug_csr_clk_en = rtu_dtu_halt_ack ||
                               cp0_write_dcsr   ||
                               cp0_write_dpc    ||
                               cp0_write_dscratch0 || tdt_dm_write_dscratch0 ||  updata_tval ||
                               cp0_write_dscratch1;
// &Force("nonport","core_debug_csr_clk_en"); @307

// &Instance("gated_clk_cell", "x_reg_gated_clk"); @309
gated_clk_cell  x_reg_gated_clk (
  .clk_in                (forever_cpuclk       ),
  .clk_out               (core_debug_csr_clk   ),
  .external_en           (1'b0                 ),
  .global_en             (cp0_yy_clk_en        ),
  .local_en              (core_debug_csr_clk_en),
  .module_en             (cp0_dtu_icg_en       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

// &Connect(.clk_in      (forever_cpuclk), @310
//          .external_en (1'b0), @311
//          .global_en   (cp0_yy_clk_en), @312
//          .module_en   (cp0_dtu_icg_en), @313
//          .local_en    (core_debug_csr_clk_en), @314
//          //.local_en    (1'b1), @315
//          .clk_out     (core_debug_csr_clk)); @316

// &ModuleEnd; @318
endmodule


