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

// &Depend("cpu_cfig.h"); @18
// &Depend("aq_lsu_cfig.h"); @19

// &ModuleBeg; @21
module aq_lsu_icc(
  cp0_lsu_dcache_read_idx,
  cp0_lsu_dcache_read_req,
  cp0_lsu_dcache_read_type,
  cp0_lsu_dcache_read_way,
  cp0_lsu_icc_addr,
  cp0_lsu_icc_op,
  cp0_lsu_icc_req,
  cp0_lsu_icc_type,
  cp0_lsu_icg_en,
  cpurst_b,
  dc_icc_dcache_data,
  dc_icc_dcache_dirty,
  dc_icc_dcache_tag,
  dc_icc_dcache_tagvld,
  forever_cpuclk,
  icc_arb_data02_idx,
  icc_arb_data0_req,
  icc_arb_data13_idx,
  icc_arb_data1_req,
  icc_arb_data2_req,
  icc_arb_data3_req,
  icc_arb_data_way,
  icc_arb_dirty_din,
  icc_arb_dirty_idx,
  icc_arb_dirty_req,
  icc_arb_dirty_wen,
  icc_arb_tag_idx,
  icc_arb_tag_req,
  icc_arb_tag_sel,
  icc_arb_tag_way,
  icc_arb_tag_wen,
  icc_dc_acc_fifo,
  icc_dc_acc_idx,
  icc_dc_sel,
  icc_vb_addr,
  icc_vb_data,
  icc_vb_data_vld,
  icc_vb_req,
  icc_xx_idle,
  icc_xx_sync_req,
  ifu_lsu_warm_up,
  lsu_cp0_dcache_read_data,
  lsu_cp0_dcache_read_data_vld,
  lsu_cp0_icc_done,
  lsu_no_op,
  pad_yy_icg_scan_en,
  vb_icc_empty,
  vb_icc_grant,
  vb_xx_idle
);

// &Ports; @22
input   [16 :0]  cp0_lsu_dcache_read_idx;     
input            cp0_lsu_dcache_read_req;     
input            cp0_lsu_dcache_read_type;    
input   [1  :0]  cp0_lsu_dcache_read_way;     
input   [63 :0]  cp0_lsu_icc_addr;            
input   [1  :0]  cp0_lsu_icc_op;              
input            cp0_lsu_icc_req;             
input   [1  :0]  cp0_lsu_icc_type;            
input            cp0_lsu_icg_en;              
input            cpurst_b;                    
input   [127:0]  dc_icc_dcache_data;          
input   [3  :0]  dc_icc_dcache_dirty;         
input   [27 :0]  dc_icc_dcache_tag;           
input            dc_icc_dcache_tagvld;        
input            forever_cpuclk;              
input            ifu_lsu_warm_up;             
input            lsu_no_op;                   
input            pad_yy_icg_scan_en;          
input            vb_icc_empty;                
input            vb_icc_grant;                
input            vb_xx_idle;                  
output  [13 :0]  icc_arb_data02_idx;          
output           icc_arb_data0_req;           
output  [13 :0]  icc_arb_data13_idx;          
output           icc_arb_data1_req;           
output           icc_arb_data2_req;           
output           icc_arb_data3_req;           
output  [3  :0]  icc_arb_data_way;            
output  [7  :0]  icc_arb_dirty_din;           
output  [13 :0]  icc_arb_dirty_idx;           
output           icc_arb_dirty_req;           
output  [7  :0]  icc_arb_dirty_wen;           
output  [11 :0]  icc_arb_tag_idx;             
output           icc_arb_tag_req;             
output  [3  :0]  icc_arb_tag_sel;             
output  [3  :0]  icc_arb_tag_way;             
output           icc_arb_tag_wen;             
output  [3  :0]  icc_dc_acc_fifo;             
output  [1  :0]  icc_dc_acc_idx;              
output           icc_dc_sel;                  
output  [33 :0]  icc_vb_addr;                 
output  [127:0]  icc_vb_data;                 
output           icc_vb_data_vld;             
output           icc_vb_req;                  
output           icc_xx_idle;                 
output           icc_xx_sync_req;             
output  [127:0]  lsu_cp0_dcache_read_data;    
output           lsu_cp0_dcache_read_data_vld; 
output           lsu_cp0_icc_done;            

// &Regs; @23
reg     [1  :0]  data_acc_fifo;               
reg     [1  :0]  data_offset;                 
reg     [127:0]  dca_data;                    
reg     [7  :0]  icc_cnt;                     
reg     [4  :0]  icc_cur_state;               
reg              icc_data_vld;                
reg     [3  :0]  icc_dirty;                   
reg     [4  :0]  icc_next_state;              
reg     [27 :0]  icc_tag;                     
reg              icc_tagvld;                  

// &Wires; @24
wire    [16 :0]  cp0_lsu_dcache_read_idx;     
wire             cp0_lsu_dcache_read_req;     
wire             cp0_lsu_dcache_read_type;    
wire    [1  :0]  cp0_lsu_dcache_read_way;     
wire    [63 :0]  cp0_lsu_icc_addr;            
wire    [1  :0]  cp0_lsu_icc_op;              
wire             cp0_lsu_icc_req;             
wire    [1  :0]  cp0_lsu_icc_type;            
wire             cp0_lsu_icg_en;              
wire    [7  :0]  cp0_set;                     
wire    [3  :0]  cp0_way;                     
wire             cpurst_b;                    
wire             data0_addr_3;                
wire             data1_addr_3;                
wire             data_rd_last;                
wire    [1  :0]  data_sel;                    
wire    [3  :0]  data_way_sel;                
wire    [127:0]  dc_icc_dcache_data;          
wire    [3  :0]  dc_icc_dcache_dirty;         
wire    [27 :0]  dc_icc_dcache_tag;           
wire             dc_icc_dcache_tagvld;        
wire    [1  :0]  dca_icc_way;                 
wire             dca_req_tag;                 
wire             dca_req_vld;                 
wire    [1  :0]  dca_req_way;                 
wire             dirty;                       
wire             dirty_wen;                   
wire             fifo_wen;                    
wire             forever_cpuclk;              
wire    [13 :0]  icc_arb_data02_idx;          
wire             icc_arb_data0_req;           
wire    [13 :0]  icc_arb_data13_idx;          
wire             icc_arb_data1_req;           
wire             icc_arb_data2_req;           
wire             icc_arb_data3_req;           
wire    [3  :0]  icc_arb_data_way;            
wire    [7  :0]  icc_arb_dirty_din;           
wire    [13 :0]  icc_arb_dirty_idx;           
wire             icc_arb_dirty_req;           
wire    [7  :0]  icc_arb_dirty_wen;           
wire    [11 :0]  icc_arb_tag_idx;             
wire             icc_arb_tag_req;             
wire    [3  :0]  icc_arb_tag_sel;             
wire    [3  :0]  icc_arb_tag_way;             
wire             icc_arb_tag_wen;             
wire             icc_clk;                     
wire             icc_clk_en;                  
wire             icc_cnt_done;                
wire             icc_cnt_en;                  
wire             icc_cnt_start;               
wire             icc_cur_clr_vb;              
wire             icc_cur_data;                
wire             icc_cur_dca_wb;              
wire             icc_cur_dirty_rd;            
wire             icc_cur_dirty_wen;           
wire             icc_cur_idle;                
wire             icc_cur_inv_all;             
wire             icc_cur_tag_rd;              
wire             icc_cur_tag_wen;             
wire             icc_cur_tag_wt;              
wire             icc_cur_wfvb;                
wire             icc_data_clk;                
wire             icc_data_clk_en;             
wire    [3  :0]  icc_dc_acc_fifo;             
wire    [1  :0]  icc_dc_acc_idx;              
wire             icc_dc_sel;                  
wire    [3  :0]  icc_dirty_mask;              
wire             icc_fsm_clk;                 
wire             icc_fsm_clk_en;              
wire             icc_req_cln;                 
wire             icc_req_inv;                 
wire             icc_req_vld;                 
wire    [33 :0]  icc_vb_addr;                 
wire    [127:0]  icc_vb_data;                 
wire             icc_vb_data_vld;             
wire             icc_vb_req;                  
wire             icc_xx_idle;                 
wire             icc_xx_sync_req;             
wire             ifu_lsu_warm_up;             
wire             inv_all_setway;              
wire             line_dirty;                  
wire             line_vld;                    
wire    [127:0]  lsu_cp0_dcache_read_data;    
wire             lsu_cp0_dcache_read_data_vld; 
wire             lsu_cp0_icc_done;            
wire             lsu_no_op;                   
wire    [1  :0]  offset;                      
wire             pad_yy_icg_scan_en;          
wire    [7  :0]  tag_idx;                     
wire             tag_wen;                     
wire             type_all;                    
wire             type_setway;                 
wire             vb_icc_empty;                
wire             vb_icc_grant;                
wire             vb_xx_idle;                  
wire             way0_sel;                    
wire             way0_way2_sel;               
wire             way1_sel;                    
wire             way2_sel;                    
wire    [3  :0]  way_dirty;                   
wire    [3  :0]  way_sel;                     


parameter D_TAG_INDEX_LEN  = `D_TAG_INDEX_WIDTH;
parameter D_TAG_TAG_LEN    = `D_TAG_TAG_WIDTH;

parameter ICC_IDLE      = 5'b00000;
parameter ICC_DIRTY_RD  = 5'b00001;
parameter ICC_DIRTY_WEN = 5'b00010;
parameter ICC_CHECK     = 5'b00011;
parameter ICC_TAG_RD_W0 = 5'b00100;
parameter ICC_TAG_RD_W1 = 5'b00101;
parameter ICC_TAG_RD_W2 = 5'b00110;
parameter ICC_TAG_RD_W3 = 5'b00111;
parameter ICC_TAG_WEN_W0= 5'b01000;
parameter ICC_TAG_WEN_W1= 5'b01001;
parameter ICC_TAG_WEN_W2= 5'b01010;
parameter ICC_TAG_WEN_W3= 5'b01011;
parameter ICC_WFVB_W0   = 5'b01100;
parameter ICC_WFVB_W1   = 5'b01101;
parameter ICC_WFVB_W2   = 5'b01110;
parameter ICC_WFVB_W3   = 5'b01111;
parameter ICC_DATA_W0   = 5'b10000;
parameter ICC_DATA_W1   = 5'b10001;
parameter ICC_DATA_W2   = 5'b10010;
parameter ICC_DATA_W3   = 5'b10011;
parameter ICC_TAG_WT    = 5'b10100;
parameter ICC_INV_ALL   = 5'b10101;
parameter ICC_CLR_VB    = 5'b10110;
parameter ICC_DCA       = 5'b10111;
parameter ICC_DCA_WB    = 5'b11000;

parameter ALL    = 2'b00;
parameter SETWAY = 2'b01;
parameter VA     = 2'b10;

always@(posedge icc_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    icc_cur_state[4:0] <= ICC_IDLE;
  else 
    icc_cur_state[4:0] <= icc_next_state[4:0];
end

assign icc_req_vld    = cp0_lsu_icc_req;
assign icc_req_inv    = cp0_lsu_icc_op[0] & icc_req_vld;
assign icc_req_cln    = cp0_lsu_icc_op[1] & icc_req_vld;
assign type_all       = cp0_lsu_icc_type[1:0] == ALL;
assign type_setway    = cp0_lsu_icc_type[1:0] == SETWAY;
assign inv_all_setway = icc_req_inv & !icc_req_cln & (type_all | type_setway);

assign dca_req_vld       = cp0_lsu_dcache_read_req;
assign dca_req_tag       = cp0_lsu_dcache_read_type & dca_req_vld;
assign dca_req_way[1:0]  = cp0_lsu_dcache_read_way[1:0];

assign icc_xx_sync_req = (icc_req_vld | dca_req_vld) & icc_cur_state == ICC_IDLE;

// &CombBeg; @80
always @( type_all
       or dca_req_vld
       or icc_cnt_done
       or way2_sel
       or icc_req_cln
       or vb_icc_empty
       or lsu_no_op
       or dca_req_way[1:0]
       or dca_req_tag
       or way0_sel
       or data_rd_last
       or inv_all_setway
       or way1_sel
       or icc_req_vld
       or line_vld
       or icc_cur_state
       or vb_icc_grant
       or line_dirty
       or vb_xx_idle)
begin
  case (icc_cur_state)
    ICC_IDLE: begin
      if ((icc_req_vld | dca_req_vld) & lsu_no_op & vb_xx_idle) begin
        if (icc_req_vld & inv_all_setway)
          icc_next_state = ICC_INV_ALL;
        else if (icc_req_vld | dca_req_tag)
          icc_next_state = ICC_DIRTY_RD;
        else 
          icc_next_state = {3'b100,dca_req_way[1:0]};
      end
      else
        icc_next_state = ICC_IDLE;
    end
    ICC_INV_ALL: begin
      if (icc_cnt_done)
        icc_next_state = ICC_CLR_VB;
      else
        icc_next_state = ICC_INV_ALL;
    end
    ICC_DIRTY_RD: begin
      icc_next_state = ICC_DIRTY_WEN;
    end
    ICC_DIRTY_WEN: begin
      icc_next_state = ICC_CHECK;
    end
    ICC_CHECK: begin
      if (icc_req_cln & line_dirty | dca_req_tag)
        icc_next_state = way0_sel ? ICC_TAG_RD_W0 
                       : way1_sel ? ICC_TAG_RD_W1
                       : way2_sel ? ICC_TAG_RD_W2
                                  : ICC_TAG_RD_W3;
      else
        icc_next_state = ICC_TAG_WT;
    end
    ICC_TAG_RD_W0: begin
      icc_next_state = ICC_TAG_WEN_W0;
    end
    ICC_TAG_WEN_W0: begin
      if (icc_req_cln & line_vld)
        icc_next_state = ICC_WFVB_W0;
      else if (icc_req_cln)
        icc_next_state = ICC_CHECK;
      else
        icc_next_state = ICC_DCA_WB;
    end
    ICC_TAG_RD_W1: begin
      icc_next_state = ICC_TAG_WEN_W1;
    end
    ICC_TAG_WEN_W1: begin
      if (icc_req_cln & line_vld)
        icc_next_state = ICC_WFVB_W1;
      else if (icc_req_cln)
        icc_next_state = ICC_CHECK;
      else
        icc_next_state = ICC_DCA_WB;
    end
    ICC_TAG_RD_W2: begin
      icc_next_state = ICC_TAG_WEN_W2;
    end
    ICC_TAG_WEN_W2: begin
      if (icc_req_cln & line_vld)
        icc_next_state = ICC_WFVB_W2;
      else if (icc_req_cln)
        icc_next_state = ICC_CHECK;
      else
        icc_next_state = ICC_DCA_WB;
    end
    ICC_TAG_RD_W3: begin
      icc_next_state = ICC_TAG_WEN_W3;
    end
    ICC_TAG_WEN_W3: begin
      if (icc_req_cln & line_vld)
        icc_next_state = ICC_WFVB_W3;
      else if (icc_req_cln)
        icc_next_state = ICC_CHECK;
      else
        icc_next_state = ICC_DCA_WB;
    end
    ICC_WFVB_W0: begin
      if (vb_icc_grant)
        icc_next_state = ICC_DATA_W0;
      else
        icc_next_state = ICC_WFVB_W0;
    end
    ICC_DATA_W0: begin
      if (data_rd_last) begin
        if (dca_req_vld)
          icc_next_state = ICC_DCA;
        else if (type_all & line_dirty)
          icc_next_state = way1_sel ? ICC_TAG_RD_W1 
                         : way2_sel ? ICC_TAG_RD_W2 
                                    : ICC_TAG_RD_W3;
        else
          icc_next_state = ICC_TAG_WT;
      end
      else
        icc_next_state = ICC_DATA_W0;
    end
    ICC_WFVB_W1: begin
      if (vb_icc_grant)
        icc_next_state = ICC_DATA_W1;
      else
        icc_next_state = ICC_WFVB_W1;
    end
    ICC_DATA_W1: begin
      if (data_rd_last) begin
        if (dca_req_vld)
          icc_next_state = ICC_DCA;
        else if (type_all & line_dirty)
          icc_next_state = way2_sel ? ICC_TAG_RD_W2 
                                    : ICC_TAG_RD_W3;
        else
          icc_next_state = ICC_TAG_WT;
      end
      else
        icc_next_state = ICC_DATA_W1;
    end
    ICC_WFVB_W2: begin
      if (vb_icc_grant)
        icc_next_state = ICC_DATA_W2;
      else
        icc_next_state = ICC_WFVB_W2;
    end
    ICC_DATA_W2: begin
      if (data_rd_last) begin
        if (dca_req_vld)
          icc_next_state = ICC_DCA;
        else if (type_all & line_dirty)
          icc_next_state = ICC_TAG_RD_W3;
        else
          icc_next_state = ICC_TAG_WT;
      end
      else
        icc_next_state = ICC_DATA_W2;
    end
    ICC_WFVB_W3: begin
      if (vb_icc_grant)
        icc_next_state = ICC_DATA_W3;
      else
        icc_next_state = ICC_WFVB_W3;
    end
    ICC_DATA_W3: begin
      if (data_rd_last)
        icc_next_state = dca_req_vld ? ICC_DCA : ICC_TAG_WT;
      else
        icc_next_state = ICC_DATA_W3;
    end
    ICC_TAG_WT: begin
      if (icc_cnt_done)
        icc_next_state = ICC_CLR_VB;
      else
        icc_next_state = ICC_DIRTY_RD;
    end
    ICC_CLR_VB: begin
      if (vb_icc_empty)
        icc_next_state = ICC_IDLE;
      else 
        icc_next_state = ICC_CLR_VB;
    end
    ICC_DCA: begin
      icc_next_state = ICC_DCA_WB;
    end
    ICC_DCA_WB: begin
      icc_next_state = ICC_IDLE;
    end
    default: icc_next_state = ICC_IDLE;
  endcase
// &CombEnd; @248
end

assign icc_cur_tag_rd  = icc_cur_state[4:2] == 3'b001;
assign icc_cur_tag_wen = icc_cur_state[4:2] == 3'b010;
assign icc_cur_wfvb    = icc_cur_state[4:2] == 3'b011;
assign icc_cur_data    = icc_cur_state[4:2] == 3'b100;

assign icc_cur_idle      = icc_cur_state == ICC_IDLE;
assign icc_cur_inv_all   = icc_cur_state == ICC_INV_ALL;
assign icc_cur_dirty_rd  = icc_cur_state == ICC_DIRTY_RD;
assign icc_cur_dirty_wen = icc_cur_state == ICC_DIRTY_WEN;
assign icc_cur_tag_wt    = icc_cur_state == ICC_TAG_WT;
assign icc_cur_clr_vb    = icc_cur_state == ICC_CLR_VB;
assign icc_cur_dca_wb    = icc_cur_state == ICC_DCA_WB;

assign icc_xx_idle       = icc_cur_idle & !(icc_req_vld | dca_req_vld);

//================================================
//  icc cnt
//================================================
assign icc_cnt_start = icc_cur_idle & icc_req_vld;
assign icc_cnt_en    = icc_cur_inv_all | icc_cur_tag_wt;

always@(posedge icc_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    icc_cnt[7:0] <= 8'b0;
  else if (icc_cnt_start)
    icc_cnt[7:0] <= type_all ? {8{1'b1}} : {8{1'b0}};
  else if (icc_cnt_en)
    icc_cnt[7:0] <= icc_cnt[7:0] - 8'b1;
end

assign icc_cnt_done = icc_cnt[`D_DATA_INDEX_WIDTH-4:0] == {(`D_DATA_INDEX_WIDTH-3){1'b0}};

assign lsu_cp0_icc_done = vb_icc_empty & icc_cur_clr_vb;


//================================================
//  tag info
//================================================

assign icc_dirty_mask[3:0] = ~(4'b1 << icc_cur_state[1:0]);

always@(posedge icc_clk)
begin
  if (ifu_lsu_warm_up) 
    icc_dirty[3:0] <= 4'b0;
  else if (icc_cur_dirty_wen) 
    icc_dirty[3:0] <= dc_icc_dcache_dirty[3:0];
  else if (icc_cur_tag_wen & icc_req_vld)
    icc_dirty[3:0] <= icc_dirty[3:0] & icc_dirty_mask[3:0];
end

always@(posedge icc_clk)
begin
  if (ifu_lsu_warm_up) begin
    icc_tag[D_TAG_TAG_LEN-1:0] <= {D_TAG_TAG_LEN{1'b0}};
    icc_tagvld                 <= 1'b0;
  end
  else if (icc_cur_tag_wen) begin
    icc_tag[D_TAG_TAG_LEN-1:0] <= dc_icc_dcache_tag[D_TAG_TAG_LEN-1:0];
    icc_tagvld                 <= dc_icc_dcache_tagvld;
  end
end

assign line_vld = dc_icc_dcache_tagvld;

//================================================
//        line dirty check   
//================================================
// &Force("bus","cp0_lsu_icc_addr",63,0); @319
// &Force("bus","cp0_lsu_dcache_read_idx",16,0); @320

assign dca_icc_way[1:0] = dca_req_vld ? cp0_lsu_dcache_read_way[1:0] : cp0_lsu_icc_addr[31:30];

assign cp0_way[3:0] = 4'b1 << dca_icc_way[1:0];
assign cp0_set[7:0] = dca_req_vld ? cp0_lsu_dcache_read_idx[13:6] : cp0_lsu_icc_addr[13:6];

assign way_sel[3:0] = (icc_req_vld & type_setway | dca_req_vld)
                    ? cp0_way[3:0] : 4'b1111;

assign way_dirty[3:0] = (icc_req_vld ? icc_dirty[3:0] : 4'b1111) & way_sel[3:0];

assign way0_sel   = way_dirty[0];
assign way1_sel   = way_dirty[1];
assign way2_sel   = way_dirty[2];

assign line_dirty = |way_dirty[3:0];

//================================================
//           dc interface
//================================================
assign icc_dc_sel           = !icc_cur_idle;
assign icc_dc_acc_fifo[3:0] = dca_req_vld ? cp0_way[3:0] : (4'b1<<data_acc_fifo[1:0]);
assign icc_dc_acc_idx[1:0]  = tag_idx[7:6];

always@(posedge icc_fsm_clk)
begin
  if (icc_cur_tag_rd | ifu_lsu_warm_up)
    data_acc_fifo[1:0] <= icc_cur_state[1:0];
end

//================================================
//           dcache request
//================================================
//tag_req
assign tag_idx[7:0] = (icc_req_vld & type_setway | dca_req_vld)
                    ? cp0_set[7:0]
                    : icc_cnt[7:0];

assign tag_wen = icc_cur_inv_all | 
                 icc_cur_tag_wt & icc_req_inv;

assign icc_arb_tag_req = tag_wen |
                         icc_cur_tag_rd;

assign icc_arb_tag_way[3:0]  = icc_cur_tag_rd ? 4'b1 << icc_cur_state[1:0] : way_sel[3:0];

assign icc_arb_tag_sel[3:0]  = {2'b00,2'b1<<tag_idx[6]};

assign icc_arb_tag_wen       = tag_wen;
assign icc_arb_tag_idx[11:0] = {tag_idx[5:0],6'b0};

//dirty_req
assign dirty_wen = icc_cur_inv_all & type_all | 
                   icc_cur_tag_wt & icc_req_cln;

assign fifo_wen  = type_all & icc_req_inv & dirty_wen;

assign icc_arb_dirty_req = dirty_wen |
                           icc_cur_dirty_rd; 

assign icc_arb_dirty_wen[7:0]  = {{4{fifo_wen}}, {4{dirty_wen}} & way_sel[3:0]};
assign icc_arb_dirty_din[7:0]  = {4'b1, 4'b0};
assign icc_arb_dirty_idx[13:0] = {tag_idx[7:0],6'b0};

//data_req
assign offset[1:0] = dca_req_vld ? cp0_lsu_dcache_read_idx[5:4] : data_offset[1:0];

assign data_way_sel[3:0] = 4'b1 << icc_cur_state[1:0];

assign data_sel[1:0] = {data_way_sel[3] | data_way_sel[2],
                        data_way_sel[1] | data_way_sel[0]};

assign way0_way2_sel = data_way_sel[0] | data_way_sel[2]; 

assign data0_addr_3  = way0_way2_sel
                     ? 1'b0 : 1'b1;
assign data1_addr_3  = way0_way2_sel
                     ? 1'b1 : 1'b0;

assign icc_arb_data0_req        = icc_cur_data & data_sel[0];
assign icc_arb_data1_req        = icc_cur_data & data_sel[0];
assign icc_arb_data2_req        = icc_cur_data & data_sel[1];
assign icc_arb_data3_req        = icc_cur_data & data_sel[1];
assign icc_arb_data02_idx[13:0] = {tag_idx[7:0],offset[1:0],data0_addr_3,3'b000};
assign icc_arb_data13_idx[13:0] = {tag_idx[7:0],offset[1:0],data1_addr_3,3'b000};
assign icc_arb_data_way[3:0]    = data_way_sel[3:0];

//================================================
//           VB request
//================================================

always@(posedge icc_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    icc_data_vld <= 1'b0;
  else 
    icc_data_vld <= icc_cur_data;
end

always@(posedge icc_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    data_offset[1:0] <= 2'b0;
  else if (icc_cur_wfvb & vb_icc_grant) 
    data_offset[1:0] <= 2'b0;
  else if (icc_cur_data & icc_req_vld) 
    data_offset[1:0] <= data_offset[1:0] + 2'b1;
end

assign data_rd_last = dca_req_vld | (data_offset[1:0] == 2'b11);

assign icc_vb_req        = icc_cur_wfvb;
assign icc_vb_addr[33:0] = {icc_tag[27:0], tag_idx[5:0]};
assign icc_vb_data_vld    = icc_data_vld & icc_req_vld;
assign icc_vb_data[127:0] = dc_icc_dcache_data[127:0];

//================================================
//  ICG
//================================================

always@(posedge icc_data_clk)
begin
  if (icc_data_vld & dca_req_vld | ifu_lsu_warm_up) 
    dca_data[127:0] <= dc_icc_dcache_data[127:0];
end

assign dirty = |(icc_dirty[3:0] & way_sel[3:0]);
assign lsu_cp0_dcache_read_data_vld = icc_cur_dca_wb;
assign lsu_cp0_dcache_read_data[127:0] = dca_req_tag
                                       ? {88'b0, icc_tag[27:0], 9'b0, dirty, 1'b0, icc_tagvld}
                                       : dca_data[127:0];
//================================================
//  ICG
//================================================

assign icc_fsm_clk_en = icc_req_vld | dca_req_vld | !icc_cur_idle | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_icc_fsm_gated_clk"); @487
gated_clk_cell  x_icc_fsm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (icc_fsm_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (icc_fsm_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @488
//          .external_en (1'b0), @489
//          .global_en   (1'b1), @490
//          .module_en   (cp0_lsu_icg_en), @491
//          .local_en    (icc_fsm_clk_en), @492
//          .clk_out     (icc_fsm_clk)); @493

assign icc_clk_en =  icc_cur_dirty_wen | icc_cur_tag_wen | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_icc_dp_gated_clk"); @496
gated_clk_cell  x_icc_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (icc_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (icc_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @497
//          .external_en (1'b0), @498
//          .global_en   (1'b1), @499
//          .module_en   (cp0_lsu_icg_en), @500
//          .local_en    (icc_clk_en), @501
//          .clk_out     (icc_clk)); @502

assign icc_data_clk_en = icc_data_vld & dca_req_vld | ifu_lsu_warm_up; 
// &Instance("gated_clk_cell", "x_icc_data_gated_clk"); @505
gated_clk_cell  x_icc_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (icc_data_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (icc_data_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @506
//          .external_en (1'b0), @507
//          .global_en   (1'b1), @508
//          .module_en   (cp0_lsu_icg_en), @509
//          .local_en    (icc_data_clk_en), @510
//          .clk_out     (icc_data_clk)); @511

// &ModuleEnd; @520
endmodule


