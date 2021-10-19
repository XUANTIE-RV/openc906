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
module aq_lsu_stb_entry(
  amo_alu_stb_rst,
  amo_data_ready_x,
  cp0_lsu_dcache_wb,
  cp0_lsu_icg_en,
  cpurst_b,
  dc_hit_stb_addr_wca_x,
  dc_hit_stb_addr_x,
  dc_hit_stb_dca_x,
  dc_hit_stb_full_x,
  dc_hit_stb_idx_x,
  dc_hit_stb_part_x,
  dc_xx_bytes_vld,
  dc_xx_pa,
  forever_cpuclk,
  ifu_lsu_warm_up,
  lfb_done_x,
  lfb_err,
  lfb_fifo,
  pad_yy_icg_scan_en,
  pfb_hit_stb_idx_x,
  pfb_xx_pa,
  stb_create_age,
  stb_create_alct,
  stb_create_alias_idx,
  stb_create_amo_inst,
  stb_create_attr,
  stb_create_bytes_vld,
  stb_create_cache_hit,
  stb_create_data,
  stb_create_dca_inst,
  stb_create_dca_type,
  stb_create_en_gate_x,
  stb_create_en_x,
  stb_create_lock,
  stb_create_pa,
  stb_create_priv_mode,
  stb_create_shift,
  stb_create_size,
  stb_create_src2_depd,
  stb_create_src2_reg,
  stb_create_virt_idx,
  stb_create_wait_lfb,
  stb_create_way,
  stb_dca_done_x,
  stb_dca_grant_x,
  stb_entry_biu_req_x,
  stb_entry_dcache_req_x,
  stb_entry_fwd_vld_x,
  stb_entry_merge_en_x,
  stb_entry_pop_vld_x,
  stb_entry_rdl_req_x,
  stb_entry_so_vld_x,
  stb_entry_src2_depd_x,
  stb_entry_vld_x,
  stb_entryx_age,
  stb_entryx_bytes_vld,
  stb_entryx_cache,
  stb_entryx_data,
  stb_entryx_dbginfo,
  stb_entryx_dca_idx,
  stb_entryx_dca_type,
  stb_entryx_dca_way,
  stb_entryx_idx,
  stb_entryx_pa,
  stb_entryx_prot,
  stb_entryx_size,
  stb_entryx_user,
  stb_entryx_way,
  stb_merge_finish_x,
  stb_merge_req,
  stb_merge_req_gate,
  stb_pop_en,
  stb_wbus_cmplt_x,
  stb_wca_grant_x,
  vlsu_lsu_fwd_data,
  vlsu_lsu_fwd_dest_reg,
  vlsu_lsu_fwd_vld
);

// &Ports; @21
input   [63:0]  amo_alu_stb_rst;       
input           amo_data_ready_x;      
input           cp0_lsu_dcache_wb;     
input           cp0_lsu_icg_en;        
input           cpurst_b;              
input   [7 :0]  dc_xx_bytes_vld;       
input   [39:0]  dc_xx_pa;              
input           forever_cpuclk;        
input           ifu_lsu_warm_up;       
input           lfb_done_x;            
input           lfb_err;               
input   [3 :0]  lfb_fifo;              
input           pad_yy_icg_scan_en;    
input   [39:0]  pfb_xx_pa;             
input   [3 :0]  stb_create_age;        
input           stb_create_alct;       
input   [1 :0]  stb_create_alias_idx;  
input           stb_create_amo_inst;   
input   [2 :0]  stb_create_attr;       
input   [7 :0]  stb_create_bytes_vld;  
input           stb_create_cache_hit;  
input   [63:0]  stb_create_data;       
input           stb_create_dca_inst;   
input   [1 :0]  stb_create_dca_type;   
input           stb_create_en_gate_x;  
input           stb_create_en_x;       
input           stb_create_lock;       
input   [39:0]  stb_create_pa;         
input   [1 :0]  stb_create_priv_mode;  
input   [3 :0]  stb_create_shift;      
input   [1 :0]  stb_create_size;       
input           stb_create_src2_depd;  
input   [4 :0]  stb_create_src2_reg;   
input   [1 :0]  stb_create_virt_idx;   
input           stb_create_wait_lfb;   
input   [3 :0]  stb_create_way;        
input           stb_dca_done_x;        
input           stb_dca_grant_x;       
input           stb_merge_finish_x;    
input           stb_merge_req;         
input           stb_merge_req_gate;    
input   [3 :0]  stb_pop_en;            
input           stb_wbus_cmplt_x;      
input           stb_wca_grant_x;       
input   [63:0]  vlsu_lsu_fwd_data;     
input   [4 :0]  vlsu_lsu_fwd_dest_reg; 
input           vlsu_lsu_fwd_vld;      
output          dc_hit_stb_addr_wca_x; 
output          dc_hit_stb_addr_x;     
output          dc_hit_stb_dca_x;      
output          dc_hit_stb_full_x;     
output          dc_hit_stb_idx_x;      
output          dc_hit_stb_part_x;     
output          pfb_hit_stb_idx_x;     
output          stb_entry_biu_req_x;   
output          stb_entry_dcache_req_x; 
output          stb_entry_fwd_vld_x;   
output          stb_entry_merge_en_x;  
output          stb_entry_pop_vld_x;   
output          stb_entry_rdl_req_x;   
output          stb_entry_so_vld_x;    
output          stb_entry_src2_depd_x; 
output          stb_entry_vld_x;       
output  [3 :0]  stb_entryx_age;        
output  [7 :0]  stb_entryx_bytes_vld;  
output  [3 :0]  stb_entryx_cache;      
output  [63:0]  stb_entryx_data;       
output  [2 :0]  stb_entryx_dbginfo;    
output  [1 :0]  stb_entryx_dca_idx;    
output  [1 :0]  stb_entryx_dca_type;   
output  [3 :0]  stb_entryx_dca_way;    
output  [13:0]  stb_entryx_idx;        
output  [39:0]  stb_entryx_pa;         
output  [2 :0]  stb_entryx_prot;       
output  [2 :0]  stb_entryx_size;       
output          stb_entryx_user;       
output  [3 :0]  stb_entryx_way;        

// &Regs; @22
reg     [3 :0]  stb_cur_state;         
reg     [3 :0]  stb_entry_age;         
reg             stb_entry_alct;        
reg     [1 :0]  stb_entry_alias_idx;   
reg             stb_entry_amo_inst;    
reg     [2 :0]  stb_entry_attr;        
reg     [7 :0]  stb_entry_bytes_vld;   
reg             stb_entry_cache_hit;   
reg     [63:0]  stb_entry_data;        
reg     [1 :0]  stb_entry_dca_type;    
reg             stb_entry_lock;        
reg     [39:0]  stb_entry_pa;          
reg     [1 :0]  stb_entry_priv_mode;   
reg     [3 :0]  stb_entry_shift;       
reg     [1 :0]  stb_entry_size;        
reg             stb_entry_src2_depd;   
reg     [4 :0]  stb_entry_src2_reg;    
reg     [1 :0]  stb_entry_virt_idx;    
reg     [3 :0]  stb_entry_way;         
reg             stb_entry_wb;          
reg     [63:0]  stb_fwd_data;          
reg     [3 :0]  stb_next_state;        

// &Wires; @23
wire    [63:0]  amo_alu_stb_rst;       
wire            amo_data_ready_x;      
wire            bytes_vld_allone;      
wire            cp0_lsu_dcache_wb;     
wire            cp0_lsu_icg_en;        
wire            cpurst_b;              
wire            dc_hit_stb_addr;       
wire            dc_hit_stb_addr_wca_x; 
wire            dc_hit_stb_addr_x;     
wire            dc_hit_stb_bytes;      
wire            dc_hit_stb_bytes_full; 
wire            dc_hit_stb_dca_x;      
wire            dc_hit_stb_full_x;     
wire            dc_hit_stb_idx_x;      
wire            dc_hit_stb_line;       
wire            dc_hit_stb_part_x;     
wire    [7 :0]  dc_xx_bytes_vld;       
wire    [39:0]  dc_xx_pa;              
wire            forever_cpuclk;        
wire            ifu_lsu_warm_up;       
wire            lfb_done_x;            
wire            lfb_err;               
wire    [3 :0]  lfb_fifo;              
wire            pad_yy_icg_scan_en;    
wire            pfb_hit_stb_idx_x;     
wire    [39:0]  pfb_xx_pa;             
wire    [3 :0]  stb_create_age;        
wire            stb_create_alct;       
wire    [1 :0]  stb_create_alias_idx;  
wire            stb_create_amo_inst;   
wire    [2 :0]  stb_create_attr;       
wire    [7 :0]  stb_create_bytes_vld;  
wire            stb_create_ca;         
wire            stb_create_cache_hit;  
wire    [63:0]  stb_create_data;       
wire            stb_create_dca_inst;   
wire    [1 :0]  stb_create_dca_type;   
wire            stb_create_en_gate_x;  
wire            stb_create_en_x;       
wire            stb_create_lock;       
wire    [39:0]  stb_create_pa;         
wire    [1 :0]  stb_create_priv_mode;  
wire    [3 :0]  stb_create_shift;      
wire    [1 :0]  stb_create_size;       
wire            stb_create_src2_depd;  
wire    [4 :0]  stb_create_src2_reg;   
wire    [1 :0]  stb_create_virt_idx;   
wire            stb_create_wait_lfb;   
wire    [3 :0]  stb_create_way;        
wire            stb_cur_idle;          
wire            stb_cur_merg;          
wire            stb_cur_rdl;           
wire            stb_cur_wbus;          
wire            stb_cur_wca;           
wire            stb_cur_wlfb;          
wire            stb_cur_wrdl;          
wire            stb_dca_done_x;        
wire            stb_dca_grant_x;       
wire            stb_dp_clk;            
wire            stb_dp_clk_en;         
wire            stb_entry_biu_req_x;   
wire            stb_entry_buf;         
wire            stb_entry_ca;          
wire            stb_entry_dca;         
wire            stb_entry_dcache_req_x; 
wire            stb_entry_fwd_vld_x;   
wire            stb_entry_merge_en;    
wire            stb_entry_merge_en_x;  
wire    [2 :0]  stb_entry_offset;      
wire            stb_entry_pop_vld_x;   
wire            stb_entry_rdl_req_x;   
wire            stb_entry_so_vld_x;    
wire            stb_entry_src2_depd_x; 
wire            stb_entry_vld;         
wire            stb_entry_vld_x;       
wire            stb_entry_wdata_ready; 
wire            stb_entry_wo;          
wire    [3 :0]  stb_entryx_age;        
wire    [7 :0]  stb_entryx_bytes_vld;  
wire    [3 :0]  stb_entryx_cache;      
wire    [63:0]  stb_entryx_data;       
wire    [2 :0]  stb_entryx_dbginfo;    
wire    [1 :0]  stb_entryx_dca_idx;    
wire    [1 :0]  stb_entryx_dca_type;   
wire    [3 :0]  stb_entryx_dca_way;    
wire    [13:0]  stb_entryx_idx;        
wire    [39:0]  stb_entryx_pa;         
wire    [2 :0]  stb_entryx_prot;       
wire    [2 :0]  stb_entryx_size;       
wire            stb_entryx_user;       
wire    [3 :0]  stb_entryx_way;        
wire            stb_fsm_clk;           
wire            stb_fsm_clk_en;        
wire    [63:0]  stb_fwd_data_raw;      
wire            stb_fwd_vld;           
wire    [63:0]  stb_merge_bytes;       
wire    [63:0]  stb_merge_data;        
wire            stb_merge_finish_x;    
wire            stb_merge_req;         
wire            stb_merge_req_gate;    
wire            stb_merge_vld;         
wire            stb_merge_vld_gate;    
wire    [3 :0]  stb_pop_en;            
wire            stb_wbus_cmplt_x;      
wire            stb_wca_grant_x;       
wire            stb_wdata_clk;         
wire            stb_wdata_clk_en;      
wire    [63:0]  vlsu_lsu_fwd_data;     
wire    [4 :0]  vlsu_lsu_fwd_dest_reg; 
wire            vlsu_lsu_fwd_vld;      


parameter DEPTH = 4;
parameter PADDR = 40;

parameter CA    = 0;
parameter SO    = 1;
parameter BUF   = 2;
//================================================
//  STB ENTRY FSM
//================================================
parameter STB_IDLE  = 4'b0000;
parameter STB_WLFB  = 4'b0001;
parameter STB_WCA   = 4'b0010;
parameter STB_MERGE = 4'b0011;
parameter STB_WBUS  = 4'b0100;
parameter STB_WFC   = 4'b0101;
parameter STB_RDL   = 4'b0110;
parameter STB_WRDL  = 4'b0111;
parameter STB_FWD   = 4'b1000;

always@(posedge stb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_cur_state[3:0] <= STB_IDLE;
  else
    stb_cur_state[3:0] <= stb_next_state[3:0];
end

// &CombBeg; @52
always @( lfb_err
       or stb_entry_wb
       or stb_create_ca
       or stb_create_lock
       or stb_entry_cache_hit
       or stb_create_en_x
       or stb_dca_done_x
       or bytes_vld_allone
       or stb_cur_state
       or stb_entry_ca
       or stb_merge_finish_x
       or stb_wca_grant_x
       or stb_dca_grant_x
       or lfb_done_x
       or stb_entry_wdata_ready
       or stb_create_dca_inst
       or stb_create_wait_lfb
       or stb_wbus_cmplt_x
       or stb_entry_lock
       or stb_create_src2_depd
       or stb_create_cache_hit)
begin
  case(stb_cur_state)
    STB_IDLE: begin
      if (stb_create_en_x) begin
        if (stb_create_dca_inst)
          stb_next_state = STB_RDL;
        else if (stb_create_wait_lfb)
          stb_next_state = STB_WLFB;
        else if (!stb_create_src2_depd) begin
          if (stb_create_cache_hit)
            stb_next_state = STB_WCA;
          else if (stb_create_ca & !stb_create_lock)
            stb_next_state = STB_MERGE;
          else 
            stb_next_state = STB_WBUS;
        end
        else
          stb_next_state = STB_FWD;
      end
      else
        stb_next_state = STB_IDLE;
    end
    STB_RDL: begin
      if (stb_dca_grant_x)
        stb_next_state = STB_WRDL;
      else 
        stb_next_state = STB_RDL;
    end
    STB_WRDL: begin
      if (stb_dca_done_x)
        stb_next_state = STB_IDLE;
      else
        stb_next_state = STB_WRDL;
    end
    STB_WLFB: begin
      if (lfb_done_x) begin
        if (stb_entry_wdata_ready)
          stb_next_state = !lfb_err ? STB_WCA : STB_WBUS;
        else
          stb_next_state = STB_FWD;
      end
      else
        stb_next_state = STB_WLFB;
    end
    STB_FWD: begin
      if (stb_entry_wdata_ready) begin
        if (stb_entry_cache_hit)
          stb_next_state = STB_WCA;
        else if (stb_entry_ca & !stb_entry_lock)
          stb_next_state = STB_MERGE;
        else
          stb_next_state = STB_WBUS;
      end
      else
        stb_next_state = STB_FWD;
    end
    STB_WCA: begin
      if (stb_wca_grant_x)
        stb_next_state = stb_entry_wb ? STB_IDLE : STB_WBUS;
      else
        stb_next_state = STB_WCA;
    end
    STB_MERGE: begin
      if (stb_merge_finish_x | bytes_vld_allone)
        stb_next_state = STB_WBUS;
      else
        stb_next_state = STB_MERGE;
    end
    STB_WBUS: begin
      if (stb_wbus_cmplt_x)
        stb_next_state = STB_IDLE;
      else
        stb_next_state = STB_WBUS;
    end
    default: stb_next_state = STB_IDLE;
  endcase
// &CombEnd; @128
end

assign stb_cur_idle = stb_cur_state == STB_IDLE;
assign stb_cur_rdl  = stb_cur_state == STB_RDL; 
assign stb_cur_wrdl = stb_cur_state == STB_WRDL; 
assign stb_cur_wlfb = stb_cur_state == STB_WLFB; 
assign stb_cur_wca  = stb_cur_state == STB_WCA; 
assign stb_cur_merg = stb_cur_state == STB_MERGE;
assign stb_cur_wbus = stb_cur_state == STB_WBUS; 

assign stb_entry_vld = !stb_cur_idle;
assign stb_entry_dca = stb_cur_rdl | stb_cur_wrdl;

assign stb_entry_pop_vld_x = stb_cur_wrdl & stb_dca_done_x |
                             stb_cur_wca  & stb_wca_grant_x & stb_entry_wb |
                             stb_cur_wbus & stb_wbus_cmplt_x;

//================================================
// stb entry content
//================================================
always@(posedge stb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_entry_age[DEPTH-1:0] <= {DEPTH{1'b0}};
  else if (stb_create_en_gate_x)
    stb_entry_age[DEPTH-1:0] <= stb_create_age[DEPTH-1:0] & (~stb_pop_en[DEPTH-1:0]);
  else if (|stb_pop_en[DEPTH-1:0])
    stb_entry_age[DEPTH-1:0] <= stb_entry_age[DEPTH-1:0] & (~stb_pop_en[DEPTH-1:0]);
end

always@(posedge stb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_entry_cache_hit <= 1'b0;
  else if (stb_create_en_gate_x)
    stb_entry_cache_hit <= stb_create_cache_hit;
  else if (stb_cur_wlfb & lfb_done_x)
    stb_entry_cache_hit <= !lfb_err;
end

always@(posedge stb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_entry_way[3:0] <= 4'b0;
  else if (stb_create_en_gate_x)
    stb_entry_way[3:0] <= stb_create_way[3:0];
  else if (lfb_done_x & stb_cur_wlfb)
    stb_entry_way[3:0] <= lfb_fifo[3:0];
end

always@(posedge stb_dp_clk)
begin
  if (stb_create_en_gate_x | ifu_lsu_warm_up) begin
    stb_entry_pa[PADDR-1:0]  <= stb_create_pa[PADDR-1:0];
    stb_entry_virt_idx[1:0]  <= stb_create_virt_idx[1:0];
    stb_entry_alias_idx[1:0] <= stb_create_alias_idx[1:0];
    stb_entry_dca_type[1:0]  <= stb_create_dca_type[1:0];
    stb_entry_attr[2:0]      <= stb_create_attr[2:0];
  end
end

always@(posedge stb_dp_clk)
begin
  if (stb_create_en_gate_x & !stb_create_dca_inst | ifu_lsu_warm_up) begin
    stb_entry_size[1:0]      <= stb_create_size[1:0];
    stb_entry_wb             <= cp0_lsu_dcache_wb;
    stb_entry_alct           <= stb_create_alct;
    stb_entry_priv_mode[1:0] <= stb_create_priv_mode[1:0];
    stb_entry_lock           <= stb_create_lock;
    stb_entry_src2_reg[4:0]  <= stb_create_src2_reg[4:0];
    stb_entry_shift[3:0]     <= stb_create_shift[3:0];
    stb_entry_amo_inst       <= stb_create_amo_inst;
  end
end

assign stb_create_ca = stb_create_attr[CA];
assign stb_entry_ca  = stb_entry_attr[CA];
assign stb_entry_wo  = !stb_entry_attr[SO];
assign stb_entry_buf = stb_entry_ca ? stb_entry_wb : stb_entry_attr[BUF];

always@(posedge stb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    stb_entry_src2_depd <= 1'b0;
  else if (stb_create_en_gate_x & !stb_create_dca_inst)
    stb_entry_src2_depd <= stb_create_src2_depd;
  else if (stb_fwd_vld)
    stb_entry_src2_depd <= 1'b0;
end

assign stb_entry_wdata_ready = !stb_entry_src2_depd | stb_fwd_vld;
assign stb_fwd_vld           = stb_entry_src2_depd & 
                               (stb_entry_amo_inst & amo_data_ready_x |
                                !stb_entry_amo_inst & vlsu_lsu_fwd_vld & 
                               (vlsu_lsu_fwd_dest_reg[4:0] == stb_entry_src2_reg[4:0]));

assign stb_fwd_data_raw[63:0] = stb_entry_amo_inst
                                ? amo_alu_stb_rst[63:0]
                                : vlsu_lsu_fwd_data[63:0];

// &CombBeg; @234
always @( stb_entry_shift[2:0]
       or stb_fwd_data_raw[63:0])
begin
  casez(stb_entry_shift[2:0])
  3'b000 : stb_fwd_data[`LSU_DATAW-1:0] =  stb_fwd_data_raw[63:0];
  3'b001 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[55:0],stb_fwd_data_raw[63:56]};
  3'b010 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[47:0],stb_fwd_data_raw[63:48]};
  3'b011 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[39:0],stb_fwd_data_raw[63:40]};
  3'b100 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[31:0],stb_fwd_data_raw[63:32]};
  3'b101 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[23:0],stb_fwd_data_raw[63:24]};
  3'b110 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[15:0],stb_fwd_data_raw[63:16]};
  3'b111 : stb_fwd_data[`LSU_DATAW-1:0] = {stb_fwd_data_raw[7:0], stb_fwd_data_raw[63:8]};
  default: stb_fwd_data[`LSU_DATAW-1:0] =  stb_fwd_data_raw[`LSU_DATAW-1:0];
  endcase
// &CombEnd; @266
end

always@(posedge stb_wdata_clk)
begin
  if (stb_create_en_gate_x & !stb_create_dca_inst | ifu_lsu_warm_up) begin
    stb_entry_data[`LSU_DATAW-1:0]       <= stb_create_data[`LSU_DATAW-1:0];
    stb_entry_bytes_vld[`LSU_BYTEW-1:0]  <= stb_create_bytes_vld[`LSU_BYTEW-1:0];
  end
  else if (stb_fwd_vld) begin
    stb_entry_data[`LSU_DATAW-1:0]       <= stb_fwd_data[`LSU_DATAW-1:0];
    stb_entry_bytes_vld[`LSU_BYTEW-1:0]  <= stb_entry_bytes_vld[`LSU_BYTEW-1:0];
  end
  else if (stb_merge_vld) begin
    stb_entry_data[`LSU_DATAW-1:0]       <= stb_merge_data[`LSU_DATAW-1:0];
    stb_entry_bytes_vld[`LSU_BYTEW-1:0]  <= stb_entry_bytes_vld[`LSU_BYTEW-1:0] | stb_create_bytes_vld[`LSU_BYTEW-1:0];
  end
end

assign bytes_vld_allone = &stb_entry_bytes_vld[`LSU_BYTEW-1:0];

assign stb_merge_bytes[`LSU_DATAW-1:0] = {{8{stb_create_bytes_vld[7]}},
                                          {8{stb_create_bytes_vld[6]}},
                                          {8{stb_create_bytes_vld[5]}},
                                          {8{stb_create_bytes_vld[4]}},
                                          {8{stb_create_bytes_vld[3]}},
                                          {8{stb_create_bytes_vld[2]}},
                                          {8{stb_create_bytes_vld[1]}},
                                          {8{stb_create_bytes_vld[0]}}};


assign stb_merge_data[`LSU_DATAW-1:0] = stb_merge_bytes[`LSU_DATAW-1:0] & stb_create_data[`LSU_DATAW-1:0] |
                                        ~stb_merge_bytes[`LSU_DATAW-1:0] & stb_entry_data[`LSU_DATAW-1:0];

assign stb_merge_vld      = stb_merge_req & stb_entry_merge_en;
assign stb_merge_vld_gate = stb_merge_req_gate & stb_entry_merge_en;

assign stb_entry_merge_en = stb_entry_wo & 
                           !stb_entry_dca & 
                            dc_hit_stb_addr &
                            stb_cur_merg;

assign stb_entry_merge_en_x = stb_entry_merge_en;

//================================================
//          dependency check
//================================================
// &Force("bus", "pfb_xx_pa",PADDR-1,0); @331
// &Force("bus", "dc_stb_xx_pa",PADDR-1,0); @333
// &Force("bus", "dc_xx_pa",PADDR-1,0); @335

assign dc_hit_stb_line       = (dc_xx_pa[PADDR-1:6] == stb_entry_pa[PADDR-1:6]) & stb_entry_vld;
assign dc_hit_stb_addr       = (dc_xx_pa[PADDR-1:3] == stb_entry_pa[PADDR-1:3]) & stb_entry_vld;

assign dc_hit_stb_bytes_full = (dc_xx_bytes_vld[7:0] == stb_entry_bytes_vld[7:0]);
assign dc_hit_stb_bytes      = |(dc_xx_bytes_vld[7:0] & stb_entry_bytes_vld[7:0]);

assign dc_hit_stb_full_x     = dc_hit_stb_addr & dc_hit_stb_bytes_full;
assign dc_hit_stb_part_x     = dc_hit_stb_addr & dc_hit_stb_bytes & !dc_hit_stb_bytes_full;

assign dc_hit_stb_idx_x      = (dc_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == stb_entry_pa[`D_TAG_INDEX_WIDTH+6-1:6]) & stb_entry_vld;
assign dc_hit_stb_dca_x      = dc_hit_stb_line & stb_entry_dca;

assign stb_entry_so_vld_x    = stb_entry_vld & !stb_entry_wo;
assign stb_entry_vld_x       = stb_entry_vld;

assign dc_hit_stb_addr_x     = dc_hit_stb_addr;
assign dc_hit_stb_addr_wca_x = dc_hit_stb_addr & dc_hit_stb_bytes;

assign pfb_hit_stb_idx_x     = (pfb_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == stb_entry_pa[`D_TAG_INDEX_WIDTH+6-1:6]) & stb_entry_vld;

assign stb_entry_src2_depd_x = stb_entry_src2_depd;
assign stb_entry_fwd_vld_x   = stb_entry_vld & stb_fwd_vld;

//================================================
//         dcache inst request RDL
//================================================
assign stb_entry_rdl_req_x      = stb_cur_rdl;
assign stb_entryx_dca_idx[1:0]  = stb_entry_alias_idx[1:0];
assign stb_entryx_dca_way[3:0]  = stb_entry_way[3:0];
assign stb_entryx_dca_type[1:0] = stb_entry_dca_type[1:0];

//================================================
// request CACHE
//================================================
assign stb_entry_dcache_req_x      = stb_cur_wca;

assign stb_entry_biu_req_x         = stb_cur_wbus;

assign stb_entry_offset[2:0]                = stb_entry_wo ? 3'b000 : stb_entry_pa[2:0];
assign stb_entryx_pa[PADDR-1:0]             = {stb_entry_pa[PADDR-1:3],stb_entry_offset[2:0]};
assign stb_entryx_size[2:0]                 = stb_entry_wo ? 3'b011 : {1'b0,stb_entry_size[1:0]};
assign stb_entryx_prot[2:0]                 = {1'b0,1'b1,stb_entry_priv_mode[0]};
assign stb_entryx_cache[3:0]                = {stb_entry_alct,stb_entry_ca,stb_entry_wo,stb_entry_buf};
assign stb_entryx_user                      = stb_entry_priv_mode[1];

assign stb_entryx_way[3:0]                  = stb_entry_way[3:0];
assign stb_entryx_idx[13:0]                 = {stb_entry_virt_idx[1:0], stb_entry_pa[11:0]};
assign stb_entryx_data[`LSU_DATAW-1:0]      = stb_entry_data[`LSU_DATAW-1:0];
assign stb_entryx_age[DEPTH-1:0]            = stb_entry_age[DEPTH-1:0];
assign stb_entryx_bytes_vld[`LSU_BYTEW-1:0] = stb_entry_bytes_vld[`LSU_BYTEW-1:0];

//================================================
// ICG
//================================================
assign stb_fsm_clk_en = stb_create_en_gate_x | stb_entry_vld;
// &Instance("gated_clk_cell", "x_pa_lsu_stb_fsm_gated_clk"); @415
gated_clk_cell  x_pa_lsu_stb_fsm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (stb_fsm_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (stb_fsm_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @416
//          .external_en (1'b0), @417
//          .global_en   (1'b1), @418
//          .module_en   (cp0_lsu_icg_en), @419
//          .local_en    (stb_fsm_clk_en), @420
//          .clk_out     (stb_fsm_clk)); @421

assign stb_dp_clk_en = stb_create_en_gate_x | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_stb_dp_gated_clk"); @424
gated_clk_cell  x_pa_lsu_stb_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (stb_dp_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (stb_dp_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @425
//          .external_en (1'b0), @426
//          .global_en   (1'b1), @427
//          .module_en   (cp0_lsu_icg_en), @428
//          .local_en    (stb_dp_clk_en), @429
//          .clk_out     (stb_dp_clk)); @430

assign stb_wdata_clk_en = stb_create_en_gate_x & !stb_create_dca_inst | 
                          stb_merge_vld_gate | stb_fwd_vld |
                          ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_stb_wdata_gated_clk"); @435
gated_clk_cell  x_pa_lsu_stb_wdata_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (stb_wdata_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (stb_wdata_clk_en  ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @436
//          .external_en (1'b0), @437
//          .global_en   (1'b1), @438
//          .module_en   (cp0_lsu_icg_en), @439
//          .local_en    (stb_wdata_clk_en), @440
//          .clk_out     (stb_wdata_clk)); @441

//================================================
//  DBG_INFO
//================================================
assign stb_entryx_dbginfo[2:0] = stb_cur_state[2:0];

//================================================
//
//================================================
// &ModuleEnd; @460
endmodule


