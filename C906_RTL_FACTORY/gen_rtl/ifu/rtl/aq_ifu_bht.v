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
module aq_ifu_bht(
  bht_pred_mem_taken,
  bht_pred_rslt,
  bht_top_cur_st,
  cp0_ifu_bht_en,
  cp0_ifu_bht_inv,
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ifu_cp0_bht_inv_done,
  iu_ifu_bht_cur_pc,
  iu_ifu_bht_mispred,
  iu_ifu_bht_mispred_gate,
  iu_ifu_bht_pred,
  iu_ifu_bht_taken,
  iu_ifu_br_vld,
  iu_ifu_br_vld_gate,
  pad_yy_icg_scan_en,
  pred_bht_br_vld,
  pred_bht_pc
);

// &Ports; @24
input           cp0_ifu_bht_en;         
input           cp0_ifu_bht_inv;        
input           cp0_ifu_icg_en;         
input           cp0_yy_clk_en;          
input           cpurst_b;               
input           forever_cpuclk;         
input   [39:0]  iu_ifu_bht_cur_pc;      
input           iu_ifu_bht_mispred;     
input           iu_ifu_bht_mispred_gate; 
input   [1 :0]  iu_ifu_bht_pred;        
input           iu_ifu_bht_taken;       
input           iu_ifu_br_vld;          
input           iu_ifu_br_vld_gate;     
input           pad_yy_icg_scan_en;     
input           pred_bht_br_vld;        
input   [2 :0]  pred_bht_pc;            
output          bht_pred_mem_taken;     
output  [1 :0]  bht_pred_rslt;          
output  [1 :0]  bht_top_cur_st;         
output          ifu_cp0_bht_inv_done;   

// &Regs; @25
reg             bht_bypass_sel;         
reg     [15:0]  bht_dout_bypass;        
reg     [15:0]  bht_dout_ff;            
reg     [13:0]  bht_ghr;                
reg     [9 :0]  bht_inv_cnt;            
reg     [1 :0]  bht_inv_cur_st;         
reg     [1 :0]  bht_inv_nxt_st;         
reg     [2 :0]  bht_ref_cur_st;         
reg     [2 :0]  bht_ref_nxt_st;         
reg     [1 :0]  bht_ref_val;            
reg     [13:0]  bht_ref_vghr;           
reg             bht_upd_en;             
reg     [1 :0]  bht_upd_val;            
reg     [13:0]  bht_vghr;               

// &Wires; @26
wire            bht_cen;                
wire            bht_cen_gate;           
wire            bht_clk;                
wire            bht_cur_idle;           
wire    [15:0]  bht_din;                
wire    [15:0]  bht_dout;               
wire    [15:0]  bht_dout_rslt;          
wire            bht_icg_en;             
wire    [9 :0]  bht_idx;                
wire            bht_inv_clk;            
wire            bht_inv_done;           
wire            bht_inv_icg_en;         
wire            bht_inv_ide;            
wire            bht_inv_rd;             
wire            bht_inv_req;            
wire            bht_inv_wr;             
wire    [2 :0]  bht_mem_idx;            
wire    [7 :0]  bht_mem_way;            
wire    [7 :0]  bht_mis_wen;            
wire            bht_miss_read1;         
wire            bht_miss_read2;         
wire            bht_miss_write;         
wire            bht_pred_mem_taken;     
wire    [1 :0]  bht_pred_rslt;          
wire            bht_pred_taken;         
wire    [1 :0]  bht_sel_result;         
wire    [7 :0]  bht_sel_way;            
wire    [1 :0]  bht_top_cur_st;         
wire    [2 :0]  bht_upd_idx;            
wire            bht_upd_vld;            
wire            bht_upd_write;          
wire    [15:0]  bht_wen;                
wire    [15:0]  bht_wr_val;             
wire    [1 :0]  bht_wr_val_single;      
wire            cp0_ifu_bht_en;         
wire            cp0_ifu_bht_inv;        
wire            cp0_ifu_icg_en;         
wire            cp0_yy_clk_en;          
wire            cpurst_b;               
wire            forever_cpuclk;         
wire            ifu_cp0_bht_inv_done;   
wire            iu_ifu_bht_mispred;     
wire            iu_ifu_bht_mispred_gate; 
wire    [1 :0]  iu_ifu_bht_pred;        
wire            iu_ifu_bht_taken;       
wire            iu_ifu_br_vld;          
wire            iu_ifu_br_vld_gate;     
wire            pad_yy_icg_scan_en;     
wire            pred_bht_br_vld;        


parameter IDX_WIDTH  = `BHT_INDEX_WIDTH;
parameter HIS_WIDTH  = `BHT_INDEX_WIDTH+4;
parameter DATA_WIDTH = 16;

// &Force("input", "pred_bht_pc"); @32
// &Force("bus", "pred_bht_pc", 2, 0); @33
// &Force("input", "iu_ifu_bht_cur_pc"); @34
// &Force("bus", "iu_ifu_bht_cur_pc", 39, 0); @35
//==========================================================
// Branch History Table Module
// 1. Instance ICG Cell
// 2. Implement GHR and VGHR
// 3. Implement BHT array
// 4. Generate Change Flow
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign bht_icg_en = pred_bht_br_vld
                 || iu_ifu_bht_mispred_gate
                 || cp0_ifu_bht_inv
                 || iu_ifu_br_vld_gate
                 || !bht_cur_idle;
// &Instance("gated_clk_cell", "x_aq_ifu_bht_icg_cell"); @52
gated_clk_cell  x_aq_ifu_bht_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bht_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bht_icg_en        ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @53
//          .external_en (1'b0), @54
//          .global_en   (cp0_yy_clk_en), @55
//          .module_en   (cp0_ifu_icg_en), @56
//          .local_en    (bht_icg_en), @57
//          .clk_out     (bht_clk), @58
// ); @59

assign bht_inv_icg_en = cp0_ifu_bht_inv 
                      | !bht_inv_ide;
// &Instance("gated_clk_cell", "x_aq_ifu_bht_inv_icg_cell"); @63
gated_clk_cell  x_aq_ifu_bht_inv_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bht_inv_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bht_inv_icg_en    ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @64
//          .external_en (1'b0), @65
//          .global_en   (cp0_yy_clk_en), @66
//          .module_en   (cp0_ifu_icg_en), @67
//          .local_en    (bht_inv_icg_en), @68
//          .clk_out     (bht_inv_clk), @69
// ); @70
//------------------------------------------------
// 2. Implement GHR and VGHR
//------------------------------------------------
always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_ghr[HIS_WIDTH-1:0] <= {HIS_WIDTH{1'b0}};
  else if(cp0_ifu_bht_inv)
    bht_ghr[HIS_WIDTH-1:0] <= {HIS_WIDTH{1'b0}};
  else if(iu_ifu_br_vld)
    bht_ghr[HIS_WIDTH-1:0] <= {bht_ghr[HIS_WIDTH-2:0], iu_ifu_bht_taken};
  else
    bht_ghr[HIS_WIDTH-1:0] <= bht_ghr[HIS_WIDTH-1:0];
end

always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_vghr[HIS_WIDTH-1:0] <= {HIS_WIDTH{1'b0}};
  else if(cp0_ifu_bht_inv)
    bht_vghr[HIS_WIDTH-1:0] <= {HIS_WIDTH{1'b0}};
  else if(iu_ifu_bht_mispred)
    bht_vghr[HIS_WIDTH-1:0] <= {bht_ghr[HIS_WIDTH-2:0], iu_ifu_bht_taken};
  else if(pred_bht_br_vld)
    bht_vghr[HIS_WIDTH-1:0] <= {bht_vghr[HIS_WIDTH-2:0], bht_pred_taken};
  else
    bht_vghr[HIS_WIDTH-1:0] <= bht_vghr[HIS_WIDTH-1:0];
end

//------------------------------------------------
// 3. Implement BHT array
// a. Generate BHT array Request
// b. Instance BHT memory array
// c. Select BHT Output
// d. BHT Invalid Request
// e. BHT Read Request After Miss-Pred
//------------------------------------------------

// a. Generate BHT array Request
// Chip Enable, WEN, Index, Data In
assign bht_cen      = bht_inv_req
                   || (pred_bht_br_vld
                   || bht_miss_read1
                   || bht_miss_read2
                   || bht_miss_write
                   || bht_upd_vld)
                      && cp0_ifu_bht_en;
assign bht_cen_gate = bht_inv_req
                   || (pred_bht_br_vld
                   || iu_ifu_br_vld_gate
                   || !bht_cur_idle)
                      && cp0_ifu_bht_en;

assign bht_mis_wen[7:0] = 8'b1 << bht_upd_idx[2:0];
assign bht_wen[15:0]  = bht_inv_wr ? 16'hffff
                      : bht_miss_write || bht_upd_vld ? {2{bht_mis_wen[7:0]}}
                      : 16'b0;

assign bht_din[15:0]  = {16{!bht_inv_req}} & bht_wr_val[15:0];

assign bht_idx[IDX_WIDTH-1:0] = bht_inv_req ? {IDX_WIDTH{bht_inv_wr}} & bht_inv_cnt[IDX_WIDTH-1:0]
                              : bht_miss_read1 ? bht_ghr[HIS_WIDTH-1:4]
                              : bht_miss_read2 ? bht_ghr[HIS_WIDTH-2:3]
                              : (bht_miss_write || bht_upd_vld) ? bht_ref_vghr[HIS_WIDTH-1:4]
                              : bht_vghr[HIS_WIDTH-3:2];

// b. Instance BHT memory array
// &Instance("aq_ifu_bht_array", "x_aq_ifu_bht_array"); @138
aq_ifu_bht_array  x_aq_ifu_bht_array (
  .bht_cen            (bht_cen           ),
  .bht_cen_gate       (bht_cen_gate      ),
  .bht_din            (bht_din           ),
  .bht_dout           (bht_dout          ),
  .bht_idx            (bht_idx           ),
  .bht_wen            (bht_wen           ),
  .cp0_ifu_icg_en     (cp0_ifu_icg_en    ),
  .cp0_yy_clk_en      (cp0_yy_clk_en     ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// c. Select BHT Output
always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_bypass_sel <= 1'b0;
  else if(bht_miss_write || bht_upd_vld)
    bht_bypass_sel <= 1'b1;
  else if(pred_bht_br_vld)
    bht_bypass_sel <= 1'b0;
end

always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_dout_bypass[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
  else if(bht_miss_write || bht_upd_vld)
    bht_dout_bypass[DATA_WIDTH-1:0] <= bht_dout[DATA_WIDTH-1:0];
end

assign bht_dout_rslt[DATA_WIDTH-1:0] = bht_bypass_sel ? bht_dout_bypass[DATA_WIDTH-1:0]
                                     : bht_dout[DATA_WIDTH-1:0];

always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_dout_ff[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
  else if(pred_bht_br_vld || bht_miss_read2)
    bht_dout_ff[DATA_WIDTH-1:0] <= bht_dout_rslt[DATA_WIDTH-1:0];
end
                     
assign bht_sel_way[7:0] = 8'b1 << bht_vghr[2:0];

assign bht_sel_result[1] = |(bht_sel_way[7:0] & bht_dout_ff[15:8]);
assign bht_sel_result[0] = |(bht_sel_way[7:0] & bht_dout_ff[7:0]);

assign bht_mem_idx[2:0] = {bht_vghr[1:0],bht_pred_taken};

assign bht_mem_way[7:0] = 8'b1 << bht_mem_idx[2:0];

assign bht_pred_mem_taken = |(bht_mem_way[7:0] & bht_dout_rslt[15:8]);

assign bht_pred_taken = bht_sel_result[1];

// d. BHT Invalid Request
parameter BHT_INV_IDLE = 2'b00;
parameter BHT_INV_WRTE = 2'b10;
parameter BHT_INV_READ = 2'b11;

// BHT Invalid FSM, for Array Invalid
// IDLE: default state
// WRTE: BHT invalid iteration state
// READ: BHT Read after invalid
always @ (posedge bht_inv_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_inv_cur_st[1:0] <= BHT_INV_IDLE;
  else
    bht_inv_cur_st[1:0] <= bht_inv_nxt_st[1:0];
end

// &CombBeg; @200
always @( bht_inv_cur_st[1:0]
       or cp0_ifu_bht_inv
       or bht_inv_done)
begin
case(bht_inv_cur_st[1:0])
  BHT_INV_IDLE:
  begin
    if(cp0_ifu_bht_inv)
      bht_inv_nxt_st[1:0] = BHT_INV_WRTE;
    else
      bht_inv_nxt_st[1:0] = BHT_INV_IDLE;
  end
  BHT_INV_WRTE:
  begin
    if(bht_inv_done)
      bht_inv_nxt_st[1:0] = BHT_INV_READ;
    else
      bht_inv_nxt_st[1:0] = BHT_INV_WRTE;
  end
  BHT_INV_READ:
  begin
    bht_inv_nxt_st[1:0] = BHT_INV_IDLE;
  end
  default:
  begin
    bht_inv_nxt_st[1:0] = BHT_INV_IDLE;
  end
endcase
// &CombEnd; @225
end

assign bht_inv_ide = bht_inv_cur_st[1:0] == BHT_INV_IDLE;
assign bht_inv_wr  = bht_inv_cur_st[1:0] == BHT_INV_WRTE;
assign bht_inv_rd  = bht_inv_cur_st[1:0] == BHT_INV_READ;
assign bht_inv_req = bht_inv_wr || bht_inv_rd;

always @ (posedge bht_inv_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_inv_cnt[IDX_WIDTH-1:0] <= {IDX_WIDTH{1'b0}};
  else if(bht_inv_wr)
    bht_inv_cnt[IDX_WIDTH-1:0] <= bht_inv_cnt[IDX_WIDTH-1:0] + 1'b1;
  else
    bht_inv_cnt[IDX_WIDTH-1:0] <= bht_inv_cnt[IDX_WIDTH-1:0];
end

assign bht_inv_done = bht_inv_cnt[IDX_WIDTH-1:0] == {IDX_WIDTH{1'b1}};

// e. BHT Read Request After Miss-Pred
// IDLE: default state, first read
// READ: BHT Second Read after Miss-Pred
// WRTE: BHT Write after Miss-Pred

parameter BHT_REF_IDLE  = 3'b000;
parameter BHT_REF_READ1 = 3'b001;
parameter BHT_REF_READ2 = 3'b010;
parameter BHT_REF_WRTE  = 3'b110;
parameter BHT_REF_UPD   = 3'b111;

always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_ref_cur_st[2:0] <= BHT_REF_IDLE;
  else
    bht_ref_cur_st[2:0] <= bht_ref_nxt_st[2:0];
end

// &CombBeg; @263
always @( bht_upd_en
       or iu_ifu_bht_mispred
       or bht_ref_cur_st[2:0]
       or iu_ifu_br_vld
       or pred_bht_br_vld)
begin
case(bht_ref_cur_st[2:0])
  BHT_REF_IDLE:
  begin
    if(iu_ifu_bht_mispred)
      bht_ref_nxt_st[2:0] = BHT_REF_READ1;
    else if(iu_ifu_br_vld && bht_upd_en)
      bht_ref_nxt_st[2:0] = BHT_REF_UPD;
    else
      bht_ref_nxt_st[2:0] = BHT_REF_IDLE;
  end
  BHT_REF_READ1:
  begin
    bht_ref_nxt_st[2:0] = BHT_REF_READ2;
  end
  BHT_REF_READ2:
  begin
    bht_ref_nxt_st[2:0] = BHT_REF_WRTE;
  end
  BHT_REF_WRTE:
  begin
    if(!pred_bht_br_vld)
      bht_ref_nxt_st[2:0] = BHT_REF_IDLE;
    else
      bht_ref_nxt_st[2:0] = BHT_REF_WRTE;
  end
  BHT_REF_UPD:
  begin
    if(!pred_bht_br_vld)
      bht_ref_nxt_st[2:0] = BHT_REF_IDLE;
    else
      bht_ref_nxt_st[2:0] = BHT_REF_UPD;
  end
  default:
  begin
    bht_ref_nxt_st[2:0] = BHT_REF_IDLE;
  end
endcase
// &CombEnd; @301
end

assign bht_cur_idle   = bht_ref_cur_st[2:0] == BHT_REF_IDLE;
assign bht_miss_read1 = bht_ref_cur_st[2:0] == BHT_REF_READ1;
assign bht_miss_read2 = bht_ref_cur_st[2:0] == BHT_REF_READ2;
assign bht_miss_write = bht_ref_cur_st[2:0] == BHT_REF_WRTE && !pred_bht_br_vld;
assign bht_upd_vld      = bht_ref_cur_st[2:0] == BHT_REF_UPD && !pred_bht_br_vld;
assign bht_upd_idx[2:0] = bht_ref_vghr[2:0];

// &CombBeg; @310
always @( iu_ifu_bht_taken
       or iu_ifu_bht_pred[1:0])
begin
case({iu_ifu_bht_pred[1:0], iu_ifu_bht_taken})
  3'b000: 
  begin
    bht_upd_en       = 1'b0;
    bht_upd_val[1:0] = 2'b00;
  end
  3'b001: 
  begin
    bht_upd_en       = 1'b1;
    bht_upd_val[1:0] = 2'b01;
  end
  3'b010: 
  begin
    bht_upd_en       = 1'b1;
    bht_upd_val[1:0] = 2'b00;
  end
  3'b011: 
  begin
    bht_upd_en       = 1'b1;
    bht_upd_val[1:0] = 2'b10;
  end
  3'b100: 
  begin
    bht_upd_en       = 1'b1;
    bht_upd_val[1:0] = 2'b01;
  end
  3'b101: 
  begin
    bht_upd_en       = 1'b1;
    bht_upd_val[1:0] = 2'b11;
  end
  3'b110: 
  begin
    bht_upd_en       = 1'b1;
    bht_upd_val[1:0] = 2'b10;
  end
  3'b111: 
  begin
    bht_upd_en       = 1'b0;
    bht_upd_val[1:0] = 2'b11;
  end
  default: 
  begin
    bht_upd_en       = 1'b0;
    bht_upd_val[1:0] = {2{1'bx}};
  end
endcase
// &CombEnd; @358
end

assign bht_upd_write  = bht_ref_cur_st[2:0] == BHT_REF_IDLE && iu_ifu_br_vld
                  && !iu_ifu_bht_mispred && bht_upd_en;
always @ (posedge bht_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    bht_ref_vghr[HIS_WIDTH-1:0] <= {(HIS_WIDTH){1'b0}};
    bht_ref_val[1:0]            <= 2'b0;
  end
  else if(iu_ifu_bht_mispred || bht_upd_write)
  begin
    bht_ref_vghr[HIS_WIDTH-1:0] <= bht_ghr[HIS_WIDTH-1:0];
    bht_ref_val[1:0]            <= bht_upd_val[1:0];
  end
  else
  begin
    bht_ref_vghr[HIS_WIDTH-1:0] <= bht_ref_vghr[HIS_WIDTH-1:0];
    bht_ref_val[1:0]            <= bht_ref_val[1:0];
  end
end

assign bht_wr_val_single[1:0] = bht_ref_val[1:0];
assign bht_wr_val[15:0]       = {{8{bht_wr_val_single[1]}}, {8{bht_wr_val_single[0]}}};

//==========================================================
// Rename for Output
//==========================================================
// Output to top
assign bht_top_cur_st[1:0] = bht_ref_cur_st[1:0];

// Output to id prediction
assign bht_pred_rslt[1:0] = bht_sel_result[1:0];
assign ifu_cp0_bht_inv_done = bht_inv_done;


// &ModuleEnd; @419
endmodule


