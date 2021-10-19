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

// &Depend("aq_idu_cfig.h"); @23
// &ModuleBeg; @24
module aq_vidu_vid_split_fp(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_split_fp_dis_stall,
  forever_cpuclk,
  idu_vidu_ex1_fp_dp_sel,
  idu_vidu_ex1_fp_gateclk_sel,
  idu_vidu_ex1_fp_sel,
  idu_vidu_ex1_inst_data,
  ifu_vidu_warm_up,
  pad_yy_icg_scan_en,
  rtu_yy_xx_async_flush,
  split_fp_ctrl_entry_vld,
  split_fp_ctrl_inst_dp_vld,
  split_fp_ctrl_inst_gateclk_vld,
  split_fp_ctrl_inst_vld,
  split_fp_dp_inst_data
);

// &Ports; @25
input            cp0_idu_icg_en;                
input            cp0_yy_clk_en;                 
input            cpurst_b;                      
input            ctrl_split_fp_dis_stall;       
input            forever_cpuclk;                
input            idu_vidu_ex1_fp_dp_sel;        
input            idu_vidu_ex1_fp_gateclk_sel;   
input            idu_vidu_ex1_fp_sel;           
input   [179:0]  idu_vidu_ex1_inst_data;        
input            ifu_vidu_warm_up;              
input            pad_yy_icg_scan_en;            
input            rtu_yy_xx_async_flush;         
output           split_fp_ctrl_entry_vld;       
output           split_fp_ctrl_inst_dp_vld;     
output           split_fp_ctrl_inst_gateclk_vld; 
output           split_fp_ctrl_inst_vld;        
output  [179:0]  split_fp_dp_inst_data;         

// &Regs; @26
reg     [0  :0]  non_cur_state;                 
reg              non_next_state;                
reg     [179:0]  split_buf_inst_data;           

// &Wires; @27
wire             cp0_idu_icg_en;                
wire             cp0_yy_clk_en;                 
wire             cpurst_b;                      
wire             ctrl_split_fp_dis_stall;       
wire             forever_cpuclk;                
wire             idu_vidu_ex1_fp_dp_sel;        
wire             idu_vidu_ex1_fp_gateclk_sel;   
wire             idu_vidu_ex1_fp_sel;           
wire    [179:0]  idu_vidu_ex1_inst_data;        
wire             ifu_vidu_warm_up;              
wire             non_entry_vld;                 
wire    [179:0]  non_inst_data;                 
wire             non_inst_data_wen;             
wire             non_inst_vld;                  
wire             non_sm_start;                  
wire             non_split_type;                
wire             pad_yy_icg_scan_en;            
wire             rtu_yy_xx_async_flush;         
wire             split_clk;                     
wire             split_clk_en;                  
wire             split_fp_ctrl_entry_vld;       
wire             split_fp_ctrl_inst_dp_vld;     
wire             split_fp_ctrl_inst_gateclk_vld; 
wire             split_fp_ctrl_inst_vld;        
wire    [179:0]  split_fp_dp_inst_data;         
wire             split_fp_entry_vld;            
wire             split_fp_inst_vld;             
wire    [179:0]  split_inst_data;               
wire             split_inst_data_wen;           
wire    [179:0]  split_inst_wdata;              


//==========================================================
//                Spliter Instruction Data
//==========================================================
//----------------------------------------------------------
//                   inst data buffer
//----------------------------------------------------------
always @(posedge split_clk)
begin
  if(ifu_vidu_warm_up || split_inst_data_wen)
    split_buf_inst_data[`DIS_VEC_WIDTH-1:0] <= split_inst_wdata[`DIS_VEC_WIDTH-1:0];
  else
    split_buf_inst_data[`DIS_VEC_WIDTH-1:0] <= split_buf_inst_data[`DIS_VEC_WIDTH-1:0];
end

//----------------------------------------------------------
//          select between buf data and input data
//----------------------------------------------------------
assign split_inst_data[`DIS_VEC_WIDTH-1:0] =
         split_fp_entry_vld ? split_buf_inst_data[`DIS_VEC_WIDTH-1:0]
                            : idu_vidu_ex1_inst_data[`DIS_VEC_WIDTH-1:0];

//==========================================================
//                 non-split instructions
//==========================================================
//----------------------------------------------------------
//                   non split inst
//----------------------------------------------------------
assign non_split_type =
  (split_inst_data[`DIS_VEC_SPLIT_TYPE:`DIS_VEC_SPLIT_TYPE-3] == `VEC_SPLIT_NON);

//----------------------------------------------------------
//           non split variables initial value
//----------------------------------------------------------
assign non_sm_start   = idu_vidu_ex1_fp_sel
                        && non_split_type;

//----------------------------------------------------------
//              FSM of inst non ctrl logic
//----------------------------------------------------------
// State Description:
// NON_IDLE  : id stage instruction 0 is not non inst
//            (non) or the first cycle to start non FSM
// NON_SPLIT : the non instruction is spliting
// lsb should encode for not IDLE state
parameter NON_IDLE  = 1'b0;
parameter NON_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    non_cur_state <= NON_IDLE;
  else if(rtu_yy_xx_async_flush)
    non_cur_state <= NON_IDLE;
  else
    non_cur_state <= non_next_state;
end

// &CombBeg; @86
always @( ctrl_split_fp_dis_stall
       or non_cur_state
       or non_sm_start)
begin
  case(non_cur_state)
  NON_IDLE  : if(non_sm_start && ctrl_split_fp_dis_stall)
                non_next_state = NON_SPLIT;
              else
                non_next_state = NON_IDLE;
  NON_SPLIT : if(!ctrl_split_fp_dis_stall)
                non_next_state = NON_IDLE;
              else
                non_next_state = NON_SPLIT;
  default   :   non_next_state = NON_IDLE;
  endcase
// &CombEnd; @98
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign non_inst_vld      = 1'b1;

assign non_entry_vld     = non_cur_state[0];

assign non_inst_data_wen = (non_cur_state == NON_IDLE)
                           && non_sm_start && ctrl_split_fp_dis_stall;

//----------------------------------------------------------
//               Split Instruction : non
//----------------------------------------------------------
//split inst: hold original inst data
assign non_inst_data[`DIS_VEC_WIDTH-1:0] = split_inst_data[`DIS_VEC_WIDTH-1:0];

////----------------------------------------------------------
////               Split Instruction: store
////----------------------------------------------------------
////split inst 0: sw/sd/swu rs2,(rs1),sign_ext(imm5<<imm2)
////split inst 1: sw/sd/swu rs2+1,(rs1),sign_ext(imm5<<imm2+4/8)
//&CombBeg;
//  non_inst_store_data[ID_WIDTH-1:0]                 = {ID_WIDTH{1'b0}};
//  if(1'b1) begin
//  non_inst_store_data[ID_EU:ID_EU-`EU_WIDTH+1]       = LSU;
//  non_inst_store_data[ID_FUNC:ID_FUNC-`FUNC_WIDTH+1] = {`FUNC_WIDTH{1'b0}};
//  non_inst_store_data[ID_SRC0_VLD]                  = 1'b1;
//  non_inst_store_data[ID_SRC0_REG:ID_SRC0_REG-5]    = {1'b0,dp_split_inst[19:15]};
//  non_inst_store_data[ID_SRC1_VLD]                  = 1'b0;
//  non_inst_store_data[ID_SRC1_IMM:ID_SRC1_IMM-63]   = non_inst1_sel ? {{52{non_inst1_offset[11]}},
//                                                                           non_inst1_offset[11:0]}
//                                                                    : {{52{non_inst0_offset[11]}},
//                                                                           non_inst0_offset[11:0]};
//  non_inst_store_data[ID_SRC2_VLD]                  = 1'b1;
//  non_inst_store_data[ID_SRC2_REG:ID_SRC2_REG-5]    = non_inst1_sel ? {1'b0,dp_split_inst[24:20]}
//                                                                    : {1'b0,dp_split_inst[11:7]};
//  non_inst_store_data[ID_SPLIT]                     = !non_inst1_sel;
//  non_inst_store_data[ID_LENGTH]                    = 1'b1;
//  end 
//&CombEnd;
//
////----------------------------------------------------------
////                 Split Instruction Data
////----------------------------------------------------------
//assign non_inst_data[ID_WIDTH-1:0] = non_load
//                                     ? non_inst_load_data[ID_WIDTH-1:0]
//                                     : non_inst_store_data[ID_WIDTH-1:0];

//==========================================================
//               Split Instructions Selection
//==========================================================
//----------------------------------------------------------
//                split inst data update
//----------------------------------------------------------
assign split_inst_data_wen =
         non_split_type && non_inst_data_wen;

assign split_inst_wdata[`DIS_VEC_WIDTH-1:0] = 
         {`DIS_VEC_WIDTH{non_split_type}} & non_inst_data[`DIS_VEC_WIDTH-1:0];

//----------------------------------------------------------
//              MUX between split instructions
//----------------------------------------------------------
assign split_fp_entry_vld =
         non_entry_vld;

assign split_fp_inst_vld  =
         non_split_type && non_inst_vld;

//==========================================================
//              Other control and data output
//==========================================================
//----------------------------------------------------------
//                   Data path signals
//----------------------------------------------------------
assign split_fp_dp_inst_data[`DIS_VEC_WIDTH-1:0] = split_inst_data[`DIS_VEC_WIDTH-1:0];

//----------------------------------------------------------
//                   Control path signals
//----------------------------------------------------------
assign split_fp_ctrl_entry_vld                   = split_fp_entry_vld;

assign split_fp_ctrl_inst_vld                    = (split_fp_entry_vld || idu_vidu_ex1_fp_sel)
                                                   && split_fp_inst_vld;
assign split_fp_ctrl_inst_dp_vld                 = (split_fp_entry_vld || idu_vidu_ex1_fp_dp_sel)
                                                   && split_fp_inst_vld;
assign split_fp_ctrl_inst_gateclk_vld            = (split_fp_entry_vld || idu_vidu_ex1_fp_gateclk_sel)
                                                   && split_fp_inst_vld;

//==========================================================
//                 Instance of Gated Cell
//==========================================================
assign split_clk_en = ifu_vidu_warm_up
                      || idu_vidu_ex1_fp_gateclk_sel
                      || (non_cur_state != NON_IDLE);
// &Instance("gated_clk_cell", "x_split_clk_gated_clk_cell"); @195
gated_clk_cell  x_split_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (split_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (split_clk_en      ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @196
//          .external_en (1'b0), @197
//          .global_en   (cp0_yy_clk_en), @198
//          .module_en   (cp0_idu_icg_en), @199
//          .local_en    (split_clk_en), @200
//          .clk_out     (split_clk)); @201

// &ModuleEnd; @203
endmodule


