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
module aq_cp0_ext_csr(
  biu_cp0_rvba,
  cp0_biu_icg_en,
  cp0_dtu_icg_en,
  cp0_dtu_pcfifo_frz,
  cp0_hpcp_icg_en,
  cp0_hpcp_pmdm,
  cp0_hpcp_pmds,
  cp0_hpcp_pmdu,
  cp0_idu_cskyee,
  cp0_idu_dis_fence_in_dbg,
  cp0_idu_icg_en,
  cp0_idu_ucme,
  cp0_ifu_bht_en,
  cp0_ifu_btb_clr,
  cp0_ifu_btb_en,
  cp0_ifu_icache_en,
  cp0_ifu_icache_pref_en,
  cp0_ifu_icache_read_index,
  cp0_ifu_icache_read_req,
  cp0_ifu_icache_read_tag,
  cp0_ifu_icache_read_way,
  cp0_ifu_icg_en,
  cp0_ifu_iwpe,
  cp0_ifu_ras_en,
  cp0_iu_icg_en,
  cp0_lsu_amr,
  cp0_lsu_dcache_en,
  cp0_lsu_dcache_pref_dist,
  cp0_lsu_dcache_pref_en,
  cp0_lsu_dcache_read_idx,
  cp0_lsu_dcache_read_req,
  cp0_lsu_dcache_read_type,
  cp0_lsu_dcache_read_way,
  cp0_lsu_dcache_wa,
  cp0_lsu_dcache_wb,
  cp0_lsu_icg_en,
  cp0_lsu_mm,
  cp0_lsu_we_en,
  cp0_mmu_icg_en,
  cp0_mmu_maee,
  cp0_mmu_ptw_en,
  cp0_pmp_icg_en,
  cp0_rtu_icg_en,
  cp0_vpu_icg_en,
  cp0_xx_mrvbr,
  cpurst_b,
  ifu_cp0_bht_inv_done,
  ifu_cp0_icache_inv_done,
  ifu_cp0_icache_read_data,
  ifu_cp0_icache_read_data_vld,
  iui_regs_wdata,
  lsu_cp0_dcache_read_data,
  lsu_cp0_dcache_read_data_vld,
  lsu_cp0_icc_done,
  mapbaddr_value,
  mccr2_value,
  mcdata0_value,
  mcdata1_value,
  mcer2_value,
  mcer_value,
  mcindex_local_en,
  mcindex_value,
  mcins_local_en,
  mcins_value,
  mcor_local_en,
  mcor_value,
  meicr2_value,
  meicr_value,
  mhcr_local_en,
  mhcr_value,
  mhint2_local_en,
  mhint2_value,
  mhint3_value,
  mhint4_value,
  mhint_local_en,
  mhint_value,
  mhpmcr_local_en,
  mrmr_value,
  mrvbr_value,
  mxstatus_local_en,
  mxstatus_value,
  regs_clintee,
  regs_clk,
  regs_flush_clk,
  regs_iui_mcins_stall,
  regs_iui_mcor_stall,
  regs_mcins_busy,
  regs_mcor_busy,
  regs_pm,
  regs_special_bht_inv,
  regs_special_dcache_clr,
  regs_special_dcache_inv,
  regs_special_dcache_req,
  regs_special_icache_inv,
  regs_xx_icg_en,
  rtu_yy_xx_flush,
  scer2_value,
  scer_value,
  shcr_value,
  shint2_value,
  shint_value,
  shpmcr_local_en,
  sxstatus_local_en,
  sxstatus_value,
  sysio_cp0_apb_base
);


// &Ports; @25
input   [39 :0]  biu_cp0_rvba;                
input            cpurst_b;                    
input            ifu_cp0_bht_inv_done;        
input            ifu_cp0_icache_inv_done;     
input   [127:0]  ifu_cp0_icache_read_data;    
input            ifu_cp0_icache_read_data_vld; 
input   [63 :0]  iui_regs_wdata;              
input   [127:0]  lsu_cp0_dcache_read_data;    
input            lsu_cp0_dcache_read_data_vld; 
input            lsu_cp0_icc_done;            
input            mcindex_local_en;            
input            mcins_local_en;              
input            mcor_local_en;               
input            mhcr_local_en;               
input            mhint2_local_en;             
input            mhint_local_en;              
input            mhpmcr_local_en;             
input            mxstatus_local_en;           
input            regs_clk;                    
input            regs_flush_clk;              
input   [1  :0]  regs_pm;                     
input            rtu_yy_xx_flush;             
input            shpmcr_local_en;             
input            sxstatus_local_en;           
input   [39 :0]  sysio_cp0_apb_base;          
output           cp0_biu_icg_en;              
output           cp0_dtu_icg_en;              
output           cp0_dtu_pcfifo_frz;          
output           cp0_hpcp_icg_en;             
output           cp0_hpcp_pmdm;               
output           cp0_hpcp_pmds;               
output           cp0_hpcp_pmdu;               
output           cp0_idu_cskyee;              
output           cp0_idu_dis_fence_in_dbg;    
output           cp0_idu_icg_en;              
output           cp0_idu_ucme;                
output           cp0_ifu_bht_en;              
output           cp0_ifu_btb_clr;             
output           cp0_ifu_btb_en;              
output           cp0_ifu_icache_en;           
output           cp0_ifu_icache_pref_en;      
output  [13 :0]  cp0_ifu_icache_read_index;   
output           cp0_ifu_icache_read_req;     
output           cp0_ifu_icache_read_tag;     
output           cp0_ifu_icache_read_way;     
output           cp0_ifu_icg_en;              
output           cp0_ifu_iwpe;                
output           cp0_ifu_ras_en;              
output           cp0_iu_icg_en;               
output  [1  :0]  cp0_lsu_amr;                 
output           cp0_lsu_dcache_en;           
output  [1  :0]  cp0_lsu_dcache_pref_dist;    
output           cp0_lsu_dcache_pref_en;      
output  [16 :0]  cp0_lsu_dcache_read_idx;     
output           cp0_lsu_dcache_read_req;     
output           cp0_lsu_dcache_read_type;    
output  [1  :0]  cp0_lsu_dcache_read_way;     
output           cp0_lsu_dcache_wa;           
output           cp0_lsu_dcache_wb;           
output           cp0_lsu_icg_en;              
output           cp0_lsu_mm;                  
output           cp0_lsu_we_en;               
output           cp0_mmu_icg_en;              
output           cp0_mmu_maee;                
output           cp0_mmu_ptw_en;              
output           cp0_pmp_icg_en;              
output           cp0_rtu_icg_en;              
output           cp0_vpu_icg_en;              
output  [39 :0]  cp0_xx_mrvbr;                
output  [63 :0]  mapbaddr_value;              
output  [63 :0]  mccr2_value;                 
output  [63 :0]  mcdata0_value;               
output  [63 :0]  mcdata1_value;               
output  [63 :0]  mcer2_value;                 
output  [63 :0]  mcer_value;                  
output  [63 :0]  mcindex_value;               
output  [63 :0]  mcins_value;                 
output  [63 :0]  mcor_value;                  
output  [63 :0]  meicr2_value;                
output  [63 :0]  meicr_value;                 
output  [63 :0]  mhcr_value;                  
output  [63 :0]  mhint2_value;                
output  [63 :0]  mhint3_value;                
output  [63 :0]  mhint4_value;                
output  [63 :0]  mhint_value;                 
output  [63 :0]  mrmr_value;                  
output  [63 :0]  mrvbr_value;                 
output  [63 :0]  mxstatus_value;              
output           regs_clintee;                
output           regs_iui_mcins_stall;        
output           regs_iui_mcor_stall;         
output           regs_mcins_busy;             
output           regs_mcor_busy;              
output           regs_special_bht_inv;        
output           regs_special_dcache_clr;     
output           regs_special_dcache_inv;     
output           regs_special_dcache_req;     
output           regs_special_icache_inv;     
output           regs_xx_icg_en;              
output  [63 :0]  scer2_value;                 
output  [63 :0]  scer_value;                  
output  [63 :0]  shcr_value;                  
output  [63 :0]  shint2_value;                
output  [63 :0]  shint_value;                 
output  [63 :0]  sxstatus_value;              

// &Regs; @26
reg     [1  :0]  amr;                         
reg              bht_inv;                     
reg              bpe;                         
reg              btb_inv;                     
reg              btbe;                        
reg     [63 :0]  cdata0;                      
reg     [63 :0]  cdata1;                      
reg     [127:0]  cdata_read_data;             
reg     [20 :0]  cindex_index;                
reg     [3  :0]  cindex_rid;                  
reg     [3  :0]  cindex_way;                  
reg              cins_r;                      
reg              clintee;                     
reg              clr;                         
reg              cskyisaee;                   
reg              dcache_inv;                  
reg     [1  :0]  dcache_pref_dist;            
reg              dcache_pref_en;              
reg              de;                          
reg              fence_in_dbg_dis;            
reg              icache_inv;                  
reg              icache_pref_en;              
reg              ie;                          
reg              insde;                       
reg              iwpe;                        
reg              maee;                        
reg              mhrd;                        
reg              mm;                          
reg     [8  :0]  module_icg_en;               
reg              pcfifo_freeze;               
reg              pmdm;                        
reg              pmds;                        
reg              pmdu;                        
reg              rse;                         
reg     [1  :0]  sel;                         
reg              ucme;                        
reg              wa;                          

// &Wires; @27
wire             amr2;                        
wire    [127:0]  biu_cp0_l2_read_data;        
wire             biu_cp0_l2_read_data_vld;    
wire    [39 :0]  biu_cp0_rvba;                
wire             cdata_clk;                   
wire             cdata_data_vld;              
wire             cindex_rid_dcache_data;      
wire             cindex_rid_dcache_st_tag;    
wire             cindex_rid_icache_data;      
wire             cindex_rid_icache_tag;       
wire             cins_no_op_data_vld;         
wire             cins_read_data_vld;          
wire             clr_done;                    
wire             cp0_biu_icg_en;              
wire             cp0_dtu_icg_en;              
wire             cp0_dtu_pcfifo_frz;          
wire             cp0_hpcp_icg_en;             
wire             cp0_hpcp_pmdm;               
wire             cp0_hpcp_pmds;               
wire             cp0_hpcp_pmdu;               
wire             cp0_idu_cskyee;              
wire             cp0_idu_dis_fence_in_dbg;    
wire             cp0_idu_icg_en;              
wire             cp0_idu_ucme;                
wire             cp0_ifu_bht_en;              
wire             cp0_ifu_btb_clr;             
wire             cp0_ifu_btb_en;              
wire             cp0_ifu_icache_en;           
wire             cp0_ifu_icache_pref_en;      
wire    [13 :0]  cp0_ifu_icache_read_index;   
wire             cp0_ifu_icache_read_req;     
wire             cp0_ifu_icache_read_tag;     
wire             cp0_ifu_icache_read_way;     
wire             cp0_ifu_icg_en;              
wire             cp0_ifu_iwpe;                
wire             cp0_ifu_ras_en;              
wire             cp0_iu_icg_en;               
wire    [1  :0]  cp0_lsu_amr;                 
wire             cp0_lsu_dcache_en;           
wire    [1  :0]  cp0_lsu_dcache_pref_dist;    
wire             cp0_lsu_dcache_pref_en;      
wire    [16 :0]  cp0_lsu_dcache_read_idx;     
wire             cp0_lsu_dcache_read_req;     
wire             cp0_lsu_dcache_read_type;    
wire    [1  :0]  cp0_lsu_dcache_read_way;     
wire             cp0_lsu_dcache_wa;           
wire             cp0_lsu_dcache_wb;           
wire             cp0_lsu_icg_en;              
wire             cp0_lsu_mm;                  
wire             cp0_lsu_we_en;               
wire             cp0_mmu_icg_en;              
wire             cp0_mmu_maee;                
wire             cp0_mmu_ptw_en;              
wire             cp0_pmp_icg_en;              
wire             cp0_rtu_icg_en;              
wire             cp0_vpu_icg_en;              
wire    [39 :0]  cp0_xx_mrvbr;                
wire             cpurst_b;                    
wire    [16 :0]  dcache_read_idx;             
wire             dcache_read_req;             
wire             dcache_read_tag;             
wire    [1  :0]  dcache_read_way;             
wire             ecc_en;                      
wire             fccee;                       
wire             ibp_inv;                     
wire             ibpe;                        
wire    [16 :0]  icache_read_idx;             
wire             icache_read_req;             
wire             icache_read_tag;             
wire             icache_read_way;             
wire             ifu_cp0_bht_inv_done;        
wire             ifu_cp0_icache_inv_done;     
wire    [127:0]  ifu_cp0_icache_read_data;    
wire             ifu_cp0_icache_read_data_vld; 
wire             inv;                         
wire    [63 :0]  iui_regs_wdata;              
wire             l0btbe;                      
wire    [1  :0]  l2_pref_dist;                
wire             l2pld;                       
wire             l2stpld;                     
wire             lpe;                         
wire    [127:0]  lsu_cp0_dcache_read_data;    
wire             lsu_cp0_dcache_read_data_vld; 
wire             lsu_cp0_icc_done;            
wire    [63 :0]  mapbaddr_value;              
wire    [63 :0]  mccr2_value;                 
wire    [63 :0]  mcdata0_value;               
wire    [63 :0]  mcdata1_value;               
wire    [63 :0]  mcer2_value;                 
wire    [63 :0]  mcer_value;                  
wire             mcindex_local_en;            
wire    [63 :0]  mcindex_value;               
wire             mcins_busy;                  
wire             mcins_local_en;              
wire    [63 :0]  mcins_value;                 
wire             mcor_busy;                   
wire             mcor_local_en;               
wire    [63 :0]  mcor_value;                  
wire    [63 :0]  meicr2_value;                
wire    [63 :0]  meicr_value;                 
wire             mhcr_local_en;               
wire    [63 :0]  mhcr_value;                  
wire             mhint2_local_en;             
wire    [63 :0]  mhint2_value;                
wire    [63 :0]  mhint3_value;                
wire    [63 :0]  mhint4_value;                
wire             mhint_local_en;              
wire    [63 :0]  mhint_value;                 
wire             mhpmcr_local_en;             
wire    [63 :0]  mrmr_value;                  
wire    [39 :0]  mrvbr_reg;                   
wire    [63 :0]  mrvbr_value;                 
wire             mxstatus_local_en;           
wire    [63 :0]  mxstatus_value;              
wire             nsfe;                        
wire             pmp4k;                       
wire             regs_clintee;                
wire             regs_clk;                    
wire             regs_flush_clk;              
wire             regs_iui_mcins_stall;        
wire             regs_iui_mcor_stall;         
wire             regs_mcins_busy;             
wire             regs_mcor_busy;              
wire    [1  :0]  regs_pm;                     
wire             regs_special_bht_inv;        
wire             regs_special_dcache_clr;     
wire             regs_special_dcache_inv;     
wire             regs_special_dcache_req;     
wire             regs_special_icache_inv;     
wire             regs_xx_icg_en;              
wire             rtu_yy_xx_flush;             
wire    [63 :0]  scer2_value;                 
wire    [63 :0]  scer_value;                  
wire    [2  :0]  sck;                         
wire    [63 :0]  shcr_value;                  
wire    [63 :0]  shint2_value;                
wire    [63 :0]  shint_value;                 
wire             shpmcr_local_en;             
wire             sre;                         
wire             sxstatus_local_en;           
wire    [63 :0]  sxstatus_value;              
wire    [39 :0]  sysio_cp0_apb_base;          
wire             tlb_broad_dis;               
wire             v;                           
wire             ve;                          
wire             wb;                          
wire             wbr;                         


//==========================================================
//                        Extension
//==========================================================
//----------------------------------------------------------
//           Machine Control and Status Extension
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mxstatus   | M ext status reg.   |                    |
// | mhcr       | M hw config reg.    |                    |
// | mcor       | M cache oper reg.   |                    |
// | mhint      | M hint reg.         |                    |
// | mrmr       | M reset mode.       |                    |
// | mrvbr      | M reset base.       |                    |
// | mcntwen    | M counter write en  | In hpcp_csr        |
// | mcntinten  | M counter int en    | In HPCP            |
// | mcntintof  | M counter overflow  | In HPCP
// | mhint2     | M hint reg.         |                    |
// | mhint3     | M hint reg.         |                    |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//         Supervisor Control and Status Extension
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | sxstatus   | S ext status reg.   |                    |
// | shcr       | S hw config reg.    |                    |
// | shint      | S hint reg.         |                    |
// | shint2     | S hint reg.         |                    |
// | scntinten  | S counter int en    | In HPCP            |
// | scntintof  | S counter overflow  | In HPCP
// | shpmcnt    | S counter           | In HPCP
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//                 Machine L1 Cache Control
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mcer       | M l1 cache err.     | Reserved           |
// | meicr      | M l1 ecc injection  | Reserved           |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//               Supervisor L1 Cache Control
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | scer       | S l1 cache err.     | Reserved           |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//                 Machine L2 Cache Control
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mccr2      | M l2 cache oper     | Reserved           |
// | mcer2      | M l2 cache err.     | Reserved           |
// | meicr2     | M l2 ecc injection  | Reserved           |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//               Supervisor L2 Cache Control
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | scer2      | S l2 cache err.     | Reserved           |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//              Machine Cache Access Extension
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mcins      | Cache inst reg      |                    |
// | mcindex    | Cache index         |                    |
// | mcdata0    | Cache data0         |                    |
// | mcdata1    | Cache data1         |                    |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//                Machine CPU Info Extension
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mcpuid     | CPU ID              |                    |
// | mapbaddr   | APB bus base addr.  |                    |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//            Supervisor MMU Control and Status
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | smcir      | MMU control         | In MMU             |
// | smir       | MMU index           | In MMU             |
// | smeh       | MMU entry high      | In MMU             |
// | smel       | MMU entry low       | In MMU             |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//               User Float Control Extension
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | fxcr       | float control       | In float_csr       |
// |------------|---------------------|--------------------|

// &Force("bus", "iui_regs_wdata", 63, 0); @148
//==========================================================
//                   Define the MXSTATUS
//==========================================================
//  Machine Extension Status register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Extension Status of the current core
//  the definiton for MXSTATUS register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    mm    <= 1'b1;
    pmds  <= 1'b0;
    pmdu  <= 1'b0;
  end
  else if(mxstatus_local_en)
  begin
    mm    <= iui_regs_wdata[15];
    pmds  <= iui_regs_wdata[11];
    pmdu  <= iui_regs_wdata[10];
  end
  else if(sxstatus_local_en)
  begin
    mm    <= iui_regs_wdata[15];
    pmds  <= iui_regs_wdata[11];
    pmdu  <= iui_regs_wdata[10];
  end
    else if(mhpmcr_local_en)
  begin
    mm    <= mm;
    pmds  <= iui_regs_wdata[11];
    pmdu  <= iui_regs_wdata[10];
  end
  else if(shpmcr_local_en)
  begin
    mm    <= mm;
    pmds  <= iui_regs_wdata[11];
    pmdu  <= iui_regs_wdata[10];
  end
  else
  begin
    mm    <= mm;
    pmds  <= pmds;
    pmdu  <= pmdu;
  end
end

assign fccee = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    cskyisaee <= 1'b1;
    maee      <= 1'b1;
    insde     <= 1'b0;
    mhrd      <= 1'b0;
    clintee   <= 1'b1;
    ucme      <= 1'b1;
    // pmp4k     <= 1'b0;
    pmdm      <= 1'b0;
  end
  else if(mxstatus_local_en)
  begin
    cskyisaee <= iui_regs_wdata[22];
    maee      <= iui_regs_wdata[21];
    insde     <= iui_regs_wdata[19];
    mhrd      <= iui_regs_wdata[18];
    clintee   <= iui_regs_wdata[17];
    ucme      <= iui_regs_wdata[16];
    // pmp4k     <= iui_regs_wdata[14];
    pmdm      <= iui_regs_wdata[13];
  end
  else if(mhpmcr_local_en)
  begin
    cskyisaee <= cskyisaee;
    maee      <= maee;
    insde     <= insde;
    mhrd      <= mhrd;
    clintee   <= clintee;
    ucme      <= ucme;
    pmdm      <= iui_regs_wdata[13];
  end
  else
  begin
    cskyisaee <= cskyisaee;
    maee      <= maee;
    insde     <= insde;
    mhrd      <= mhrd;
    clintee   <= clintee;
    ucme      <= ucme;
    // pmp4k     <= pmp4k;
    pmdm      <= pmdm;
  end
end

assign pmp4k = 1'b0; // this bit is removed from mxstatus.
assign ve = 1'b0;
assign v  = 1'b0;

assign mxstatus_value[63:0]  = {32'b0, regs_pm[1:0], 7'b0, cskyisaee, maee,
                                fccee, insde, mhrd, clintee, ucme, mm,
                                pmp4k, pmdm, 1'b0, pmds, pmdu, v, ve,
                                8'b0};

//==========================================================
//                   Define the SXSTATUS
//==========================================================
//  Supervisor Extension Status Register
//  64-bit Supervisor Mode Read/Write
//  Providing the C-SKY Extension Status Register
//  the definiton for SXSTATUS register is listed as follows
//==========================================================
assign sxstatus_value[63:0]  = {32'b0, regs_pm[1:0], 7'b0, cskyisaee, maee,
                                fccee, insde, mhrd, clintee, ucme, mm,
                                pmp4k, pmdm, 1'b0, pmds, pmdu, 10'b0};

//==========================================================
//                     Define the MHCR
//==========================================================
//  Machine Hardware Config register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Hardware Config of the current core
//  the definiton for MHCR register is listed as follows
//==========================================================
assign sck[2:0] = 3'b0;//biu_cp0_clkratio[2:0];

assign wbr = 1'b1;

assign ibpe = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    // l0btbe <= 1'b0;
    btbe   <= 1'b0;
  end
  else if(mhcr_local_en)
  begin
    // l0btbe <= iui_regs_wdata[12];
    btbe   <= iui_regs_wdata[6];
  end
  else
  begin
    // l0btbe <= l0btbe;
    btbe   <= btbe;
  end
end
assign l0btbe = 1'b0;

assign wb = 1'b1;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    bpe <= 1'b0;
    rse <= 1'b0;
    wa  <= 1'b0;
    de  <= 1'b0;
    ie  <= 1'b0;
  end
  else if(mhcr_local_en)
  begin
    bpe <= iui_regs_wdata[5];
    rse <= iui_regs_wdata[4];
    wa  <= iui_regs_wdata[2];
    de  <= iui_regs_wdata[1];
    ie  <= iui_regs_wdata[0];
  end
  else
  begin
    bpe <= bpe;
    rse <= rse;
    wa  <= wa;
    de  <= de;
    ie  <= ie;
  end
end

assign mhcr_value[63:0] = {45'b0, sck[2:0], 3'b0, l0btbe, 3'b0, wbr, ibpe,
                           btbe, bpe, rse, wb, wa, de, ie};

//==========================================================
//                     Define the SHCR
//==========================================================
//  Supervisor Hardware Config register
//  64-bit Supervisor Mode Read Only
//  Providing the C-SKY Hardware Config of the current core
//  the definiton for SHCR register is listed as follows
//==========================================================
assign shcr_value[63:0] = {45'b0, sck[2:0], 3'b0, l0btbe, 3'b0, wbr, ibpe,
                           btbe, bpe, rse, wb, wa, de, ie};

//==========================================================
//                     Define the MCOR
//==========================================================
assign ibp_inv =1'b0;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    btb_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
    btb_inv <= 1'b0;
  else if(mcor_local_en) 
    btb_inv <= iui_regs_wdata[17];
//   else if(ifu_cp0_btb_inv_done)
//     btb_inv <= 1'b0;
//   else
//     btb_inv <= btb_inv;
  else
    btb_inv <= 1'b0;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
    bht_inv <= 1'b0;
  else if(mcor_local_en) 
    bht_inv <= iui_regs_wdata[16];
  else if(ifu_cp0_bht_inv_done)
    bht_inv <= 1'b0;
  else
    bht_inv <= bht_inv;
end

//if sel dcache bit is set, wait lsu dcache done
//else always done
assign clr_done = !sel[1] || lsu_cp0_icc_done;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
   clr <= 1'b0;
  else if(rtu_yy_xx_flush)
   clr <= 1'b0;
  else if(mcor_local_en) 
   clr <= iui_regs_wdata[5];
  else if(clr && clr_done)
   clr <= 1'b0;
  else
   clr <= clr;
end

// 1.when inv and clr complete, clear the inv and clr bit.
// 2.mtcr cfr will update inv and clr bit
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      icache_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
      icache_inv <= 1'b0;
  else if(mcor_local_en) 
      icache_inv <= iui_regs_wdata[4];
  else if(icache_inv && (ifu_cp0_icache_inv_done || !sel[0]))
      icache_inv <= 1'b0;
  else
      icache_inv <= icache_inv;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      dcache_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
      dcache_inv <= 1'b0;
  else if(mcor_local_en) 
      dcache_inv <= iui_regs_wdata[4];
  else if(dcache_inv && (lsu_cp0_icc_done || !sel[1]))
      dcache_inv <= 1'b0;
  else
      dcache_inv <= dcache_inv;
end

assign inv = icache_inv || dcache_inv;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sel[1:0] <= 2'b0;
  else if(mcor_local_en) 
    sel[1:0] <= iui_regs_wdata[1:0];
  else
    sel[1:0] <= sel[1:0];
end

// TODO add clk en.
assign mcor_busy = mcor_local_en || ibp_inv || btb_inv
                || bht_inv || clr || inv;
assign mcor_value[63:0] = {45'b0, ibp_inv, btb_inv, bht_inv, 10'b0,
                           clr, inv, 2'b0, sel[1:0]};

//==========================================================
//                     Define the MHINT
//==========================================================
assign ecc_en = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pcfifo_freeze <= 1'b0;
  else if(mhint_local_en)
    pcfifo_freeze <= iui_regs_wdata[24];
  else
    pcfifo_freeze <= pcfifo_freeze; 
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    // l2stpld               <= 1'b0;
    // nsfe                  <= 1'b0;
    // l2_pref_dist[1:0]     <= 2'b10;
    // l2pld                 <= 1'b0;
    dcache_pref_dist[1:0] <= 2'b10;
    // sre                   <= 1'b0;
    iwpe                  <= 1'b0;
    // lpe                   <= 1'b0;
    icache_pref_en        <= 1'b0;
    // amr2                  <= 1'b0;
    amr[1:0]              <= 2'b0;
    dcache_pref_en        <= 1'b0;
  end
  else if(mhint_local_en) begin
    // l2stpld               <= iui_regs_wdata[20];
    // nsfe                  <= iui_regs_wdata[18];
    // l2_pref_dist[1:0]     <= iui_regs_wdata[17:16]; 
    // l2pld                 <= iui_regs_wdata[15];
    dcache_pref_dist[1:0] <= iui_regs_wdata[14:13];
    // sre                   <= iui_regs_wdata[11];
    iwpe                  <= iui_regs_wdata[10];
    // lpe                   <= iui_regs_wdata[9];
    icache_pref_en        <= iui_regs_wdata[8];
    // amr2                  <= iui_regs_wdata[5];
    amr[1:0]              <= iui_regs_wdata[4:3];
    dcache_pref_en        <= iui_regs_wdata[2];
  end
  else begin
    // l2stpld               <= l2stpld;
    // nsfe                  <= nsfe;
    // l2_pref_dist[1:0]     <= l2_pref_dist[1:0];
    // l2pld                 <= l2pld;
    dcache_pref_dist[1:0] <= dcache_pref_dist[1:0];
    // sre                   <= sre;
    iwpe                  <= iwpe;
    // lpe                   <= lpe;
    icache_pref_en        <= icache_pref_en;
    // amr2                  <= amr2;
    amr[1:0]              <= amr[1:0];
    dcache_pref_en        <= dcache_pref_en;
  end
end

assign tlb_broad_dis = 1'b0;
assign l2stpld = 1'b0;
assign nsfe = 1'b0;
assign l2_pref_dist[1:0] = 2'b0;
assign l2pld = 1'b0;
assign sre = 1'b0;
assign lpe = 1'b0;
assign amr2 = 1'b0;

assign mhint_value[63:0] = {32'b0, 7'b0, pcfifo_freeze, 2'b0,
                            tlb_broad_dis, l2stpld, ecc_en,
                            nsfe, l2_pref_dist[1:0], l2pld, 
                            dcache_pref_dist[1:0], 1'b0, sre,
                            iwpe, lpe, icache_pref_en, 2'b0, amr2,
                            amr[1:0], dcache_pref_en, 2'b0};


always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    fence_in_dbg_dis   <= 1'b0;
    module_icg_en[8:0] <= 9'b0;
  end
  else if(mhint2_local_en) begin
    fence_in_dbg_dis   <= iui_regs_wdata[23];
    module_icg_en[8:0] <= iui_regs_wdata[22:14];
  end
  else begin
    fence_in_dbg_dis   <= fence_in_dbg_dis;
    module_icg_en[8:0] <= module_icg_en[8:0];
  end
end

assign mhint2_value[63:0] = {32'b0, 8'b0, fence_in_dbg_dis,
                             module_icg_en[8:0], 14'b0};

assign mhint3_value[63:0] = 64'b0;
assign mhint4_value[63:0] = 64'b0;

//==========================================================
//                     Define the SHINT
//==========================================================
assign shint_value[63:0] = 64'b0;
assign shint2_value[63:0] = 64'b0;

//==========================================================
//                     Define the MRMR
//==========================================================
assign mrmr_value[63:0] = 64'b0;

//==========================================================
//                     Define the MRVBR
//==========================================================
assign mrvbr_reg[39:0] = biu_cp0_rvba[39:0];
assign mrvbr_value[63:0] = {24'b0, mrvbr_reg[39:0]};

//==========================================================
//                     Define the MCER
//==========================================================
assign mcer_value[63:0] = 64'b0;

//==========================================================
//                     Define the SCER
//==========================================================
assign scer_value[63:0] = 64'b0;

//==========================================================
//                     Define the MEICR
//==========================================================
assign meicr_value[63:0] = 64'b0;

//==========================================================
//                     Define the MCCR2
//==========================================================
assign mccr2_value[63:0] = 64'b0;

//==========================================================
//                     Define the MCER2
//==========================================================
assign mcer2_value[63:0] = 64'b0;

//==========================================================
//                     Define the SCER2
//==========================================================
assign scer2_value[63:0] = 64'b0;

//==========================================================
//                    Define the MEICR2
//==========================================================
assign meicr2_value[63:0] = 64'b0;

//==========================================================
//                     Define the MCINS
//==========================================================
//  Machine Cache Instruction register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Read Line Instruction
//  the definiton for MCINS register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cins_r <= 1'b0;
  else if(rtu_yy_xx_flush)
    cins_r <= 1'b0;
  else if(mcins_local_en)
    cins_r <= iui_regs_wdata[0];
  else if(cins_read_data_vld)
    cins_r <= 1'b0;
  else
    cins_r <= cins_r;
end
// always @(posedge regs_flush_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b)
//     cins_ff <= 1'b0;
//   else if(rtu_yy_xx_flush)
//     cins_ff <= 1'b0;
//   else if(mcins_local_en)
//     cins_ff <= iui_regs_wdata[0];
//   else if(cins_ff)
//     cins_ff <= 1'b0;
//   else
//     cins_ff <= cins_ff;
// end

assign mcins_busy = cins_r || mcins_local_en;
//write only register
assign mcins_value[63:0] = 64'b0;

//==========================================================
//                    Define the MCINDEX
//==========================================================
//  Machine Cache Read Line Index register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Read Line Index
//  the definiton for MCINDEX register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cindex_rid[3:0]    <= 4'b0;
    cindex_way[3:0]    <= 4'b0;
    cindex_index[20:0] <= 21'b0;
  end
  else if (mcindex_local_en) begin
    cindex_rid[3:0]    <= iui_regs_wdata[31:28];
    cindex_way[3:0]    <= iui_regs_wdata[24:21];
    cindex_index[20:0] <= iui_regs_wdata[20:0];
  end
  else begin
    cindex_rid[3:0]    <= cindex_rid[3:0];
    cindex_way[3:0]    <= cindex_way[3:0];
    cindex_index[20:0] <= cindex_index[20:0];
  end
end

assign mcindex_value[63:0] = {32'b0, cindex_rid[3:0], 3'b0,
                              cindex_way[3:0], cindex_index[20:0]};

//ram select
assign cindex_rid_icache_tag           = (cindex_rid[3:0] == 4'd0);
assign cindex_rid_icache_data          = (cindex_rid[3:0] == 4'd1);
assign cindex_rid_dcache_st_tag        = (cindex_rid[3:0] == 4'd2);
assign cindex_rid_dcache_data          = (cindex_rid[3:0] == 4'd3);

assign icache_read_req       = cins_r && (cindex_rid_icache_tag
                                       || cindex_rid_icache_data);

assign icache_read_tag       = cindex_rid_icache_tag;
assign icache_read_way       = cindex_way[0];
assign icache_read_idx[16:0] = cindex_index[16:0];

assign dcache_read_req       = cins_r && (cindex_rid_dcache_st_tag
                                       || cindex_rid_dcache_data);

assign dcache_read_tag       = cindex_rid_dcache_st_tag;
assign dcache_read_way       = cindex_way[1:0];
assign dcache_read_idx[16:0] = cindex_index[16:0];

//==========================================================
//                   Define the MCDATA0/1
//==========================================================
//  Machine Cache Read Line Data register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Read Line Data Register
//  the definiton for MCDATA0/1 register is listed as follows
//==========================================================
assign biu_cp0_l2_read_data_vld = 1'b0;

assign biu_cp0_l2_read_data[127:0] = 128'b0;

assign cdata_data_vld = ifu_cp0_icache_read_data_vld
                     || lsu_cp0_dcache_read_data_vld
                     || biu_cp0_l2_read_data_vld;
// &CombBeg; @749
always @( lsu_cp0_dcache_read_data_vld
       or biu_cp0_l2_read_data[127:0]
       or ifu_cp0_icache_read_data[127:0]
       or ifu_cp0_icache_read_data_vld
       or biu_cp0_l2_read_data_vld
       or lsu_cp0_dcache_read_data[127:0])
begin
  case({biu_cp0_l2_read_data_vld,
        lsu_cp0_dcache_read_data_vld,
        ifu_cp0_icache_read_data_vld})
    3'b001 : cdata_read_data[127:0] = ifu_cp0_icache_read_data[127:0];
    3'b010 : cdata_read_data[127:0] = lsu_cp0_dcache_read_data[127:0];
    3'b100 : cdata_read_data[127:0] = biu_cp0_l2_read_data[127:0];
    default: cdata_read_data[127:0] = {128{1'bx}};
  endcase
// &CombEnd; @758
end
assign cdata_clk = regs_clk;

always @(posedge cdata_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cdata0[63:0] <= 64'b0;
    cdata1[63:0] <= 64'b0;
  end
  else if (cdata_data_vld) begin
    cdata0[63:0] <= cdata_read_data[63:0];
    cdata1[63:0] <= cdata_read_data[127:64];
  end
  else begin
    cdata0[63:0] <= cdata0[63:0];
    cdata1[63:0] <= cdata1[63:0];
  end
end

assign mcdata0_value[63:0] = cdata0[63:0];
assign mcdata1_value[63:0] = cdata1[63:0];

assign cins_no_op_data_vld = cins_r
                             && !(cindex_rid_icache_tag
                               || cindex_rid_icache_data
                               || cindex_rid_dcache_st_tag
                               || cindex_rid_dcache_data
                               );

assign cins_read_data_vld  = cdata_data_vld || cins_no_op_data_vld;
//==========================================================
//                   Define the MAPBADDR
//==========================================================
assign mapbaddr_value[63:0] = {24'b0, sysio_cp0_apb_base[39:0]};

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign regs_iui_mcor_stall  = mcor_busy;
assign regs_iui_mcins_stall = mcins_busy;

assign regs_special_icache_inv = icache_inv && sel[0];
assign regs_special_bht_inv    = bht_inv;
assign regs_special_dcache_req = (dcache_inv || clr) && sel[1];
assign regs_special_dcache_inv = dcache_inv;
assign regs_special_dcache_clr = clr;

assign regs_clintee = clintee;
assign regs_mcor_busy  = mcor_busy;
assign regs_mcins_busy = mcins_busy;

assign regs_xx_icg_en = module_icg_en[2];

//----------------------------------------------------------
//                          For XX
//----------------------------------------------------------
assign cp0_xx_mrvbr[39:0] = mrvbr_reg[39:0];

//----------------------------------------------------------
//                         For IFU
//----------------------------------------------------------
assign cp0_ifu_icg_en = module_icg_en[0];

assign cp0_ifu_btb_en = btbe;
assign cp0_ifu_bht_en = bpe;
assign cp0_ifu_icache_en = ie;
assign cp0_ifu_ras_en = rse;

assign cp0_ifu_btb_clr = btb_inv;

assign cp0_ifu_icache_pref_en          = icache_pref_en;
assign cp0_ifu_icache_read_req         = icache_read_req;
assign cp0_ifu_icache_read_tag         = icache_read_tag;
assign cp0_ifu_icache_read_way         = icache_read_way;
assign cp0_ifu_icache_read_index[13:0] = icache_read_idx[15:2];

assign cp0_ifu_iwpe                    = iwpe;

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign cp0_idu_cskyee = cskyisaee;
assign cp0_idu_ucme   = ucme;
assign cp0_idu_icg_en = module_icg_en[1];
assign cp0_idu_dis_fence_in_dbg = fence_in_dbg_dis;

//----------------------------------------------------------
//                          For IU
//----------------------------------------------------------
assign cp0_iu_icg_en = module_icg_en[2];

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
assign cp0_hpcp_pmdm = pmdm;
assign cp0_hpcp_pmds = pmds;
assign cp0_hpcp_pmdu = pmdu;

assign cp0_hpcp_icg_en = module_icg_en[2];

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign cp0_lsu_icg_en = module_icg_en[3];

assign cp0_lsu_mm = mm;
assign cp0_lsu_dcache_en = de;
assign cp0_lsu_dcache_wa = wa;
assign cp0_lsu_dcache_wb = wb;

assign cp0_lsu_we_en = 1'b0;

assign cp0_lsu_amr[1:0] = amr[1:0];
assign cp0_lsu_dcache_pref_en = dcache_pref_en;
assign cp0_lsu_dcache_pref_dist[1:0] = dcache_pref_dist[1:0];

assign cp0_lsu_dcache_read_req       = dcache_read_req;
assign cp0_lsu_dcache_read_type      = dcache_read_tag;// read type: 0-data, 1-tag
assign cp0_lsu_dcache_read_way[1:0]  = dcache_read_way[1:0];
assign cp0_lsu_dcache_read_idx[16:0] = dcache_read_idx[16:0];

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_icg_en = module_icg_en[4];

assign cp0_mmu_maee   = maee;
assign cp0_mmu_ptw_en = !mhrd;

//----------------------------------------------------------
//                         For PMP
//----------------------------------------------------------
assign cp0_pmp_icg_en = module_icg_en[4];

//----------------------------------------------------------
//                         For BIU
//----------------------------------------------------------
assign cp0_biu_icg_en = module_icg_en[5];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign cp0_rtu_icg_en = module_icg_en[6];

//----------------------------------------------------------
//                         For VPU
//----------------------------------------------------------
assign cp0_vpu_icg_en = module_icg_en[7];

//----------------------------------------------------------
//                         For DTU
//----------------------------------------------------------
assign cp0_dtu_icg_en     = module_icg_en[8];

assign cp0_dtu_pcfifo_frz = pcfifo_freeze;


// &ModuleEnd; @920
endmodule



