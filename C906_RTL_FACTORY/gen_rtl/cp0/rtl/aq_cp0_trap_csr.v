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

// &ModuleBeg; @23
module aq_cp0_trap_csr(
  biu_cp0_me_int,
  biu_cp0_ms_int,
  biu_cp0_mt_int,
  biu_cp0_se_int,
  biu_cp0_ss_int,
  biu_cp0_st_int,
  cp0_dtu_mexpt_vld,
  cp0_hpcp_int_off_vld,
  cp0_idu_fs,
  cp0_idu_vs,
  cp0_lsu_mpp,
  cp0_lsu_mprv,
  cp0_mmu_mxr,
  cp0_mmu_sum,
  cp0_rtu_int_vld,
  cp0_rtu_trap_pc,
  cp0_yy_priv_mode,
  cpurst_b,
  dtu_cp0_dcsr_mprven,
  dtu_cp0_dcsr_prv,
  fcsr_local_en,
  fflags_local_en,
  float_clk,
  frm_local_en,
  fs_dirty_upd_gate,
  fxcr_local_en,
  hpcp_cp0_int_vld,
  iui_regs_inst_mret,
  iui_regs_inst_sret,
  iui_regs_wdata,
  mcause_local_en,
  mcause_value,
  medeleg_local_en,
  medeleg_value,
  mepc_local_en,
  mepc_value,
  mideleg_local_en,
  mideleg_value,
  mie_local_en,
  mie_value,
  mip_local_en,
  mip_value,
  mscratch_local_en,
  mscratch_value,
  mstatus_local_en,
  mstatus_value,
  mtval_local_en,
  mtval_value,
  mtvec_local_en,
  mtvec_value,
  regs_clintee,
  regs_clk,
  regs_flush_clk,
  regs_fs_off,
  regs_iui_mepc,
  regs_iui_pm,
  regs_iui_sepc,
  regs_iui_tsr,
  regs_iui_tvm,
  regs_iui_tw,
  regs_lpmd_int_vld,
  regs_mxl,
  regs_pm,
  regs_tvm,
  rtu_cp0_epc,
  rtu_cp0_exit_debug,
  rtu_cp0_fs_dirty_updt,
  rtu_cp0_fs_dirty_updt_dp,
  rtu_cp0_tval,
  rtu_cp0_vs_dirty_updt,
  rtu_cp0_vs_dirty_updt_dp,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_int,
  rtu_yy_xx_expt_vec,
  rtu_yy_xx_expt_vld,
  scause_local_en,
  scause_value,
  sepc_local_en,
  sepc_value,
  sie_local_en,
  sie_value,
  sip_local_en,
  sip_raw,
  sip_value,
  sscratch_local_en,
  sscratch_value,
  sstatus_local_en,
  sstatus_value,
  stval_local_en,
  stval_value,
  stvec_local_en,
  stvec_value,
  vs_dirty_upd_gate
);


// &Ports; @25
input           biu_cp0_me_int;          
input           biu_cp0_ms_int;          
input           biu_cp0_mt_int;          
input           biu_cp0_se_int;          
input           biu_cp0_ss_int;          
input           biu_cp0_st_int;          
input           cpurst_b;                
input           dtu_cp0_dcsr_mprven;     
input   [1 :0]  dtu_cp0_dcsr_prv;        
input           fcsr_local_en;           
input           fflags_local_en;         
input           float_clk;               
input           frm_local_en;            
input           fxcr_local_en;           
input           hpcp_cp0_int_vld;        
input           iui_regs_inst_mret;      
input           iui_regs_inst_sret;      
input   [63:0]  iui_regs_wdata;          
input           mcause_local_en;         
input           medeleg_local_en;        
input           mepc_local_en;           
input           mideleg_local_en;        
input           mie_local_en;            
input           mip_local_en;            
input           mscratch_local_en;       
input           mstatus_local_en;        
input           mtval_local_en;          
input           mtvec_local_en;          
input           regs_clintee;            
input           regs_clk;                
input           regs_flush_clk;          
input   [1 :0]  regs_mxl;                
input   [63:0]  rtu_cp0_epc;             
input           rtu_cp0_exit_debug;      
input           rtu_cp0_fs_dirty_updt;   
input           rtu_cp0_fs_dirty_updt_dp; 
input   [63:0]  rtu_cp0_tval;            
input           rtu_cp0_vs_dirty_updt;   
input           rtu_cp0_vs_dirty_updt_dp; 
input           rtu_yy_xx_dbgon;         
input           rtu_yy_xx_expt_int;      
input   [4 :0]  rtu_yy_xx_expt_vec;      
input           rtu_yy_xx_expt_vld;      
input           scause_local_en;         
input           sepc_local_en;           
input           sie_local_en;            
input           sip_local_en;            
input           sscratch_local_en;       
input           sstatus_local_en;        
input           stval_local_en;          
input           stvec_local_en;          
output          cp0_dtu_mexpt_vld;       
output          cp0_hpcp_int_off_vld;    
output  [1 :0]  cp0_idu_fs;              
output  [1 :0]  cp0_idu_vs;              
output  [1 :0]  cp0_lsu_mpp;             
output          cp0_lsu_mprv;            
output          cp0_mmu_mxr;             
output          cp0_mmu_sum;             
output  [14:0]  cp0_rtu_int_vld;         
output  [39:0]  cp0_rtu_trap_pc;         
output  [1 :0]  cp0_yy_priv_mode;        
output          fs_dirty_upd_gate;       
output  [63:0]  mcause_value;            
output  [63:0]  medeleg_value;           
output  [63:0]  mepc_value;              
output  [63:0]  mideleg_value;           
output  [63:0]  mie_value;               
output  [63:0]  mip_value;               
output  [63:0]  mscratch_value;          
output  [63:0]  mstatus_value;           
output  [63:0]  mtval_value;             
output  [63:0]  mtvec_value;             
output          regs_fs_off;             
output  [39:0]  regs_iui_mepc;           
output  [1 :0]  regs_iui_pm;             
output  [39:0]  regs_iui_sepc;           
output          regs_iui_tsr;            
output          regs_iui_tvm;            
output          regs_iui_tw;             
output          regs_lpmd_int_vld;       
output  [1 :0]  regs_pm;                 
output          regs_tvm;                
output  [63:0]  scause_value;            
output  [63:0]  sepc_value;              
output  [63:0]  sie_value;               
output  [63:0]  sip_raw;                 
output  [63:0]  sip_value;               
output  [63:0]  sscratch_value;          
output  [63:0]  sstatus_value;           
output  [63:0]  stval_value;             
output  [63:0]  stvec_value;             
output          vs_dirty_upd_gate;       

// &Regs; @26
reg     [15:0]  edeleg;                  
reg     [1 :0]  fs_reg;                  
reg             m_intr;                  
reg     [4 :0]  m_vector;                
reg             meie;                    
reg     [62:0]  mepc_reg;                
reg             mie_bit;                 
reg             moie;                    
reg             moie_deleg;              
reg             mpie;                    
reg     [1 :0]  mpp;                     
reg             mprv;                    
reg     [63:0]  mscratch;                
reg             msie;                    
reg             mtie;                    
reg     [63:0]  mtval_data;              
reg     [61:0]  mtvec_base;              
reg     [1 :0]  mtvec_mode;              
reg             mxr;                     
reg     [1 :0]  pm_bits;                 
reg     [1 :0]  pm_wdata;                
reg             s_intr;                  
reg     [4 :0]  s_vector;                
reg             seie;                    
reg             seie_deleg;              
reg             seip_reg;                
reg     [62:0]  sepc_reg;                
reg             sie_bit;                 
reg             spie;                    
reg             spp;                     
reg     [63:0]  sscratch;                
reg             ssie;                    
reg             ssie_deleg;              
reg             ssip_reg;                
reg             stie;                    
reg             stie_deleg;              
reg             stip_reg;                
reg     [63:0]  stval_data;              
reg     [61:0]  stvec_base;              
reg     [1 :0]  stvec_mode;              
reg             sum;                     
reg             tsr;                     
reg             tvm;                     
reg             tw;                      
reg     [18:0]  vec_num;                 

// &Wires; @27
wire            biu_cp0_me_int;          
wire            biu_cp0_ms_int;          
wire            biu_cp0_mt_int;          
wire            biu_cp0_se_int;          
wire            biu_cp0_ss_int;          
wire            biu_cp0_st_int;          
wire            cp0_dtu_mexpt_vld;       
wire            cp0_hpcp_int_off_vld;    
wire    [1 :0]  cp0_idu_fs;              
wire    [1 :0]  cp0_idu_vs;              
wire    [1 :0]  cp0_lsu_mpp;             
wire            cp0_lsu_mprv;            
wire            cp0_mmu_mxr;             
wire            cp0_mmu_sum;             
wire    [14:0]  cp0_rtu_int_vld;         
wire    [39:0]  cp0_rtu_trap_pc;         
wire    [1 :0]  cp0_yy_priv_mode;        
wire            cpurst_b;                
wire            dtu_cp0_dcsr_mprven;     
wire    [1 :0]  dtu_cp0_dcsr_prv;        
wire    [15:0]  edeleg_upd_val;          
wire            fcsr_local_en;           
wire            fflags_local_en;         
wire            float_clk;               
wire            frm_local_en;            
wire    [1 :0]  fs;                      
wire            fs_dirty_upd;            
wire            fs_dirty_upd_gate;       
wire            fs_off;                  
wire            fxcr_local_en;           
wire            hpcp_cp0_int_vld;        
wire            int_off_vld;             
wire    [14:0]  int_sel;                 
wire            iui_regs_inst_mret;      
wire            iui_regs_inst_sret;      
wire    [63:0]  iui_regs_wdata;          
wire            lpmd_ack_vld;            
wire            mcause_local_en;         
wire    [63:0]  mcause_value;            
wire            mcie;                    
wire            mcie_deleg;              
wire            mcip;                    
wire            mcip_acc_en;             
wire            mcip_deleg_vld;          
wire            mcip_en;                 
wire            mcip_nodeleg_vld;        
wire            mdeleg_vld_dp;           
wire            medeleg_local_en;        
wire    [63:0]  medeleg_value;           
wire            medeleg_vld_dp;          
wire            meip;                    
wire            meip_en;                 
wire            meip_vld;                
wire            mepc_local_en;           
wire    [63:0]  mepc_value;              
wire            mhie;                    
wire            mhie_deleg;              
wire            mhip;                    
wire            mhip_acc_en;             
wire            mhip_deleg_vld;          
wire            mhip_en;                 
wire            mhip_nodeleg_vld;        
wire    [63:0]  mideleg;                 
wire            mideleg_local_en;        
wire    [63:0]  mideleg_value;           
wire            mideleg_vld_dp;          
wire            mie_local_en;            
wire    [63:0]  mie_value;               
wire            mip_local_en;            
wire    [63:0]  mip_value;               
wire            moip;                    
wire            moip_acc_en;             
wire            moip_deleg_vld;          
wire            moip_en;                 
wire            moip_nodeleg_vld;        
wire            mpv;                     
wire            mscratch_local_en;       
wire    [63:0]  mscratch_value;          
wire            msip;                    
wire            msip_en;                 
wire            msip_vld;                
wire            mstatus_local_en;        
wire    [63:0]  mstatus_value;           
wire            mtip;                    
wire            mtip_en;                 
wire            mtip_vld;                
wire            mtval_local_en;          
wire    [63:0]  mtval_value;             
wire            mtvec_local_en;          
wire    [63:0]  mtvec_value;             
wire    [1 :0]  pm;                      
wire            pm_wen;                  
wire            regs_clintee;            
wire            regs_clk;                
wire            regs_flush_clk;          
wire            regs_fs_off;             
wire            regs_intr;               
wire    [39:0]  regs_iui_mepc;           
wire    [1 :0]  regs_iui_pm;             
wire    [39:0]  regs_iui_sepc;           
wire            regs_iui_tsr;            
wire            regs_iui_tvm;            
wire            regs_iui_tw;             
wire            regs_lpmd_int_vld;       
wire            regs_mpp_write_ill;      
wire    [1 :0]  regs_mxl;                
wire    [1 :0]  regs_pm;                 
wire    [39:0]  regs_trap_pc;            
wire    [39:0]  regs_tvec;               
wire            regs_tvm;                
wire    [4 :0]  regs_vector;             
wire    [63:0]  rtu_cp0_epc;             
wire            rtu_cp0_exit_debug;      
wire            rtu_cp0_fs_dirty_updt;   
wire            rtu_cp0_fs_dirty_updt_dp; 
wire    [63:0]  rtu_cp0_tval;            
wire            rtu_yy_xx_dbgon;         
wire            rtu_yy_xx_expt_int;      
wire    [4 :0]  rtu_yy_xx_expt_vec;      
wire            rtu_yy_xx_expt_vld;      
wire            scause_local_en;         
wire    [63:0]  scause_value;            
wire            sd;                      
wire            seip;                    
wire            seip_acc_en;             
wire            seip_deleg_vld;          
wire            seip_en;                 
wire            seip_nodeleg_vld;        
wire            sepc_local_en;           
wire    [63:0]  sepc_value;              
wire            sie_local_en;            
wire    [63:0]  sie_value;               
wire            sip_local_en;            
wire    [63:0]  sip_raw;                 
wire    [63:0]  sip_value;               
wire            sscratch_local_en;       
wire    [63:0]  sscratch_value;          
wire            ssip;                    
wire            ssip_acc_en;             
wire            ssip_deleg_vld;          
wire            ssip_en;                 
wire            ssip_nodeleg_vld;        
wire            sstatus_local_en;        
wire            sstatus_spp;             
wire    [63:0]  sstatus_value;           
wire            stip;                    
wire            stip_acc_en;             
wire            stip_deleg_vld;          
wire            stip_en;                 
wire            stip_nodeleg_vld;        
wire            stval_local_en;          
wire    [63:0]  stval_value;             
wire            stvec_local_en;          
wire    [63:0]  stvec_value;             
wire    [1 :0]  sxl;                     
wire    [1 :0]  uxl;                     
wire    [39:0]  vec_int_pc;              
wire    [1 :0]  vs;                      
wire            vs_dirty_upd_gate;       
wire            vxrm_local_en;           
wire            vxsat_local_en;          
wire    [1 :0]  xs;                      


//==========================================================
//                 Trap Setup and Handling
//==========================================================
//----------------------------------------------------------
//                    Machine Trap Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mstatus    | M status register.  |                    |
// | medeleg    | M expt delegation.  |                    |
// | mideleg    | M int delegation.   |                    |
// | mie        | M int enable.       |                    |
// | mtvec      | M trap handle addr. |                    |
// |------------|---------------------|--------------------|
// ps. misa in info_csr;
//     mcounteren in hpcp_csr.

//----------------------------------------------------------
//                    Machine Trap Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mscratch   | Scrratch for M trap.|                    |
// | mepc       | M expt pc.          |                    |
// | mcause     | M trap cause.       |                    |
// | mtval      | M bad addr or inst. |                    |
// | mip        | M int pedning.    . |                    |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//                  Supervisor Trap Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | sstatus    | S status register.  |                    |
// | sie        | S int enable.       |                    |
// | stvec      | S trap handle addr. |                    |
// |------------|---------------------|--------------------|
// ps. U-mode trap is not support, sedeleg and sideleg is not exist.
//    scounteren in hpcp_csr.

//----------------------------------------------------------
//                 Supervisor Trap Handling
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | sscratch   | Scrratch for S trap.|                    |
// | sepc       | S expt pc.          |                    |
// | scause     | S trap cause.       |                    |
// | stval      | S bad addr or inst. |                    |
// | sip        | S int pedning.    . |                    |
// |------------|---------------------|--------------------|

//==========================================================
//                    Define the MSTATUS
//==========================================================
// Machine Status Register
// 64-bit Machine Mode Read/Write
// Providing the CPU Status
// the definiton for MSTATUS register is listed as follows
// ===============================================================
// |63|62 40| 39|38 36|35 34|33 32|31 25|24 23| 22|21| 20| 19| 18|
// +--+-----+---+-----+-----+-----+-----+-----+---+--+---+---+---+
// |SD| Res |MPV| Res | SXL | UXL | Res | VS  |TSR|TM|TVM|MXR|SUM|
// ===============================================================
// ===================================================================
// | 17 |16 15|14 13|12 11|10 9| 8 |  7 | 6 |  5 | 4 | 3 | 2 | 1 | 0 |
// +----+-----+-----+-----+----+---+----+---+----+---+---+---+---+---+
// |MPRV| Res | FS  | MPP | Res|SPP|MPIE|Res|SPIE|Res|MIE|Res|SIE|Res|
// ===================================================================
assign sd = vs[1:0] == 2'b11 || fs_reg[1:0] == 2'b11 || xs[1:0] == 2'b11;

assign mpv = 1'b0;

assign sxl[1:0] = regs_mxl[1:0];

assign uxl[1:0] = regs_mxl[1:0];

// &Force("input", "rtu_cp0_vs_dirty_updt"); @134
// &Force("input", "rtu_cp0_vs_dirty_updt_dp"); @135
assign vs = 2'b0;
assign vs_dirty_upd_gate = 1'b0;
assign vxrm_local_en = 1'b0;
assign vxsat_local_en = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    tsr  <= 1'b0;
    tw   <= 1'b0;
    tvm  <= 1'b0;
    mprv <= 1'b0;
  end
  else if(mstatus_local_en)
  begin
    tsr  <= iui_regs_wdata[22];
    tw   <= iui_regs_wdata[21];
    tvm  <= iui_regs_wdata[20];
    mprv <= iui_regs_wdata[17];
  end
  else
  begin
    tsr  <= tsr;
    tw   <= tw;
    tvm  <= tvm;
    mprv <= mprv;
  end
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    mxr  <= 1'b0;
    sum  <= 1'b0;
  end
  else if(mstatus_local_en)
  begin
    mxr  <= iui_regs_wdata[19];
    sum  <= iui_regs_wdata[18];
  end
  else if(sstatus_local_en)
  begin
    mxr  <= iui_regs_wdata[19];
    sum  <= iui_regs_wdata[18];
  end
  else
  begin
    mxr  <= mxr;
    sum  <= sum;
  end
end

assign xs[1:0] = 2'b00;

assign fs_dirty_upd_gate = rtu_cp0_fs_dirty_updt_dp && (fs[1:0] == 2'b1 || fs[1:0] == 2'b10);
assign fs_dirty_upd = (rtu_cp0_fs_dirty_updt
                    || fcsr_local_en
                    || frm_local_en
                    || fflags_local_en
                    || fxcr_local_en
                    || vxrm_local_en
                    || vxsat_local_en)
                   && (fs[1:0] == 2'b1 || fs[1:0] == 2'b10);

always @(posedge float_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fs_reg[1:0] <= 2'b0;
  else if(mstatus_local_en)
    fs_reg[1:0] <= iui_regs_wdata[14:13];
  else if(sstatus_local_en)
    fs_reg[1:0] <= iui_regs_wdata[14:13];
  else if(fs_dirty_upd)
    fs_reg[1:0] <= 2'b11;
  else
    fs_reg[1:0] <= fs_reg[1:0];
end

assign fs[1:0] = fs_reg[1:0];
assign fs_off = fs[1:0] == 2'b0;


// PM field in mxstatus.
assign pm_wen = rtu_yy_xx_expt_vld
                || iui_regs_inst_mret
                || iui_regs_inst_sret
                || rtu_cp0_exit_debug;

// &CombBeg; @235
always @( mdeleg_vld_dp
       or pm[1:0]
       or sstatus_spp
       or rtu_cp0_exit_debug
       or iui_regs_inst_sret
       or dtu_cp0_dcsr_prv[1:0]
       or mpp[1:0]
       or iui_regs_inst_mret)
begin
  if(rtu_cp0_exit_debug)
    pm_wdata[1:0] = dtu_cp0_dcsr_prv[1:0];
  else if(iui_regs_inst_mret)
    pm_wdata[1:0] = mpp[1:0];
  else if(iui_regs_inst_sret)
    pm_wdata[1:0] = {1'b0, sstatus_spp};
  else if(!mdeleg_vld_dp)
    pm_wdata[1:0] = 2'b11;
  else if(mdeleg_vld_dp)
    pm_wdata[1:0] = 2'b01;
  else
    pm_wdata[1:0] = pm[1:0];
// &CombEnd; @248
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pm_bits[1:0] <= 2'b11;
  else if(pm_wen)
    pm_bits[1:0] <= pm_wdata[1:0];
  else
    pm_bits[1:0] <= pm_bits[1:0];
end

//when in debug mode, all op should executed at m mode priv level
assign pm[1:0] = pm_bits[1:0] | {2{rtu_yy_xx_dbgon}};

assign regs_mpp_write_ill = iui_regs_wdata[12:11] == 2'b10; 

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpp[1:0] <= 2'b11;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mpp[1:0] <= pm[1:0];
  else if(iui_regs_inst_mret)
    mpp[1:0] <= 2'b00;
  else if(mstatus_local_en && regs_mpp_write_ill)
    mpp[1:0] <= 2'b00;
  else if(mstatus_local_en)
    mpp[1:0] <= iui_regs_wdata[12:11];
  else
    mpp[1:0] <= mpp[1:0];
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    spp <= 1'b1;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    spp <= pm[0];
  else if(iui_regs_inst_sret)
    spp <= 1'b0;
  else if(mstatus_local_en)
    spp <= iui_regs_wdata[8];
  else if(sstatus_local_en)
    spp <= iui_regs_wdata[8];
  else
    spp <= spp;
end

assign sstatus_spp = spp;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpie <= 1'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mpie <= mie_bit;
  else if(iui_regs_inst_mret)
    mpie <= 1'b1;
  else if(mstatus_local_en)
    mpie <= iui_regs_wdata[7];
  else
    mpie <= mpie;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    spie <= 1'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    spie <= sie_bit;
  else if(iui_regs_inst_sret)
    spie <= 1'b1;
  else if(mstatus_local_en)
    spie <= iui_regs_wdata[5];
  else if(sstatus_local_en)
    spie <= iui_regs_wdata[5];
  else
    spie <= spie;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mie_bit <= 1'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mie_bit <= 1'b0;
  else if(iui_regs_inst_mret)
    mie_bit <= mpie;
  else if(mstatus_local_en)
    mie_bit <= iui_regs_wdata[3];
  else
    mie_bit <= mie_bit;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sie_bit <= 1'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    sie_bit <= 1'b0;
  else if(iui_regs_inst_sret)
    sie_bit <= spie;
  else if(mstatus_local_en)
    sie_bit <= iui_regs_wdata[1];
  else if(sstatus_local_en)
    sie_bit <= iui_regs_wdata[1];
  else
    sie_bit <= sie_bit;
end

assign mstatus_value[63:0]  = {sd, 23'b0, mpv, 3'b0, sxl[1:0], uxl[1:0], 7'b0, vs[1:0],
                               tsr, tw, tvm, mxr, sum, mprv, 
                               xs[1:0], fs_reg[1:0], mpp[1:0], 2'b0, spp,
                               mpie, 1'b0, spie, 1'b0, mie_bit, 1'b0, sie_bit, 1'b0};

//==========================================================
//                    Define the SSTATUS
//==========================================================
//  Supervisor Status Register
//  64-bit Supervisor Mode Read/Write
//  Providing the CPU Status
//  the definiton for SSTATUS register is listed as follows
//==========================================================
assign sstatus_value[63:0]  = {sd, 29'b0, uxl[1:0], 7'b0, vs[1:0], 3'b0,
                               mxr, sum, 1'b0, xs[1:0], fs_reg[1:0],
                               4'b0, sstatus_spp, 2'b0, spie, 1'b0,
                               2'b0, sie_bit, 1'b0};

//==========================================================
//                    Define the MEDELEG
//==========================================================
//  Machine Exception Delegation Register
//  64-bit Machine Mode Read/Write
//  Providing the CPU Status
//  the definiton for MEDELEG register is listed as follows
//==========================================================
assign edeleg_upd_val[15:0] = {iui_regs_wdata[15], 1'b0, 
                               iui_regs_wdata[13:12], 2'b0,
                               iui_regs_wdata[9:0]};

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    edeleg[15:0] <= 16'b0;
  else if(medeleg_local_en)
    edeleg[15:0] <= edeleg_upd_val[15:0];
  else
    edeleg[15:0] <= edeleg[15:0];
end
assign medeleg_value[63:0] = {48'b0, edeleg[15:0]};

// decode the vector value
// &CombBeg; @401
always @( rtu_yy_xx_expt_vec[4:0])
begin
case(rtu_yy_xx_expt_vec[4:0])
  5'd1:    vec_num[18:0] = 19'h0002;
  5'd2:    vec_num[18:0] = 19'h0004;
  5'd3:    vec_num[18:0] = 19'h0008;
  5'd4:    vec_num[18:0] = 19'h0010;
  5'd5:    vec_num[18:0] = 19'h0020;
  5'd6:    vec_num[18:0] = 19'h0040;
  5'd7:    vec_num[18:0] = 19'h0080;
  5'd8:    vec_num[18:0] = 19'h0100;
  5'd9:    vec_num[18:0] = 19'h0200;
  5'd11:   vec_num[18:0] = 19'h0800;
  5'd12:   vec_num[18:0] = 19'h1000;
  5'd13:   vec_num[18:0] = 19'h2000;
  5'd15:   vec_num[18:0] = 19'h8000;
  5'd16:   vec_num[18:0] = 19'h10000;
  5'd17:   vec_num[18:0] = 19'h20000;
  5'd18:   vec_num[18:0] = 19'h40000;
  default: vec_num[18:0] = 19'h0;
endcase
// &CombEnd; @421
end

// medeleg valid when cpu in s-mode and vector hit
assign medeleg_vld_dp = (pm[1] == 1'b0) && !rtu_yy_xx_expt_int
                 && |(vec_num[15:0] & edeleg[15:0]);

//==========================================================
//                    Define the MIDELEG
//==========================================================
//  Machine Interrupt Delegation Register
//  64-bit Machine Mode Read/Write
//  Providing the CPU Status
//  the definiton for MIDELEG register is listed as follows
//  mhie for pc trace Halt int
//  moie for hpm Overflow int
//  mcie for error Correction int
//==========================================================
assign mhie_deleg = 1'b0;

assign mcie_deleg = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    moie_deleg <= 1'b0;
    seie_deleg <= 1'b0;
    stie_deleg <= 1'b0;
    ssie_deleg <= 1'b0;
  end
  else if(mideleg_local_en)
  begin
    moie_deleg <= iui_regs_wdata[17];
    seie_deleg <= iui_regs_wdata[9];
    stie_deleg <= iui_regs_wdata[5];
    ssie_deleg <= iui_regs_wdata[1];
  end
  else
  begin
    moie_deleg <= moie_deleg;
    seie_deleg <= seie_deleg;
    stie_deleg <= stie_deleg;
    ssie_deleg <= ssie_deleg;
  end
end

assign mideleg[63:0] = {45'b0, mhie_deleg, moie_deleg, mcie_deleg,
                        6'b0, seie_deleg, 1'b0,
                        2'b0, stie_deleg, 1'b0,
                        2'b0, ssie_deleg, 1'b0};

assign mideleg_value[63:0] = mideleg[63:0];

// mideleg valid when cpu in s-mode/u-mode and vector hit
assign mideleg_vld_dp = (pm[1] == 1'b0) && rtu_yy_xx_expt_int
                 && |(vec_num[18:0] & mideleg[18:0]);

assign mdeleg_vld_dp = medeleg_vld_dp || mideleg_vld_dp;

//==========================================================
//                      Define the MIE
//==========================================================
//  Machine Interrupt Enable Register
//  64-bit Machine Mode Read/Write
//  Providing the Interrupt Local Enable of the current core
//  the definiton for MIE register is listed as follows
//==========================================================
assign mhie = 1'b0;

assign mcie = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    moie <= 1'b0;
    meie <= 1'b0;
    seie <= 1'b0;
    mtie <= 1'b0;
    stie <= 1'b0;
    msie <= 1'b0;
    ssie <= 1'b0;
  end
  else if(mie_local_en)
  begin
    moie <= iui_regs_wdata[17];
    meie <= iui_regs_wdata[11];
    seie <= iui_regs_wdata[9];
    mtie <= iui_regs_wdata[7];
    stie <= iui_regs_wdata[5];
    msie <= iui_regs_wdata[3];
    ssie <= iui_regs_wdata[1];
  end
  else if(sie_local_en)
  begin
    moie <= moip_acc_en ? iui_regs_wdata[17] : moie;
    meie <= meie;
    seie <= seip_acc_en ? iui_regs_wdata[9] : seie;
    mtie <= mtie;
    stie <= stip_acc_en ? iui_regs_wdata[5] : stie;
    msie <= msie;
    ssie <= ssip_acc_en ? iui_regs_wdata[1] : ssie;
  end
  else
  begin
    moie <= moie;
    meie <= meie;
    seie <= seie;
    mtie <= mtie;
    stie <= stie;
    msie <= msie;
    ssie <= ssie;
  end
end
 
assign mie_value[63:0] =  {45'b0, mhie, moie, mcie, 4'b0, 
                                  meie, 1'b0, seie, 1'b0, 
                                  mtie, 1'b0, stie, 1'b0, 
                                  msie, 1'b0, ssie, 1'b0}; 

//==========================================================
//                      Define the SIE
//==========================================================
//  Supervisor Interrupt Enable Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Interrupt Local Enable of the current core
//  the definiton for SIE register is listed as follows
//==========================================================
assign sie_value[63:0] =  {45'b0, mhie && mhip_acc_en,
                            moie && moip_acc_en, mcie && mcip_acc_en,
                            6'b0, seie && seip_acc_en, 1'b0, 
                            2'b0, stie && stip_acc_en, 1'b0, 
                            2'b0, ssie && ssip_acc_en, 1'b0}; 

//==========================================================
//                     Define the MTVEC
//==========================================================
//  Machine Trap Vector Register
//  64-bit Machine Mode Read/Write
//  Providing the Trap Vector Base and Mode 
//  the definiton for MTVEC register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtvec_mode[1:0] <= 2'b0;
  else if(mtvec_local_en)
    mtvec_mode[1:0] <= iui_regs_wdata[1:0];
  else
    mtvec_mode[1:0] <= mtvec_mode[1:0];
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtvec_base[61:0] <= 62'b0;
  else if(mtvec_local_en)
    mtvec_base[61:0] <= iui_regs_wdata[63:2];
  else
    mtvec_base[61:0] <= mtvec_base[61:0];
end

assign mtvec_value[63:0] = {mtvec_base[61:0], 1'b0, mtvec_mode[0]};
// &Force("output", "mtvec_value"); &Force("bus", "mtvec_value", 63, 0); @664

//==========================================================
//                     Define the STVEC
//==========================================================
//  Supervisor Trap Vector Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Trap Vector Base and Mode 
//  the definiton for STVEC register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    stvec_mode[1:0] <= 2'b0;
  else if(stvec_local_en)
    stvec_mode[1:0] <= iui_regs_wdata[1:0];
  else
    stvec_mode[1:0] <= stvec_mode[1:0];
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    stvec_base[61:0] <= 62'b0;
  else if(stvec_local_en)
    stvec_base[61:0] <= iui_regs_wdata[63:2];
  else
    stvec_base[61:0] <= stvec_base[61:0];
end

assign stvec_value[63:0] = {stvec_base[61:0], 1'b0, stvec_mode[0]};
// &Force("output", "stvec_value"); &Force("bus", "stvec_value", 63, 0); @695

//==========================================================
//                   Define the MSCRATCH
//==========================================================
//  Machine Scratch Register
//  64-bit Machine Mode Read/Write
//  Providing the Software Scratch register
//  the definiton for MSCRATCH register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mscratch[63:0] <= 64'b0;
  else if(mscratch_local_en)
    mscratch[63:0] <= iui_regs_wdata[63:0];
  else
    mscratch[63:0] <= mscratch[63:0];
end

assign mscratch_value[63:0] = mscratch[63:0];

//==========================================================
//                   Define the SSCRATCH
//==========================================================
//  Supervisor Scratch Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Software Scratch register
//  the definiton for SSCRATCH register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sscratch[63:0] <= 64'b0;
  else if(sscratch_local_en)
    sscratch[63:0] <= iui_regs_wdata[63:0];
  else
    sscratch[63:0] <= sscratch[63:0];
end

assign sscratch_value[63:0] = sscratch[63:0];

//==========================================================
//                     Define the MEPC
//==========================================================
//  Machine Exception PC Register
//  64-bit Machine Mode Read/Write
//  Providing the Machine Exception PC Register
//  the definiton for MEPC register is listed as follows
//==========================================================
// &Force("bus", "rtu_cp0_epc", 63, 0); @745
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mepc_reg[62:0] <= 63'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mepc_reg[62:0] <= rtu_cp0_epc[63:1];
  else if(mepc_local_en)
    mepc_reg[62:0] <= iui_regs_wdata[63:1];
  else
    mepc_reg[62:0] <= mepc_reg[62:0];
end

assign mepc_value[63:0] = {mepc_reg[62:0], 1'b0};

//==========================================================
//                     Define the SEPC
//==========================================================
//  Supervisor Exception PC Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Supervisor Exception PC Register
//  the definiton for SEPC register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sepc_reg[62:0] <= 63'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    sepc_reg[62:0] <= rtu_cp0_epc[63:1];
  else if(sepc_local_en)
    sepc_reg[62:0] <= iui_regs_wdata[63:1];
  else
    sepc_reg[62:0] <= sepc_reg[62:0];
end

assign sepc_value[63:0] = {sepc_reg[62:0], 1'b0};

//==========================================================
//                    Define the MCAUSE
//==========================================================
//  Machine CAUSE Register
//  64-bit Machine Mode Read/Write
//  Providing the Machine Trap Cause register
//  the definiton for MCAUSE register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    m_intr <= 1'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    m_intr <= rtu_yy_xx_expt_int;
  else if(mcause_local_en)
    m_intr <= iui_regs_wdata[63];
  else
    m_intr <= m_intr;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    m_vector[4:0] <= 5'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    m_vector[4:0] <= rtu_yy_xx_expt_vec[4:0];
  else if(mcause_local_en)
    m_vector[4:0] <= iui_regs_wdata[4:0];
  else
    m_vector[4:0] <= m_vector[4:0];
end

assign mcause_value[63:0]  = {m_intr, 58'b0, m_vector[4:0]};

//==========================================================
//                    Define the SCAUSE
//==========================================================
//  Supervisor CAUSE Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Supervisor Trap Cause register
//  the definiton for SCAUSE register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    s_intr <= 1'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    s_intr <= rtu_yy_xx_expt_int;
  else if(scause_local_en)
    s_intr <= iui_regs_wdata[63];
  else
    s_intr <= s_intr;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    s_vector[4:0] <= 5'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    s_vector[4:0] <= rtu_yy_xx_expt_vec[4:0];
  else if(scause_local_en)
    s_vector[4:0] <= iui_regs_wdata[4:0];
  else
    s_vector[4:0] <= s_vector[4:0];
end

assign scause_value[63:0] = {s_intr, 58'b0, s_vector[4:0]};

//==========================================================
//                     Define the MTVAL
//==========================================================
//  Machine Trap value Register
//  64-bit Machine Mode Read/Write
//  Providing the trap value register
//  the definiton for MTVAL register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtval_data[63:0] <= 64'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp) 
    mtval_data[63:0] <= rtu_cp0_tval[63:0];
  else if(mtval_local_en)
    mtval_data[63:0] <= iui_regs_wdata[63:0];
  else
    mtval_data[63:0] <= mtval_data[63:0];
end

assign mtval_value[63:0] = mtval_data[63:0];

//==========================================================
//                     Define the STVAL
//==========================================================
//  Supervisor Trap value Register
//  64-bit Supervisor Mode Read/Write
//  Providing the trap value register
//  the definiton for STVAL register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    stval_data[63:0] <= 64'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp) 
    stval_data[63:0] <= rtu_cp0_tval[63:0];
  else if(stval_local_en)
    stval_data[63:0] <= iui_regs_wdata[63:0];
  else
    stval_data[63:0] <= stval_data[63:0];
end

assign stval_value[63:0] = stval_data[63:0];

//==========================================================
//                      Define the MIP
//==========================================================
//  Machine Interrupt Pending Register
//  64-bit Machine Mode Read/Write
//  Providing the Interrupt Pending of the current core
//  the definiton for MIP register is listed as follows
//==========================================================
assign mhip_acc_en = mideleg[18];
assign moip_acc_en = mideleg[17];
assign mcip_acc_en = mideleg[16];
assign seip_acc_en = mideleg[9];
assign stip_acc_en = mideleg[5];
assign ssip_acc_en = mideleg[1];

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    seip_reg <= 1'b0;
    stip_reg <= 1'b0;
    ssip_reg <= 1'b0;
  end
  else if(mip_local_en)
  begin
    seip_reg <= iui_regs_wdata[9];
    stip_reg <= iui_regs_wdata[5];
    ssip_reg <= iui_regs_wdata[1];
  end
  else if(sip_local_en && ssip_acc_en)
  begin
    seip_reg <= seip_reg;
    stip_reg <= stip_reg;
    ssip_reg <= iui_regs_wdata[1];
  end
  else
  begin
    seip_reg <= seip_reg;
    stip_reg <= stip_reg;
    ssip_reg <= ssip_reg;
  end
end
  
assign mhip = 1'b0;
assign moip = hpcp_cp0_int_vld;
// assign mcip = ecc_int_vld;
assign mcip = 1'b0;
assign meip = biu_cp0_me_int;
assign mtip = biu_cp0_mt_int;
assign msip = biu_cp0_ms_int;

assign seip = biu_cp0_se_int || seip_reg;
assign stip = biu_cp0_st_int && regs_clintee || stip_reg;
assign ssip = biu_cp0_ss_int && regs_clintee || ssip_reg;

assign mip_value[63:0] =  {45'b0, mhip, moip, mcip, 4'b0,
                                  meip, 1'b0, seip, 1'b0, 
                                  mtip, 1'b0, stip, 1'b0, 
                                  msip, 1'b0, ssip, 1'b0}; 

assign sip_raw[63:0] = {48'b0, 4'b0,
                               2'b0, seip_reg, 1'b0,
                               2'b0, stip_reg, 1'b0,
                               2'b0, ssip_reg, 1'b0};

//==========================================================
//                      Define the SIP
//==========================================================
//  Supervisor Interrupt Pending Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Interrupt Pending of the current core
//  the definiton for SIP register is listed as follows
//==========================================================
assign sip_value[63:0] =  {45'b0, mhip && mhip_acc_en,
                            moip && moip_acc_en, mcip && mcip_acc_en,
                            6'b0, seip && seip_acc_en, 1'b0, 
                            2'b0, stip && stip_acc_en, 1'b0, 
                            2'b0, ssip && ssip_acc_en, 1'b0}; 

//==========================================================
//                      Int Judgement
//==========================================================
assign mhip_en = mhie && mhip;
assign moip_en = moie && moip;
assign mcip_en = mcie && mcip;
assign meip_en = meie && meip;
assign mtip_en = mtie && mtip;
assign msip_en = msie && msip;

assign seip_en = seie && seip;
assign stip_en = stie && stip;
assign ssip_en = ssie && ssip;

// For MEI, MTI, MSI: 
assign mhip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                        || pm[1:0] == 2'b01
                        || pm[1:0] == 2'b00)
                      && mhip_en && !mideleg[18];
assign moip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                        || pm[1:0] == 2'b01
                        || pm[1:0] == 2'b00)
                      && moip_en && !mideleg[17];
assign mcip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                        || pm[1:0] == 2'b01
                        || pm[1:0] == 2'b00)
                      && mcip_en && !mideleg[16];
assign mhip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                      || pm[1:0] == 2'b00)
                    && mhip_en && mideleg[18];
assign moip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                      || pm[1:0] == 2'b00)
                    && moip_en && mideleg[17];
assign mcip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                      || pm[1:0] == 2'b00)
                    && mcip_en && mideleg[16];
assign meip_vld = (pm[1:0] != 2'b11 || mie_bit) && meip_en;
assign mtip_vld = (pm[1:0] != 2'b11 || mie_bit) && mtip_en;
assign msip_vld = (pm[1:0] != 2'b11 || mie_bit) && msip_en;

// For SEI, STI, SSI: 
// M-Mode -> MIE Controlled when non-delegation;
// S-Mode -> SIE Controlled
// U-Mode -> Global always on
assign seip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                          || pm[1:0] == 2'b01
                          || pm[1:0] == 2'b00)
                        && seip_en && !mideleg[9];
assign stip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                          || pm[1:0] == 2'b01
                          || pm[1:0] == 2'b00)
                        && stip_en && !mideleg[5];
assign ssip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit
                          || pm[1:0] == 2'b01
                          || pm[1:0] == 2'b00)
                        && ssip_en && !mideleg[1];
assign seip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                        || pm[1:0] == 2'b00)
                      && seip_en && mideleg[9];
assign stip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                        || pm[1:0] == 2'b00)
                      && stip_en && mideleg[5];
assign ssip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                        || pm[1:0] == 2'b00)
                      && ssip_en && mideleg[1];

assign int_sel[14:0] = {mcip_nodeleg_vld, mhip_nodeleg_vld,
                        meip_vld, msip_vld, mtip_vld,
                        seip_nodeleg_vld, ssip_nodeleg_vld, stip_nodeleg_vld,
                        moip_nodeleg_vld,
                        mcip_deleg_vld, mhip_deleg_vld,
                        seip_deleg_vld, ssip_deleg_vld, stip_deleg_vld,
                        moip_deleg_vld};

assign lpmd_ack_vld = meip_en || mtip_en || msip_en || moip_en || mcip_en
                   || seip_en || stip_en || ssip_en;

//==========================================================
//                  Trap Address Generate
//==========================================================
assign regs_tvec[39:0]  = pm[1:0] == 2'b11 ? mtvec_value[39:0]
                                           : stvec_value[39:0];

assign regs_vector[4:0] = pm[1:0] == 2'b11 ? m_vector[4:0]
                                           : s_vector[4:0];

assign regs_intr        = pm[1:0] == 2'b11 ? m_intr
                                           : s_intr;

assign vec_int_pc[39:0] = {regs_tvec[39:2], 2'b0}
                        + {33'b0, regs_vector[4:0], 2'b0};

assign regs_trap_pc[39:0] = regs_intr && regs_tvec[0] ? vec_int_pc[39:0]
                                                      : {regs_tvec[39:2], 2'b0};

//==========================================================
//                     HPCP information
//==========================================================
assign int_off_vld = (pm[1:0] == 2'b11) && !mie_bit
                  || (pm[1:0] == 2'b01) && !sie_bit;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign regs_pm[1:0] = pm[1:0];
assign regs_tvm     = tvm;
assign regs_fs_off  = fs_off;

assign regs_iui_tsr     = tsr;
assign regs_iui_tvm     = tvm;
assign regs_iui_tw      = tw;
assign regs_iui_pm[1:0] = pm[1:0];

assign regs_iui_mepc[39:0] = {mepc_reg[38:0], 1'b0};
assign regs_iui_sepc[39:0] = {sepc_reg[38:0], 1'b0};

assign regs_lpmd_int_vld = lpmd_ack_vld;

//----------------------------------------------------------
//                          For XX
//----------------------------------------------------------
assign cp0_yy_priv_mode[1:0] = pm[1:0];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign cp0_rtu_int_vld[14:0] = int_sel[14:0];
assign cp0_rtu_trap_pc[39:0] = regs_trap_pc[39:0];

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign cp0_idu_fs[1:0] = fs[1:0];
assign cp0_idu_vs[1:0] = vs[1:0];

//----------------------------------------------------------
//                         For PMP
//----------------------------------------------------------
//assign cp0_pmp_mpp[1:0] = mpp[1:0];
//assign cp0_pmp_mprv     = mprv;

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_sum = sum;
//assign cp0_mmu_mpp[1:0] = mpp[1:0];
//assign cp0_mmu_mprv     = mprv;
assign cp0_mmu_mxr      = mxr;

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign cp0_lsu_mpp[1:0] = mpp[1:0];
assign cp0_lsu_mprv     = rtu_yy_xx_dbgon ? dtu_cp0_dcsr_mprven && mprv : mprv;

//----------------------------------------------------------
//                         For HAD
//----------------------------------------------------------
assign cp0_dtu_mexpt_vld = rtu_yy_xx_expt_vld && !mdeleg_vld_dp;

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
assign cp0_hpcp_int_off_vld = int_off_vld;


// &ModuleEnd; @1155
endmodule



