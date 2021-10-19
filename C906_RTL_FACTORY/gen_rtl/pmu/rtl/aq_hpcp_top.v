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

// &ModuleBeg; @22
module aq_hpcp_top(
  biu_hpcp_time,
  cp0_hpcp_icg_en,
  cp0_hpcp_index,
  cp0_hpcp_int_off_vld,
  cp0_hpcp_mcntwen,
  cp0_hpcp_pmdm,
  cp0_hpcp_pmds,
  cp0_hpcp_pmdu,
  cp0_hpcp_sync_stall_vld,
  cp0_hpcp_wdata,
  cp0_hpcp_wreg,
  cp0_yy_priv_mode,
  cpurst_b,
  dtu_hpcp_dcsr_stopcount,
  forever_cpuclk,
  hpcp_cp0_data,
  hpcp_cp0_int_vld,
  hpcp_cp0_sce,
  hpcp_idu_cnt_en,
  hpcp_ifu_cnt_en,
  hpcp_iu_cnt_en,
  hpcp_lsu_cnt_en,
  hpcp_mmu_cnt_en,
  hpcp_rtu_cnt_en,
  idu_hpcp_backend_stall,
  idu_hpcp_frontend_stall,
  idu_hpcp_inst_type,
  ifu_hpcp_icache_access,
  ifu_hpcp_icache_miss,
  iu_hpcp_inst_bht_mispred,
  iu_hpcp_inst_condbr,
  iu_hpcp_jump_8m,
  lsu_hpcp_cache_read_access,
  lsu_hpcp_cache_read_miss,
  lsu_hpcp_cache_write_access,
  lsu_hpcp_cache_write_miss,
  lsu_hpcp_inst_store,
  lsu_hpcp_unalign_inst,
  mmu_hpcp_dutlb_miss,
  mmu_hpcp_iutlb_miss,
  mmu_hpcp_jtlb_miss,
  pad_yy_icg_scan_en,
  rtu_hpcp_int_vld,
  rtu_hpcp_retire_inst_vld,
  rtu_hpcp_retire_pc,
  rtu_yy_xx_dbgon
);

// &Ports; @23
input   [63:0]  biu_hpcp_time;               
input           cp0_hpcp_icg_en;             
input   [11:0]  cp0_hpcp_index;              
input           cp0_hpcp_int_off_vld;        
input   [31:0]  cp0_hpcp_mcntwen;            
input           cp0_hpcp_pmdm;               
input           cp0_hpcp_pmds;               
input           cp0_hpcp_pmdu;               
input           cp0_hpcp_sync_stall_vld;     
input   [63:0]  cp0_hpcp_wdata;              
input           cp0_hpcp_wreg;               
input   [1 :0]  cp0_yy_priv_mode;            
input           cpurst_b;                    
input           dtu_hpcp_dcsr_stopcount;     
input           forever_cpuclk;              
input           idu_hpcp_backend_stall;      
input           idu_hpcp_frontend_stall;     
input   [6 :0]  idu_hpcp_inst_type;          
input           ifu_hpcp_icache_access;      
input           ifu_hpcp_icache_miss;        
input           iu_hpcp_inst_bht_mispred;    
input           iu_hpcp_inst_condbr;         
input           iu_hpcp_jump_8m;             
input           lsu_hpcp_cache_read_access;  
input           lsu_hpcp_cache_read_miss;    
input           lsu_hpcp_cache_write_access; 
input           lsu_hpcp_cache_write_miss;   
input           lsu_hpcp_inst_store;         
input           lsu_hpcp_unalign_inst;       
input           mmu_hpcp_dutlb_miss;         
input           mmu_hpcp_iutlb_miss;         
input           mmu_hpcp_jtlb_miss;          
input           pad_yy_icg_scan_en;          
input           rtu_hpcp_int_vld;            
input           rtu_hpcp_retire_inst_vld;    
input   [39:0]  rtu_hpcp_retire_pc;          
input           rtu_yy_xx_dbgon;             
output  [63:0]  hpcp_cp0_data;               
output          hpcp_cp0_int_vld;            
output          hpcp_cp0_sce;                
output          hpcp_idu_cnt_en;             
output          hpcp_ifu_cnt_en;             
output          hpcp_iu_cnt_en;              
output          hpcp_lsu_cnt_en;             
output          hpcp_mmu_cnt_en;             
output          hpcp_rtu_cnt_en;             

// &Regs; @24
reg             cnt_mode_dis;                
reg             cy;                          
reg     [63:0]  data_out;                    
reg             hpcp_stop_vld_ff;            
reg     [28:0]  hpm;                         
reg             hpmep_high_vld;              
reg     [62:0]  hpmep_reg;                   
reg             hpmsp_high_vld;              
reg     [62:0]  hpmsp_reg;                   
reg             ir;                          
reg             sce;                         
reg     [1 :0]  tme;                         
reg             ts;                          

// &Wires @25
wire    [63:0]  biu_hpcp_time;               
wire            cnt_mode_dis_pre;            
wire    [31:0]  cntinten;                    
wire    [63:0]  cntinten_value;              
wire    [31:0]  cntinten_wen;                
wire    [31:0]  cntof;                       
wire    [63:0]  cntof_value;                 
wire    [31:0]  cntof_wen;                   
wire    [31:0]  counter_overflow;            
wire            cp0_hpcp_icg_en;             
wire    [11:0]  cp0_hpcp_index;              
wire            cp0_hpcp_int_off_vld;        
wire    [31:0]  cp0_hpcp_mcntwen;            
wire            cp0_hpcp_pmdm;               
wire            cp0_hpcp_pmds;               
wire            cp0_hpcp_pmdu;               
wire            cp0_hpcp_sync_stall_vld;     
wire    [63:0]  cp0_hpcp_wdata;              
wire            cp0_hpcp_wreg;               
wire    [1 :0]  cp0_yy_priv_mode;            
wire            cpurst_b;                    
wire            debug_mode_en;               
wire            dtu_hpcp_dcsr_stopcount;     
wire            end_vld;                     
wire            event01_adder;               
wire            event02_adder;               
wire            event03_adder;               
wire            event04_adder;               
wire            event05_adder;               
wire            event06_adder;               
wire            event07_adder;               
wire            event08_adder;               
wire            event09_adder;               
wire            event10_adder;               
wire            event11_adder;               
wire            event12_adder;               
wire            event13_adder;               
wire            event14_adder;               
wire            event15_adder;               
wire            event16_adder;               
wire            event17_adder;               
wire            event18_adder;               
wire            event19_adder;               
wire            event20_adder;               
wire            event21_adder;               
wire            event22_adder;               
wire            event23_adder;               
wire            event24_adder;               
wire            event25_adder;               
wire            event26_adder;               
wire            event27_adder;               
wire            event28_adder;               
wire            event29_adder;               
wire            event30_adder;               
wire            event31_adder;               
wire            event32_adder;               
wire            event33_adder;               
wire            event34_adder;               
wire            event35_adder;               
wire            event36_adder;               
wire            event37_adder;               
wire            event38_adder;               
wire            event39_adder;               
wire            event40_adder;               
wire            event41_adder;               
wire            event42_adder;               
wire            forever_cpuclk;              
wire    [39:0]  hmpep_sub_retire_result;     
wire            hpcp_backend_stall;          
wire            hpcp_clk;                    
wire            hpcp_clk_en;                 
wire            hpcp_cnt_en;                 
wire    [63:0]  hpcp_cp0_data;               
wire            hpcp_cp0_int_vld;            
wire            hpcp_cp0_sce;                
wire            hpcp_end_vld;                
wire            hpcp_frontend_stall;         
wire            hpcp_idu_cnt_en;             
wire    [6 :0]  hpcp_idu_inst_type;          
wire            hpcp_ifu_cnt_en;             
wire            hpcp_ifu_icache_access;      
wire            hpcp_ifu_icache_miss;        
wire            hpcp_inst_jmp_over_8m;       
wire            hpcp_int_ack;                
wire            hpcp_int_disable;            
wire            hpcp_iu_cnt_en;              
wire            hpcp_lsu_cnt_en;             
wire            hpcp_lsu_dcache_read_access; 
wire            hpcp_lsu_dcache_read_miss;   
wire            hpcp_lsu_dcache_write_access; 
wire            hpcp_lsu_dcache_write_miss;  
wire            hpcp_mmu_cnt_en;             
wire            hpcp_retire_bht_mispred;     
wire            hpcp_retire_inst_condbr;     
wire            hpcp_retire_inst_store;      
wire            hpcp_retire_inst_vld;        
wire    [39:0]  hpcp_retire_pc;              
wire            hpcp_rtu_cnt_en;             
wire            hpcp_start_vld;              
wire            hpcp_stop_vld;               
wire            hpcp_sync_stall;             
wire            hpcp_tlb_dutlb_miss;         
wire            hpcp_tlb_iutlb_miss;         
wire            hpcp_tlb_jtlb_miss;          
wire            hpcp_trigger_vld;            
wire            hpcp_unalign_inst;           
wire    [63:0]  hpcp_wdata;                  
wire            hpcp_xx_cnt_en;              
wire            hpmep_high_test;             
wire            hpmsp_high_test;             
wire            idu_hpcp_backend_stall;      
wire            idu_hpcp_frontend_stall;     
wire    [6 :0]  idu_hpcp_inst_type;          
wire            ifu_hpcp_icache_access;      
wire            ifu_hpcp_icache_miss;        
wire            iu_hpcp_inst_bht_mispred;    
wire            iu_hpcp_inst_condbr;         
wire            iu_hpcp_jump_8m;             
wire            lsu_hpcp_cache_read_access;  
wire            lsu_hpcp_cache_read_miss;    
wire            lsu_hpcp_cache_write_access; 
wire            lsu_hpcp_cache_write_miss;   
wire            lsu_hpcp_inst_store;         
wire            lsu_hpcp_unalign_inst;       
wire            mcntinhbt_clk_en;            
wire    [63:0]  mcntinhbt_value;             
wire            mcntinhbt_wen;               
wire            mcntinten_clk_en;            
wire    [63:0]  mcntinten_value;             
wire            mcntinten_wen;               
wire            mcntof_clk_en;               
wire    [63:0]  mcntof_value;                
wire            mcntof_wen;                  
wire            mcycle_adder;                
wire            mcycle_clk_en;               
wire            mcycle_en;                   
wire            mcycle_of;                   
wire    [63:0]  mcycle_value;                
wire            mcycle_wen;                  
wire            mhpmcnt10_adder;             
wire            mhpmcnt10_clk_en;            
wire            mhpmcnt10_en;                
wire            mhpmcnt10_of;                
wire    [63:0]  mhpmcnt10_value;             
wire            mhpmcnt10_wen;               
wire            mhpmcnt3_adder;              
wire            mhpmcnt3_clk_en;             
wire            mhpmcnt3_en;                 
wire            mhpmcnt3_of;                 
wire    [63:0]  mhpmcnt3_value;              
wire            mhpmcnt3_wen;                
wire            mhpmcnt4_adder;              
wire            mhpmcnt4_clk_en;             
wire            mhpmcnt4_en;                 
wire            mhpmcnt4_of;                 
wire    [63:0]  mhpmcnt4_value;              
wire            mhpmcnt4_wen;                
wire            mhpmcnt5_adder;              
wire            mhpmcnt5_clk_en;             
wire            mhpmcnt5_en;                 
wire            mhpmcnt5_of;                 
wire    [63:0]  mhpmcnt5_value;              
wire            mhpmcnt5_wen;                
wire            mhpmcnt6_adder;              
wire            mhpmcnt6_clk_en;             
wire            mhpmcnt6_en;                 
wire            mhpmcnt6_of;                 
wire    [63:0]  mhpmcnt6_value;              
wire            mhpmcnt6_wen;                
wire            mhpmcnt7_adder;              
wire            mhpmcnt7_clk_en;             
wire            mhpmcnt7_en;                 
wire            mhpmcnt7_of;                 
wire    [63:0]  mhpmcnt7_value;              
wire            mhpmcnt7_wen;                
wire            mhpmcnt8_adder;              
wire            mhpmcnt8_clk_en;             
wire            mhpmcnt8_en;                 
wire            mhpmcnt8_of;                 
wire    [63:0]  mhpmcnt8_value;              
wire            mhpmcnt8_wen;                
wire            mhpmcnt9_adder;              
wire            mhpmcnt9_clk_en;             
wire            mhpmcnt9_en;                 
wire            mhpmcnt9_of;                 
wire    [63:0]  mhpmcnt9_value;              
wire            mhpmcnt9_wen;                
wire            mhpmcr_clk_en;               
wire    [63:0]  mhpmcr_value;                
wire            mhpmcr_wen;                  
wire            mhpmep_clk_en;               
wire    [63:0]  mhpmep_value;                
wire            mhpmep_wen;                  
wire            mhpmevt10_clk_en;            
wire    [63:0]  mhpmevt10_value;             
wire            mhpmevt10_wen;               
wire            mhpmevt3_clk_en;             
wire    [63:0]  mhpmevt3_value;              
wire            mhpmevt3_wen;                
wire            mhpmevt4_clk_en;             
wire    [63:0]  mhpmevt4_value;              
wire            mhpmevt4_wen;                
wire            mhpmevt5_clk_en;             
wire    [63:0]  mhpmevt5_value;              
wire            mhpmevt5_wen;                
wire            mhpmevt6_clk_en;             
wire    [63:0]  mhpmevt6_value;              
wire            mhpmevt6_wen;                
wire            mhpmevt7_clk_en;             
wire    [63:0]  mhpmevt7_value;              
wire            mhpmevt7_wen;                
wire            mhpmevt8_clk_en;             
wire    [63:0]  mhpmevt8_value;              
wire            mhpmevt8_wen;                
wire            mhpmevt9_clk_en;             
wire    [63:0]  mhpmevt9_value;              
wire            mhpmevt9_wen;                
wire            mhpmsp_clk_en;               
wire    [63:0]  mhpmsp_value;                
wire            mhpmsp_wen;                  
wire            minstret_adder;              
wire            minstret_clk_en;             
wire            minstret_en;                 
wire            minstret_of;                 
wire    [63:0]  minstret_value;              
wire            minstret_wen;                
wire            mmu_hpcp_dutlb_miss;         
wire            mmu_hpcp_iutlb_miss;         
wire            mmu_hpcp_jtlb_miss;          
wire            pad_yy_icg_scan_en;          
wire    [39:0]  retire_sub_hmpsp_result;     
wire            rtu_hpcp_int_vld;            
wire            rtu_hpcp_retire_inst_vld;    
wire    [39:0]  rtu_hpcp_retire_pc;          
wire            rtu_yy_xx_dbgon;             
wire            scntinhbt_clk_en;            
wire    [31:0]  scntinhbt_updt_value;        
wire    [63:0]  scntinhbt_value;             
wire            scntinhbt_wen;               
wire            scntinten_clk_en;            
wire    [63:0]  scntinten_value;             
wire            scntinten_wen;               
wire            scntof_clk_en;               
wire    [63:0]  scntof_value;                
wire            scntof_wen;                  
wire            shpmcr_clk_en;               
wire    [63:0]  shpmcr_value;                
wire            shpmcr_wen;                  
wire            shpmep_clk_en;               
wire    [63:0]  shpmep_value;                
wire            shpmep_wen;                  
wire            shpmsp_clk_en;               
wire    [63:0]  shpmsp_value;                
wire            shpmsp_wen;                  
wire            start_vld;                   
wire            stop_vld;                    
wire            trigger_vld;                 


// &Depend("cpu_cfig.h"); @27

//define total counter num
parameter HPMCNT_NUM   = 42;
parameter HPMEVT_WIDTH = 6;
     
// performance monitor regs list in C960
// Machine Counter Setup
parameter MCNTINHBT = 12'h320;
parameter MCNTWEN   = 12'h7C9;
parameter MCNTINTEN = 12'h7CA;
parameter MCNTOF    = 12'h7CB;
parameter MHPMCR    = 12'h7F0;
parameter MHPMSP    = 12'h7F1;
parameter MHPMEP    = 12'h7F2;

parameter MHPMEVT3  = 12'h323;
parameter MHPMEVT4  = 12'h324;
parameter MHPMEVT5  = 12'h325;
parameter MHPMEVT6  = 12'h326;
parameter MHPMEVT7  = 12'h327;
parameter MHPMEVT8  = 12'h328;
parameter MHPMEVT9  = 12'h329;
parameter MHPMEVT10 = 12'h32A;
parameter MHPMEVT11 = 12'h32B;
parameter MHPMEVT12 = 12'h32C;
parameter MHPMEVT13 = 12'h32D;
parameter MHPMEVT14 = 12'h32E;
parameter MHPMEVT15 = 12'h32F;
parameter MHPMEVT16 = 12'h330;
parameter MHPMEVT17 = 12'h331;
parameter MHPMEVT18 = 12'h332;
parameter MHPMEVT19 = 12'h333;
parameter MHPMEVT20 = 12'h334;
parameter MHPMEVT21 = 12'h335;
parameter MHPMEVT22 = 12'h336;
parameter MHPMEVT23 = 12'h337;
parameter MHPMEVT24 = 12'h338;
parameter MHPMEVT25 = 12'h339;
parameter MHPMEVT26 = 12'h33A;
parameter MHPMEVT27 = 12'h33B;
parameter MHPMEVT28 = 12'h33C;
parameter MHPMEVT29 = 12'h33D;
parameter MHPMEVT30 = 12'h33E;
parameter MHPMEVT31 = 12'h33F;

// Machine Counters/Timers
parameter MCYCLE    = 12'hB00;
parameter MINSTRET  = 12'hB02;
parameter MHPMCNT3  = 12'hB03;
parameter MHPMCNT4  = 12'hB04;
parameter MHPMCNT5  = 12'hB05;
parameter MHPMCNT6  = 12'hB06;
parameter MHPMCNT7  = 12'hB07;
parameter MHPMCNT8  = 12'hB08;
parameter MHPMCNT9  = 12'hB09;
parameter MHPMCNT10 = 12'hB0A;
parameter MHPMCNT11 = 12'hB0B;
parameter MHPMCNT12 = 12'hB0C;
parameter MHPMCNT13 = 12'hB0D;
parameter MHPMCNT14 = 12'hB0E;
parameter MHPMCNT15 = 12'hB0F;
parameter MHPMCNT16 = 12'hB10;
parameter MHPMCNT17 = 12'hB11;
parameter MHPMCNT18 = 12'hB12;
parameter MHPMCNT19 = 12'hB13;
parameter MHPMCNT20 = 12'hB14;
parameter MHPMCNT21 = 12'hB15;
parameter MHPMCNT22 = 12'hB16;
parameter MHPMCNT23 = 12'hB17;
parameter MHPMCNT24 = 12'hB18;
parameter MHPMCNT25 = 12'hB19;
parameter MHPMCNT26 = 12'hB1A;
parameter MHPMCNT27 = 12'hB1B;
parameter MHPMCNT28 = 12'hB1C;
parameter MHPMCNT29 = 12'hB1D;
parameter MHPMCNT30 = 12'hB1E;
parameter MHPMCNT31 = 12'hB1F;

//Supervisor Control Registor
parameter SCNTINTEN = 12'h5C4;
parameter SCNTOF    = 12'h5C5;
parameter SCNTINHBT = 12'h5C8;
parameter SHPMCR    = 12'h5C9;
parameter SHPMSP    = 12'h5CA;
parameter SHPMEP    = 12'h5CB;
//Supervisor Couters
parameter SCYCLE    = 12'h5E0;
parameter SINSTRET  = 12'h5E2;
parameter SHPMCNT3  = 12'h5E3;
parameter SHPMCNT4  = 12'h5E4;
parameter SHPMCNT5  = 12'h5E5;
parameter SHPMCNT6  = 12'h5E6;
parameter SHPMCNT7  = 12'h5E7;
parameter SHPMCNT8  = 12'h5E8;
parameter SHPMCNT9  = 12'h5E9;
parameter SHPMCNT10 = 12'h5EA;
parameter SHPMCNT11 = 12'h5EB;
parameter SHPMCNT12 = 12'h5EC;
parameter SHPMCNT13 = 12'h5ED;
parameter SHPMCNT14 = 12'h5EE;
parameter SHPMCNT15 = 12'h5EF;
parameter SHPMCNT16 = 12'h5F0;
parameter SHPMCNT17 = 12'h5F1;
parameter SHPMCNT18 = 12'h5F2;
parameter SHPMCNT19 = 12'h5F3;
parameter SHPMCNT20 = 12'h5F4;
parameter SHPMCNT21 = 12'h5F5;
parameter SHPMCNT22 = 12'h5F6;
parameter SHPMCNT23 = 12'h5F7;
parameter SHPMCNT24 = 12'h5F8;
parameter SHPMCNT25 = 12'h5F9;
parameter SHPMCNT26 = 12'h5FA;
parameter SHPMCNT27 = 12'h5FB;
parameter SHPMCNT28 = 12'h5FC;
parameter SHPMCNT29 = 12'h5FD;
parameter SHPMCNT30 = 12'h5FE;
parameter SHPMCNT31 = 12'h5FF;

// User Counters/Timers
parameter CYCLE    = 12'hC00;
parameter TIME     = 12'hC01;
parameter INSTRET  = 12'hC02;
parameter HPMCNT3  = 12'hC03;
parameter HPMCNT4  = 12'hC04;
parameter HPMCNT5  = 12'hC05;
parameter HPMCNT6  = 12'hC06;
parameter HPMCNT7  = 12'hC07;
parameter HPMCNT8  = 12'hC08;
parameter HPMCNT9  = 12'hC09;
parameter HPMCNT10 = 12'hC0A;
parameter HPMCNT11 = 12'hC0B;
parameter HPMCNT12 = 12'hC0C;
parameter HPMCNT13 = 12'hC0D;
parameter HPMCNT14 = 12'hC0E;
parameter HPMCNT15 = 12'hC0F;
parameter HPMCNT16 = 12'hC10;
parameter HPMCNT17 = 12'hC11;
parameter HPMCNT18 = 12'hC12;
parameter HPMCNT19 = 12'hC13;
parameter HPMCNT20 = 12'hC14;
parameter HPMCNT21 = 12'hC15;
parameter HPMCNT22 = 12'hC16;
parameter HPMCNT23 = 12'hC17;
parameter HPMCNT24 = 12'hC18;
parameter HPMCNT25 = 12'hC19;
parameter HPMCNT26 = 12'hC1A;
parameter HPMCNT27 = 12'hC1B;
parameter HPMCNT28 = 12'hC1C;
parameter HPMCNT29 = 12'hC1D;
parameter HPMCNT30 = 12'hC1E;
parameter HPMCNT31 = 12'hC1F;


//==========================================================
//                Event Signals Rename
//==========================================================
//SPLIT INST???
assign hpcp_retire_inst_vld           = rtu_hpcp_retire_inst_vld;
assign hpcp_retire_pc[39:0]           = rtu_hpcp_retire_pc[39:0];
assign hpcp_retire_inst_condbr        = iu_hpcp_inst_condbr;
assign hpcp_retire_bht_mispred        = iu_hpcp_inst_bht_mispred;
assign hpcp_retire_inst_store         = lsu_hpcp_inst_store;
assign hpcp_ifu_icache_access         = ifu_hpcp_icache_access;
assign hpcp_ifu_icache_miss           = ifu_hpcp_icache_miss;
assign hpcp_lsu_dcache_read_access    = lsu_hpcp_cache_read_access;
assign hpcp_lsu_dcache_read_miss      = lsu_hpcp_cache_read_miss;
assign hpcp_lsu_dcache_write_access   = lsu_hpcp_cache_write_access;
assign hpcp_lsu_dcache_write_miss     = lsu_hpcp_cache_write_miss;
assign hpcp_tlb_iutlb_miss            = mmu_hpcp_iutlb_miss;
assign hpcp_tlb_dutlb_miss            = mmu_hpcp_dutlb_miss;
assign hpcp_tlb_jtlb_miss             = mmu_hpcp_jtlb_miss;
assign hpcp_idu_inst_type[6:0]        = idu_hpcp_inst_type[6:0];
assign hpcp_unalign_inst              = lsu_hpcp_unalign_inst;
assign hpcp_int_disable               = cp0_hpcp_int_off_vld;
assign hpcp_int_ack                   = rtu_hpcp_int_vld;
assign hpcp_inst_jmp_over_8m          = iu_hpcp_jump_8m;
assign hpcp_backend_stall             = idu_hpcp_backend_stall;
assign hpcp_frontend_stall            = idu_hpcp_frontend_stall;
assign hpcp_sync_stall                = cp0_hpcp_sync_stall_vld;

//==============================================================================
// Write signal 
//==============================================================================
//machine mode counter inhibit
//machine counter write en
assign mcntinhbt_wen   = (cp0_hpcp_index[11:0] == MCNTINHBT ) && cp0_hpcp_wreg;
assign mcntinten_wen   = (cp0_hpcp_index[11:0] == MCNTINTEN ) && cp0_hpcp_wreg; 
assign mcntof_wen      = (cp0_hpcp_index[11:0] == MCNTOF    ) && cp0_hpcp_wreg; 
assign mhpmcr_wen      = (cp0_hpcp_index[11:0] == MHPMCR    ) && cp0_hpcp_wreg; 
assign mhpmsp_wen      = (cp0_hpcp_index[11:0] == MHPMSP    ) && cp0_hpcp_wreg; 
assign mhpmep_wen      = (cp0_hpcp_index[11:0] == MHPMEP    ) && cp0_hpcp_wreg; 

//mhpmevt write enable 
assign mhpmevt3_wen    = (cp0_hpcp_index[11:0] == MHPMEVT3 ) && cp0_hpcp_wreg;
assign mhpmevt4_wen    = (cp0_hpcp_index[11:0] == MHPMEVT4 ) && cp0_hpcp_wreg;
assign mhpmevt5_wen    = (cp0_hpcp_index[11:0] == MHPMEVT5 ) && cp0_hpcp_wreg;
assign mhpmevt6_wen    = (cp0_hpcp_index[11:0] == MHPMEVT6 ) && cp0_hpcp_wreg;
assign mhpmevt7_wen    = (cp0_hpcp_index[11:0] == MHPMEVT7 ) && cp0_hpcp_wreg;
assign mhpmevt8_wen    = (cp0_hpcp_index[11:0] == MHPMEVT8 ) && cp0_hpcp_wreg;
assign mhpmevt9_wen    = (cp0_hpcp_index[11:0] == MHPMEVT9 ) && cp0_hpcp_wreg;
assign mhpmevt10_wen   = (cp0_hpcp_index[11:0] == MHPMEVT10) && cp0_hpcp_wreg;

// counter write enable signal                      
assign mcycle_wen      = ((cp0_hpcp_index[11:0] == MCYCLE)    || (cp0_hpcp_index[11:0] == SCYCLE)   ) && cp0_hpcp_wreg;
assign minstret_wen    = ((cp0_hpcp_index[11:0] == MINSTRET)  || (cp0_hpcp_index[11:0] == SINSTRET) ) && cp0_hpcp_wreg;

assign mhpmcnt3_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT3)  || (cp0_hpcp_index[11:0] == SHPMCNT3) ) && cp0_hpcp_wreg; 
assign mhpmcnt4_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT4)  || (cp0_hpcp_index[11:0] == SHPMCNT4) ) && cp0_hpcp_wreg; 
assign mhpmcnt5_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT5)  || (cp0_hpcp_index[11:0] == SHPMCNT5) ) && cp0_hpcp_wreg; 
assign mhpmcnt6_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT6)  || (cp0_hpcp_index[11:0] == SHPMCNT6) ) && cp0_hpcp_wreg; 
assign mhpmcnt7_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT7)  || (cp0_hpcp_index[11:0] == SHPMCNT7) ) && cp0_hpcp_wreg; 
assign mhpmcnt8_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT8)  || (cp0_hpcp_index[11:0] == SHPMCNT8) ) && cp0_hpcp_wreg; 
assign mhpmcnt9_wen    = ((cp0_hpcp_index[11:0] == MHPMCNT9)  || (cp0_hpcp_index[11:0] == SHPMCNT9) ) && cp0_hpcp_wreg; 
assign mhpmcnt10_wen   = ((cp0_hpcp_index[11:0] == MHPMCNT10) || (cp0_hpcp_index[11:0] == SHPMCNT10)) && cp0_hpcp_wreg; 

//Supervisor counter write en
assign scntinhbt_wen   = (cp0_hpcp_index[11:0] == SCNTINHBT ) && cp0_hpcp_wreg;
assign scntinten_wen   = (cp0_hpcp_index[11:0] == SCNTINTEN ) && cp0_hpcp_wreg; 
assign scntof_wen      = (cp0_hpcp_index[11:0] == SCNTOF    ) && cp0_hpcp_wreg; 
assign shpmcr_wen      = (cp0_hpcp_index[11:0] == SHPMCR    ) && cp0_hpcp_wreg; 
assign shpmsp_wen      = (cp0_hpcp_index[11:0] == SHPMSP    ) && cp0_hpcp_wreg; 
assign shpmep_wen      = (cp0_hpcp_index[11:0] == SHPMEP    ) && cp0_hpcp_wreg; 

//==============================================================================
//                Counter Control Signals
//==============================================================================
//when user/supervisor/machine counter disable,counter can not count
always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cnt_mode_dis <= 1'b0;
  else
    cnt_mode_dis <= cnt_mode_dis_pre;
end

assign cnt_mode_dis_pre = (cp0_yy_priv_mode[1:0] == 2'b11) && cp0_hpcp_pmdm
                       || (cp0_yy_priv_mode[1:0] == 2'b01) && cp0_hpcp_pmds
                       || (cp0_yy_priv_mode[1:0] == 2'b00) && cp0_hpcp_pmdu;

assign hpcp_cnt_en  = (tme[1:0] == 2'b00)
                   || (tme[1:0] == 2'b01) && ts
                   || (tme[1:0] == 2'b10) && ts; 
                 
assign debug_mode_en = !rtu_yy_xx_dbgon || !dtu_hpcp_dcsr_stopcount;

// enable counter
assign mcycle_en    = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[0];
assign minstret_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[2];

assign mhpmcnt3_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[3]  && (|mhpmevt3_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt4_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[4]  && (|mhpmevt4_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt5_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[5]  && (|mhpmevt5_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt6_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[6]  && (|mhpmevt6_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt7_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[7]  && (|mhpmevt7_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt8_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[8]  && (|mhpmevt8_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt9_en  = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[9]  && (|mhpmevt9_value[HPMEVT_WIDTH-1:0]);
assign mhpmcnt10_en = debug_mode_en && !cnt_mode_dis && !mcntinhbt_value[10] && (|mhpmevt10_value[HPMEVT_WIDTH-1:0]);

//==============================================================================
//                Counter Adders
//==============================================================================
//1. cycles
assign mcycle_adder  = 1'b1;

//2. inst retire
assign minstret_adder= hpcp_retire_inst_vld;

//event adder
assign event01_adder = hpcp_ifu_icache_access;
assign event02_adder = hpcp_ifu_icache_miss;
assign event03_adder = hpcp_tlb_iutlb_miss;
assign event04_adder = hpcp_tlb_dutlb_miss;
assign event05_adder = hpcp_tlb_jtlb_miss;
assign event06_adder = hpcp_retire_bht_mispred;
assign event07_adder = hpcp_retire_inst_condbr;
assign event08_adder = 1'b0; //reserved
assign event09_adder = 1'b0; //reserved
assign event10_adder = 1'b0; //reserved
assign event11_adder = hpcp_retire_inst_store;
assign event12_adder = hpcp_lsu_dcache_read_access; 
assign event13_adder = hpcp_lsu_dcache_read_miss; 
assign event14_adder = hpcp_lsu_dcache_write_access;
assign event15_adder = hpcp_lsu_dcache_write_miss;
assign event16_adder = 1'b0; //reserved  
assign event17_adder = 1'b0; //reserved
assign event18_adder = 1'b0; //reserved
assign event19_adder = 1'b0; //reserved
assign event20_adder = 1'b0; //reserved
assign event21_adder = 1'b0; //reserved  
assign event22_adder = 1'b0; //reserved
assign event23_adder = 1'b0; //reserved
assign event24_adder = 1'b0; //reserved
assign event25_adder = 1'b0; //reserved  
assign event26_adder = 1'b0; //reserved
assign event27_adder = 1'b0; //reserved
assign event28_adder = 1'b0; //reserved
assign event29_adder = hpcp_idu_inst_type[0]; 
assign event30_adder = hpcp_idu_inst_type[1]; 
assign event31_adder = hpcp_idu_inst_type[2]; 
assign event32_adder = hpcp_idu_inst_type[3]; 
assign event33_adder = hpcp_idu_inst_type[4]; 
assign event34_adder = hpcp_unalign_inst;
assign event35_adder = hpcp_int_ack;
assign event36_adder = hpcp_int_disable;
assign event37_adder = hpcp_idu_inst_type[5]; 
assign event38_adder = hpcp_inst_jmp_over_8m;
assign event39_adder = hpcp_frontend_stall;
assign event40_adder = hpcp_backend_stall;
assign event41_adder = hpcp_sync_stall; 
assign event42_adder = hpcp_idu_inst_type[6]; 


//select adder for hpmcnt[n]
// &ConnRule(s/x/3/); @429
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_3"); @430
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_3 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt3_adder),
  .mhpmevtx_value (mhpmevt3_value)
);


// &ConnRule(s/x/4/); @432
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_4"); @433
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_4 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt4_adder),
  .mhpmevtx_value (mhpmevt4_value)
);


// &ConnRule(s/x/5/); @435
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_5"); @436
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_5 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt5_adder),
  .mhpmevtx_value (mhpmevt5_value)
);


// &ConnRule(s/x/6/); @438
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_6"); @439
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_6 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt6_adder),
  .mhpmevtx_value (mhpmevt6_value)
);

// &ConnRule(s/x/7/); @442
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_7"); @443
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_7 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt7_adder),
  .mhpmevtx_value (mhpmevt7_value)
);


// &ConnRule(s/x/8/); @445
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_8"); @446
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_8 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt8_adder),
  .mhpmevtx_value (mhpmevt8_value)
);


// &ConnRule(s/x/9/); @448
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_9"); @449
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_9 (
  .event01_adder  (event01_adder ),
  .event02_adder  (event02_adder ),
  .event03_adder  (event03_adder ),
  .event04_adder  (event04_adder ),
  .event05_adder  (event05_adder ),
  .event06_adder  (event06_adder ),
  .event07_adder  (event07_adder ),
  .event08_adder  (event08_adder ),
  .event09_adder  (event09_adder ),
  .event10_adder  (event10_adder ),
  .event11_adder  (event11_adder ),
  .event12_adder  (event12_adder ),
  .event13_adder  (event13_adder ),
  .event14_adder  (event14_adder ),
  .event15_adder  (event15_adder ),
  .event16_adder  (event16_adder ),
  .event17_adder  (event17_adder ),
  .event18_adder  (event18_adder ),
  .event19_adder  (event19_adder ),
  .event20_adder  (event20_adder ),
  .event21_adder  (event21_adder ),
  .event22_adder  (event22_adder ),
  .event23_adder  (event23_adder ),
  .event24_adder  (event24_adder ),
  .event25_adder  (event25_adder ),
  .event26_adder  (event26_adder ),
  .event27_adder  (event27_adder ),
  .event28_adder  (event28_adder ),
  .event29_adder  (event29_adder ),
  .event30_adder  (event30_adder ),
  .event31_adder  (event31_adder ),
  .event32_adder  (event32_adder ),
  .event33_adder  (event33_adder ),
  .event34_adder  (event34_adder ),
  .event35_adder  (event35_adder ),
  .event36_adder  (event36_adder ),
  .event37_adder  (event37_adder ),
  .event38_adder  (event38_adder ),
  .event39_adder  (event39_adder ),
  .event40_adder  (event40_adder ),
  .event41_adder  (event41_adder ),
  .event42_adder  (event42_adder ),
  .mhpmcntx_adder (mhpmcnt9_adder),
  .mhpmevtx_value (mhpmevt9_value)
);


// &ConnRule(s/x/10/); @451
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_10"); @452
aq_hpcp_adder_sel  x_aq_hpcp_adder_sel_10 (
  .event01_adder   (event01_adder  ),
  .event02_adder   (event02_adder  ),
  .event03_adder   (event03_adder  ),
  .event04_adder   (event04_adder  ),
  .event05_adder   (event05_adder  ),
  .event06_adder   (event06_adder  ),
  .event07_adder   (event07_adder  ),
  .event08_adder   (event08_adder  ),
  .event09_adder   (event09_adder  ),
  .event10_adder   (event10_adder  ),
  .event11_adder   (event11_adder  ),
  .event12_adder   (event12_adder  ),
  .event13_adder   (event13_adder  ),
  .event14_adder   (event14_adder  ),
  .event15_adder   (event15_adder  ),
  .event16_adder   (event16_adder  ),
  .event17_adder   (event17_adder  ),
  .event18_adder   (event18_adder  ),
  .event19_adder   (event19_adder  ),
  .event20_adder   (event20_adder  ),
  .event21_adder   (event21_adder  ),
  .event22_adder   (event22_adder  ),
  .event23_adder   (event23_adder  ),
  .event24_adder   (event24_adder  ),
  .event25_adder   (event25_adder  ),
  .event26_adder   (event26_adder  ),
  .event27_adder   (event27_adder  ),
  .event28_adder   (event28_adder  ),
  .event29_adder   (event29_adder  ),
  .event30_adder   (event30_adder  ),
  .event31_adder   (event31_adder  ),
  .event32_adder   (event32_adder  ),
  .event33_adder   (event33_adder  ),
  .event34_adder   (event34_adder  ),
  .event35_adder   (event35_adder  ),
  .event36_adder   (event36_adder  ),
  .event37_adder   (event37_adder  ),
  .event38_adder   (event38_adder  ),
  .event39_adder   (event39_adder  ),
  .event40_adder   (event40_adder  ),
  .event41_adder   (event41_adder  ),
  .event42_adder   (event42_adder  ),
  .mhpmcntx_adder  (mhpmcnt10_adder),
  .mhpmevtx_value  (mhpmevt10_value)
);

// &ConnRule(s/x/11/); @455
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_11"); @456
// &ConnRule(s/x/12/); @458
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_12"); @459
// &ConnRule(s/x/13/); @461
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_13"); @462
// &ConnRule(s/x/14/); @464
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_14"); @465
// &ConnRule(s/x/15/); @467
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_15"); @468
// &ConnRule(s/x/16/); @470
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_16"); @471
// &ConnRule(s/x/17/); @473
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_17"); @474
// &ConnRule(s/x/18/); @476
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_18"); @477
// &ConnRule(s/x/19/); @480
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_19"); @481
// &ConnRule(s/x/20/); @483
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_20"); @484
// &ConnRule(s/x/21/); @486
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_21"); @487
// &ConnRule(s/x/22/); @489
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_22"); @490
// &ConnRule(s/x/23/); @492
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_23"); @493
// &ConnRule(s/x/24/); @495
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_24"); @496
// &ConnRule(s/x/25/); @498
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_25"); @499
// &ConnRule(s/x/26/); @501
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_26"); @502
// &ConnRule(s/x/27/); @504
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_27"); @505
// &ConnRule(s/x/28/); @507
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_28"); @508
// &ConnRule(s/x/29/); @510
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_29"); @511
// &ConnRule(s/x/30/); @513
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_30"); @514
// &ConnRule(s/x/31/); @516
// &Instance("aq_hpcp_adder_sel", "x_aq_hpcp_adder_sel_31"); @517

//==========================================================
//                 Clk Enable of Gated Cell 
//==========================================================
assign mcntinhbt_clk_en  =  mcntinhbt_wen;
assign mcntinten_clk_en  =  mcntinten_wen;
assign mcntof_clk_en     =  mcntof_wen;
assign mhpmcr_clk_en     =  mhpmcr_wen;
assign mhpmsp_clk_en     =  mhpmsp_wen;
assign mhpmep_clk_en     =  mhpmep_wen;
assign scntinhbt_clk_en  =  scntinhbt_wen;
assign scntinten_clk_en  =  scntinten_wen;
assign scntof_clk_en     =  scntof_wen;
assign shpmcr_clk_en     =  shpmcr_wen;
assign shpmsp_clk_en     =  shpmsp_wen;
assign shpmep_clk_en     =  shpmep_wen;
assign mhpmevt3_clk_en   =  mhpmevt3_wen; 
assign mhpmevt4_clk_en   =  mhpmevt4_wen; 
assign mhpmevt5_clk_en   =  mhpmevt5_wen; 
assign mhpmevt6_clk_en   =  mhpmevt6_wen; 
assign mhpmevt7_clk_en   =  mhpmevt7_wen; 
assign mhpmevt8_clk_en   =  mhpmevt8_wen; 
assign mhpmevt9_clk_en   =  mhpmevt9_wen; 
assign mhpmevt10_clk_en  =  mhpmevt10_wen; 
assign mcycle_clk_en     =  mcycle_en    || mcycle_wen    || mcycle_of   ;
assign minstret_clk_en   =  minstret_en  || minstret_wen  || minstret_of ;
assign mhpmcnt3_clk_en   =  mhpmcnt3_en  || mhpmcnt3_wen  || mhpmcnt3_of ;
assign mhpmcnt4_clk_en   =  mhpmcnt4_en  || mhpmcnt4_wen  || mhpmcnt4_of ;
assign mhpmcnt5_clk_en   =  mhpmcnt5_en  || mhpmcnt5_wen  || mhpmcnt5_of ;
assign mhpmcnt6_clk_en   =  mhpmcnt6_en  || mhpmcnt6_wen  || mhpmcnt6_of ;
assign mhpmcnt7_clk_en   =  mhpmcnt7_en  || mhpmcnt7_wen  || mhpmcnt7_of ;
assign mhpmcnt8_clk_en   =  mhpmcnt8_en  || mhpmcnt8_wen  || mhpmcnt8_of ;
assign mhpmcnt9_clk_en   =  mhpmcnt9_en  || mhpmcnt9_wen  || mhpmcnt9_of ;
assign mhpmcnt10_clk_en  =  mhpmcnt10_en || mhpmcnt10_wen || mhpmcnt10_of;


//data prepare
assign hpcp_wdata[63:0] = cp0_hpcp_wdata[63:0];
//==========================================================
//                Control Registers
//==========================================================
// &Instance("gated_clk_cell", "x_hpcp_gated_clk"); @618
gated_clk_cell  x_hpcp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (hpcp_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (hpcp_clk_en       ),
  .module_en          (cp0_hpcp_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @619
//          .external_en (1'b0), @620
//          .global_en   (1'b1), @621
//          .module_en   (cp0_hpcp_icg_en), @622
//          .local_en    (hpcp_clk_en), @623
//          .clk_out     (hpcp_clk)); @624
assign hpcp_clk_en = mcntinhbt_clk_en 
                  || mcntinten_clk_en 
                  || mhpmcr_clk_en
                  || mhpmsp_clk_en
                  || mhpmep_clk_en
                  || scntinhbt_clk_en
                  || scntinten_clk_en
                  || shpmcr_clk_en
                  || shpmsp_clk_en
                  || shpmep_clk_en
                  || mcntof_clk_en
                  || scntof_clk_en
                  || (|counter_overflow[31:0])
                  || (tme[1:0] != 2'b00)
                  || (cnt_mode_dis_pre^cnt_mode_dis);

//==========================================================
// M/SHPMCR - Machine/Supervisor Contrl Register
//==========================================================
// +----+----+------+----+--+----+----+-------+-------+
// | 63 | 62 |      | 13 |  | 11 | 10 |       | 1   0 |
// +----+----+------+----+--+----+----+-------+-------+
//    |    |           |       |   |   |          |
//    |    |           |       |   |   |          +------ TME
//    |    |           |       |   |   |       
//    |    |           |       |   |   |   
//    |    |           |       |   +--------------------- PMDU
//    |    |           |       +------------------------- PMDS
//    |    |           |         
//    |    |           +--------------------------------- PMDM
//    |    +--------------------------------------------- SCE
//    +-------------------------------------------------- TS

assign mhpmcr_value[63:0] = {ts,sce,48'b0,cp0_hpcp_pmdm,1'b0,cp0_hpcp_pmds,cp0_hpcp_pmdu,8'b0,tme[1:0]};
assign shpmcr_value[63:0] = {ts,49'b0,cp0_hpcp_pmdm,1'b0,cp0_hpcp_pmds,cp0_hpcp_pmdu,8'b0,tme[1:0]};

always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      sce      <= 1'b0;
      tme[1:0] <= 2'b0;
    end
  else if(mhpmcr_wen) 
    begin
      sce      <= hpcp_wdata[62]; 
      tme[1:0] <= hpcp_wdata[1:0];
    end
  else if(shpmcr_wen) 
    begin
      sce      <= sce; //sce can be modified on m-mode 
      tme[1:0] <= hpcp_wdata[1:0];
    end
  else
    begin
      sce      <= sce;  
      tme[1:0] <= tme[1:0];
    end
end

always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ts <= 1'b0;
  else if(mhpmcr_wen || shpmcr_wen)
    ts <= hpcp_wdata[63];
  else if(hpcp_trigger_vld)
    ts <= 1'b1;
  else if(hpcp_stop_vld_ff)
    ts <= 1'b0;
  else if(hpcp_end_vld)
    ts <= 1'b0;
  else if(hpcp_start_vld)
    ts <= 1'b1;
  else
    ts <= ts;
end

always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    hpcp_stop_vld_ff <= 1'b0;
  else if(tme[1:0] == 2'b01)
    hpcp_stop_vld_ff <= hpcp_stop_vld;
  else
    hpcp_stop_vld_ff <= 1'b0;
end

//start point
assign retire_sub_hmpsp_result[39:0] =  {1'b0,hpcp_retire_pc[39:1]} - {1'b0,hpmsp_reg[38:0]};

//end point
assign hmpep_sub_retire_result[39:0] = {1'b0,hpmep_reg[38:0]} - {1'b0,hpcp_retire_pc[39:1]};

assign trigger_vld = (hpcp_retire_pc[39:1] == hpmsp_reg[38:0]) && hpcp_retire_inst_vld;

assign stop_vld    = (hpcp_retire_pc[39:1] == hpmep_reg[38:0]) && hpcp_retire_inst_vld;  
                  
assign start_vld   = !retire_sub_hmpsp_result[39] && !hmpep_sub_retire_result[39] && hpcp_retire_inst_vld;

assign end_vld     = (retire_sub_hmpsp_result[39] || hmpep_sub_retire_result[39]) && hpcp_retire_inst_vld;
 
assign hpcp_trigger_vld = trigger_vld && hpmsp_high_vld && hpmep_high_vld && (tme[1:0] == 2'b01);                
assign hpcp_stop_vld    = stop_vld    && hpmsp_high_vld && hpmep_high_vld && (tme[1:0] == 2'b01);                
assign hpcp_start_vld   = start_vld   && hpmsp_high_vld && hpmep_high_vld && (tme[1:0] == 2'b10);                
assign hpcp_end_vld     = end_vld     && hpmsp_high_vld && hpmep_high_vld && (tme[1:0] == 2'b10);                
 
//==================================================================
// M/SHPMSP - Machine/Supervisor Start Point PC Register
//==================================================================
always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    hpmsp_reg[62:0] <= 63'b0;
    hpmsp_high_vld  <= 1'b0;
  end
  else if(mhpmsp_wen || shpmsp_wen)
  begin
    hpmsp_reg[62:0] <= cp0_hpcp_wdata[63:1];
    hpmsp_high_vld  <= hpmsp_high_test; 
  end
  else
  begin
    hpmsp_reg[62:0] <= hpmsp_reg[62:0];
    hpmsp_high_vld  <= hpmsp_high_vld;
  end
end

//if start pc high 24 bit should be signed extended from bit 39
assign hpmsp_high_test   = (&cp0_hpcp_wdata[63:39]) || (!(|cp0_hpcp_wdata[63:39]));                 
assign mhpmsp_value[63:0] = {hpmsp_reg[62:0],1'b0};
assign shpmsp_value[63:0] = {hpmsp_reg[62:0],1'b0};

//==================================================================
// M/SHPMEP - Machine/Supervisor End Point PC Register
//==================================================================
always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    hpmep_reg[62:0] <= 63'b0;
    hpmep_high_vld  <= 1'b0;
  end
  else if(mhpmep_wen || shpmep_wen)
  begin
    hpmep_reg[62:0] <= cp0_hpcp_wdata[63:1];
    hpmep_high_vld  <= hpmep_high_test;
  end
  else
  begin
    hpmep_reg[62:0] <= hpmep_reg[62:0];
    hpmep_high_vld  <= hpmep_high_vld;
  end
end

assign hpmep_high_test   = (&cp0_hpcp_wdata[63:39]) || (!(|cp0_hpcp_wdata[63:39]));                 
assign mhpmep_value[63:0] = {hpmep_reg[62:0],1'b0};
assign shpmep_value[63:0] = {hpmep_reg[62:0],1'b0};


//==================================================================
// M/SCOUNTINHIBIT - Machine/Supervisor Counter-Inhibit Register
//==================================================================
// +----+----+----+-----------+---+---+---+---+---+---+
// | 31 | 30 | 29 |      28:6 | 5 | 4 | 3 | 2 | 1 | 0 |
// +----+----+----+-----------+---+---+---+---+---+---+
//    |    |    |               |   |   |   |   |   |
//    |    |    |               |   |   |   |   |   +---- CY
//    |    |    |               |   |   |   |   +-------- 0
//    |    |    |               |   |   |   +------------ IR
//    |    |    |               |   |   +---------------- HPM3
//    |    |    |               |   +-------------------- HPM4
//    |    |    |               +------------------------ HPM5
//    |    |    + --------------------------------------- HPM29
//    |    +--------------------------------------------- HPM30
//    +-------------------------------------------------- HPPM31

assign mcntinhbt_value[63:0] = {32'b0,hpm[28:0], ir, 1'b0, cy};
assign scntinhbt_value[63:0] = {32'b0,hpm[28:0], ir, 1'b0, cy} & {32'b0,cp0_hpcp_mcntwen[31:0]};


assign scntinhbt_updt_value[31:0] = ((~cp0_hpcp_mcntwen[31:0])& {hpm[28:0],ir,1'b0,cy}) 
                                  | (  cp0_hpcp_mcntwen[31:0] & hpcp_wdata[31:0]);
//=====================================
// HPM31~3/IR/CY bit in mnountinhibt
//=====================================
always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      hpm[28:0] <= 29'b0;
      ir        <= 1'b0;
      cy        <= 1'b0;
    end
  else if(mcntinhbt_wen) 
    begin
      hpm[28:0] <= hpcp_wdata[31:3];
      ir        <= hpcp_wdata[2];
      cy        <= hpcp_wdata[0];
    end
  else if(scntinhbt_wen) 
    begin
      hpm[28:0] <= scntinhbt_updt_value[31:3]; 
      ir        <= scntinhbt_updt_value[2];
      cy        <= scntinhbt_updt_value[0];
    end
  else
    begin
      hpm[28:0] <= hpm[28:0];
      ir        <= ir;
      cy        <= cy;
    end
end

//==================================================================
// M/SCOUNTERINTEN - Machine/Supervisor Counter-Int Enable Register
//==================================================================
// +----+----+----+-----------+---+---+---+---+---+---+
// | 31 | 30 | 29 |      28:6 | 5 | 4 | 3 | 2 | 1 | 0 |
// +----+----+----+-----------+---+---+---+---+---+---+
//    |    |    |               |   |   |   |   |   |
//    |    |    |               |   |   |   |   |   +---- CY_INTEN
//    |    |    |               |   |   |   |   +-------- 0
//    |    |    |               |   |   |   +------------ IR_INTEN
//    |    |    |               |   |   +---------------- HPM3_INTEN
//    |    |    |               |   +-------------------- HPM4_INTEN
//    |    |    |               +------------------------ HPM5_INTEN
//    |    |    + --------------------------------------- HPM29_INTEN
//    |    +--------------------------------------------- HPM30_INTEN
//    +-------------------------------------------------- HPPM31_INTEN
assign cntinten_value[63:0]  = {32'b0,cntinten[31:0]};
assign mcntinten_value[63:0] = cntinten_value[63:0];
assign scntinten_value[63:0] = cntinten_value[63:0] & {32'b0,cp0_hpcp_mcntwen[31:0]}; 

//======================================
// HPM31~3/IR/CY Int enable bit in m/scountinten
//=====================================
assign cntinten_wen[31:0] = {32{mcntinten_wen}} 
                          | {32{scntinten_wen}} & cp0_hpcp_mcntwen[31:0];

// &ConnRule(s/_x$/[0]/); @866
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_0"); @867
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_0 (
  .cntinten_wen_x  (cntinten_wen[0]),
  .cntinten_x      (cntinten[0]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[0]  )
);


assign cntinten[1] = 1'b0;

// &ConnRule(s/_x$/[2]/); @871
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_2"); @872
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_2 (
  .cntinten_wen_x  (cntinten_wen[2]),
  .cntinten_x      (cntinten[2]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[2]  )
);


// &ConnRule(s/_x$/[3]/); @874
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_3"); @875
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_3 (
  .cntinten_wen_x  (cntinten_wen[3]),
  .cntinten_x      (cntinten[3]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[3]  )
);


// &ConnRule(s/_x$/[4]/); @877
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_4"); @878
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_4 (
  .cntinten_wen_x  (cntinten_wen[4]),
  .cntinten_x      (cntinten[4]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[4]  )
);


// &ConnRule(s/_x$/[5]/); @880
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_5"); @881
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_5 (
  .cntinten_wen_x  (cntinten_wen[5]),
  .cntinten_x      (cntinten[5]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[5]  )
);


// &ConnRule(s/_x$/[6]/); @883
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_6"); @884
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_6 (
  .cntinten_wen_x  (cntinten_wen[6]),
  .cntinten_x      (cntinten[6]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[6]  )
);


// &ConnRule(s/_x$/[7]/); @886
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_7"); @887
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_7 (
  .cntinten_wen_x  (cntinten_wen[7]),
  .cntinten_x      (cntinten[7]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[7]  )
);


// &ConnRule(s/_x$/[8]/); @889
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_8"); @890
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_8 (
  .cntinten_wen_x  (cntinten_wen[8]),
  .cntinten_x      (cntinten[8]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[8]  )
);


// &ConnRule(s/_x$/[9]/); @892
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_9"); @893
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_9 (
  .cntinten_wen_x  (cntinten_wen[9]),
  .cntinten_x      (cntinten[9]    ),
  .cpurst_b        (cpurst_b       ),
  .hpcp_clk        (hpcp_clk       ),
  .hpcp_wdata_x    (hpcp_wdata[9]  )
);


// &ConnRule(s/_x$/[10]/); @895
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_10"); @896
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_10 (
  .cntinten_wen_x   (cntinten_wen[10]),
  .cntinten_x       (cntinten[10]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[10]  )
);


// &ConnRule(s/_x$/[11]/); @898
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_11"); @899
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_11 (
  .cntinten_wen_x   (cntinten_wen[11]),
  .cntinten_x       (cntinten[11]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[11]  )
);


// &ConnRule(s/_x$/[12]/); @901
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_12"); @902
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_12 (
  .cntinten_wen_x   (cntinten_wen[12]),
  .cntinten_x       (cntinten[12]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[12]  )
);


// &ConnRule(s/_x$/[13]/); @904
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_13"); @905
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_13 (
  .cntinten_wen_x   (cntinten_wen[13]),
  .cntinten_x       (cntinten[13]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[13]  )
);


// &ConnRule(s/_x$/[14]/); @907
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_14"); @908
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_14 (
  .cntinten_wen_x   (cntinten_wen[14]),
  .cntinten_x       (cntinten[14]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[14]  )
);


// &ConnRule(s/_x$/[15]/); @910
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_15"); @911
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_15 (
  .cntinten_wen_x   (cntinten_wen[15]),
  .cntinten_x       (cntinten[15]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[15]  )
);


// &ConnRule(s/_x$/[16]/); @913
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_16"); @914
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_16 (
  .cntinten_wen_x   (cntinten_wen[16]),
  .cntinten_x       (cntinten[16]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[16]  )
);


// &ConnRule(s/_x$/[17]/); @916
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_17"); @917
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_17 (
  .cntinten_wen_x   (cntinten_wen[17]),
  .cntinten_x       (cntinten[17]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[17]  )
);


// &ConnRule(s/_x$/[18]/); @919
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_18"); @920
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_18 (
  .cntinten_wen_x   (cntinten_wen[18]),
  .cntinten_x       (cntinten[18]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[18]  )
);


// &ConnRule(s/_x$/[19]/); @922
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_19"); @923
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_19 (
  .cntinten_wen_x   (cntinten_wen[19]),
  .cntinten_x       (cntinten[19]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[19]  )
);


// &ConnRule(s/_x$/[20]/); @925
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_20"); @926
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_20 (
  .cntinten_wen_x   (cntinten_wen[20]),
  .cntinten_x       (cntinten[20]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[20]  )
);


// &ConnRule(s/_x$/[21]/); @928
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_21"); @929
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_21 (
  .cntinten_wen_x   (cntinten_wen[21]),
  .cntinten_x       (cntinten[21]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[21]  )
);


// &ConnRule(s/_x$/[22]/); @931
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_22"); @932
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_22 (
  .cntinten_wen_x   (cntinten_wen[22]),
  .cntinten_x       (cntinten[22]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[22]  )
);


// &ConnRule(s/_x$/[23]/); @934
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_23"); @935
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_23 (
  .cntinten_wen_x   (cntinten_wen[23]),
  .cntinten_x       (cntinten[23]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[23]  )
);


// &ConnRule(s/_x$/[24]/); @937
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_24"); @938
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_24 (
  .cntinten_wen_x   (cntinten_wen[24]),
  .cntinten_x       (cntinten[24]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[24]  )
);


// &ConnRule(s/_x$/[25]/); @940
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_25"); @941
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_25 (
  .cntinten_wen_x   (cntinten_wen[25]),
  .cntinten_x       (cntinten[25]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[25]  )
);


// &ConnRule(s/_x$/[26]/); @943
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_26"); @944
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_26 (
  .cntinten_wen_x   (cntinten_wen[26]),
  .cntinten_x       (cntinten[26]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[26]  )
);


// &ConnRule(s/_x$/[27]/); @946
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_27"); @947
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_27 (
  .cntinten_wen_x   (cntinten_wen[27]),
  .cntinten_x       (cntinten[27]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[27]  )
);


// &ConnRule(s/_x$/[28]/); @949
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_28"); @950
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_28 (
  .cntinten_wen_x   (cntinten_wen[28]),
  .cntinten_x       (cntinten[28]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[28]  )
);


// &ConnRule(s/_x$/[29]/); @952
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_29"); @953
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_29 (
  .cntinten_wen_x   (cntinten_wen[29]),
  .cntinten_x       (cntinten[29]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[29]  )
);


// &ConnRule(s/_x$/[30]/); @955
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_30"); @956
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_30 (
  .cntinten_wen_x   (cntinten_wen[30]),
  .cntinten_x       (cntinten[30]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[30]  )
);


// &ConnRule(s/_x$/[31]/); @958
// &Instance("aq_hpcp_cntinten_reg","x_aq_hpcp_cntinten_31"); @959
aq_hpcp_cntinten_reg  x_aq_hpcp_cntinten_31 (
  .cntinten_wen_x   (cntinten_wen[31]),
  .cntinten_x       (cntinten[31]    ),
  .cpurst_b         (cpurst_b        ),
  .hpcp_clk         (hpcp_clk        ),
  .hpcp_wdata_x     (hpcp_wdata[31]  )
);




//==========================================================
// M/SCNTOF  - Machine/Supervisor Counter Overflow Register
//==========================================================
// +----+----+----+-----------+---+---+---+---+---+---+
// | 31 | 30 | 29 |      28:6 | 5 | 4 | 3 | 2 | 1 | 0 |
// +----+----+----+-----------+---+---+---+---+---+---+
//    |    |    |               |   |   |   |   |   |
//    |    |    |               |   |   |   |   |   +---- CY_OF
//    |    |    |               |   |   |   |   +-------- 0
//    |    |    |               |   |   |   +------------ IR_OF
//    |    |    |               |   |   +---------------- HPM3_OF
//    |    |    |               |   +-------------------- HPM4_OF
//    |    |    |               +------------------------ HPM5_OF
//    |    |    + --------------------------------------- HPM29_OF
//    |    +--------------------------------------------- HPM30_OF
//    +-------------------------------------------------- HPPM31_OF

assign cntof_value[63:0]  = {32'b0,cntof[31:0]};
assign mcntof_value[63:0] = cntof_value[63:0]; 
assign scntof_value[63:0] = cntof_value[63:0] & {32'b0,cp0_hpcp_mcntwen[31:0]}; 

//======================================
// HPM31~3/IR/CY bit in mcountof
//======================================
assign cntof_wen[31:0] = {32{mcntof_wen}} 
                       | {32{scntof_wen}} & cp0_hpcp_mcntwen[31:0];

// &ConnRule(s/_x$/[0]/); @990
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_0"); @991
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_0 (
  .cntof_wen_x         (cntof_wen[0]       ),
  .cntof_x             (cntof[0]           ),
  .counter_overflow_x  (counter_overflow[0]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[0]      )
);


assign cntof[1] = 1'b0;

// &ConnRule(s/_x$/[2]/); @995
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_2"); @996
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_2 (
  .cntof_wen_x         (cntof_wen[2]       ),
  .cntof_x             (cntof[2]           ),
  .counter_overflow_x  (counter_overflow[2]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[2]      )
);


// &ConnRule(s/_x$/[3]/); @998
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_3"); @999
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_3 (
  .cntof_wen_x         (cntof_wen[3]       ),
  .cntof_x             (cntof[3]           ),
  .counter_overflow_x  (counter_overflow[3]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[3]      )
);


// &ConnRule(s/_x$/[4]/); @1001
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_4"); @1002
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_4 (
  .cntof_wen_x         (cntof_wen[4]       ),
  .cntof_x             (cntof[4]           ),
  .counter_overflow_x  (counter_overflow[4]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[4]      )
);


// &ConnRule(s/_x$/[5]/); @1004
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_5"); @1005
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_5 (
  .cntof_wen_x         (cntof_wen[5]       ),
  .cntof_x             (cntof[5]           ),
  .counter_overflow_x  (counter_overflow[5]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[5]      )
);


// &ConnRule(s/_x$/[6]/); @1007
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_6"); @1008
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_6 (
  .cntof_wen_x         (cntof_wen[6]       ),
  .cntof_x             (cntof[6]           ),
  .counter_overflow_x  (counter_overflow[6]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[6]      )
);


// &ConnRule(s/_x$/[7]/); @1010
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_7"); @1011
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_7 (
  .cntof_wen_x         (cntof_wen[7]       ),
  .cntof_x             (cntof[7]           ),
  .counter_overflow_x  (counter_overflow[7]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[7]      )
);


// &ConnRule(s/_x$/[8]/); @1013
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_8"); @1014
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_8 (
  .cntof_wen_x         (cntof_wen[8]       ),
  .cntof_x             (cntof[8]           ),
  .counter_overflow_x  (counter_overflow[8]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[8]      )
);


// &ConnRule(s/_x$/[9]/); @1016
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_9"); @1017
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_9 (
  .cntof_wen_x         (cntof_wen[9]       ),
  .cntof_x             (cntof[9]           ),
  .counter_overflow_x  (counter_overflow[9]),
  .cpurst_b            (cpurst_b           ),
  .hpcp_clk            (hpcp_clk           ),
  .hpcp_wdata_x        (hpcp_wdata[9]      )
);


// &ConnRule(s/_x$/[10]/); @1019
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_10"); @1020
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_10 (
  .cntof_wen_x          (cntof_wen[10]       ),
  .cntof_x              (cntof[10]           ),
  .counter_overflow_x   (counter_overflow[10]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[10]      )
);


// &ConnRule(s/_x$/[11]/); @1022
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_11"); @1023
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_11 (
  .cntof_wen_x          (cntof_wen[11]       ),
  .cntof_x              (cntof[11]           ),
  .counter_overflow_x   (counter_overflow[11]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[11]      )
);


// &ConnRule(s/_x$/[12]/); @1025
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_12"); @1026
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_12 (
  .cntof_wen_x          (cntof_wen[12]       ),
  .cntof_x              (cntof[12]           ),
  .counter_overflow_x   (counter_overflow[12]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[12]      )
);


// &ConnRule(s/_x$/[13]/); @1028
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_13"); @1029
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_13 (
  .cntof_wen_x          (cntof_wen[13]       ),
  .cntof_x              (cntof[13]           ),
  .counter_overflow_x   (counter_overflow[13]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[13]      )
);


// &ConnRule(s/_x$/[14]/); @1031
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_14"); @1032
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_14 (
  .cntof_wen_x          (cntof_wen[14]       ),
  .cntof_x              (cntof[14]           ),
  .counter_overflow_x   (counter_overflow[14]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[14]      )
);


// &ConnRule(s/_x$/[15]/); @1034
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_15"); @1035
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_15 (
  .cntof_wen_x          (cntof_wen[15]       ),
  .cntof_x              (cntof[15]           ),
  .counter_overflow_x   (counter_overflow[15]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[15]      )
);


// &ConnRule(s/_x$/[16]/); @1037
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_16"); @1038
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_16 (
  .cntof_wen_x          (cntof_wen[16]       ),
  .cntof_x              (cntof[16]           ),
  .counter_overflow_x   (counter_overflow[16]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[16]      )
);


// &ConnRule(s/_x$/[17]/); @1040
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_17"); @1041
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_17 (
  .cntof_wen_x          (cntof_wen[17]       ),
  .cntof_x              (cntof[17]           ),
  .counter_overflow_x   (counter_overflow[17]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[17]      )
);


// &ConnRule(s/_x$/[18]/); @1043
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_18"); @1044
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_18 (
  .cntof_wen_x          (cntof_wen[18]       ),
  .cntof_x              (cntof[18]           ),
  .counter_overflow_x   (counter_overflow[18]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[18]      )
);


// &ConnRule(s/_x$/[19]/); @1046
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_19"); @1047
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_19 (
  .cntof_wen_x          (cntof_wen[19]       ),
  .cntof_x              (cntof[19]           ),
  .counter_overflow_x   (counter_overflow[19]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[19]      )
);


// &ConnRule(s/_x$/[20]/); @1049
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_20"); @1050
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_20 (
  .cntof_wen_x          (cntof_wen[20]       ),
  .cntof_x              (cntof[20]           ),
  .counter_overflow_x   (counter_overflow[20]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[20]      )
);


// &ConnRule(s/_x$/[21]/); @1052
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_21"); @1053
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_21 (
  .cntof_wen_x          (cntof_wen[21]       ),
  .cntof_x              (cntof[21]           ),
  .counter_overflow_x   (counter_overflow[21]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[21]      )
);


// &ConnRule(s/_x$/[22]/); @1055
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_22"); @1056
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_22 (
  .cntof_wen_x          (cntof_wen[22]       ),
  .cntof_x              (cntof[22]           ),
  .counter_overflow_x   (counter_overflow[22]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[22]      )
);


// &ConnRule(s/_x$/[23]/); @1058
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_23"); @1059
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_23 (
  .cntof_wen_x          (cntof_wen[23]       ),
  .cntof_x              (cntof[23]           ),
  .counter_overflow_x   (counter_overflow[23]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[23]      )
);


// &ConnRule(s/_x$/[24]/); @1061
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_24"); @1062
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_24 (
  .cntof_wen_x          (cntof_wen[24]       ),
  .cntof_x              (cntof[24]           ),
  .counter_overflow_x   (counter_overflow[24]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[24]      )
);


// &ConnRule(s/_x$/[25]/); @1064
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_25"); @1065
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_25 (
  .cntof_wen_x          (cntof_wen[25]       ),
  .cntof_x              (cntof[25]           ),
  .counter_overflow_x   (counter_overflow[25]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[25]      )
);


// &ConnRule(s/_x$/[26]/); @1067
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_26"); @1068
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_26 (
  .cntof_wen_x          (cntof_wen[26]       ),
  .cntof_x              (cntof[26]           ),
  .counter_overflow_x   (counter_overflow[26]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[26]      )
);


// &ConnRule(s/_x$/[27]/); @1070
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_27"); @1071
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_27 (
  .cntof_wen_x          (cntof_wen[27]       ),
  .cntof_x              (cntof[27]           ),
  .counter_overflow_x   (counter_overflow[27]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[27]      )
);


// &ConnRule(s/_x$/[28]/); @1073
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_28"); @1074
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_28 (
  .cntof_wen_x          (cntof_wen[28]       ),
  .cntof_x              (cntof[28]           ),
  .counter_overflow_x   (counter_overflow[28]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[28]      )
);


// &ConnRule(s/_x$/[29]/); @1076
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_29"); @1077
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_29 (
  .cntof_wen_x          (cntof_wen[29]       ),
  .cntof_x              (cntof[29]           ),
  .counter_overflow_x   (counter_overflow[29]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[29]      )
);


// &ConnRule(s/_x$/[30]/); @1079
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_30"); @1080
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_30 (
  .cntof_wen_x          (cntof_wen[30]       ),
  .cntof_x              (cntof[30]           ),
  .counter_overflow_x   (counter_overflow[30]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[30]      )
);


// &ConnRule(s/_x$/[31]/); @1082
// &Instance("aq_hpcp_cntof_reg","x_aq_hpcp_cntof_31"); @1083
aq_hpcp_cntof_reg  x_aq_hpcp_cntof_31 (
  .cntof_wen_x          (cntof_wen[31]       ),
  .cntof_x              (cntof[31]           ),
  .counter_overflow_x   (counter_overflow[31]),
  .cpurst_b             (cpurst_b            ),
  .hpcp_clk             (hpcp_clk            ),
  .hpcp_wdata_x         (hpcp_wdata[31]      )
);


assign counter_overflow[31:0] = {21'b0       ,mhpmcnt10_of,mhpmcnt9_of ,mhpmcnt8_of ,mhpmcnt7_of ,mhpmcnt6_of,
                                 mhpmcnt5_of ,mhpmcnt4_of ,mhpmcnt3_of ,minstret_of ,1'b0        ,mcycle_of};

//==========================================================
//                Configure Registers
//==========================================================
// &ConnRule(s/^eventx/mhpmevt3/);   @1113
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent3"); @1114
aq_hpcp_event  x_hpcp_mhpmevent3 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt3_clk_en   ),
  .eventx_value       (mhpmevt3_value    ),
  .eventx_wen         (mhpmevt3_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^eventx/mhpmevt4/);   @1116
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent4"); @1117
aq_hpcp_event  x_hpcp_mhpmevent4 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt4_clk_en   ),
  .eventx_value       (mhpmevt4_value    ),
  .eventx_wen         (mhpmevt4_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^eventx/mhpmevt5/);   @1119
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent5"); @1120
aq_hpcp_event  x_hpcp_mhpmevent5 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt5_clk_en   ),
  .eventx_value       (mhpmevt5_value    ),
  .eventx_wen         (mhpmevt5_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^eventx/mhpmevt6/);   @1122
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent6"); @1123
aq_hpcp_event  x_hpcp_mhpmevent6 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt6_clk_en   ),
  .eventx_value       (mhpmevt6_value    ),
  .eventx_wen         (mhpmevt6_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &ConnRule(s/^eventx/mhpmevt7/);   @1126
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent7"); @1127
aq_hpcp_event  x_hpcp_mhpmevent7 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt7_clk_en   ),
  .eventx_value       (mhpmevt7_value    ),
  .eventx_wen         (mhpmevt7_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^eventx/mhpmevt8/);   @1129
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent8"); @1130
aq_hpcp_event  x_hpcp_mhpmevent8 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt8_clk_en   ),
  .eventx_value       (mhpmevt8_value    ),
  .eventx_wen         (mhpmevt8_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^eventx/mhpmevt9/);   @1132
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent9"); @1133
aq_hpcp_event  x_hpcp_mhpmevent9 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt9_clk_en   ),
  .eventx_value       (mhpmevt9_value    ),
  .eventx_wen         (mhpmevt9_wen      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^eventx/mhpmevt10/);   @1135
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent10"); @1136
aq_hpcp_event  x_hpcp_mhpmevent10 (
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .eventx_clk_en      (mhpmevt10_clk_en  ),
  .eventx_value       (mhpmevt10_value   ),
  .eventx_wen         (mhpmevt10_wen     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &ConnRule(s/^eventx/mhpmevt11/);   @1139
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent11"); @1140
// &ConnRule(s/^eventx/mhpmevt12/);   @1142
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent12"); @1143
// &ConnRule(s/^eventx/mhpmevt13/);   @1145
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent13"); @1146
// &ConnRule(s/^eventx/mhpmevt14/);   @1148
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent14"); @1149
// &ConnRule(s/^eventx/mhpmevt15/);   @1151
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent15"); @1152
// &ConnRule(s/^eventx/mhpmevt16/);   @1154
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent16"); @1155
// &ConnRule(s/^eventx/mhpmevt17/);   @1157
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent17"); @1158
// &ConnRule(s/^eventx/mhpmevt18/);   @1160
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent18"); @1161
// &ConnRule(s/^eventx/mhpmevt19/);   @1164
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent19"); @1165
// &ConnRule(s/^eventx/mhpmevt20/);   @1167
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent20"); @1168
// &ConnRule(s/^eventx/mhpmevt21/);   @1170
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent21"); @1171
// &ConnRule(s/^eventx/mhpmevt22/);   @1173
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent22"); @1174
// &ConnRule(s/^eventx/mhpmevt23/);   @1176
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent23"); @1177
// &ConnRule(s/^eventx/mhpmevt24/);   @1179
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent24"); @1180
// &ConnRule(s/^eventx/mhpmevt25/);   @1182
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent25"); @1183
// &ConnRule(s/^eventx/mhpmevt26/);   @1185
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent26"); @1186
// &ConnRule(s/^eventx/mhpmevt27/);   @1188
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent27"); @1189
// &ConnRule(s/^eventx/mhpmevt28/);   @1191
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent28"); @1192
// &ConnRule(s/^eventx/mhpmevt29/);   @1194
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent29"); @1195
// &ConnRule(s/^eventx/mhpmevt30/);   @1197
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent30"); @1198
// &ConnRule(s/^eventx/mhpmevt31/);   @1200
// &Instance("aq_hpcp_event", "x_hpcp_mhpmevent31"); @1201

//==========================================================
//                       Counters 
//==========================================================
// Cycle counter 
// &ConnRule(s/^cnt/mcycle/); @1208
// &Instance("aq_hpcp_cnt", "x_hpcp_mcycle"); @1209
aq_hpcp_cnt  x_hpcp_mcycle (
  .cnt_adder          (mcycle_adder      ),
  .cnt_clk_en         (mcycle_clk_en     ),
  .cnt_en             (mcycle_en         ),
  .cnt_of             (mcycle_of         ),
  .cnt_value          (mcycle_value      ),
  .cnt_wen            (mcycle_wen        ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


//Instruction Retire counter
// &ConnRule(s/^cnt/minstret/); @1212
// &Instance("aq_hpcp_cnt", "x_hpcp_minstret"); @1213
aq_hpcp_cnt  x_hpcp_minstret (
  .cnt_adder          (minstret_adder    ),
  .cnt_clk_en         (minstret_clk_en   ),
  .cnt_en             (minstret_en       ),
  .cnt_of             (minstret_of       ),
  .cnt_value          (minstret_value    ),
  .cnt_wen            (minstret_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt3/); @1216
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt3"); @1217
aq_hpcp_cnt  x_hpcp_mhpmcnt3 (
  .cnt_adder          (mhpmcnt3_adder    ),
  .cnt_clk_en         (mhpmcnt3_clk_en   ),
  .cnt_en             (mhpmcnt3_en       ),
  .cnt_of             (mhpmcnt3_of       ),
  .cnt_value          (mhpmcnt3_value    ),
  .cnt_wen            (mhpmcnt3_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt4/); @1219
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt4"); @1220
aq_hpcp_cnt  x_hpcp_mhpmcnt4 (
  .cnt_adder          (mhpmcnt4_adder    ),
  .cnt_clk_en         (mhpmcnt4_clk_en   ),
  .cnt_en             (mhpmcnt4_en       ),
  .cnt_of             (mhpmcnt4_of       ),
  .cnt_value          (mhpmcnt4_value    ),
  .cnt_wen            (mhpmcnt4_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt5/); @1222
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt5"); @1223
aq_hpcp_cnt  x_hpcp_mhpmcnt5 (
  .cnt_adder          (mhpmcnt5_adder    ),
  .cnt_clk_en         (mhpmcnt5_clk_en   ),
  .cnt_en             (mhpmcnt5_en       ),
  .cnt_of             (mhpmcnt5_of       ),
  .cnt_value          (mhpmcnt5_value    ),
  .cnt_wen            (mhpmcnt5_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt6/); @1225
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt6"); @1226
aq_hpcp_cnt  x_hpcp_mhpmcnt6 (
  .cnt_adder          (mhpmcnt6_adder    ),
  .cnt_clk_en         (mhpmcnt6_clk_en   ),
  .cnt_en             (mhpmcnt6_en       ),
  .cnt_of             (mhpmcnt6_of       ),
  .cnt_value          (mhpmcnt6_value    ),
  .cnt_wen            (mhpmcnt6_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt7/); @1230
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt7"); @1231
aq_hpcp_cnt  x_hpcp_mhpmcnt7 (
  .cnt_adder          (mhpmcnt7_adder    ),
  .cnt_clk_en         (mhpmcnt7_clk_en   ),
  .cnt_en             (mhpmcnt7_en       ),
  .cnt_of             (mhpmcnt7_of       ),
  .cnt_value          (mhpmcnt7_value    ),
  .cnt_wen            (mhpmcnt7_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt8/); @1233
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt8"); @1234
aq_hpcp_cnt  x_hpcp_mhpmcnt8 (
  .cnt_adder          (mhpmcnt8_adder    ),
  .cnt_clk_en         (mhpmcnt8_clk_en   ),
  .cnt_en             (mhpmcnt8_en       ),
  .cnt_of             (mhpmcnt8_of       ),
  .cnt_value          (mhpmcnt8_value    ),
  .cnt_wen            (mhpmcnt8_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt9/); @1236
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt9"); @1237
aq_hpcp_cnt  x_hpcp_mhpmcnt9 (
  .cnt_adder          (mhpmcnt9_adder    ),
  .cnt_clk_en         (mhpmcnt9_clk_en   ),
  .cnt_en             (mhpmcnt9_en       ),
  .cnt_of             (mhpmcnt9_of       ),
  .cnt_value          (mhpmcnt9_value    ),
  .cnt_wen            (mhpmcnt9_wen      ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt10/); @1239
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt10"); @1240
aq_hpcp_cnt  x_hpcp_mhpmcnt10 (
  .cnt_adder          (mhpmcnt10_adder   ),
  .cnt_clk_en         (mhpmcnt10_clk_en  ),
  .cnt_en             (mhpmcnt10_en      ),
  .cnt_of             (mhpmcnt10_of      ),
  .cnt_value          (mhpmcnt10_value   ),
  .cnt_wen            (mhpmcnt10_wen     ),
  .cp0_hpcp_icg_en    (cp0_hpcp_icg_en   ),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .hpcp_cnt_en        (hpcp_cnt_en       ),
  .hpcp_wdata         (hpcp_wdata        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &ConnRule(s/^cnt/mhpmcnt11/); @1244
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt11"); @1245
// &ConnRule(s/^cnt/mhpmcnt12/); @1247
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt12"); @1248
// &ConnRule(s/^cnt/mhpmcnt13/); @1250
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt13"); @1251
// &ConnRule(s/^cnt/mhpmcnt14/); @1253
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt14"); @1254
// &ConnRule(s/^cnt/mhpmcnt15/); @1256
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt15"); @1257
// &ConnRule(s/^cnt/mhpmcnt16/); @1259
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt16"); @1260
// &ConnRule(s/^cnt/mhpmcnt17/); @1262
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt17"); @1263
// &ConnRule(s/^cnt/mhpmcnt18/); @1265
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt18"); @1266

// &ConnRule(s/^cnt/mhpmcnt19/); @1270
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt19"); @1271
// &ConnRule(s/^cnt/mhpmcnt20/); @1273
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt20"); @1274
// &ConnRule(s/^cnt/mhpmcnt21/); @1276
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt21"); @1277
// &ConnRule(s/^cnt/mhpmcnt22/); @1279
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt22"); @1280
// &ConnRule(s/^cnt/mhpmcnt23/); @1282
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt23"); @1283
// &ConnRule(s/^cnt/mhpmcnt24/); @1285
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt24"); @1286
// &ConnRule(s/^cnt/mhpmcnt25/); @1288
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt25"); @1289
// &ConnRule(s/^cnt/mhpmcnt26/); @1291
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt26"); @1292
// &ConnRule(s/^cnt/mhpmcnt27/); @1294
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt27"); @1295
// &ConnRule(s/^cnt/mhpmcnt28/); @1297
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt28"); @1298
// &ConnRule(s/^cnt/mhpmcnt29/); @1300
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt29"); @1301
// &ConnRule(s/^cnt/mhpmcnt30/); @1303
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt30"); @1304
// &ConnRule(s/^cnt/mhpmcnt31/); @1306
// &Instance("aq_hpcp_cnt", "x_hpcp_mhpmcnt31"); @1307

//==========================================================
// Read Operation
//==========================================================
// &CombBeg; @1313
always @( mhpmcr_value[63:0]
       or mhpmevt10_value[63:0]
       or mcntinhbt_value[63:0]
       or mhpmevt6_value[63:0]
       or mhpmcnt9_value[63:0]
       or mhpmcnt5_value[63:0]
       or scntinten_value[63:0]
       or mcntinten_value[63:0]
       or mhpmcnt7_value[63:0]
       or scntinhbt_value[63:0]
       or mhpmevt8_value[63:0]
       or shpmcr_value[63:0]
       or mcycle_value[63:0]
       or cp0_hpcp_index[11:0]
       or mhpmevt5_value[63:0]
       or mhpmcnt4_value[63:0]
       or biu_hpcp_time[63:0]
       or mhpmsp_value[63:0]
       or shpmsp_value[63:0]
       or mhpmevt3_value[63:0]
       or mhpmep_value[63:0]
       or minstret_value[63:0]
       or mhpmevt7_value[63:0]
       or mcntof_value[63:0]
       or mhpmcnt8_value[63:0]
       or shpmep_value[63:0]
       or mhpmevt4_value[63:0]
       or mhpmcnt3_value[63:0]
       or mhpmcnt10_value[63:0]
       or mhpmcnt6_value[63:0]
       or mhpmevt9_value[63:0]
       or scntof_value[63:0])
begin
  case(cp0_hpcp_index[11:0])
    MCNTINHBT  : data_out[63:0] = mcntinhbt_value[63:0];
    MCNTINTEN  : data_out[63:0] = mcntinten_value[63:0];
    MCNTOF     : data_out[63:0] = mcntof_value[63:0];
    MHPMCR     : data_out[63:0] = mhpmcr_value[63:0];
    MHPMSP     : data_out[63:0] = mhpmsp_value[63:0];
    MHPMEP     : data_out[63:0] = mhpmep_value[63:0];
    SCNTINHBT  : data_out[63:0] = scntinhbt_value[63:0];
    SCNTINTEN  : data_out[63:0] = scntinten_value[63:0];
    SCNTOF     : data_out[63:0] = scntof_value[63:0];
    SHPMCR     : data_out[63:0] = shpmcr_value[63:0];
    SHPMSP     : data_out[63:0] = shpmsp_value[63:0];
    SHPMEP     : data_out[63:0] = shpmep_value[63:0];
    MHPMEVT3   : data_out[63:0] = mhpmevt3_value[63:0]; 
    MHPMEVT4   : data_out[63:0] = mhpmevt4_value[63:0]; 
    MHPMEVT5   : data_out[63:0] = mhpmevt5_value[63:0];
    MHPMEVT6   : data_out[63:0] = mhpmevt6_value[63:0];
    MHPMEVT7   : data_out[63:0] = mhpmevt7_value[63:0];
    MHPMEVT8   : data_out[63:0] = mhpmevt8_value[63:0];
    MHPMEVT9   : data_out[63:0] = mhpmevt9_value[63:0];
    MHPMEVT10  : data_out[63:0] = mhpmevt10_value[63:0];
    MCYCLE     : data_out[63:0] = mcycle_value[63:0];
    MINSTRET   : data_out[63:0] = minstret_value[63:0]; 
    MHPMCNT3   : data_out[63:0] = mhpmcnt3_value[63:0]; 
    MHPMCNT4   : data_out[63:0] = mhpmcnt4_value[63:0];
    MHPMCNT5   : data_out[63:0] = mhpmcnt5_value[63:0];
    MHPMCNT6   : data_out[63:0] = mhpmcnt6_value[63:0];
    MHPMCNT7   : data_out[63:0] = mhpmcnt7_value[63:0];
    MHPMCNT8   : data_out[63:0] = mhpmcnt8_value[63:0];
    MHPMCNT9   : data_out[63:0] = mhpmcnt9_value[63:0];
    MHPMCNT10  : data_out[63:0] = mhpmcnt10_value[63:0];
    SCYCLE     : data_out[63:0] = mcycle_value[63:0];
    SINSTRET   : data_out[63:0] = minstret_value[63:0]; 
    SHPMCNT3   : data_out[63:0] = mhpmcnt3_value[63:0]; 
    SHPMCNT4   : data_out[63:0] = mhpmcnt4_value[63:0];
    SHPMCNT5   : data_out[63:0] = mhpmcnt5_value[63:0];
    SHPMCNT6   : data_out[63:0] = mhpmcnt6_value[63:0];
    SHPMCNT7   : data_out[63:0] = mhpmcnt7_value[63:0];
    SHPMCNT8   : data_out[63:0] = mhpmcnt8_value[63:0];
    SHPMCNT9   : data_out[63:0] = mhpmcnt9_value[63:0];
    SHPMCNT10  : data_out[63:0] = mhpmcnt10_value[63:0];
    CYCLE      : data_out[63:0] = mcycle_value[63:0]; 
    TIME       : data_out[63:0] = biu_hpcp_time[63:0];
    INSTRET    : data_out[63:0] = minstret_value[63:0];
    HPMCNT3    : data_out[63:0] = mhpmcnt3_value[63:0]; 
    HPMCNT4    : data_out[63:0] = mhpmcnt4_value[63:0];
    HPMCNT5    : data_out[63:0] = mhpmcnt5_value[63:0];
    HPMCNT6    : data_out[63:0] = mhpmcnt6_value[63:0];
    HPMCNT7    : data_out[63:0] = mhpmcnt7_value[63:0];
    HPMCNT8    : data_out[63:0] = mhpmcnt8_value[63:0];
    HPMCNT9    : data_out[63:0] = mhpmcnt9_value[63:0];
    HPMCNT10   : data_out[63:0] = mhpmcnt10_value[63:0];
    default    : data_out[63:0] = 64'b0;
  endcase
// &CombEnd; @1484
end

//==========================================================
// Output to CP0
//==========================================================
assign hpcp_cp0_data[63:0] = data_out[63:0];
assign hpcp_cp0_int_vld    = |(cntinten_value[31:0] & cntof_value[31:0]);
assign hpcp_cp0_sce        = sce;


assign hpcp_xx_cnt_en   = debug_mode_en && !cnt_mode_dis;
   
//==========================================================
// Output to IFU
//==========================================================
assign hpcp_ifu_cnt_en  = hpcp_xx_cnt_en; 

//==========================================================
// Output to MMU
//==========================================================
assign hpcp_mmu_cnt_en  = hpcp_xx_cnt_en;

//==========================================================
// Output to IDU
//==========================================================
assign hpcp_idu_cnt_en  = hpcp_xx_cnt_en; 

//==========================================================
// Output to IDU
//==========================================================
assign hpcp_iu_cnt_en   = hpcp_xx_cnt_en; 

//==========================================================
// Output to RTU
//==========================================================
assign hpcp_rtu_cnt_en  = hpcp_xx_cnt_en;

//==========================================================
// Output to LSU
//==========================================================
assign hpcp_lsu_cnt_en  = hpcp_xx_cnt_en; 


// &ModuleEnd; @1527
endmodule


