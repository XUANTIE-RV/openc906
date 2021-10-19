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

// &Depend("aq_dtu_cfig.h"); @18
// &Depend("cpu_cfig.h"); @19

// &ModuleBeg; @21
module aq_lsu_dtif(
  ag_dtu_addr,
  ag_dtu_addr_ready,
  ag_dtu_amo_type,
  ag_dtu_bytes_vld,
  ag_dtu_data,
  ag_dtu_data_chk_mask,
  ag_dtu_data_vld,
  ag_dtu_halt_info,
  ag_dtu_mem_access_size,
  ag_dtu_pipe_down,
  ag_dtu_req,
  ag_dtu_req_gate,
  ag_dtu_split_last,
  ag_dtu_st_type,
  cp0_lsu_icg_en,
  cpurst_b,
  da_dtu_data,
  da_dtu_data_vld,
  dtif_ag_cmplt_ready,
  dtif_ag_fsm_idle,
  dtif_ag_halt_info,
  dtif_ag_halt_info_up,
  dtif_ag_pipedown_mask,
  dtif_ag_stall,
  dtif_ag_trig_en,
  dtu_lsu_addr_trig_en,
  dtu_lsu_data_trig_en,
  dtu_lsu_halt_info,
  dtu_lsu_halt_info_vld,
  forever_cpuclk,
  ifu_lsu_warm_up,
  lsu_dtu_halt_info,
  lsu_dtu_last_check,
  lsu_dtu_ldst_addr,
  lsu_dtu_ldst_addr_vld,
  lsu_dtu_ldst_bytes_vld,
  lsu_dtu_ldst_data,
  lsu_dtu_ldst_data_vld,
  lsu_dtu_ldst_type,
  lsu_dtu_mem_access_size,
  pad_yy_icg_scan_en,
  rtu_yy_xx_flush,
  vlsu_dtu_data,
  vlsu_dtu_data_vld,
  vlsu_dtu_data_vld_gate
);

// &Ports; @22
input   [39:0]  ag_dtu_addr;            
input           ag_dtu_addr_ready;      
input           ag_dtu_amo_type;        
input   [15:0]  ag_dtu_bytes_vld;       
input   [63:0]  ag_dtu_data;            
input           ag_dtu_data_chk_mask;   
input           ag_dtu_data_vld;        
input   [21:0]  ag_dtu_halt_info;       
input   [2 :0]  ag_dtu_mem_access_size; 
input           ag_dtu_pipe_down;       
input           ag_dtu_req;             
input           ag_dtu_req_gate;        
input           ag_dtu_split_last;      
input           ag_dtu_st_type;         
input           cp0_lsu_icg_en;         
input           cpurst_b;               
input   [63:0]  da_dtu_data;            
input           da_dtu_data_vld;        
input           dtu_lsu_addr_trig_en;   
input           dtu_lsu_data_trig_en;   
input   [21:0]  dtu_lsu_halt_info;      
input           dtu_lsu_halt_info_vld;  
input           forever_cpuclk;         
input           ifu_lsu_warm_up;        
input           pad_yy_icg_scan_en;     
input           rtu_yy_xx_flush;        
input   [63:0]  vlsu_dtu_data;          
input           vlsu_dtu_data_vld;      
input           vlsu_dtu_data_vld_gate; 
output          dtif_ag_cmplt_ready;    
output          dtif_ag_fsm_idle;       
output  [21:0]  dtif_ag_halt_info;      
output          dtif_ag_halt_info_up;   
output          dtif_ag_pipedown_mask;  
output          dtif_ag_stall;          
output          dtif_ag_trig_en;        
output  [21:0]  lsu_dtu_halt_info;      
output          lsu_dtu_last_check;     
output  [39:0]  lsu_dtu_ldst_addr;      
output          lsu_dtu_ldst_addr_vld;  
output  [15:0]  lsu_dtu_ldst_bytes_vld; 
output  [63:0]  lsu_dtu_ldst_data;      
output          lsu_dtu_ldst_data_vld;  
output  [1 :0]  lsu_dtu_ldst_type;      
output  [2 :0]  lsu_dtu_mem_access_size; 

// &Regs; @23
reg             dt_addr_chk_last_ff;    
reg     [39:0]  dt_addr_ff;             
reg     [15:0]  dt_bytes_vld_ff;        
reg     [2 :0]  dt_cur_state;           
reg             dt_data_chk_last_ff;    
reg     [63:0]  dt_data_ff;             
reg     [2 :0]  dt_next_state;          
reg             dt_rdata_vld;           
reg             dt_wait_state;          

// &Wires; @24
wire            addr_chk_en;            
wire            addr_trig_en;           
wire    [39:0]  ag_dtu_addr;            
wire            ag_dtu_addr_ready;      
wire            ag_dtu_amo_type;        
wire    [15:0]  ag_dtu_bytes_vld;       
wire    [63:0]  ag_dtu_data;            
wire            ag_dtu_data_chk_mask;   
wire            ag_dtu_data_vld;        
wire    [21:0]  ag_dtu_halt_info;       
wire    [2 :0]  ag_dtu_mem_access_size; 
wire            ag_dtu_pipe_down;       
wire            ag_dtu_req;             
wire            ag_dtu_req_gate;        
wire            ag_dtu_split_last;      
wire            ag_dtu_st_type;         
wire            cp0_lsu_icg_en;         
wire            cpurst_b;               
wire    [63:0]  da_dtu_data;            
wire            da_dtu_data_vld;        
wire            data_chk_en;            
wire            data_trig_en;           
wire            dt_addr_clk;            
wire            dt_addr_clk_en;         
wire    [1 :0]  dt_addr_ldst_type;      
wire            dt_addr_req;            
wire            dt_addr_start;          
wire            dt_cmplt_ready;         
wire            dt_data_clk;            
wire            dt_data_clk_en;         
wire    [1 :0]  dt_data_ldst_type;      
wire            dt_data_req;            
wire            dt_data_start;          
wire            dt_data_vld;            
wire            dt_fsm_addr_chk;        
wire            dt_fsm_chk;             
wire            dt_fsm_clk;             
wire            dt_fsm_clk_en;          
wire            dt_fsm_data_chk;        
wire            dt_fsm_idle;            
wire            dt_fsm_wait_cmplt;      
wire            dt_fsm_wait_data;       
wire            dt_last_check;          
wire    [1 :0]  dt_ldst_type;           
wire            dt_pipedown_mask;       
wire            dt_stall;               
wire            dt_start_gate;          
wire            dtif_ag_cmplt_ready;    
wire            dtif_ag_fsm_idle;       
wire    [21:0]  dtif_ag_halt_info;      
wire            dtif_ag_halt_info_up;   
wire            dtif_ag_pipedown_mask;  
wire            dtif_ag_stall;          
wire            dtif_ag_trig_en;        
wire            dtu_cancel;             
wire            dtu_halt_info_vld;      
wire            dtu_lsu_addr_trig_en;   
wire            dtu_lsu_data_trig_en;   
wire    [21:0]  dtu_lsu_halt_info;      
wire            dtu_lsu_halt_info_vld;  
wire            forever_cpuclk;         
wire    [21:0]  halt_info;              
wire            ifu_lsu_warm_up;        
wire    [39:0]  lsu_addr;               
wire            lsu_addr_chk_last;      
wire            lsu_addr_up;            
wire            lsu_addr_vld;           
wire            lsu_addr_vld_gate;      
wire            lsu_amo_type;           
wire    [15:0]  lsu_bytes_vld;          
wire    [63:0]  lsu_data;               
wire            lsu_data_chk_last;      
wire            lsu_data_chk_mask;      
wire            lsu_data_up;            
wire            lsu_data_vld;           
wire            lsu_data_vld_gate;      
wire    [21:0]  lsu_dtu_halt_info;      
wire            lsu_dtu_last_check;     
wire    [39:0]  lsu_dtu_ldst_addr;      
wire            lsu_dtu_ldst_addr_vld;  
wire    [15:0]  lsu_dtu_ldst_bytes_vld; 
wire    [63:0]  lsu_dtu_ldst_data;      
wire            lsu_dtu_ldst_data_vld;  
wire    [1 :0]  lsu_dtu_ldst_type;      
wire    [2 :0]  lsu_dtu_mem_access_size; 
wire    [21:0]  lsu_halt_info;          
wire    [2 :0]  lsu_mem_access_size;    
wire            lsu_pipe_down;          
wire            lsu_req;                
wire            lsu_req_gate;           
wire            lsu_split_last;         
wire            lsu_st_type;            
wire            pad_yy_icg_scan_en;     
wire            rtu_yy_xx_flush;        
wire    [63:0]  vlsu_dtu_data;          
wire            vlsu_dtu_data_vld;      
wire            vlsu_dtu_data_vld_gate; 


parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;
//================================================
//        input interface
//================================================
//------------------from dtu----------------------
assign halt_info[`TDT_HINFO_WIDTH-1:0] = dtu_lsu_halt_info[`TDT_HINFO_WIDTH-1:0]; 

assign addr_trig_en = dtu_lsu_addr_trig_en;
assign data_trig_en = dtu_lsu_data_trig_en;

//for timing
assign dtu_halt_info_vld = dtu_lsu_halt_info_vld;

//------------------from lsu----------------------
//req info
assign lsu_req                 = ag_dtu_req;
assign lsu_req_gate            = ag_dtu_req_gate;
assign lsu_addr_vld            = ag_dtu_req && ag_dtu_addr_ready;
assign lsu_addr_vld_gate       = ag_dtu_req_gate;
assign lsu_data_vld            = ag_dtu_data_vld || da_dtu_data_vld || vlsu_dtu_data_vld;
assign lsu_data_vld_gate       = ag_dtu_data_vld || da_dtu_data_vld || vlsu_dtu_data_vld_gate; 

assign lsu_addr[`PA_WIDTH-1:0] = ag_dtu_addr[`PA_WIDTH-1:0];
assign lsu_bytes_vld[15:0]     = ag_dtu_bytes_vld[15:0];   

assign lsu_data[63:0]    = da_dtu_data_vld
                           ? da_dtu_data[63:0]
                           : ag_dtu_data_vld
                             ? ag_dtu_data[63:0]
                             : vlsu_dtu_data[63:0];

assign lsu_halt_info[`TDT_HINFO_WIDTH-1:0] = ag_dtu_halt_info[`TDT_HINFO_WIDTH-1:0];

//lsu inst info
assign lsu_st_type              = ag_dtu_st_type;
assign lsu_amo_type             = ag_dtu_amo_type;
assign lsu_mem_access_size[2:0] = ag_dtu_mem_access_size[2:0];
assign lsu_split_last           = ag_dtu_split_last;
assign lsu_data_chk_mask        = ag_dtu_data_chk_mask;

//cmplt and pipe info
assign lsu_pipe_down   = ag_dtu_pipe_down; 

//================================================
//        ICG
//================================================
assign dt_fsm_clk_en = dt_start_gate || !dt_fsm_idle;

// &Instance("gated_clk_cell", "x_aq_lsu_dtif_fsm_gated_clk"); @77
gated_clk_cell  x_aq_lsu_dtif_fsm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dt_fsm_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dt_fsm_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @78
//          .external_en (1'b0), @79
//          .global_en   (1'b1), @80
//          .module_en   (cp0_lsu_icg_en), @81
//          .local_en    (dt_fsm_clk_en), @82
//          .clk_out     (dt_fsm_clk)); @83

assign dt_addr_clk_en = dt_fsm_idle && lsu_addr_vld_gate
                        || ifu_lsu_warm_up;

// &Instance("gated_clk_cell", "x_aq_lsu_dtif_addr_gated_clk"); @88
gated_clk_cell  x_aq_lsu_dtif_addr_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dt_addr_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dt_addr_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @89
//          .external_en (1'b0), @90
//          .global_en   (1'b1), @91
//          .module_en   (cp0_lsu_icg_en), @92
//          .local_en    (dt_addr_clk_en), @93
//          .clk_out     (dt_addr_clk)); @94

assign dt_data_clk_en = dt_fsm_wait_data && lsu_data_vld_gate
                        || ifu_lsu_warm_up;

// &Instance("gated_clk_cell", "x_aq_lsu_dtif_data_gated_clk"); @99
gated_clk_cell  x_aq_lsu_dtif_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dt_data_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dt_data_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @100
//          .external_en (1'b0), @101
//          .global_en   (1'b1), @102
//          .module_en   (cp0_lsu_icg_en), @103
//          .local_en    (dt_data_clk_en), @104
//          .clk_out     (dt_data_clk)); @105

//================================================
//        FSM
//================================================
parameter IDLE       = 3'b000;
parameter ADDR_CHK   = 3'b001;
parameter DATA_CHK   = 3'b010;
parameter WAIT_DATA  = 3'b011;
parameter WAIT_PIPE  = 3'b100;
parameter WAIT_CMPLT = 3'b101;

always@(posedge dt_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dt_cur_state[2:0] <= IDLE;
  else if (rtu_yy_xx_flush)
    dt_cur_state[2:0] <= IDLE;
  else
    dt_cur_state[2:0] <= dt_next_state[2:0];
end

// &CombBeg; @127
always @( lsu_st_type
       or dt_data_vld
       or lsu_pipe_down
       or dtu_cancel
       or lsu_data_vld
       or dt_cur_state[2:0]
       or dt_addr_start
       or lsu_split_last
       or data_chk_en
       or dt_data_start)
begin
  case(dt_cur_state[2:0])
  IDLE:begin
    if (dt_addr_start)
      dt_next_state[2:0] = ADDR_CHK;
    else if (dt_data_start && lsu_st_type)
      dt_next_state[2:0] = WAIT_DATA;
    else if (dt_data_start && !lsu_st_type)
      dt_next_state[2:0] = WAIT_PIPE;
    else
      dt_next_state[2:0] = IDLE;
  end
  ADDR_CHK:begin
    if (dt_data_vld && lsu_split_last && !data_chk_en || dtu_cancel)
      dt_next_state[2:0] = WAIT_CMPLT;
    else if (dt_data_vld && data_chk_en && lsu_st_type) 
      dt_next_state[2:0] = WAIT_DATA;
    else if(dt_data_vld)
      dt_next_state[2:0] = WAIT_PIPE;
    else 
      dt_next_state[2:0] = ADDR_CHK;
  end
  DATA_CHK:begin
    if (dt_data_vld && lsu_split_last || dtu_cancel)
      dt_next_state[2:0] = WAIT_CMPLT;
    else if(dt_data_vld)
      dt_next_state[2:0] = WAIT_PIPE;
    else 
      dt_next_state[2:0] = DATA_CHK;
  end
  WAIT_DATA:begin
    if (lsu_data_vld)
      dt_next_state[2:0] = DATA_CHK;
    else
      dt_next_state[2:0] = WAIT_DATA;
  end
  WAIT_PIPE:begin
    if (lsu_pipe_down && !lsu_st_type && data_chk_en)
      dt_next_state[2:0] = WAIT_DATA;
    else if (lsu_pipe_down)
      dt_next_state[2:0] = IDLE;
    else
      dt_next_state[2:0] = WAIT_PIPE;
  end
  WAIT_CMPLT:begin
    if (lsu_pipe_down)
      dt_next_state[2:0] = IDLE;
    else
      dt_next_state[2:0] = WAIT_CMPLT;
  end
  default:dt_next_state[2:0] = IDLE;
  endcase
// &CombEnd; @179
end
//================================================
//        FSM ctrl
//================================================
//fsm start
//for lsu split inst,should check addr multi,but data only once
//ld chk at last split while st chk at first split
//for vector,not check data for current model
assign data_chk_en = data_trig_en && !lsu_data_chk_mask;
assign addr_chk_en = addr_trig_en;

assign dt_addr_start = lsu_addr_vld && addr_chk_en;
assign dt_data_start = lsu_req && data_chk_en && !addr_chk_en;

assign dt_start_gate = lsu_req_gate && (addr_trig_en || data_trig_en); 

//check
assign dtu_cancel   = dtu_halt_info_vld && halt_info[`TDT_HINFO_CANCEL];

//================================================
//        FSM output
//================================================
assign dt_fsm_idle       = (dt_cur_state[2:0] == IDLE);
assign dt_fsm_addr_chk   = (dt_cur_state[2:0] == ADDR_CHK);
assign dt_fsm_data_chk   = (dt_cur_state[2:0] == DATA_CHK);
assign dt_fsm_wait_data  = (dt_cur_state[2:0] == WAIT_DATA);
assign dt_fsm_wait_cmplt = (dt_cur_state[2:0] == WAIT_CMPLT);

//---------for lsu ag--------------------
assign dt_stall = dt_fsm_idle 
                     && lsu_req_gate
                     && (addr_chk_en || data_chk_en)
                  || dt_fsm_addr_chk
                  || dt_fsm_data_chk
                  || dt_fsm_wait_data;

assign dt_cmplt_ready = dt_fsm_wait_cmplt;

//for ld data check,we must pipedown first then cmplt
//hence we need pipedown_mask here
assign dt_pipedown_mask = dt_fsm_wait_cmplt
                          && data_chk_en 
                          && !lsu_st_type;

//---------for dtu-----------------------
//for timing,flop addr and data before req
assign lsu_addr_up = dt_fsm_idle && dt_addr_start;   
assign lsu_data_up = dt_fsm_wait_data && lsu_data_vld;

assign lsu_addr_chk_last = lsu_split_last && !data_chk_en;
assign lsu_data_chk_last = !addr_chk_en || !lsu_st_type || lsu_split_last;

always@(posedge dt_addr_clk)
begin
  if (lsu_addr_up || ifu_lsu_warm_up)
  begin
    dt_addr_ff[`PA_WIDTH-1:0]      <= lsu_addr[`PA_WIDTH-1:0];
    dt_bytes_vld_ff[15:0]          <= lsu_bytes_vld[15:0];
    dt_addr_chk_last_ff            <= lsu_addr_chk_last;
  end
end

always@(posedge dt_data_clk)
begin
  if (lsu_data_up || ifu_lsu_warm_up)
  begin
    dt_rdata_vld         <= da_dtu_data_vld;
    dt_data_ff[63:0]     <= lsu_data[63:0];
    dt_data_chk_last_ff  <= lsu_data_chk_last;
  end
end

//for timing,use dtu halt_info_vld to indicate 1 or more cycles
assign dt_fsm_chk = dt_fsm_addr_chk || dt_fsm_data_chk;

always@(posedge dt_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dt_wait_state <= 1'b0;
  else if(rtu_yy_xx_flush || dt_fsm_chk && dtu_halt_info_vld)
    dt_wait_state <= 1'b0;
  else if (dt_fsm_chk && !dtu_halt_info_vld)
    dt_wait_state <= 1'b1;
end

assign dt_data_vld = dtu_halt_info_vld; 

//req ctrl
assign dt_addr_req = dt_fsm_addr_chk && !dt_wait_state;  
assign dt_data_req = dt_fsm_data_chk && !dt_wait_state;

//for amo,when req addr,should use both ldst type
//when req data,should check st or ld data seperately  
assign dt_addr_ldst_type[1:0] = lsu_amo_type
                                ? 2'b11
                                : {!lsu_st_type,lsu_st_type};

assign dt_data_ldst_type[1:0] = {dt_rdata_vld,!dt_rdata_vld};

assign dt_ldst_type[1:0] = dt_addr_req
                           ? dt_addr_ldst_type[1:0]
                           : dt_data_ldst_type[1:0];

//for dtu match maintenance
assign dt_last_check = dt_addr_req
                          && dt_addr_chk_last_ff 
                       || dt_data_req
                          && dt_data_chk_last_ff;

//================================================
//        output interface
//================================================
//------------------for ag ctrl-------------------
//cmplt/pipe stall
assign dtif_ag_stall         = dt_stall; 
assign dtif_ag_cmplt_ready   = dt_cmplt_ready;
assign dtif_ag_fsm_idle      = dt_fsm_idle;
assign dtif_ag_pipedown_mask = dt_pipedown_mask;

//half info
assign dtif_ag_halt_info_up                    = (dt_fsm_addr_chk || dt_fsm_data_chk)
                                                 && dt_data_vld;
assign dtif_ag_halt_info[`TDT_HINFO_WIDTH-1:0] = halt_info[`TDT_HINFO_WIDTH-1:0];

//other
//trig_en prevent fast cmplt
assign dtif_ag_trig_en = addr_chk_en || data_chk_en;

//------------------for dtu-----------------------
assign lsu_dtu_ldst_addr_vld            = dt_addr_req;
assign lsu_dtu_ldst_type[1:0]           = dt_ldst_type[1:0];
assign lsu_dtu_ldst_addr[`PA_WIDTH-1:0] = dt_addr_ff[`PA_WIDTH-1:0];
assign lsu_dtu_ldst_bytes_vld[15:0]     = dt_bytes_vld_ff[15:0];
assign lsu_dtu_mem_access_size[2:0]     = lsu_mem_access_size[2:0];
assign lsu_dtu_ldst_data_vld            = dt_data_req;
assign lsu_dtu_ldst_data[63:0]          = dt_data_ff[63:0];
assign lsu_dtu_last_check               = dt_last_check;

assign lsu_dtu_halt_info[`TDT_HINFO_WIDTH-1:0] = lsu_halt_info[`TDT_HINFO_WIDTH-1:0]; 


// &ModuleEnd; @320
endmodule


