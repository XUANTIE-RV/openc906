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
module aq_dtu_cdc(
  async_halt_req_wakeup,
  cp0_dtu_satp,
  cp0_yy_clk_en,
  cpurst_b,
  dscratch0,
  dtu_ifu_debug_inst,
  dtu_ifu_debug_inst_vld,
  dtu_ifu_halt_on_reset,
  dtu_rtu_async_halt_req,
  dtu_rtu_resume_req,
  dtu_rtu_sync_halt_req,
  dtu_tdt_dm_halted,
  dtu_tdt_dm_havereset,
  dtu_tdt_dm_itr_done,
  dtu_tdt_dm_retire_debug_expt_vld,
  dtu_tdt_dm_rx_data,
  dtu_tdt_dm_wr_ready,
  forever_cpuclk,
  latest_pc,
  pad_yy_icg_scan_en,
  rtu_dtu_retire_debug_expt_vld,
  rtu_dtu_retire_vld,
  rtu_yy_xx_dbgon,
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
  tdt_dm_wdata,
  tdt_dm_wr_flg,
  tdt_dm_wr_vld
);

// &Ports; @21
input   [63:0]  cp0_dtu_satp;                    
input           cp0_yy_clk_en;                   
input           cpurst_b;                        
input   [63:0]  dscratch0;                       
input           forever_cpuclk;                  
input   [39:0]  latest_pc;                       
input           pad_yy_icg_scan_en;              
input           rtu_dtu_retire_debug_expt_vld;   
input           rtu_dtu_retire_vld;              
input           rtu_yy_xx_dbgon;                 
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
output          async_halt_req_wakeup;           
output  [31:0]  dtu_ifu_debug_inst;              
output          dtu_ifu_debug_inst_vld;          
output          dtu_ifu_halt_on_reset;           
output          dtu_rtu_async_halt_req;          
output          dtu_rtu_resume_req;              
output          dtu_rtu_sync_halt_req;           
output          dtu_tdt_dm_halted;               
output          dtu_tdt_dm_havereset;            
output          dtu_tdt_dm_itr_done;             
output          dtu_tdt_dm_retire_debug_expt_vld; 
output  [63:0]  dtu_tdt_dm_rx_data;              
output          dtu_tdt_dm_wr_ready;             
output  [63:0]  tdt_dm_wdata;                    
output  [1 :0]  tdt_dm_wr_flg;                   
output          tdt_dm_wr_vld;                   

// &Regs; @22
reg     [1 :0]  cur_state;                       
reg             debug_inst_vld_pulse_f;          
reg     [63:0]  dm_rdata;                        
reg     [63:0]  dm_rdata_reg;                    
reg             dtu_havereset;                   
reg             dtu_rtu_async_halt_req_lvl_f;    
reg             dtu_rtu_async_halt_req_lvl_ff;   
reg             dtu_tdt_dm_wr_ready;             
reg     [31:0]  itr_reg;                         
reg     [1 :0]  next_state;                      
reg             rtu_yy_xx_dbgon_reg;             
reg     [63:0]  rx_data;                         
reg     [63:0]  tdt_dm_wdata;                    
reg     [1 :0]  tdt_dm_wr_flg;                   
reg             tdt_dm_wr_vld_f;                 
reg             tdt_dm_wr_vld_pulse_f;           

// &Wires; @23
wire            async_halt_req_wakeup;           
wire    [63:0]  cp0_dtu_satp;                    
wire            cp0_yy_clk_en;                   
wire            cpurst_b;                        
wire            debug_inst_vld_pulse;            
wire    [63:0]  dscratch0;                       
wire            dtu_cdc_clk;                     
wire    [31:0]  dtu_ifu_debug_inst;              
wire            dtu_ifu_debug_inst_vld;          
wire            dtu_ifu_halt_on_reset;           
wire            dtu_rtu_async_halt_req;          
wire            dtu_rtu_async_halt_req_lvl;      
wire            dtu_rtu_resume_req;              
wire            dtu_rtu_sync_halt_req;           
wire            dtu_tdt_dm_halted;               
wire            dtu_tdt_dm_havereset;            
wire            dtu_tdt_dm_itr_done;             
wire            dtu_tdt_dm_retire_debug_expt_vld; 
wire    [63:0]  dtu_tdt_dm_rx_data;              
wire            dtu_tdt_dm_wr_ready_pulse;       
wire            forever_cpuclk;                  
wire    [39:0]  latest_pc;                       
wire    [39:0]  latest_pc_for_dm;                
wire            pad_yy_icg_scan_en;              
wire            rtu_dtu_retire_debug_expt_vld;   
wire            rtu_dtu_retire_vld;              
wire            rtu_dtu_retire_vld_dbgon;        
wire            rtu_yy_xx_dbgon;                 
wire            sys_apb_clk;                     
wire            sys_apb_rst_b;                   
wire            tdt_dm_ack_havereset;            
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
wire            tdt_dm_wr_vld;                   
wire            tdt_dm_wr_vld_pulse;             


//XLEN
parameter XLEN = `TDT_DM_CORE_MAX_XLEN;

//state machine parameter
parameter IDLE       = 2'b00;
parameter PULSE      = 2'b01;
parameter HAVE_RESET = 2'b10;
parameter PENDING    = 2'b11;

//===============================================================
//                 CDC of DM to DTU 
//===============================================================
//tdt_dm_dtu_halt_req to dtu_rtu_sync_halt_req
// &Instance("aq_dtu_cdc_lvl","x_aq_tdt_dm_dtu_halt_req_cdc"); @39
aq_dtu_cdc_lvl  x_aq_tdt_dm_dtu_halt_req_cdc (
  .clk                   (forever_cpuclk       ),
  .dst_lvl               (dtu_rtu_sync_halt_req),
  .rst_n                 (cpurst_b             ),
  .src_lvl               (tdt_dm_dtu_halt_req  )
);

// &Connect(.clk      (forever_cpuclk), @40
//          .rst_n    (cpurst_b), @41
//          .src_lvl  (tdt_dm_dtu_halt_req), @42
//          .dst_lvl  (dtu_rtu_sync_halt_req)); @43

//tdt_dm_dtu_async_halt_req to dtu_rtu_async_halt_req
// &Instance("aq_dtu_cdc_lvl","x_aq_tdt_dm_dtu_async_halt_req_cdc"); @46
aq_dtu_cdc_lvl  x_aq_tdt_dm_dtu_async_halt_req_cdc (
  .clk                        (forever_cpuclk            ),
  .dst_lvl                    (dtu_rtu_async_halt_req_lvl),
  .rst_n                      (cpurst_b                  ),
  .src_lvl                    (tdt_dm_dtu_async_halt_req )
);

// &Connect(.clk      (forever_cpuclk), @47
//          .rst_n    (cpurst_b), @48
//          .src_lvl  (tdt_dm_dtu_async_halt_req), @49
//          .dst_lvl  (dtu_rtu_async_halt_req_lvl)); @50
always @(posedge forever_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      dtu_rtu_async_halt_req_lvl_f  <= 1'b0;
      dtu_rtu_async_halt_req_lvl_ff <= 1'b0;
    end
  else
    begin
      dtu_rtu_async_halt_req_lvl_f  <= dtu_rtu_async_halt_req_lvl;
      dtu_rtu_async_halt_req_lvl_ff <= dtu_rtu_async_halt_req_lvl_f;
    end
end

assign async_halt_req_wakeup  = dtu_rtu_async_halt_req_lvl && !dtu_rtu_async_halt_req_lvl_f;
assign dtu_rtu_async_halt_req = dtu_rtu_async_halt_req_lvl_f && !dtu_rtu_async_halt_req_lvl_ff;

//tdt_dm_dtu_halt_on_reset to dtu_ifu_halt_on_reset
// &Instance("aq_dtu_cdc_lvl","x_aq_tdt_dm_dtu_halt_on_reset_cdc"); @69
aq_dtu_cdc_lvl  x_aq_tdt_dm_dtu_halt_on_reset_cdc (
  .clk                      (dtu_cdc_clk             ),
  .dst_lvl                  (dtu_ifu_halt_on_reset   ),
  .rst_n                    (cpurst_b                ),
  .src_lvl                  (tdt_dm_dtu_halt_on_reset)
);

// &Connect(.clk      (dtu_cdc_clk), @70
//          .rst_n    (cpurst_b), @71
//          .src_lvl  (tdt_dm_dtu_halt_on_reset), @72
//          .dst_lvl  (dtu_ifu_halt_on_reset)); @73

//tdt_dm_dtu_resume_req(pulse) to dtu_rtu_resume_req(pulse)
// &Instance("aq_dtu_cdc_pulse","x_aq_dtu_rtu_resume_req_cdc"); @76
aq_dtu_cdc_pulse  x_aq_dtu_rtu_resume_req_cdc (
  .dst_clk               (dtu_cdc_clk          ),
  .dst_pulse             (dtu_rtu_resume_req   ),
  .dst_rstn              (cpurst_b             ),
  .src_clk               (sys_apb_clk          ),
  .src_pulse             (tdt_dm_dtu_resume_req),
  .src_rstn              (sys_apb_rst_b        )
);

// &Connect(.src_clk (sys_apb_clk), @77
//          .src_rstn (sys_apb_rst_b), @78
//          .dst_clk(dtu_cdc_clk), @79
//          .dst_rstn(cpurst_b), @80
//          .src_pulse(tdt_dm_dtu_resume_req), @81
//          .dst_pulse(dtu_rtu_resume_req)); @82

//tdt_dm_dtu_ack_havereset(pulse) to tdt_dm_ack_havereset(pulse)
// &Instance("aq_dtu_cdc_pulse","x_aq_tdt_dm_dtu_ack_havereset_cdc"); @85
aq_dtu_cdc_pulse  x_aq_tdt_dm_dtu_ack_havereset_cdc (
  .dst_clk                  (dtu_cdc_clk             ),
  .dst_pulse                (tdt_dm_ack_havereset    ),
  .dst_rstn                 (cpurst_b                ),
  .src_clk                  (sys_apb_clk             ),
  .src_pulse                (tdt_dm_dtu_ack_havereset),
  .src_rstn                 (sys_apb_rst_b           )
);

// &Connect(.src_clk (sys_apb_clk), @86
//          .src_rstn (sys_apb_rst_b), @87
//          .dst_clk(dtu_cdc_clk), @88
//          .dst_rstn(cpurst_b), @89
//          .src_pulse(tdt_dm_dtu_ack_havereset), @90
//          .dst_pulse(tdt_dm_ack_havereset)); @91

//tdt_dm_dtu_itr_vld(pulse) to dtu_ifu_debug_inst_vld(pulse)
//tdt_dm_dtu_itr(32 bit) to dtu_ifu_debug_inst(32 bit)
// &Instance("aq_dtu_cdc_pulse","x_aq_tdt_dm_dtu_itr_vld_cdc"); @95
aq_dtu_cdc_pulse  x_aq_tdt_dm_dtu_itr_vld_cdc (
  .dst_clk              (dtu_cdc_clk         ),
  .dst_pulse            (debug_inst_vld_pulse),
  .dst_rstn             (cpurst_b            ),
  .src_clk              (sys_apb_clk         ),
  .src_pulse            (tdt_dm_dtu_itr_vld  ),
  .src_rstn             (sys_apb_rst_b       )
);

// &Connect(.src_clk (sys_apb_clk), @96
//          .src_rstn (sys_apb_rst_b), @97
//          .dst_clk(dtu_cdc_clk), @98
//          .dst_rstn(cpurst_b), @99
//          .src_pulse(tdt_dm_dtu_itr_vld), @100
//          .dst_pulse(debug_inst_vld_pulse)); @101

always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_inst_vld_pulse_f <= 1'b0;
  else
    debug_inst_vld_pulse_f <= debug_inst_vld_pulse;
end
assign dtu_ifu_debug_inst_vld = debug_inst_vld_pulse_f;

always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    itr_reg[31:0] <= 32'b0;
  else if(debug_inst_vld_pulse)
    itr_reg[31:0] <= tdt_dm_dtu_itr[31:0];
end
assign dtu_ifu_debug_inst[31:0] = itr_reg[31:0];

//tdt_dm_dtu_wr_vld
//tdt_dm_dtu_wr_flg
//tdt_dm_dtu_wdata
// &Instance("aq_dtu_cdc_pulse","x_aq_tdt_dm_dtu_wr_vld_cdc"); @124
aq_dtu_cdc_pulse  x_aq_tdt_dm_dtu_wr_vld_cdc (
  .dst_clk             (dtu_cdc_clk        ),
  .dst_pulse           (tdt_dm_wr_vld_pulse),
  .dst_rstn            (cpurst_b           ),
  .src_clk             (sys_apb_clk        ),
  .src_pulse           (tdt_dm_dtu_wr_vld  ),
  .src_rstn            (sys_apb_rst_b      )
);

// &Connect(.src_clk (sys_apb_clk), @125
//          .src_rstn (sys_apb_rst_b), @126
//          .dst_clk(dtu_cdc_clk), @127
//          .dst_rstn(cpurst_b), @128
//          .src_pulse(tdt_dm_dtu_wr_vld), @129
//          .dst_pulse(tdt_dm_wr_vld_pulse)); @130

always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tdt_dm_wr_vld_pulse_f <= 1'b0;
  else
    tdt_dm_wr_vld_pulse_f <= tdt_dm_wr_vld_pulse;
end
assign tdt_dm_wr_vld = tdt_dm_wr_vld_pulse_f;
// &Force("output","tdt_dm_wr_vld"); @140
//when cpuclk = abp_clk, dtu_tdt_dm_wr_ready need wait dtu_tdt_dm_rx_data for a cycle
always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tdt_dm_wr_vld_f <= 1'b0;
  else
    tdt_dm_wr_vld_f <= tdt_dm_wr_vld;
end

always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tdt_dm_wr_flg[1:0] <= 2'b0;
  else if(tdt_dm_wr_vld_pulse)
    tdt_dm_wr_flg[1:0] <= tdt_dm_dtu_wr_flg[1:0];
end
// &Force("output","tdt_dm_wr_flg");&Force("bus","tdt_dm_wr_flg",1,0); @157

always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tdt_dm_wdata[XLEN-1:0] <= 64'b0;
  else if(tdt_dm_wr_vld_pulse)
    tdt_dm_wdata[XLEN-1:0] <= tdt_dm_dtu_wdata[XLEN-1:0];
end

//sample satp
//cp0_dtu_satp[XLEN-1:0];

//sample last_pc_for_dm
assign latest_pc_for_dm[`PA_WIDTH-1:0] = latest_pc[`PA_WIDTH-1:0];

//read data for dm
// &CombBeg; @178
always @( tdt_dm_wr_flg[1:0]
       or latest_pc_for_dm[39:0]
       or dscratch0[63:0]
       or cp0_dtu_satp[63:0])
begin
case(tdt_dm_wr_flg[1:0])
  2'b00:dm_rdata[XLEN-1:0] = dscratch0[XLEN-1:0];
  2'b01:dm_rdata[XLEN-1:0] = 64'b0;
  2'b10:dm_rdata[XLEN-1:0] = {{XLEN-`PA_WIDTH{1'b0}},latest_pc_for_dm[`PA_WIDTH-1:0]};
  2'b11:dm_rdata[XLEN-1:0] = cp0_dtu_satp[XLEN-1:0];
  default:dm_rdata[XLEN-1:0] = {64{1'bx}};
endcase
// &CombEnd; @186
end
always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      dm_rdata_reg[XLEN-1:0] <= 64'b0;
  else
      dm_rdata_reg[XLEN-1:0] <= dm_rdata[XLEN-1:0];
end

 //===============================================================
//                 CDC of DTU to DM 
//================================================================
//rtu_yy_xx_dbgon to dtu_tdt_dm_halted
always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      rtu_yy_xx_dbgon_reg <= 1'b0;
  else
      rtu_yy_xx_dbgon_reg <= rtu_yy_xx_dbgon;
end
// &Instance("aq_dtu_cdc_lvl","x_aq_dtu_tdt_dm_halted_cdc"); @206
aq_dtu_cdc_lvl  x_aq_dtu_tdt_dm_halted_cdc (
  .clk                 (sys_apb_clk        ),
  .dst_lvl             (dtu_tdt_dm_halted  ),
  .rst_n               (sys_apb_rst_b      ),
  .src_lvl             (rtu_yy_xx_dbgon_reg)
);

// &Connect(.clk      (sys_apb_clk), @207
//          .rst_n    (sys_apb_rst_b), @208
//          .src_lvl  (rtu_yy_xx_dbgon_reg), @209
//          .dst_lvl  (dtu_tdt_dm_halted)); @210

//rtu_dtu_retire_vld(pluse) to dtu_tdt_dm_itr_done(pluse)
assign rtu_dtu_retire_vld_dbgon = rtu_dtu_retire_vld && rtu_yy_xx_dbgon;
// &Instance("aq_dtu_cdc_pulse","x_aq_dtu_tdt_dm_itr_done_cdc"); @214
aq_dtu_cdc_pulse  x_aq_dtu_tdt_dm_itr_done_cdc (
  .dst_clk                  (sys_apb_clk             ),
  .dst_pulse                (dtu_tdt_dm_itr_done     ),
  .dst_rstn                 (sys_apb_rst_b           ),
  .src_clk                  (dtu_cdc_clk             ),
  .src_pulse                (rtu_dtu_retire_vld_dbgon),
  .src_rstn                 (cpurst_b                )
);

// &Connect(.src_clk (dtu_cdc_clk), @215
//          .src_rstn (cpurst_b), @216
//          .dst_clk(sys_apb_clk), @217
//          .dst_rstn(sys_apb_rst_b), @218
//          .src_pulse(rtu_dtu_retire_vld_dbgon), @219
//          .dst_pulse(dtu_tdt_dm_itr_done)); @220

//rtu_dtu_retire_debug_expt_vld(pulse) to dtu_tdt_dm_retire_debug_expt_vld(pulse)
// &Instance("aq_dtu_cdc_pulse","x_aq_dtu_tdt_dm_retire_debug_expt_vld_cdc"); @223
aq_dtu_cdc_pulse  x_aq_dtu_tdt_dm_retire_debug_expt_vld_cdc (
  .dst_clk                          (sys_apb_clk                     ),
  .dst_pulse                        (dtu_tdt_dm_retire_debug_expt_vld),
  .dst_rstn                         (sys_apb_rst_b                   ),
  .src_clk                          (dtu_cdc_clk                     ),
  .src_pulse                        (rtu_dtu_retire_debug_expt_vld   ),
  .src_rstn                         (cpurst_b                        )
);

// &Connect(.src_clk (dtu_cdc_clk), @224
//          .src_rstn (cpurst_b), @225
//          .dst_clk(sys_apb_clk), @226
//          .dst_rstn(sys_apb_rst_b), @227
//          .src_pulse(rtu_dtu_retire_debug_expt_vld), @228
//          .dst_pulse(dtu_tdt_dm_retire_debug_expt_vld)); @229

//dtu_tdt_dm_wr_ready
//dtu_tdt_dm_Rx_data
// &Instance("aq_dtu_cdc_pulse","x_aq_dtu_tdt_dm_wr_ready_cdc"); @233
aq_dtu_cdc_pulse  x_aq_dtu_tdt_dm_wr_ready_cdc (
  .dst_clk                   (sys_apb_clk              ),
  .dst_pulse                 (dtu_tdt_dm_wr_ready_pulse),
  .dst_rstn                  (sys_apb_rst_b            ),
  .src_clk                   (dtu_cdc_clk              ),
  .src_pulse                 (tdt_dm_wr_vld_f          ),
  .src_rstn                  (cpurst_b                 )
);

// &Connect(.src_clk (dtu_cdc_clk), @234
//          .src_rstn (cpurst_b), @235
//          .dst_clk(sys_apb_clk), @236
//          .dst_rstn(sys_apb_rst_b), @237
//          .src_pulse(tdt_dm_wr_vld_f), @238
//          .dst_pulse(dtu_tdt_dm_wr_ready_pulse)); @239

always @(posedge sys_apb_clk or negedge sys_apb_rst_b)
begin
  if(!sys_apb_rst_b)
      dtu_tdt_dm_wr_ready <= 1'b0;
  else
      dtu_tdt_dm_wr_ready <= dtu_tdt_dm_wr_ready_pulse;
end

always @(posedge sys_apb_clk or negedge sys_apb_rst_b)
begin
  if(!sys_apb_rst_b)
    rx_data[XLEN-1:0] <= 64'b0;
  else if(dtu_tdt_dm_wr_ready_pulse)
    rx_data[XLEN-1:0] <= dm_rdata_reg[XLEN-1:0];
end
assign dtu_tdt_dm_rx_data[XLEN-1:0] = rx_data[XLEN-1:0];

//generate dtu_tdt_dm_havereset(lvl) when cpurst_b switch to 1
always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

// &CombBeg; @267
always @( cur_state[1:0]
       or tdt_dm_ack_havereset)
begin
  case(cur_state[1:0])
    IDLE:        next_state[1:0]   = PULSE;
    PULSE:       next_state[1:0]   = HAVE_RESET;
    HAVE_RESET:  if(tdt_dm_ack_havereset)
                   next_state[1:0] = PENDING;
                 else
                   next_state[1:0] = HAVE_RESET;
    PENDING:     next_state[1:0]   = PENDING;
    default:     next_state[1:0]   = IDLE;
  endcase
// &CombEnd; @278
end

always @(posedge dtu_cdc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      dtu_havereset <= 1'b0;
  else
      dtu_havereset <= cur_state[1:0] == HAVE_RESET;
end

// &Instance("aq_dtu_cdc_lvl","x_aq_dtu_tdt_dm_havereset_cdc"); @288
aq_dtu_cdc_lvl  x_aq_dtu_tdt_dm_havereset_cdc (
  .clk                  (sys_apb_clk         ),
  .dst_lvl              (dtu_tdt_dm_havereset),
  .rst_n                (sys_apb_rst_b       ),
  .src_lvl              (dtu_havereset       )
);

// &Connect(.clk      (sys_apb_clk), @289
//          .rst_n    (sys_apb_rst_b), @290
//          .src_lvl  (dtu_havereset), @291
//          .dst_lvl  (dtu_tdt_dm_havereset)); @292

// &Force("output","dtu_rtu_resume_req"); @347
// &Force("output","dtu_ifu_debug_inst_vld"); @371
// &Force("output","tdt_dm_wr_vld"); @393
// &Force("output","tdt_dm_wr_flg");&Force("bus","tdt_dm_wr_flg",1,0); @410
// &CombBeg; @431
// &CombEnd; @439
// &Instance("aq_dtu_cdc_pulse_div_fast_to_slow","x_aq_dtu_tdt_dm_itr_done_cdc"); @468
// &Connect(.src_clk (dtu_cdc_clk), @469
//          .src_rstn (cpurst_b), @470
//          .clk_en(sys_apb_clk_en), @471
//          .modify(itr_done_modify), @472
//          .src_pulse(rtu_dtu_retire_vld_dbgon), @473
//          .dst_pulse(dtu_tdt_dm_itr_done)); @474
// &Force("nonport","itr_done_modify"); @475
// &Instance("aq_dtu_cdc_pulse_div_fast_to_slow","x_aq_dtu_tdt_dm_retire_debug_expt_vld_cdc"); @478
// &Connect(.src_clk (dtu_cdc_clk), @479
//          .src_rstn (cpurst_b), @480
//          .clk_en(sys_apb_clk_en), @481
//          .modify(retire_debug_expt_vld_modify), @482
//          .src_pulse(rtu_dtu_retire_debug_expt_vld), @483
//          .dst_pulse(dtu_tdt_dm_retire_debug_expt_vld)); @484
// &Force("nonport","retire_debug_expt_vld_modify"); @485
// &Instance("aq_dtu_cdc_pulse_div_fast_to_slow","x_aq_dtu_tdt_dm_wr_ready_cdc"); @489
// &Connect(.src_clk (dtu_cdc_clk), @490
//          .src_rstn (cpurst_b), @491
//          .clk_en(sys_apb_clk_en), @492
//          .modify(wr_ready_modify), @493
//          .src_pulse(tdt_dm_wr_vld_f), @494
//          .dst_pulse(dtu_tdt_dm_wr_ready)); @495
// &CombBeg; @515
// &CombEnd; @526

// &Instance("gated_clk_cell", "x_reg_gated_clk"); @545
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dtu_cdc_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (1'b1              ),
  .module_en          (1'b1              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @546
//          .external_en (1'b0), @547
//          .global_en   (cp0_yy_clk_en), @548
//          //.module_en   (cp0_dtu_icg_en), @549
//          .module_en   (1'b1), @550
//          .local_en    (1'b1), @551
//          .clk_out     (dtu_cdc_clk)); @552
// &ModuleEnd; @553
endmodule


