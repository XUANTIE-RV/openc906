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

// &ModuleBeg; @21
module aq_dtu_m_iie_all(
  cp0_dtu_icg_en,
  cp0_dtu_mexpt_vld,
  cp0_dtu_satp,
  cp0_dtu_wdata,
  cp0_write_mcontext,
  cp0_write_scontext,
  cp0_write_tcontrol,
  cp0_write_tdata1,
  cp0_write_tdata2,
  cp0_write_tdata3,
  cp0_write_tselect,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_cause,
  dtu_ifu_halt_info0,
  dtu_ifu_halt_info1,
  dtu_ifu_halt_info_vld,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  exe0_16bit,
  exe0_32bit,
  exe1_16bit,
  exe1_32bit,
  expt_vld,
  forever_cpuclk,
  icount_enable,
  ifu_dtu_addr_vld0,
  ifu_dtu_addr_vld1,
  ifu_dtu_data_vld0,
  ifu_dtu_data_vld1,
  ifu_dtu_exe_addr0,
  ifu_dtu_exe_addr1,
  ifu_dtu_exe_data0,
  ifu_dtu_exe_data1,
  int_vld,
  ldst_128bit,
  ldst_16bit,
  ldst_32bit,
  ldst_64bit,
  ldst_8bit,
  ldst_addr_mcontrol,
  ldst_data_mcontrol,
  load_addr_vld,
  load_data_vld,
  lsu_dtu_halt_info,
  lsu_dtu_last_check,
  lsu_dtu_ldst_addr,
  lsu_dtu_ldst_addr_vld,
  lsu_dtu_ldst_bytes_vld,
  lsu_dtu_ldst_data,
  lsu_dtu_ldst_data_vld,
  m_mode,
  mcontext,
  pad_yy_icg_scan_en,
  pending_halt,
  rtu_dtu_halt_ack,
  rtu_dtu_pending_ack,
  rtu_dtu_retire_halt_info,
  rtu_dtu_retire_mret,
  rtu_dtu_retire_vld,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_expt_vec,
  s_mode,
  scontext,
  store_addr_vld,
  store_data_vld,
  tcontrol,
  tdata1,
  tdata2,
  tdata3,
  tinfo,
  tselect,
  u_mode,
  updata_tval
);

// &Ports; @22
input           cp0_dtu_icg_en;               
input           cp0_dtu_mexpt_vld;            
input   [63:0]  cp0_dtu_satp;                 
input   [63:0]  cp0_dtu_wdata;                
input           cp0_write_mcontext;           
input           cp0_write_scontext;           
input           cp0_write_tcontrol;           
input           cp0_write_tdata1;             
input           cp0_write_tdata2;             
input           cp0_write_tdata3;             
input           cp0_write_tselect;            
input           cp0_yy_clk_en;                
input           cpurst_b;                     
input           exe0_16bit;                   
input           exe0_32bit;                   
input           exe1_16bit;                   
input           exe1_32bit;                   
input           expt_vld;                     
input           forever_cpuclk;               
input           ifu_dtu_addr_vld0;            
input           ifu_dtu_addr_vld1;            
input           ifu_dtu_data_vld0;            
input           ifu_dtu_data_vld1;            
input   [39:0]  ifu_dtu_exe_addr0;            
input   [39:0]  ifu_dtu_exe_addr1;            
input   [31:0]  ifu_dtu_exe_data0;            
input   [31:0]  ifu_dtu_exe_data1;            
input           int_vld;                      
input           ldst_128bit;                  
input           ldst_16bit;                   
input           ldst_32bit;                   
input           ldst_64bit;                   
input           ldst_8bit;                    
input           load_addr_vld;                
input           load_data_vld;                
input   [21:0]  lsu_dtu_halt_info;            
input           lsu_dtu_last_check;           
input   [39:0]  lsu_dtu_ldst_addr;            
input           lsu_dtu_ldst_addr_vld;        
input   [15:0]  lsu_dtu_ldst_bytes_vld;       
input   [63:0]  lsu_dtu_ldst_data;            
input           lsu_dtu_ldst_data_vld;        
input           m_mode;                       
input           pad_yy_icg_scan_en;           
input           rtu_dtu_halt_ack;             
input           rtu_dtu_pending_ack;          
input   [21:0]  rtu_dtu_retire_halt_info;     
input           rtu_dtu_retire_mret;          
input           rtu_dtu_retire_vld;           
input           rtu_yy_xx_dbgon;              
input   [4 :0]  rtu_yy_xx_expt_vec;           
input           s_mode;                       
input           store_addr_vld;               
input           store_data_vld;               
input           u_mode;                       
output  [3 :0]  dtu_cause;                    
output  [21:0]  dtu_ifu_halt_info0;           
output  [21:0]  dtu_ifu_halt_info1;           
output          dtu_ifu_halt_info_vld;        
output  [21:0]  dtu_lsu_halt_info;            
output          dtu_lsu_halt_info_vld;        
output          icount_enable;                
output          ldst_addr_mcontrol;           
output          ldst_data_mcontrol;           
output  [63:0]  mcontext;                     
output          pending_halt;                 
output  [63:0]  scontext;                     
output  [63:0]  tcontrol;                     
output  [63:0]  tdata1;                       
output  [63:0]  tdata2;                       
output  [63:0]  tdata3;                       
output  [63:0]  tinfo;                        
output  [63:0]  tselect;                      
output          updata_tval;                  

// &Regs; @23
reg     [3 :0]  dtu_cause;                    
reg     [12:0]  mcontext_lowbits;             
reg             mpte_reg;                     
reg             mte_reg;                      
reg             pending_halt;                 
reg             record_action01_reg;          
reg             record_action_reg;            
reg     [3 :0]  record_cause_reg;             
reg     [9 :0]  record_hit_reg;               
reg             record_ldst_reg;              
reg             retire_action01;              
reg     [33:0]  scontext_lowbits;             
reg     [63:0]  tdata1;                       
reg     [63:0]  tdata2;                       
reg     [63:0]  tdata3;                       
reg     [63:0]  tinfo;                        
reg     [9 :0]  triggers_hit;                 
reg     [3 :0]  tselect_lowbits;              
reg     [9 :0]  tselect_wr_en;                

// &Wires; @24
wire    [1 :0]  action0_iies;                 
wire    [9 :0]  action0_match_trigger;        
wire    [7 :0]  action0_mcontrol;             
wire    [9 :0]  action0_triggers;             
wire    [1 :0]  action1_iies;                 
wire    [9 :0]  action1_match_trigger;        
wire    [7 :0]  action1_mcontrol;             
wire    [9 :0]  action1_triggers;             
wire            clear_action01_reg;           
wire            clear_record;                 
wire            cp0_dtu_icg_en;               
wire            cp0_dtu_mexpt_vld;            
wire    [63:0]  cp0_dtu_satp;                 
wire    [63:0]  cp0_dtu_wdata;                
wire            cp0_write_mcontext;           
wire            cp0_write_scontext;           
wire            cp0_write_tcontrol;           
wire            cp0_write_tdata1;             
wire            cp0_write_tdata2;             
wire            cp0_write_tdata3;             
wire            cp0_write_tselect;            
wire            cp0_yy_clk_en;                
wire            cpurst_b;                     
wire    [21:0]  dtu_ifu_halt_info0;           
wire    [21:0]  dtu_ifu_halt_info1;           
wire            dtu_ifu_halt_info_vld;        
wire    [21:0]  dtu_lsu_halt_info;            
wire            dtu_lsu_halt_info_vld;        
wire    [31:0]  exception_codes_onehot;       
wire            exe0_16bit;                   
wire            exe0_32bit;                   
wire            exe1_16bit;                   
wire            exe1_32bit;                   
wire            expt_vld;                     
wire            forever_cpuclk;               
wire            generate_pending_halt;        
wire            generate_retire_action01;     
wire            generate_timing0;             
wire            give_action01_halt_info;      
wire            have_iie_action1_match;       
wire            have_iie_match;               
wire            icount_enable;                
wire            ifu_dtu_addr_vld0;            
wire            ifu_dtu_addr_vld1;            
wire            ifu_dtu_data_vld0;            
wire            ifu_dtu_data_vld1;            
wire    [39:0]  ifu_dtu_exe_addr0;            
wire    [39:0]  ifu_dtu_exe_addr1;            
wire    [31:0]  ifu_dtu_exe_data0;            
wire    [31:0]  ifu_dtu_exe_data1;            
wire            iie0_icount_enable;           
wire            iie0_match;                   
wire    [63:0]  iie0_tdata1;                  
wire            iie0_tdata1_action0;          
wire            iie0_tdata1_action1;          
wire    [63:0]  iie0_tdata2;                  
wire    [63:0]  iie0_tdata3;                  
wire    [63:0]  iie0_tinfo;                   
wire            iie0_updata_tval;             
wire            iie1_icount_enable;           
wire            iie1_match;                   
wire    [63:0]  iie1_tdata1;                  
wire            iie1_tdata1_action0;          
wire            iie1_tdata1_action1;          
wire    [63:0]  iie1_tdata2;                  
wire    [63:0]  iie1_tdata3;                  
wire    [63:0]  iie1_tinfo;                   
wire            iie1_updata_tval;             
wire    [1 :0]  iie_hit;                      
wire    [1 :0]  iie_match;                    
wire            iie_pending_halt;             
wire            int_vld;                      
wire            ldst_128bit;                  
wire            ldst_16bit;                   
wire            ldst_32bit;                   
wire            ldst_64bit;                   
wire            ldst_8bit;                    
wire            ldst_addr_mcontrol;           
wire            ldst_data_mcontrol;           
wire            load_addr_vld;                
wire            load_data_vld;                
wire    [21:0]  lsu_dtu_halt_info;            
wire            lsu_dtu_last_check;           
wire    [39:0]  lsu_dtu_ldst_addr;            
wire            lsu_dtu_ldst_addr_vld;        
wire    [15:0]  lsu_dtu_ldst_bytes_vld;       
wire    [63:0]  lsu_dtu_ldst_data;            
wire            lsu_dtu_ldst_data_vld;        
wire    [63:0]  m0_tdata1;                    
wire    [63:0]  m0_tdata2;                    
wire    [63:0]  m0_tdata3;                    
wire    [63:0]  m0_tinfo;                     
wire    [63:0]  m1_tdata1;                    
wire    [63:0]  m1_tdata2;                    
wire    [63:0]  m1_tdata3;                    
wire    [63:0]  m1_tinfo;                     
wire    [63:0]  m2_tdata1;                    
wire    [63:0]  m2_tdata2;                    
wire    [63:0]  m2_tdata3;                    
wire    [63:0]  m2_tinfo;                     
wire    [63:0]  m3_tdata1;                    
wire    [63:0]  m3_tdata2;                    
wire    [63:0]  m3_tdata3;                    
wire    [63:0]  m3_tinfo;                     
wire    [63:0]  m4_tdata1;                    
wire    [63:0]  m4_tdata2;                    
wire    [63:0]  m4_tdata3;                    
wire    [63:0]  m4_tinfo;                     
wire    [63:0]  m5_tdata1;                    
wire    [63:0]  m5_tdata2;                    
wire    [63:0]  m5_tdata3;                    
wire    [63:0]  m5_tinfo;                     
wire    [63:0]  m6_tdata1;                    
wire    [63:0]  m6_tdata2;                    
wire    [63:0]  m6_tdata3;                    
wire    [63:0]  m6_tinfo;                     
wire    [63:0]  m7_tdata1;                    
wire    [63:0]  m7_tdata2;                    
wire    [63:0]  m7_tdata3;                    
wire    [63:0]  m7_tinfo;                     
wire    [2 :0]  m_iie_action0;                
wire    [2 :0]  m_iie_action1;                
wire            m_iie_clk;                    
wire            m_iie_clk_en;                 
wire            m_iie_have_action0;           
wire            m_iie_have_action1;           
wire    [2 :0]  m_iie_match;                  
wire            m_mode;                       
wire            match_or_sync;                
wire    [63:0]  mcontext;                     
wire    [21:0]  mcontrol_halt_info0;          
wire    [21:0]  mcontrol_halt_info1;          
wire    [7 :0]  mcontrol_hit;                 
wire            mcontrol_updata_tval;         
wire            other_pending_halt;           
wire            pad_yy_icg_scan_en;           
wire            pending_halt_action;          
wire    [9 :0]  pending_halt_hit;             
wire            penging_halt_action01;        
wire            record_aciton01;              
wire            record_action;                
wire    [3 :0]  record_cause;                 
wire    [21:0]  record_halt_info;             
wire    [9 :0]  record_hit;                   
wire            record_ldst;                  
wire            record_match;                 
wire            record_pending_halt;          
wire    [3 :0]  rtu_cause;                    
wire            rtu_dtu_halt_ack;             
wire            rtu_dtu_pending_ack;          
wire    [21:0]  rtu_dtu_retire_halt_info;     
wire            rtu_dtu_retire_mret;          
wire            rtu_dtu_retire_vld;           
wire            rtu_pending_ack;              
wire            rtu_pending_halt;             
wire    [21:0]  rtu_retire_halt_info;         
wire            rtu_yy_xx_dbgon;              
wire    [4 :0]  rtu_yy_xx_expt_vec;           
wire            s_mode;                       
wire    [63:0]  scontext;                     
wire            store_addr_vld;               
wire            store_data_vld;               
wire    [63:0]  tcontrol;                     
wire            timing0_mcontrol_match;       
wire    [9 :0]  triggers_match;               
wire    [63:0]  tselect;                      
wire            u_mode;                       
wire            updata_tval;                  
wire            use_record_halt_info;         
wire            wdata_bigger_than_trigger_num; 


//XLEN
parameter XLEN = `TDT_DM_CORE_MAX_XLEN;

parameter TRIGGER_NUM = `TDT_TM_TRIGGER_NUM-1;

//tcontrol parameter
parameter MPTE       = 7;
parameter MTE        = 3;
//=========================================================            
//                    tselect write             
//=========================================================
//tselect write. When wdata > TRIGGER_NUM, write TRIGGER_NUM to tselsect.
assign wdata_bigger_than_trigger_num = cp0_dtu_wdata[3:0] >= TRIGGER_NUM[3:0] || (|cp0_dtu_wdata[63:4]);
always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tselect_lowbits[3:0] <= 4'b0;
  else if(cp0_write_tselect && wdata_bigger_than_trigger_num)
    tselect_lowbits[3:0] <= TRIGGER_NUM[3:0];
  else if(cp0_write_tselect && !wdata_bigger_than_trigger_num)
    tselect_lowbits[3:0] <= cp0_dtu_wdata[3:0];
end
assign tselect[XLEN-1:0] = {{XLEN-4{1'b0}},tselect_lowbits[3:0]};
// &Force("output","tselect");&Force("bus","tselect",XLEN-1,0); @49

//select trigger
// &CombBeg; @52
always @( tselect[3:0])
begin
case(tselect[3:0])
  4'b0000:tselect_wr_en[9:0] = 10'b0000000001;
  4'b0001:tselect_wr_en[9:0] = 10'b0000000010;
  4'b0010:tselect_wr_en[9:0] = 10'b0000000100;
  4'b0011:tselect_wr_en[9:0] = 10'b0000001000;
  4'b0100:tselect_wr_en[9:0] = 10'b0000010000;
  4'b0101:tselect_wr_en[9:0] = 10'b0000100000;
  4'b0110:tselect_wr_en[9:0] = 10'b0001000000;
  4'b0111:tselect_wr_en[9:0] = 10'b0010000000;
  4'b1000:tselect_wr_en[9:0] = 10'b0100000000;
  4'b1001:tselect_wr_en[9:0] = 10'b1000000000;
  default:tselect_wr_en[9:0] = {10{1'bx}};
endcase
// &CombEnd; @66
end

//=========================================================            
//              trigger csr read              
//=========================================================

// &CombBeg; @72
always @( iie0_tinfo[63:0]
       or m0_tdata3[63:0]
       or tselect[3:0]
       or m4_tdata2[63:0]
       or m2_tdata2[63:0]
       or iie1_tinfo[63:0]
       or m6_tinfo[63:0]
       or m5_tdata2[63:0]
       or m1_tdata3[63:0]
       or iie0_tdata1[63:0]
       or m6_tdata3[63:0]
       or m0_tdata2[63:0]
       or m5_tdata3[63:0]
       or m3_tdata3[63:0]
       or m4_tdata3[63:0]
       or m7_tdata2[63:0]
       or m3_tinfo[63:0]
       or m5_tinfo[63:0]
       or m2_tdata3[63:0]
       or m6_tdata2[63:0]
       or m0_tinfo[63:0]
       or iie1_tdata1[63:0]
       or iie1_tdata2[63:0]
       or m6_tdata1[63:0]
       or m2_tdata1[63:0]
       or m7_tdata1[63:0]
       or m2_tinfo[63:0]
       or m1_tdata1[63:0]
       or m0_tdata1[63:0]
       or m4_tdata1[63:0]
       or iie0_tdata3[63:0]
       or m7_tinfo[63:0]
       or m1_tinfo[63:0]
       or m4_tinfo[63:0]
       or m5_tdata1[63:0]
       or iie1_tdata3[63:0]
       or iie0_tdata2[63:0]
       or m3_tdata1[63:0]
       or m3_tdata2[63:0]
       or m1_tdata2[63:0]
       or m7_tdata3[63:0])
begin
case(tselect[3:0])
//         &Force("nonport","m0_tdata1"); @177
//         &Force("nonport","m0_tdata2"); @178
//         &Force("nonport","m0_tdata3"); @179
//         &Force("nonport","m0_tinfo"); @180
//         //&Force("nonport","m0_tcontrol"); @181
//         //&Force("nonport","m0_mcontext"); @182
//         //&Force("nonport","m0_scontext"); @183
//         &Force("nonport","m1_tdata1"); @184
//         &Force("nonport","m1_tdata2"); @185
//         &Force("nonport","m1_tdata3"); @186
//         &Force("nonport","m1_tinfo"); @187
//         //&Force("nonport","m1_tcontrol"); @188
//         //&Force("nonport","m1_mcontext"); @189
//         //&Force("nonport","m1_scontext"); @190
        4'b0000:
              begin
                tdata1[XLEN-1:0]   = m0_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = m0_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = m0_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = m0_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = m0_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = m0_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = m0_scontext[XLEN-1:0];
              end
        4'b0001:
              begin
                tdata1[XLEN-1:0]   = m1_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = m1_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = m1_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = m1_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = m1_tcontrol[XLEN-1:0];
               //mcontext[XLEN-1:0] = m1_mcontext[XLEN-1:0];
               //scontext[XLEN-1:0] = m1_scontext[XLEN-1:0];
              end
//         &Force("nonport","m2_tdata1"); @234
//         &Force("nonport","m2_tdata2"); @235
//         &Force("nonport","m2_tdata3"); @236
//         &Force("nonport","m2_tinfo"); @237
//         //&Force("nonport","m2_tcontrol"); @238
//         //&Force("nonport","m2_mcontext"); @239
//         //&Force("nonport","m2_scontext"); @240
//         &Force("nonport","m3_tdata1"); @241
//         &Force("nonport","m3_tdata2"); @242
//         &Force("nonport","m3_tdata3"); @243
//         &Force("nonport","m3_tinfo"); @244
//         //&Force("nonport","m3_tcontrol"); @245
//         //&Force("nonport","m3_mcontext"); @246
//         //&Force("nonport","m3_scontext"); @247
        4'b0010:
              begin
                tdata1[XLEN-1:0]   = m2_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = m2_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = m2_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = m2_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = m2_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = m2_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = m2_scontext[XLEN-1:0];
              end
        4'b0011:
              begin
                tdata1[XLEN-1:0]   = m3_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = m3_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = m3_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = m3_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = m3_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = m3_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = m3_scontext[XLEN-1:0];
              end
//         &Force("nonport","m4_tdata1"); @291
//         &Force("nonport","m4_tdata2"); @292
//         &Force("nonport","m4_tdata3"); @293
//         &Force("nonport","m4_tinfo"); @294
//         //&Force("nonport","m4_tcontrol"); @295
//         //&Force("nonport","m4_mcontext"); @296
//         //&Force("nonport","m4_scontext"); @297
//         &Force("nonport","m5_tdata1"); @298
//         &Force("nonport","m5_tdata2"); @299
//         &Force("nonport","m5_tdata3"); @300
//         &Force("nonport","m5_tinfo"); @301
//         //&Force("nonport","m5_tcontrol"); @302
//         //&Force("nonport","m5_mcontext"); @303
//         //&Force("nonport","m5_scontext"); @304
        4'b0100:
              begin
                tdata1[XLEN-1:0]   = m4_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = m4_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = m4_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = m4_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = m4_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = m4_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = m4_scontext[XLEN-1:0];
              end
        4'b0101:
              begin
                tdata1[XLEN-1:0]   = m5_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = m5_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = m5_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = m5_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = m5_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = m5_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = m5_scontext[XLEN-1:0];
              end
  4'b0110:
        begin
          tdata1[XLEN-1:0]   = m6_tdata1[XLEN-1:0];
          tdata2[XLEN-1:0]   = m6_tdata2[XLEN-1:0];
          tdata3[XLEN-1:0]   = m6_tdata3[XLEN-1:0];
          tinfo[XLEN-1:0]    = m6_tinfo[XLEN-1:0];
          //tcontrol[XLEN-1:0] = m6_tcontrol[XLEN-1:0];
          //mcontext[XLEN-1:0] = m6_mcontext[XLEN-1:0];
          //scontext[XLEN-1:0] = m6_scontext[XLEN-1:0];
        end
  4'b0111:
        begin
          tdata1[XLEN-1:0]   = m7_tdata1[XLEN-1:0];
          tdata2[XLEN-1:0]   = m7_tdata2[XLEN-1:0];
          tdata3[XLEN-1:0]   = m7_tdata3[XLEN-1:0];
          tinfo[XLEN-1:0]    = m7_tinfo[XLEN-1:0];
          //tcontrol[XLEN-1:0] = m7_tcontrol[XLEN-1:0];
          //mcontext[XLEN-1:0] = m7_mcontext[XLEN-1:0];
          //scontext[XLEN-1:0] = m7_scontext[XLEN-1:0];
        end
        4'b1000:
              begin
                tdata1[XLEN-1:0]   = iie0_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = iie0_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = iie0_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = iie0_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = iie0_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = iie0_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = iie0_scontext[XLEN-1:0];
              end
        4'b1001:
              begin
                tdata1[XLEN-1:0]   = iie1_tdata1[XLEN-1:0];
                tdata2[XLEN-1:0]   = iie1_tdata2[XLEN-1:0];
                tdata3[XLEN-1:0]   = iie1_tdata3[XLEN-1:0];
                tinfo[XLEN-1:0]    = iie1_tinfo[XLEN-1:0];
                //tcontrol[XLEN-1:0] = iie1_tcontrol[XLEN-1:0];
                //mcontext[XLEN-1:0] = iie1_mcontext[XLEN-1:0];
                //scontext[XLEN-1:0] = iie1_scontext[XLEN-1:0];
              end
  default:
        begin
          tdata1[XLEN-1:0]   = {XLEN{1'bx}};
          tdata2[XLEN-1:0]   = {XLEN{1'bx}};
          tdata3[XLEN-1:0]   = {XLEN{1'bx}};
          tinfo[XLEN-1:0]    = {XLEN{1'bx}};
          //tcontrol[XLEN-1:0] = {XLEN{1'bx}};
          //mcontext[XLEN-1:0] = {XLEN{1'bx}};
          //scontext[XLEN-1:0] = {XLEN{1'bx}};
        end
endcase
// &CombEnd; @381
end

//=========================================================            
//              trigger instance              
//=========================================================
//--------------mcontrol instance--------------------------
// &Instance("aq_dtu_mcontrol_output_select"); @387
aq_dtu_mcontrol_output_select  x_aq_dtu_mcontrol_output_select (
  .action0_mcontrol       (action0_mcontrol      ),
  .action1_mcontrol       (action1_mcontrol      ),
  .cp0_dtu_icg_en         (cp0_dtu_icg_en        ),
  .cp0_dtu_satp           (cp0_dtu_satp          ),
  .cp0_dtu_wdata          (cp0_dtu_wdata         ),
  .cp0_write_tdata1       (cp0_write_tdata1      ),
  .cp0_write_tdata2       (cp0_write_tdata2      ),
  .cp0_write_tdata3       (cp0_write_tdata3      ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .dtu_ifu_halt_info_vld  (dtu_ifu_halt_info_vld ),
  .dtu_lsu_halt_info      (dtu_lsu_halt_info     ),
  .dtu_lsu_halt_info_vld  (dtu_lsu_halt_info_vld ),
  .exe0_16bit             (exe0_16bit            ),
  .exe0_32bit             (exe0_32bit            ),
  .exe1_16bit             (exe1_16bit            ),
  .exe1_32bit             (exe1_32bit            ),
  .forever_cpuclk         (forever_cpuclk        ),
  .ifu_dtu_addr_vld0      (ifu_dtu_addr_vld0     ),
  .ifu_dtu_addr_vld1      (ifu_dtu_addr_vld1     ),
  .ifu_dtu_data_vld0      (ifu_dtu_data_vld0     ),
  .ifu_dtu_data_vld1      (ifu_dtu_data_vld1     ),
  .ifu_dtu_exe_addr0      (ifu_dtu_exe_addr0     ),
  .ifu_dtu_exe_addr1      (ifu_dtu_exe_addr1     ),
  .ifu_dtu_exe_data0      (ifu_dtu_exe_data0     ),
  .ifu_dtu_exe_data1      (ifu_dtu_exe_data1     ),
  .ldst_128bit            (ldst_128bit           ),
  .ldst_16bit             (ldst_16bit            ),
  .ldst_32bit             (ldst_32bit            ),
  .ldst_64bit             (ldst_64bit            ),
  .ldst_8bit              (ldst_8bit             ),
  .ldst_addr_mcontrol     (ldst_addr_mcontrol    ),
  .ldst_data_mcontrol     (ldst_data_mcontrol    ),
  .load_addr_vld          (load_addr_vld         ),
  .load_data_vld          (load_data_vld         ),
  .lsu_dtu_halt_info      (lsu_dtu_halt_info     ),
  .lsu_dtu_last_check     (lsu_dtu_last_check    ),
  .lsu_dtu_ldst_addr      (lsu_dtu_ldst_addr     ),
  .lsu_dtu_ldst_addr_vld  (lsu_dtu_ldst_addr_vld ),
  .lsu_dtu_ldst_bytes_vld (lsu_dtu_ldst_bytes_vld),
  .lsu_dtu_ldst_data      (lsu_dtu_ldst_data     ),
  .lsu_dtu_ldst_data_vld  (lsu_dtu_ldst_data_vld ),
  .m0_tdata1              (m0_tdata1             ),
  .m0_tdata2              (m0_tdata2             ),
  .m0_tdata3              (m0_tdata3             ),
  .m0_tinfo               (m0_tinfo              ),
  .m1_tdata1              (m1_tdata1             ),
  .m1_tdata2              (m1_tdata2             ),
  .m1_tdata3              (m1_tdata3             ),
  .m1_tinfo               (m1_tinfo              ),
  .m2_tdata1              (m2_tdata1             ),
  .m2_tdata2              (m2_tdata2             ),
  .m2_tdata3              (m2_tdata3             ),
  .m2_tinfo               (m2_tinfo              ),
  .m3_tdata1              (m3_tdata1             ),
  .m3_tdata2              (m3_tdata2             ),
  .m3_tdata3              (m3_tdata3             ),
  .m3_tinfo               (m3_tinfo              ),
  .m4_tdata1              (m4_tdata1             ),
  .m4_tdata2              (m4_tdata2             ),
  .m4_tdata3              (m4_tdata3             ),
  .m4_tinfo               (m4_tinfo              ),
  .m5_tdata1              (m5_tdata1             ),
  .m5_tdata2              (m5_tdata2             ),
  .m5_tdata3              (m5_tdata3             ),
  .m5_tinfo               (m5_tinfo              ),
  .m6_tdata1              (m6_tdata1             ),
  .m6_tdata2              (m6_tdata2             ),
  .m6_tdata3              (m6_tdata3             ),
  .m6_tinfo               (m6_tinfo              ),
  .m7_tdata1              (m7_tdata1             ),
  .m7_tdata2              (m7_tdata2             ),
  .m7_tdata3              (m7_tdata3             ),
  .m7_tinfo               (m7_tinfo              ),
  .m_mode                 (m_mode                ),
  .mcontext               (mcontext              ),
  .mcontrol_halt_info0    (mcontrol_halt_info0   ),
  .mcontrol_halt_info1    (mcontrol_halt_info1   ),
  .mcontrol_hit           (mcontrol_hit          ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .rtu_yy_xx_dbgon        (rtu_yy_xx_dbgon       ),
  .s_mode                 (s_mode                ),
  .scontext               (scontext              ),
  .store_addr_vld         (store_addr_vld        ),
  .store_data_vld         (store_data_vld        ),
  .tcontrol               (tcontrol              ),
  .tselect_wr_en          (tselect_wr_en         ),
  .u_mode                 (u_mode                )
);


//--------------iie trigger instance--------------------------
// &Instance("aq_dtu_iie_trigger","x_aq_dtu_iie_trigger_0"); @391
aq_dtu_iie_trigger  x_aq_dtu_iie_trigger_0 (
  .cp0_dtu_icg_en         (cp0_dtu_icg_en        ),
  .cp0_dtu_satp           (cp0_dtu_satp          ),
  .cp0_dtu_wdata          (cp0_dtu_wdata         ),
  .cp0_write_tdata1       (cp0_write_tdata1      ),
  .cp0_write_tdata2       (cp0_write_tdata2      ),
  .cp0_write_tdata3       (cp0_write_tdata3      ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .exception_codes_onehot (exception_codes_onehot),
  .expt_vld               (expt_vld              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .generate_timing0       (generate_timing0      ),
  .icount_enable          (iie0_icount_enable    ),
  .int_vld                (int_vld               ),
  .m_mode                 (m_mode                ),
  .mcontext               (mcontext              ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .rtu_dtu_retire_vld     (rtu_dtu_retire_vld    ),
  .rtu_yy_xx_dbgon        (rtu_yy_xx_dbgon       ),
  .s_mode                 (s_mode                ),
  .scontext               (scontext              ),
  .set_trigger_hit        (iie_hit[0]            ),
  .tcontrol               (tcontrol              ),
  .tdata1                 (iie0_tdata1           ),
  .tdata1_action0         (iie0_tdata1_action0   ),
  .tdata1_action1         (iie0_tdata1_action1   ),
  .tdata2                 (iie0_tdata2           ),
  .tdata3                 (iie0_tdata3           ),
  .tinfo                  (iie0_tinfo            ),
  .trigger_match          (iie0_match            ),
  .trigger_selected       (tselect_wr_en[8]      ),
  .u_mode                 (u_mode                )
);

// &Connect( @392
//          .trigger_selected(tselect_wr_en[`TDT_TM_MCONTROL_TRI_NUM]), @393
//          .set_trigger_hit(iie_hit[0]), @394
//          //.expt_codes     (expt_codes), @395
//          //.int_codes      (int_codes), @396
//          .exception_codes_onehot(exception_codes_onehot), @397
//          .icount_enable  (iie0_icount_enable), @398
//          .tdata1_action0 (iie0_tdata1_action0), @399
//          .tdata1_action1 (iie0_tdata1_action1), @400
//          .trigger_match  (iie0_match) @401
//          .tdata1         (iie0_tdata1), @402
//          .tdata2         (iie0_tdata2), @403
//          .tdata3         (iie0_tdata3), @404
//          .tinfo          (iie0_tinfo)); @405
         //.tcontrol       (iie0_tcontrol),
         //.mcontext       (iie0_mcontext),
         //.scontext       (iie0_scontext));

// &Instance("aq_dtu_iie_trigger","x_aq_dtu_iie_trigger_1"); @410
aq_dtu_iie_trigger  x_aq_dtu_iie_trigger_1 (
  .cp0_dtu_icg_en         (cp0_dtu_icg_en        ),
  .cp0_dtu_satp           (cp0_dtu_satp          ),
  .cp0_dtu_wdata          (cp0_dtu_wdata         ),
  .cp0_write_tdata1       (cp0_write_tdata1      ),
  .cp0_write_tdata2       (cp0_write_tdata2      ),
  .cp0_write_tdata3       (cp0_write_tdata3      ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .exception_codes_onehot (exception_codes_onehot),
  .expt_vld               (expt_vld              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .generate_timing0       (generate_timing0      ),
  .icount_enable          (iie1_icount_enable    ),
  .int_vld                (int_vld               ),
  .m_mode                 (m_mode                ),
  .mcontext               (mcontext              ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .rtu_dtu_retire_vld     (rtu_dtu_retire_vld    ),
  .rtu_yy_xx_dbgon        (rtu_yy_xx_dbgon       ),
  .s_mode                 (s_mode                ),
  .scontext               (scontext              ),
  .set_trigger_hit        (iie_hit[1]            ),
  .tcontrol               (tcontrol              ),
  .tdata1                 (iie1_tdata1           ),
  .tdata1_action0         (iie1_tdata1_action0   ),
  .tdata1_action1         (iie1_tdata1_action1   ),
  .tdata2                 (iie1_tdata2           ),
  .tdata3                 (iie1_tdata3           ),
  .tinfo                  (iie1_tinfo            ),
  .trigger_match          (iie1_match            ),
  .trigger_selected       (tselect_wr_en[9]      ),
  .u_mode                 (u_mode                )
);

// &Connect( @411
//          .trigger_selected(tselect_wr_en[`TDT_TM_MCONTROL_TRI_NUM + 1]),         @412
//          .set_trigger_hit(iie_hit[1]), @413
//          //.expt_codes     (expt_codes), @414
//          //.int_codes      (int_codes), @415
//          .exception_codes_onehot(exception_codes_onehot), @416
//          .icount_enable  (iie1_icount_enable), @417
//          .tdata1_action0 (iie1_tdata1_action0), @418
//          .tdata1_action1 (iie1_tdata1_action1), @419
//          .trigger_match  (iie1_match) @420
//          .tdata1         (iie1_tdata1), @421
//          .tdata2         (iie1_tdata2), @422
//          .tdata3         (iie1_tdata3), @423
//          .tinfo          (iie1_tinfo)); @424
         //.tcontrol       (iie1_tcontrol),
         //.mcontext       (iie1_mcontext),
         //.scontext       (iie1_scontext));
assign iie_match[`TDT_TM_OTHER_TRI_NUM-1:0] = {iie1_match,iie0_match};
assign have_iie_match = iie1_match || iie0_match;
assign action0_iies[`TDT_TM_OTHER_TRI_NUM-1:0] = {iie1_tdata1_action0,iie0_tdata1_action0};
assign action1_iies[`TDT_TM_OTHER_TRI_NUM-1:0] = {iie1_tdata1_action1,iie0_tdata1_action1};
assign have_iie_action1_match = |(iie_match[`TDT_TM_OTHER_TRI_NUM-1:0] & action1_iies[`TDT_TM_OTHER_TRI_NUM-1:0]);

 //exception_codes decode
assign exception_codes_onehot[31:0] = 32'b1 << rtu_yy_xx_expt_vec[4:0];

//-------tcontrol,mcontext,scontext for triggers---------
//write tcontrol
always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      mte_reg  <= 1'b0;
      mpte_reg <= 1'b0;
    end
  else if(cp0_dtu_mexpt_vld && rtu_dtu_retire_mret && rtu_dtu_retire_vld)
    begin
      mte_reg  <= 1'b0;
      mpte_reg <= mpte_reg; 
    end
  else if(cp0_dtu_mexpt_vld)//A trap into m mode is taken, set MPTE to MTE,set MTE to 0.
    begin
      mte_reg  <= 1'b0;
      mpte_reg <= mte_reg;
    end
  else if(rtu_dtu_retire_mret && rtu_dtu_retire_vld)//mret is executed, set MTE to MPTE. 
    begin
      mte_reg  <= mpte_reg;
      mpte_reg <= mpte_reg;
    end
  else if(cp0_write_tcontrol)
    begin
      mte_reg  <= cp0_dtu_wdata[MTE];
      mpte_reg <= cp0_dtu_wdata[MPTE];
    end
end
assign tcontrol[XLEN-1:0] = {{XLEN-8{1'b0}},mpte_reg,{3{1'b0}},mte_reg,{3{1'b0}}};
// &Force("output","tcontrol");&Force("bus","tcontrol",XLEN-1,0); @469
//write mcontext
always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      mcontext_lowbits[12:0] <= 13'b0;
  else if(cp0_write_mcontext)
      mcontext_lowbits[12:0] <= cp0_dtu_wdata[12:0];
end
assign mcontext[XLEN-1:0] = {{XLEN-13{1'b0}},mcontext_lowbits[12:0]};
// &Force("output","mcontext");&Force("bus","mcontext",XLEN-1,0); @479

//write scontext
always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      scontext_lowbits[33:0] <= 34'b0;
  else if(cp0_write_scontext)
      scontext_lowbits[33:0] <= cp0_dtu_wdata[33:0];
end
assign scontext[XLEN-1:0] = {{XLEN-34{1'b0}},scontext_lowbits[33:0]};
// &Force("output","scontext");&Force("bus","scontext",XLEN-1,0); @490

//=========================================================            
//              mcontrol hit info from rtu                
//=========================================================
// &Force("input","rtu_dtu_retire_halt_info");&Force("bus","rtu_dtu_retire_halt_info",`TDT_HINFO_WIDTH-1,0); @495
assign rtu_retire_halt_info[`TDT_HINFO_WIDTH-1:0] = (rtu_dtu_retire_vld || rtu_dtu_halt_ack) ? rtu_dtu_retire_halt_info[`TDT_HINFO_WIDTH-1:0] : {`TDT_HINFO_WIDTH{1'b0}};
assign timing0_mcontrol_match = rtu_retire_halt_info[`TDT_HINFO_MATCH] &&
                                !rtu_retire_halt_info[`TDT_HINFO_CHAIN] &&
                                !rtu_retire_halt_info[`TDT_HINFO_TIMING];
assign rtu_pending_ack  = rtu_dtu_pending_ack;
assign rtu_pending_halt = rtu_retire_halt_info[`TDT_HINFO_PENDING_HALT];
assign generate_timing0 = rtu_dtu_halt_ack || timing0_mcontrol_match;

assign triggers_match[`TDT_TM_TRIGGER_NUM-1:0] = 
       rtu_retire_halt_info[`TDT_HINFO_TRIGGER:`TDT_HINFO_TRIGGER-`TDT_TM_MCONTROL_TRI_NUM-`TDT_TM_OTHER_TRI_NUM+1];
     assign action1_triggers[`TDT_TM_TRIGGER_NUM-1:0] = {action1_mcontrol[`TDT_TM_MCONTROL_TRI_NUM-1:0],action1_iies[`TDT_TM_OTHER_TRI_NUM-1:0]};
     assign action0_triggers[`TDT_TM_TRIGGER_NUM-1:0] = {action0_mcontrol[`TDT_TM_MCONTROL_TRI_NUM-1:0],action0_iies[`TDT_TM_OTHER_TRI_NUM-1:0]};

assign action1_match_trigger[`TDT_TM_TRIGGER_NUM-1:0] =  triggers_match[`TDT_TM_TRIGGER_NUM-1:0] & action1_triggers[`TDT_TM_TRIGGER_NUM-1:0];
assign action0_match_trigger[`TDT_TM_TRIGGER_NUM-1:0] =  triggers_match[`TDT_TM_TRIGGER_NUM-1:0] & action0_triggers[`TDT_TM_TRIGGER_NUM-1:0]; 

//trigger hit
// &CombBeg; @523
always @( generate_timing0
       or triggers_match[9:0]
       or action0_match_trigger[9:0]
       or rtu_retire_halt_info[5])
begin
if(generate_timing0 && !rtu_retire_halt_info[`TDT_HINFO_ACTION01])
  triggers_hit[`TDT_TM_TRIGGER_NUM-1:0] = triggers_match[`TDT_TM_TRIGGER_NUM-1:0];
else if(generate_timing0 && rtu_retire_halt_info[`TDT_HINFO_ACTION01])
  triggers_hit[`TDT_TM_TRIGGER_NUM-1:0] = action0_match_trigger[`TDT_TM_TRIGGER_NUM-1:0];
else
  triggers_hit[`TDT_TM_TRIGGER_NUM-1:0] = {`TDT_TM_TRIGGER_NUM{1'b0}};
// &CombEnd; @530
end

//mcontrol hit
assign mcontrol_hit[`TDT_TM_MCONTROL_TRI_NUM-1:0] = triggers_hit[`TDT_TM_TRIGGER_NUM-1:`TDT_TM_TRIGGER_NUM-`TDT_TM_MCONTROL_TRI_NUM];

//iie trigger hit
assign iie_hit[`TDT_TM_OTHER_TRI_NUM-1:0]         = triggers_hit[`TDT_TM_OTHER_TRI_NUM-1:0];
//&CombBeg;
//  if(rtu_pending_ack)
//    mcontrol_hit[`TDT_TM_MCONTROL_TRI_NUM-1:0] = pending_halt_mhit_reg[`TDT_TM_MCONTROL_TRI_NUM-1:0];
//  else if(generate_timing0 && !rtu_retire_halt_info[`TDT_HINFO_ACTION01])
//    mcontrol_hit[`TDT_TM_MCONTROL_TRI_NUM-1:0] = mcontrols_match[`TDT_TM_MCONTROL_TRI_NUM-1:0];
//  else if(generate_timing0 && rtu_retire_halt_info[`TDT_HINFO_ACTION01])
//    mcontrol_hit[`TDT_TM_MCONTROL_TRI_NUM-1:0] = action1_match_trigger[`TDT_TM_MCONTROL_TRI_NUM-1:0];
//  else
//    mcontrol_hit[`TDT_TM_MCONTROL_TRI_NUM-1:0] = {`TDT_TM_MCONTROL_TRI_NUM{1'b0}};
//&CombEnd;
//iie trigger hit
//&CombBeg;
//  if(rtu_pending_ack)
//    iie_hit[`TDT_TM_OTHER_TRI_NUM-1:0] = pending_halt_iie_hit_reg[`TDT_TM_OTHER_TRI_NUM-1:0];
//  else
//    iie_hit[`TDT_TM_OTHER_TRI_NUM-1:0]= {`TDT_TM_OTHER_TRI_NUM{1'b0}};
//&CombEnd;
//=========================================================            
//                 updata pending tval                
//=========================================================
assign mcontrol_updata_tval = rtu_retire_halt_info[`TDT_HINFO_MATCH] &&
                              !rtu_retire_halt_info[`TDT_HINFO_CHAIN] &&
                              rtu_retire_halt_info[`TDT_HINFO_TIMING] &&
                              (!rtu_retire_halt_info[`TDT_HINFO_ACTION] || rtu_retire_halt_info[`TDT_HINFO_ACTION01]);
assign iie0_updata_tval     = iie0_match && iie0_tdata1_action0;
assign iie1_updata_tval     = iie1_match && iie1_tdata1_action0;
assign updata_tval          = mcontrol_updata_tval || iie0_updata_tval || iie1_updata_tval;

//always @(posedge m_iie_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//      pending_tval[XLEN-1:0] <= {XLEN{1'b0}};
//  else if(updata_tval)
//      pending_tval[XLEN-1:0] <= rtu_dtu_tval[XLEN-1:0];
//end
//assign dtu_rtu_pending_tval[XLEN-1:0] = pending_tval[XLEN-1:0];

//=========================================================            
//                       cause                
//=========================================================
assign rtu_cause[3:0] = rtu_retire_halt_info[`TDT_HINFO_CAUSE:`TDT_HINFO_CAUSE-3];

// &CombBeg; @591
always @( rtu_cause[3:0]
       or have_iie_action1_match
       or rtu_dtu_halt_ack)
begin
  if(rtu_dtu_halt_ack)
      dtu_cause[3:0] = rtu_cause[3:0];
  else if(have_iie_action1_match)
      dtu_cause[3:0] = 4'd2;
  else
      dtu_cause[3:0] = rtu_cause[3:0];
// &CombEnd; @601
end
// &Force("output","dtu_cause"); @602
//=========================================================            
//                 pending halt                
//=========================================================
//icount_enable for rtu
assign icount_enable = iie0_icount_enable || iie1_icount_enable;

//assign step_match    = dcsr_step && rtu_dtu_retire_step_fire;
//pending halt source

assign iie_pending_halt  = have_iie_match;
//assign step_pending_halt     = !generate_timing0 && step_match;
assign other_pending_halt    = rtu_pending_halt;//include mcontrol pending, and other pending
assign generate_pending_halt = iie_pending_halt || other_pending_halt;

//pending halt flg
always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pending_halt <= 1'b0;
  else if(generate_pending_halt)
    pending_halt <= 1'b1;
  else if(rtu_pending_ack)
    pending_halt <= 1'b0;
end
// &Force("output","pending_halt"); @635

//action select
assign match_or_sync = rtu_retire_halt_info[`TDT_HINFO_MATCH] || rtu_retire_halt_info[`TDT_HINFO_PENDING_HALT]; 

assign m_iie_action0[2:0] = {!rtu_retire_halt_info[`TDT_HINFO_ACTION],iie1_tdata1_action0,iie0_tdata1_action0};
assign m_iie_action1[2:0] = {rtu_retire_halt_info[`TDT_HINFO_ACTION],iie1_tdata1_action1,iie0_tdata1_action1};
assign m_iie_match[2:0]   = {match_or_sync,iie1_match,iie0_match};
//assign have_m_iie_match   = |m_iie_match[2:0];
assign m_iie_have_action0 = |(m_iie_match[2:0] & m_iie_action0[2:0]);
assign m_iie_have_action1 = |(m_iie_match[2:0] & m_iie_action1[2:0]);
//assign pending_halt_action   = have_m_iie_match ? m_iie_have_action1 : 1'b0;
assign penging_halt_action01 = m_iie_have_action0 && m_iie_have_action1 || rtu_retire_halt_info[`TDT_HINFO_ACTION01];
assign pending_halt_action   = !penging_halt_action01 && m_iie_have_action1;//penging_halt_action01 ? 1'b0 : m_iie_have_action1;
//assign pending_halt_ldst     = rtu_retire_halt_info[`TDT_HINFO_LDST];
//pending halt info record
      assign pending_halt_hit[`TDT_TM_TRIGGER_NUM-1:0] = {triggers_match[`TDT_TM_TRIGGER_NUM-1:`TDT_TM_TRIGGER_NUM-`TDT_TM_MCONTROL_TRI_NUM],
                                                        iie_match[`TDT_TM_OTHER_TRI_NUM-1:0]};

//always @(posedge m_iie_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    begin
//      pending_halt_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= {`TDT_TM_TRIGGER_NUM{1'b0}};
//      pending_halt_action_reg     <= 1'b0;
//      penging_halt_action01_reg   <= 1'b0;
//      pending_halt_ldst_reg       <= 1'b0;
//      pending_halt_cause_reg[3:0] <= 4'b0;
//      pending_halt_cancel_reg     <= 1'b0;
//    end
//  else if(generate_pending_halt)
//    begin
//      pending_halt_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= pending_halt_hit[`TDT_TM_TRIGGER_NUM-1:0];
//      pending_halt_action_reg     <= pending_halt_action;
//      penging_halt_action01_reg   <= penging_halt_action01;
//      pending_halt_ldst_reg       <= pending_halt_ldst;
//      pending_halt_cause_reg[3:0] <= dtu_cause[3:0];
//      pending_halt_cancel_reg     <= 1'b1;
//    end
//  else if(rtu_pending_ack)
//    begin
//      pending_halt_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= {`TDT_TM_TRIGGER_NUM{1'b0}};
//      pending_halt_action_reg     <= 1'b0;
//      penging_halt_action01_reg   <= 1'b0;
//      pending_halt_ldst_reg       <= 1'b0;
//      pending_halt_cause_reg[3:0] <= 4'b0;
//      pending_halt_cancel_reg     <= 1'b0;
//    end
//end

//assign pending_halt_match = |pending_halt_hit_reg[`TDT_TM_TRIGGER_NUM-1:0];
//assign pending_halt_info[`TDT_HINFO_WIDTH-1:0] = {pending_halt_hit_reg[`TDT_TM_TRIGGER_NUM-1:0],
//                                                  pending_halt_cause_reg[3:0],pending_halt,1'b0,
//                                                  penging_halt_action01_reg,pending_halt_action_reg,
//                                                  1'b0,pending_halt_ldst_reg,pending_halt_match,pending_halt_cancel_reg};

//=========================================================            
//                   retire action01             
//=========================================================
//retire action01 source
assign generate_retire_action01 = generate_timing0 && rtu_retire_halt_info[`TDT_HINFO_ACTION01];

//retire action01 flg
assign clear_action01_reg = rtu_yy_xx_dbgon && retire_action01;//(ifu_dtu_addr_vld0 || ifu_dtu_data_vld0 || ifu_dtu_addr_vld1 || ifu_dtu_data_vld1);
always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    retire_action01 <= 1'b0;
  else if(generate_retire_action01)
    retire_action01 <= 1'b1;
  else if(clear_action01_reg)
    retire_action01 <= 1'b0;
end
assign give_action01_halt_info = retire_action01 && !rtu_yy_xx_dbgon;

//retire action01 record
//always @(posedge m_iie_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    begin
//      two_action_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= {`TDT_TM_TRIGGER_NUM{1'b0}};
//      two_action_ldst_reg                         <= 1'b0;
//      two_action_cancel_reg                       <= 1'b0;
//    end
//  else if(generate_retire_action01)
//    begin
//      two_action_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= action0_match_trigger[`TDT_TM_TRIGGER_NUM-1:0];
//      two_action_ldst_reg                         <= rtu_retire_halt_info[`TDT_HINFO_LDST];
//      two_action_cancel_reg                       <= 1'b1;
//    end
//  else if(clear_action01_reg)
//    begin
//      two_action_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= {`TDT_TM_TRIGGER_NUM{1'b0}};
//      two_action_ldst_reg                         <= 1'b0;
//      two_action_cancel_reg                       <= 1'b0;
//    end
//end
//assign two_action_cancel = two_action_cancel_reg && !rtu_yy_xx_dbgon;
//
//assign two_action_halt_info[`TDT_HINFO_WIDTH-1:0] = {two_action_hit_reg[`TDT_TM_TRIGGER_NUM-1:0],
//                                                     4'd2,1'b0,1'b0,1'b0,1'b0,1'b0,two_action_ldst_reg,1'b1,
//                                                     two_action_cancel};
//record hatl_info of pending halt and action01
assign record_hit[`TDT_TM_TRIGGER_NUM-1:0] = generate_pending_halt ? pending_halt_hit[`TDT_TM_TRIGGER_NUM-1:0] :
                                                                     action1_match_trigger[`TDT_TM_TRIGGER_NUM-1:0];
assign record_action                       = generate_pending_halt ? pending_halt_action :  1'b1;
assign record_aciton01                     = generate_pending_halt ? penging_halt_action01 : 1'b0;
assign record_ldst                         = rtu_retire_halt_info[`TDT_HINFO_LDST];
assign record_cause[3:0]                   = dtu_cause[3:0];
assign clear_record                        = pending_halt && rtu_pending_ack ||
                                             retire_action01 && clear_action01_reg;

always @(posedge m_iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      record_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= {`TDT_TM_TRIGGER_NUM{1'b0}};
      record_action_reg     <= 1'b0;
      record_action01_reg   <= 1'b0;
      record_ldst_reg       <= 1'b0;
      record_cause_reg[3:0] <= 4'b0;
    end
  else if(generate_pending_halt || generate_retire_action01)
    begin
      record_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= record_hit[`TDT_TM_TRIGGER_NUM-1:0];
      record_action_reg     <= record_action;
      record_action01_reg   <= record_aciton01;
      record_ldst_reg       <= record_ldst;
      record_cause_reg[3:0] <= record_cause[3:0];
    end
  else if(clear_record)
    begin
      record_hit_reg[`TDT_TM_TRIGGER_NUM-1:0] <= {`TDT_TM_TRIGGER_NUM{1'b0}};
      record_action_reg     <= 1'b0;
      record_action01_reg   <= 1'b0;
      record_ldst_reg       <= 1'b0;
      record_cause_reg[3:0] <= 4'b0;
    end
end

assign record_match        = |record_hit_reg[`TDT_TM_TRIGGER_NUM-1:0];
assign record_pending_halt = pending_halt || retire_action01;

assign record_halt_info[`TDT_HINFO_WIDTH-1:0] =  rtu_yy_xx_dbgon ? 
                                                 {`TDT_HINFO_WIDTH{1'b0}} :
                                                 {record_hit_reg[`TDT_TM_TRIGGER_NUM-1:0],//match[7:0]
                                                 record_cause_reg[3:0],//cause
                                                 record_pending_halt,  //pengding halt
                                                 1'b0,                 //timing
                                                 record_action01_reg,  //action01
                                                 record_action_reg,    //action
                                                 1'b0,                 //chain
                                                 record_ldst_reg,      //ldst
                                                 record_match,         //match
                                                 1'b1};                //cancel

//halt_info for ifu
assign use_record_halt_info = give_action01_halt_info || pending_halt;
assign dtu_ifu_halt_info0[`TDT_HINFO_WIDTH-1:0] = use_record_halt_info ?
                                                  record_halt_info[`TDT_HINFO_WIDTH-1:0] :
                                                  mcontrol_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign dtu_ifu_halt_info1[`TDT_HINFO_WIDTH-1:0] = use_record_halt_info ?
                                                  record_halt_info[`TDT_HINFO_WIDTH-1:0] :
                                                  mcontrol_halt_info1[`TDT_HINFO_WIDTH-1:0];

//==========================================================
//                     gate clk
//==========================================================
assign m_iie_clk_en =cp0_write_tselect || cp0_write_tcontrol || cp0_write_mcontext || cp0_write_scontext ||
                     cp0_dtu_mexpt_vld || (rtu_dtu_retire_mret && rtu_dtu_retire_vld) || //cp0_dtu_mret_vld_f ||
                    // updata_tval ||
                     generate_pending_halt    || rtu_pending_ack ||
                     generate_retire_action01 || (clear_action01_reg && retire_action01);
// &Force("nonport","m_iie_clk_en"); @822


// &Instance("gated_clk_cell", "x_reg_gated_clk"); @825
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (m_iie_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (m_iie_clk_en      ),
  .module_en          (cp0_dtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @826
//          .external_en (1'b0), @827
//          .global_en   (cp0_yy_clk_en), @828
//          .module_en   (cp0_dtu_icg_en), @829
//          .local_en    (m_iie_clk_en), @830
//          //.local_en    (1'b1), @831
//          .clk_out     (m_iie_clk)); @832

// &ModuleEnd; @834
endmodule


