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

// &Depend("cpu_cfig.h"); @17
// &Depend("aq_lsu_cfig.h"); @18

// &ModuleBeg; @20
module aq_lsu_rdl(
  arb_rdl_grant,
  cp0_lsu_icg_en,
  cp0_lsu_we_en,
  cpurst_b,
  dc_rdl_alias_hit,
  dc_rdl_alias_idx,
  dc_rdl_alias_way,
  dc_rdl_cache_hit,
  dc_rdl_dcache_data,
  dc_rdl_dcache_dirty,
  dc_rdl_dcache_fifo,
  dc_rdl_dcache_tag,
  dc_rdl_dcache_vld,
  forever_cpuclk,
  ifu_lsu_warm_up,
  lfb_rdl_alias_hit,
  lfb_rdl_alias_idx,
  lfb_rdl_ca,
  lfb_rdl_id,
  lfb_rdl_idx,
  lfb_rdl_no_ld,
  lfb_rdl_req,
  lfb_rdl_tag,
  lfb_rdl_type,
  lfb_rdl_way,
  pad_yy_icg_scan_en,
  rdl_arb_data02_idx,
  rdl_arb_data0_req,
  rdl_arb_data13_idx,
  rdl_arb_data1_req,
  rdl_arb_data2_req,
  rdl_arb_data3_req,
  rdl_arb_data_way,
  rdl_arb_dcache_sel,
  rdl_arb_dirty_din,
  rdl_arb_dirty_idx,
  rdl_arb_dirty_req,
  rdl_arb_dirty_wen,
  rdl_arb_tag_idx,
  rdl_arb_tag_req,
  rdl_arb_tag_sel,
  rdl_arb_tag_way,
  rdl_arb_tag_wen,
  rdl_dc_acc_fifo,
  rdl_dc_acc_idx,
  rdl_dc_acc_tag,
  rdl_dc_sel,
  rdl_lfb_alias_hit,
  rdl_lfb_cache_hit,
  rdl_lfb_cmplt,
  rdl_lfb_grant,
  rdl_lfb_ref_fifo,
  rdl_stb_cmplt,
  rdl_stb_cmplt_id,
  rdl_stb_grant,
  rdl_vb_addr,
  rdl_vb_alias,
  rdl_vb_alias_dirty,
  rdl_vb_data,
  rdl_vb_data_vld,
  rdl_vb_ld,
  rdl_vb_ld_id,
  rdl_vb_pf,
  rdl_vb_req,
  stb_rdl_id,
  stb_rdl_idx,
  stb_rdl_req,
  stb_rdl_tag,
  stb_rdl_type,
  stb_rdl_way,
  vb_rdl_grant,
  vb_rdl_ld_alias_hit
);

// &Ports; @21
input            arb_rdl_grant;         
input            cp0_lsu_icg_en;        
input            cp0_lsu_we_en;         
input            cpurst_b;              
input            dc_rdl_alias_hit;      
input   [1  :0]  dc_rdl_alias_idx;      
input   [3  :0]  dc_rdl_alias_way;      
input            dc_rdl_cache_hit;      
input   [127:0]  dc_rdl_dcache_data;    
input   [3  :0]  dc_rdl_dcache_dirty;   
input   [3  :0]  dc_rdl_dcache_fifo;    
input   [27 :0]  dc_rdl_dcache_tag;     
input            dc_rdl_dcache_vld;     
input            forever_cpuclk;        
input            ifu_lsu_warm_up;       
input            lfb_rdl_alias_hit;     
input   [1  :0]  lfb_rdl_alias_idx;     
input            lfb_rdl_ca;            
input   [2  :0]  lfb_rdl_id;            
input   [13 :0]  lfb_rdl_idx;           
input            lfb_rdl_no_ld;         
input            lfb_rdl_req;           
input   [27 :0]  lfb_rdl_tag;           
input   [1  :0]  lfb_rdl_type;          
input   [3  :0]  lfb_rdl_way;           
input            pad_yy_icg_scan_en;    
input   [1  :0]  stb_rdl_id;            
input   [13 :0]  stb_rdl_idx;           
input            stb_rdl_req;           
input   [27 :0]  stb_rdl_tag;           
input   [1  :0]  stb_rdl_type;          
input   [3  :0]  stb_rdl_way;           
input            vb_rdl_grant;          
input            vb_rdl_ld_alias_hit;   
output  [13 :0]  rdl_arb_data02_idx;    
output           rdl_arb_data0_req;     
output  [13 :0]  rdl_arb_data13_idx;    
output           rdl_arb_data1_req;     
output           rdl_arb_data2_req;     
output           rdl_arb_data3_req;     
output  [3  :0]  rdl_arb_data_way;      
output           rdl_arb_dcache_sel;    
output  [7  :0]  rdl_arb_dirty_din;     
output  [13 :0]  rdl_arb_dirty_idx;     
output           rdl_arb_dirty_req;     
output  [7  :0]  rdl_arb_dirty_wen;     
output  [11 :0]  rdl_arb_tag_idx;       
output           rdl_arb_tag_req;       
output  [3  :0]  rdl_arb_tag_sel;       
output  [3  :0]  rdl_arb_tag_way;       
output           rdl_arb_tag_wen;       
output  [3  :0]  rdl_dc_acc_fifo;       
output  [1  :0]  rdl_dc_acc_idx;        
output  [39 :0]  rdl_dc_acc_tag;        
output           rdl_dc_sel;            
output           rdl_lfb_alias_hit;     
output           rdl_lfb_cache_hit;     
output           rdl_lfb_cmplt;         
output           rdl_lfb_grant;         
output  [3  :0]  rdl_lfb_ref_fifo;      
output           rdl_stb_cmplt;         
output  [1  :0]  rdl_stb_cmplt_id;      
output           rdl_stb_grant;         
output  [33 :0]  rdl_vb_addr;           
output           rdl_vb_alias;          
output           rdl_vb_alias_dirty;    
output  [127:0]  rdl_vb_data;           
output           rdl_vb_data_vld;       
output           rdl_vb_ld;             
output  [2  :0]  rdl_vb_ld_id;          
output           rdl_vb_pf;             
output           rdl_vb_req;            

// &Regs; @22
reg              pf_cache_hit;          
reg     [3  :0]  rdl_cur_state;         
reg              rdl_data_vld;          
reg              rdl_entry_alias_hit;   
reg     [1  :0]  rdl_entry_alias_idx;   
reg     [3  :0]  rdl_entry_alias_way;   
reg     [3  :0]  rdl_entry_dirty;       
reg     [2  :0]  rdl_entry_id;          
reg     [13 :0]  rdl_entry_idx;         
reg              rdl_entry_lfb;         
reg     [27 :0]  rdl_entry_tag;         
reg              rdl_entry_tagvld;      
reg     [1  :0]  rdl_entry_type;        
reg     [3  :0]  rdl_next_state;        
reg     [3  :0]  rdl_replace_fifo;      
reg              rdl_replace_sel;       

// &Wires; @23
wire             arb_rdl_grant;         
wire             cp0_lsu_icg_en;        
wire             cp0_lsu_we_en;         
wire             cpurst_b;              
wire             data0_addr_3;          
wire             data1_addr_3;          
wire    [1  :0]  data_idx;              
wire    [1  :0]  data_offset;           
wire    [1  :0]  data_sel;              
wire             dc_rdl_alias_hit;      
wire    [1  :0]  dc_rdl_alias_idx;      
wire    [3  :0]  dc_rdl_alias_way;      
wire             dc_rdl_cache_hit;      
wire    [127:0]  dc_rdl_dcache_data;    
wire    [3  :0]  dc_rdl_dcache_dirty;   
wire    [3  :0]  dc_rdl_dcache_fifo;    
wire    [27 :0]  dc_rdl_dcache_tag;     
wire             dc_rdl_dcache_vld;     
wire             dca_cln;               
wire             dca_dirty;             
wire             dca_inv;               
wire             dirty_wen;             
wire             forever_cpuclk;        
wire             ifu_lsu_warm_up;       
wire             lfb_ld;                
wire             lfb_pf;                
wire             lfb_rdl_alias_hit;     
wire    [1  :0]  lfb_rdl_alias_idx;     
wire             lfb_rdl_ca;            
wire    [2  :0]  lfb_rdl_id;            
wire    [13 :0]  lfb_rdl_idx;           
wire             lfb_rdl_no_ld;         
wire             lfb_rdl_req;           
wire    [27 :0]  lfb_rdl_tag;           
wire    [1  :0]  lfb_rdl_type;          
wire    [3  :0]  lfb_rdl_way;           
wire             lfb_sel;               
wire             pad_yy_icg_scan_en;    
wire             rdl_alias_dirty;       
wire             rdl_alias_dirty_rd;    
wire             rdl_alias_hit;         
wire    [1  :0]  rdl_alias_idx;         
wire             rdl_alias_inv;         
wire             rdl_alias_req;         
wire    [13 :0]  rdl_arb_data02_idx;    
wire             rdl_arb_data0_req;     
wire    [13 :0]  rdl_arb_data13_idx;    
wire             rdl_arb_data1_req;     
wire             rdl_arb_data2_req;     
wire             rdl_arb_data3_req;     
wire    [3  :0]  rdl_arb_data_way;      
wire             rdl_arb_dcache_sel;    
wire    [7  :0]  rdl_arb_dirty_din;     
wire    [13 :0]  rdl_arb_dirty_idx;     
wire             rdl_arb_dirty_req;     
wire    [7  :0]  rdl_arb_dirty_wen;     
wire    [11 :0]  rdl_arb_tag_idx;       
wire             rdl_arb_tag_req;       
wire    [3  :0]  rdl_arb_tag_sel;       
wire    [3  :0]  rdl_arb_tag_way;       
wire             rdl_arb_tag_wen;       
wire             rdl_ca;                
wire             rdl_create_en;         
wire             rdl_cur_acheck;        
wire             rdl_cur_check;         
wire             rdl_cur_data_rd;       
wire             rdl_cur_data_rd_0;     
wire             rdl_cur_data_rd_3;     
wire             rdl_cur_dirty_rd;      
wire             rdl_cur_dirty_wen;     
wire             rdl_cur_idle;          
wire             rdl_cur_inv;           
wire             rdl_cur_last;          
wire             rdl_cur_tag_rd;        
wire             rdl_cur_tag_wen;       
wire             rdl_cur_wvb;           
wire    [3  :0]  rdl_data_way;          
wire    [3  :0]  rdl_dc_acc_fifo;       
wire    [1  :0]  rdl_dc_acc_idx;        
wire    [39 :0]  rdl_dc_acc_tag;        
wire             rdl_dc_sel;            
wire    [3  :0]  rdl_dca_way;           
wire             rdl_dp_clk;            
wire             rdl_dp_clk_en;         
wire             rdl_fsm_clk;           
wire             rdl_fsm_clk_en;        
wire    [2  :0]  rdl_id;                
wire    [13 :0]  rdl_idx;               
wire             rdl_lfb_alias_hit;     
wire             rdl_lfb_cache_hit;     
wire             rdl_lfb_cmplt;         
wire             rdl_lfb_grant;         
wire    [3  :0]  rdl_lfb_ref_fifo;      
wire             rdl_line_clean;        
wire             rdl_line_inv;          
wire             rdl_line_rd;           
wire             rdl_req;               
wire             rdl_stb_cmplt;         
wire    [1  :0]  rdl_stb_cmplt_id;      
wire             rdl_stb_grant;         
wire    [27 :0]  rdl_tag;               
wire             rdl_tag_clk;           
wire             rdl_tag_clk_en;        
wire    [3  :0]  rdl_tag_sel;           
wire    [1  :0]  rdl_type;              
wire    [33 :0]  rdl_vb_addr;           
wire             rdl_vb_alias;          
wire             rdl_vb_alias_dirty;    
wire    [127:0]  rdl_vb_data;           
wire             rdl_vb_data_vld;       
wire             rdl_vb_ld;             
wire    [2  :0]  rdl_vb_ld_id;          
wire             rdl_vb_pf;             
wire             rdl_vb_req;            
wire    [3  :0]  rdl_way;               
wire             replace_line_dirty;    
wire             replace_line_dirty_raw; 
wire             replace_line_vld;      
wire    [1  :0]  stb_rdl_id;            
wire    [13 :0]  stb_rdl_idx;           
wire             stb_rdl_req;           
wire    [27 :0]  stb_rdl_tag;           
wire    [1  :0]  stb_rdl_type;          
wire    [3  :0]  stb_rdl_way;           
wire    [27 :0]  stb_tag;               
wire    [1  :0]  tag_idx;               
wire    [3  :0]  tag_rd_way;            
wire             vb_rdl_grant;          
wire             vb_rdl_ld_alias_hit;   
wire             way0_way2_sel;         


parameter D_TAG_TAG_LEN = `D_TAG_TAG_WIDTH;

//==============================================================================
//  STB and LFB request arbit
//==============================================================================
//type[1:0]
//stb: [0] inv; [1] clr
//lfb: [0] pf;  [1] alias read

assign lfb_sel            = lfb_rdl_req & !vb_rdl_ld_alias_hit;
assign rdl_req            = lfb_sel ? lfb_rdl_req       : stb_rdl_req;
assign rdl_idx[13:0]      = lfb_sel ? lfb_rdl_idx[13:0] : stb_rdl_idx[13:0];
assign rdl_way[3:0]       = lfb_sel ? lfb_rdl_way[3:0]  : stb_rdl_way[3:0];
assign rdl_type[1:0]      = lfb_sel ? lfb_rdl_type[1:0] : stb_rdl_type[1:0];
assign rdl_id[2:0]        = lfb_sel ? lfb_rdl_id[2:0]   : {1'b0,stb_rdl_id[1:0]};
assign rdl_tag[27:0]      = lfb_sel ? lfb_rdl_tag[27:0] : stb_rdl_tag[27:0]; //lfb for preftech
assign rdl_alias_hit      = lfb_sel & lfb_rdl_alias_hit & lfb_rdl_ca;
assign rdl_alias_idx[1:0] = {2{lfb_sel}} & lfb_rdl_alias_idx[1:0];
assign rdl_ca             = lfb_sel ? lfb_rdl_ca        : 1'b1;

assign rdl_lfb_grant = rdl_cur_idle & !vb_rdl_ld_alias_hit;
assign rdl_stb_grant = rdl_cur_idle & !lfb_sel;

//==============================================================================
//     read dirty line FSM
//==============================================================================
//1. nc ld: IDLE -> LAST -> IDLE
//2. c ld:
//   a)!alias: IDLE -> DIRTY_RD -> DIRTY_UPDT -> TAG_RD -> TAG_UPDT -> CHECK 
//   -> WVB -> DATA_RD -> LAST -> IDLE
//   b) alias: IDLE -> DIRTY_RD -> DIRTY_UPDT -> TAG_RD -> TAG_UPDT -> CHECK 
//   -> WVB -> DATA_RD -> ACHECK -> WVB -> DATA_RD -> LAST
//   -> IDLE
//3. pf:as c ld
//4. dca: 
//   a)INV: IDLE -> DIRTY_RD -> DIRTY_UPDT -> CHECK -> INV
//   b)CLN: IDLE -> DIRTY_RD -> DIRTY_UPDT -> CHECK -> WVB -> DATA_RD -> INV

parameter RDL_IDLE       = 4'b0000;
parameter RDL_DIRTY_RD   = 4'b0001;
parameter RDL_DIRTY_UPDT = 4'b0010;
parameter RDL_TAG_RD     = 4'b0011;
parameter RDL_TAG_UPDT   = 4'b0100;
parameter RDL_CHECK      = 4'b0101;
parameter RDL_INV        = 4'b0110;
parameter RDL_ACHECK     = 4'b0111;
parameter RDL_DATA_RD_0  = 4'b1000;
parameter RDL_DATA_RD_1  = 4'b1001;
parameter RDL_DATA_RD_2  = 4'b1010;
parameter RDL_DATA_RD_3  = 4'b1011;
parameter RDL_WVB        = 4'b1100;
parameter RDL_LAST       = 4'b1101;

always@(posedge rdl_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rdl_cur_state[3:0] <= RDL_IDLE;
  else
    rdl_cur_state[3:0] <= rdl_next_state[3:0];
end

// &CombBeg; @86
always @( rdl_req
       or rdl_ca
       or arb_rdl_grant
       or lfb_rdl_no_ld
       or rdl_line_inv
       or lfb_pf
       or rdl_entry_alias_hit
       or rdl_entry_lfb
       or rdl_cur_state
       or vb_rdl_grant
       or rdl_line_rd
       or rdl_line_clean
       or rdl_replace_sel
       or pf_cache_hit)
begin
  case(rdl_cur_state)
    RDL_IDLE: begin
      if (rdl_req & rdl_ca)
        rdl_next_state = RDL_DIRTY_RD;
      else if (rdl_req)
        rdl_next_state = RDL_LAST;
      else 
        rdl_next_state = RDL_IDLE;
    end
    RDL_DIRTY_RD: begin
      if (arb_rdl_grant)
        rdl_next_state = RDL_DIRTY_UPDT;
      else
        rdl_next_state = RDL_DIRTY_RD;
    end
    RDL_DIRTY_UPDT: begin
      if (!rdl_entry_lfb | rdl_line_clean)
        rdl_next_state = RDL_CHECK;
      else
        rdl_next_state = RDL_TAG_RD;
    end
    RDL_TAG_RD: begin
      if (arb_rdl_grant)
        rdl_next_state = RDL_TAG_UPDT;
      else
        rdl_next_state = RDL_TAG_RD;
    end
    RDL_TAG_UPDT: begin
      rdl_next_state = RDL_CHECK;
    end
    RDL_CHECK: begin
      if (rdl_line_rd & !(lfb_pf & pf_cache_hit))
        rdl_next_state = RDL_WVB;
      else if (rdl_line_inv)
        rdl_next_state = RDL_INV;
      else if (rdl_entry_alias_hit)
        rdl_next_state = RDL_WVB;
      else
        rdl_next_state = RDL_IDLE;
    end
    RDL_WVB: begin
      if (vb_rdl_grant)
        rdl_next_state = RDL_DATA_RD_0;
      else
        rdl_next_state = RDL_WVB;
    end
    RDL_DATA_RD_0: begin
      if (arb_rdl_grant)
        rdl_next_state = RDL_DATA_RD_1;
      else 
        rdl_next_state = RDL_DATA_RD_0;
    end
    RDL_DATA_RD_1: begin
      if (arb_rdl_grant)
        rdl_next_state = RDL_DATA_RD_2;
      else
        rdl_next_state = RDL_DATA_RD_1;
    end
    RDL_DATA_RD_2: begin
      if (arb_rdl_grant)
        rdl_next_state = RDL_DATA_RD_3;
      else
        rdl_next_state = RDL_DATA_RD_2;
    end
    RDL_DATA_RD_3: begin
      if (arb_rdl_grant) begin
        if (rdl_entry_lfb)
          rdl_next_state = rdl_replace_sel & rdl_entry_alias_hit ? RDL_ACHECK : RDL_LAST;
        else
          rdl_next_state = RDL_INV;
      end
      else 
        rdl_next_state = RDL_DATA_RD_3;
    end
    RDL_INV: begin
      if (arb_rdl_grant)
        rdl_next_state = RDL_IDLE;
      else
        rdl_next_state = RDL_INV;
    end
    RDL_ACHECK: begin
      rdl_next_state = RDL_WVB;
    end
    RDL_LAST: begin
      if (!rdl_entry_alias_hit | lfb_rdl_no_ld)
        rdl_next_state = RDL_IDLE;
      else 
        rdl_next_state = RDL_LAST;
    end
    default: begin
      rdl_next_state = RDL_IDLE;
    end
  endcase
// &CombEnd; @180
end

assign rdl_line_clean = !lfb_pf & !(cp0_lsu_we_en | replace_line_dirty_raw);

assign rdl_line_rd  =  rdl_entry_lfb & replace_line_vld & (cp0_lsu_we_en | replace_line_dirty) |
                      !rdl_entry_lfb & dca_cln & dca_dirty;
assign rdl_line_inv = !rdl_entry_lfb & dca_inv;

assign rdl_cur_idle      = rdl_cur_state == RDL_IDLE;
assign rdl_cur_dirty_rd  = rdl_cur_state == RDL_DIRTY_RD;
assign rdl_cur_dirty_wen = rdl_cur_state == RDL_DIRTY_UPDT;
assign rdl_cur_tag_rd    = rdl_cur_state == RDL_TAG_RD;
assign rdl_cur_tag_wen   = rdl_cur_state == RDL_TAG_UPDT;
assign rdl_cur_check     = rdl_cur_state == RDL_CHECK;
assign rdl_cur_wvb       = rdl_cur_state == RDL_WVB;
assign rdl_cur_data_rd   = rdl_cur_state[3:2] == 2'b10;
assign rdl_cur_acheck    = rdl_cur_state == RDL_ACHECK;
assign rdl_cur_last      = rdl_cur_state == RDL_LAST;
assign rdl_cur_inv       = rdl_cur_state == RDL_INV;
assign rdl_cur_data_rd_3 = rdl_cur_state == RDL_DATA_RD_3;
assign rdl_cur_data_rd_0 = rdl_cur_state == RDL_DATA_RD_0;

//==============================================================================
//     read dirty line content
//==============================================================================

assign rdl_create_en = rdl_cur_idle & rdl_req;

always@(posedge rdl_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rdl_replace_sel <= 1'b0;
  else if (rdl_create_en)
    rdl_replace_sel <= lfb_sel;
  else if (rdl_cur_acheck | rdl_cur_check & !rdl_line_rd)
    rdl_replace_sel <= 1'b0;
end

always@(posedge rdl_dp_clk)
begin
  if (rdl_create_en | ifu_lsu_warm_up) begin
    rdl_entry_lfb       <= lfb_sel;
    rdl_entry_type[1:0] <= rdl_type[1:0];
    rdl_entry_id[2:0]   <= rdl_id[2:0];
    rdl_entry_idx[13:0] <= rdl_idx[13:0];
  end
end

assign dca_inv = rdl_entry_type[0] & !rdl_entry_lfb;
assign dca_cln = rdl_entry_type[1] & !rdl_entry_lfb;
assign lfb_pf  = rdl_entry_type[0] &  rdl_entry_lfb;
assign lfb_ld  = rdl_entry_type[1] &  rdl_entry_lfb;

assign stb_tag[D_TAG_TAG_LEN-1:0] = rdl_tag[27:0];

always@(posedge rdl_tag_clk)
begin
  if (rdl_create_en | ifu_lsu_warm_up)
    rdl_entry_tag[D_TAG_TAG_LEN-1:0] <= stb_tag[D_TAG_TAG_LEN-1:0]; //stb
  else if (rdl_cur_tag_wen)
    rdl_entry_tag[D_TAG_TAG_LEN-1:0] <= dc_rdl_dcache_tag[D_TAG_TAG_LEN-1:0]; //replace tag
end

//------------------------------------------------
//  alias
//------------------------------------------------
// for dca
// for lfb alias line
always@(posedge rdl_tag_clk)
begin
  if (rdl_create_en | ifu_lsu_warm_up) begin
    rdl_entry_alias_hit      <= rdl_alias_hit;  //ld or stb
    rdl_entry_alias_way[3:0] <= rdl_way[3:0];
    rdl_entry_alias_idx[1:0] <= rdl_alias_idx[1:0];
  end
  else if (rdl_cur_tag_wen & lfb_pf) begin
    rdl_entry_alias_hit      <= dc_rdl_alias_hit;  //pf
    rdl_entry_alias_way[3:0] <= dc_rdl_alias_way[3:0];
    rdl_entry_alias_idx[1:0] <= dc_rdl_alias_idx[1:0];
  end
end

assign rdl_dca_way[3:0]  = rdl_entry_alias_way[3:0];
assign rdl_data_way[3:0] = rdl_replace_sel 
                          ? rdl_replace_fifo[3:0] 
                          : rdl_entry_alias_way[3:0];

always@(posedge rdl_tag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    pf_cache_hit <= 1'b0;
  else if (rdl_cur_tag_wen & lfb_pf)
    pf_cache_hit <= dc_rdl_cache_hit;
end

// fifo for replace 
// dirty for replace and dca
always@(posedge rdl_tag_clk)
begin
  if (rdl_cur_dirty_wen | ifu_lsu_warm_up) begin
    rdl_replace_fifo[3:0] <= dc_rdl_dcache_fifo[3:0];
    rdl_entry_dirty[3:0]  <= dc_rdl_dcache_dirty[3:0];
  end
end

assign replace_line_dirty_raw = |(dc_rdl_dcache_fifo[3:0] & dc_rdl_dcache_dirty[3:0]);

assign replace_line_dirty = |(rdl_replace_fifo[3:0] & rdl_entry_dirty[3:0]);
assign dca_dirty          = |(rdl_dca_way[3:0] & rdl_entry_dirty[3:0]);

//for replace line
always@(posedge rdl_tag_clk)
begin
  if (rdl_create_en | ifu_lsu_warm_up)
    rdl_entry_tagvld <= 1'b0;
  else if (rdl_cur_tag_wen)
    rdl_entry_tagvld <= dc_rdl_dcache_vld;
end

assign replace_line_vld = rdl_replace_sel & rdl_entry_tagvld;

//================================================
//   interface to DC
//================================================
//for prefetch tag compare
assign rdl_dc_acc_tag[39:0] = {rdl_entry_tag[27:0],rdl_entry_idx[11:0]};

//for tag of replace line 
assign rdl_dc_sel           = !rdl_cur_idle;
assign rdl_dc_acc_fifo[3:0] = rdl_data_way[3:0];
assign rdl_dc_acc_idx[1:0]  = rdl_entry_idx[13:12];

//==============================================================================
//   response to LFB or STB
//==============================================================================

assign rdl_lfb_cache_hit = pf_cache_hit;
assign rdl_lfb_alias_hit = rdl_entry_alias_hit;
assign rdl_lfb_ref_fifo[3:0] = rdl_replace_fifo[3:0];

assign rdl_lfb_cmplt = rdl_entry_lfb & 
                       (rdl_cur_check & (lfb_pf & pf_cache_hit | !rdl_line_rd & !rdl_line_inv & !rdl_entry_alias_hit) |
                        rdl_cur_last & (!rdl_entry_alias_hit | lfb_rdl_no_ld));

assign rdl_stb_cmplt = !rdl_entry_lfb &
                       (rdl_cur_check & !rdl_line_rd & !rdl_line_inv |
                        rdl_cur_inv);

assign rdl_stb_cmplt_id[1:0]  = rdl_entry_id[1:0];

//==============================================================================
//     request dcache
//==============================================================================
assign rdl_arb_dcache_sel = rdl_cur_tag_rd | rdl_cur_dirty_rd | rdl_cur_data_rd | rdl_cur_inv;
assign rdl_alias_req      = rdl_cur_data_rd & rdl_entry_alias_hit & rdl_entry_lfb & !rdl_replace_sel;
assign rdl_alias_inv      = rdl_cur_data_rd_3 & rdl_alias_req;

assign tag_rd_way[3:0]    = lfb_pf ? 4'b1111 : rdl_replace_fifo[3:0];

assign rdl_arb_tag_req       = rdl_cur_tag_rd | rdl_cur_inv & dca_inv | rdl_alias_inv;
assign rdl_arb_tag_way[3:0]  = rdl_cur_tag_rd ? tag_rd_way[3:0] : rdl_entry_alias_way[3:0];
assign rdl_arb_tag_sel[3:0]  = (rdl_cur_tag_rd & lfb_pf) ? 4'b1111 : rdl_tag_sel[3:0];
assign rdl_arb_tag_idx[11:0] = rdl_entry_idx[11:0];
assign rdl_arb_tag_wen       = rdl_cur_inv & dca_inv | rdl_alias_inv;

assign tag_idx[1:0]          = rdl_alias_req ? rdl_entry_alias_idx[1:0] : rdl_entry_idx[13:12];

assign rdl_tag_sel[3:0]  = {2'b00,2'b1 << tag_idx[0]};

assign rdl_alias_dirty_rd      = rdl_cur_data_rd_0 & rdl_alias_req;
assign dirty_wen               = rdl_cur_inv & dca_cln | rdl_alias_inv;

assign rdl_arb_dirty_req       = rdl_cur_dirty_rd | dirty_wen | rdl_alias_dirty_rd;
assign rdl_arb_dirty_wen[7:0]  = {8{dirty_wen}} & {4'b0, rdl_entry_alias_way[3:0]};
assign rdl_arb_dirty_idx[13:0] = {tag_idx[1:0],rdl_entry_idx[11:0]};
assign rdl_arb_dirty_din[7:0]  = 8'b0;

assign data_offset[1:0] = rdl_cur_data_rd ? rdl_cur_state[1:0] : 2'b00;
assign data_idx[1:0]    = tag_idx[1:0];

assign data_sel[1:0] = {rdl_data_way[3] | rdl_data_way[2],
                        rdl_data_way[1] | rdl_data_way[0]};

assign way0_way2_sel = rdl_data_way[2] | rdl_data_way[0];

assign data0_addr_3  = way0_way2_sel ? 1'b0 : 1'b1;
assign data1_addr_3  = way0_way2_sel ? 1'b1 : 1'b0;

assign rdl_arb_data0_req        = rdl_cur_data_rd & data_sel[0];
assign rdl_arb_data1_req        = rdl_cur_data_rd & data_sel[0];
assign rdl_arb_data2_req        = rdl_cur_data_rd & data_sel[1];
assign rdl_arb_data3_req        = rdl_cur_data_rd & data_sel[1];
assign rdl_arb_data02_idx[13:0] = {data_idx[1:0],rdl_entry_idx[11:6], data_offset[1:0],data0_addr_3,3'b0};
assign rdl_arb_data13_idx[13:0] = {data_idx[1:0],rdl_entry_idx[11:6], data_offset[1:0],data1_addr_3,3'b0};
assign rdl_arb_data_way[3:0]    = rdl_data_way[3:0];

//==============================================================================
//     request victim buffer
//==============================================================================

always@(posedge rdl_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rdl_data_vld <= 1'b0;
  else 
    rdl_data_vld <= rdl_cur_data_rd & arb_rdl_grant;
end

assign rdl_vb_req = rdl_cur_wvb;

assign rdl_vb_addr[33:0]    = {rdl_entry_tag[27:0], rdl_entry_idx[11:6]};
assign rdl_vb_alias         = !rdl_replace_sel & rdl_entry_alias_hit;
assign rdl_vb_ld            = lfb_ld;
assign rdl_vb_pf            = lfb_pf;
assign rdl_vb_ld_id[2:0]    = rdl_entry_id[2:0];

assign rdl_vb_data_vld      = rdl_data_vld;
assign rdl_vb_alias_dirty   = rdl_alias_dirty;
assign rdl_vb_data[127:0]   = dc_rdl_dcache_data[127:0];

assign rdl_alias_dirty      = |(dc_rdl_dcache_dirty[3:0] & rdl_entry_alias_way[3:0]);

//==============================================================================
//     ICG
//==============================================================================
assign rdl_fsm_clk_en = rdl_req | !rdl_cur_idle;
// &Instance("gated_clk_cell", "x_pa_lsu_rdl_fsm_gated_clk"); @438
gated_clk_cell  x_pa_lsu_rdl_fsm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rdl_fsm_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (rdl_fsm_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @439
//          .external_en (1'b0), @440
//          .global_en   (1'b1), @441
//          .module_en   (cp0_lsu_icg_en), @442
//          .local_en    (rdl_fsm_clk_en), @443
//          .clk_out     (rdl_fsm_clk)); @444

assign rdl_dp_clk_en = rdl_create_en | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_rdl_dp_gated_clk"); @447
gated_clk_cell  x_pa_lsu_rdl_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rdl_dp_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (rdl_dp_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @448
//          .external_en (1'b0), @449
//          .global_en   (1'b1), @450
//          .module_en   (cp0_lsu_icg_en), @451
//          .local_en    (rdl_dp_clk_en), @452
//          .clk_out     (rdl_dp_clk)); @453

assign rdl_tag_clk_en = rdl_create_en | 
                        rdl_cur_dirty_wen | 
                        rdl_cur_tag_wen | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_rdl_tag_gated_clk"); @458
gated_clk_cell  x_pa_lsu_rdl_tag_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rdl_tag_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (rdl_tag_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @459
//          .external_en (1'b0), @460
//          .global_en   (1'b1), @461
//          .module_en   (cp0_lsu_icg_en), @462
//          .local_en    (rdl_tag_clk_en), @463
//          .clk_out     (rdl_tag_clk)); @464

// &ModuleEnd; @466
endmodule


