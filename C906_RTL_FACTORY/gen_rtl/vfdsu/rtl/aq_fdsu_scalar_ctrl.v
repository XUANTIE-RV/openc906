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
module aq_fdsu_scalar_ctrl(
  bhalf0_ex1_op0_id_vld,
  bhalf0_ex1_op1_id_vld,
  bhalf0_ex1_op1_sel,
  cp0_vpu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_dp_ex1_save_op0,
  ctrl_dp_ex1_save_op0_gate,
  double0_ex1_op0_id_vld,
  double0_ex1_op1_id_vld,
  double0_ex1_op1_sel,
  double_pipe0_ex1_ff1_sel_op1,
  double_pipe0_ex1_op1_sel,
  double_pipe0_ex1_save_op0,
  double_pipe0_ex1_srt_skip,
  double_pipe0_ex2_of,
  double_pipe0_ex2_uf_srt_skip,
  double_pipe0_save_op0_neg_expnt,
  double_pipe0_srt_remainder_zero,
  dp_ctrl_ex1_bhalf,
  dp_ctrl_ex1_div,
  dp_ctrl_ex1_double,
  dp_ctrl_ex1_half,
  dp_ctrl_ex1_single,
  ex1_bhalf,
  ex1_double,
  ex1_half,
  ex1_pipe_clk,
  ex1_pipedown,
  ex1_pipedown_gate,
  ex1_save_ff1_op1_id,
  ex1_single,
  ex2_pipe_clk,
  ex2_pipedown,
  ex2_srt_first_round,
  ex3_pipedown,
  ex4_pipe_clk,
  ex4_pipedown,
  expnt_rst_clk,
  fdsu_ex1_sel,
  forever_cpuclk,
  half0_ex1_op0_id_vld,
  half0_ex1_op1_id_vld,
  half0_ex1_op1_sel,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  rbus_vfdsu_fpr_wb_grnt,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_flush,
  single0_ex1_op0_id_vld,
  single0_ex1_op1_id_vld,
  single0_ex1_op1_sel,
  srt_sm_on,
  vfdsu_rbus_fflags_vld,
  vfdsu_rbus_fpr_wb_req,
  vfdsu_vpu_busy,
  vfdsu_vpu_ex1_denormal_stall,
  vfdsu_vpu_state_idle,
  vpu_vfdsu_ex1_sel
);

// &Ports; @24
input          bhalf0_ex1_op0_id_vld;          
input          bhalf0_ex1_op1_id_vld;          
input          cp0_vpu_icg_en;                 
input          cp0_yy_clk_en;                  
input          cpurst_b;                       
input          double0_ex1_op0_id_vld;         
input          double0_ex1_op1_id_vld;         
input          double_pipe0_ex1_srt_skip;      
input          double_pipe0_ex2_of;            
input          double_pipe0_ex2_uf_srt_skip;   
input          double_pipe0_srt_remainder_zero; 
input          dp_ctrl_ex1_bhalf;              
input          dp_ctrl_ex1_div;                
input          dp_ctrl_ex1_double;             
input          dp_ctrl_ex1_half;               
input          dp_ctrl_ex1_single;             
input          ex1_bhalf;                      
input          ex1_double;                     
input          ex1_half;                       
input          ex1_single;                     
input          forever_cpuclk;                 
input          half0_ex1_op0_id_vld;           
input          half0_ex1_op1_id_vld;           
input          ifu_vpu_warm_up;                
input          pad_yy_icg_scan_en;             
input          rbus_vfdsu_fpr_wb_grnt;         
input          rtu_yy_xx_async_flush;          
input          rtu_yy_xx_flush;                
input          single0_ex1_op0_id_vld;         
input          single0_ex1_op1_id_vld;         
input          vpu_vfdsu_ex1_sel;              
output         bhalf0_ex1_op1_sel;             
output         ctrl_dp_ex1_save_op0;           
output         ctrl_dp_ex1_save_op0_gate;      
output         double0_ex1_op1_sel;            
output         double_pipe0_ex1_ff1_sel_op1;   
output         double_pipe0_ex1_op1_sel;       
output         double_pipe0_ex1_save_op0;      
output         double_pipe0_save_op0_neg_expnt; 
output         ex1_pipe_clk;                   
output         ex1_pipedown;                   
output         ex1_pipedown_gate;              
output         ex1_save_ff1_op1_id;            
output         ex2_pipe_clk;                   
output         ex2_pipedown;                   
output         ex2_srt_first_round;            
output         ex3_pipedown;                   
output         ex4_pipe_clk;                   
output         ex4_pipedown;                   
output         expnt_rst_clk;                  
output         fdsu_ex1_sel;                   
output         half0_ex1_op1_sel;              
output         single0_ex1_op1_sel;            
output         srt_sm_on;                      
output         vfdsu_rbus_fflags_vld;          
output         vfdsu_rbus_fpr_wb_req;          
output         vfdsu_vpu_busy;                 
output         vfdsu_vpu_ex1_denormal_stall;   
output         vfdsu_vpu_state_idle;           

// &Regs; @25
reg            ex2_special_skip;               
reg            ex2_srt_first_round;            
reg     [2:0]  fdsu_cur_state;                 
reg     [2:0]  fdsu_next_state;                
reg     [4:0]  srt_cnt;                        

// &Wires; @26
wire           bhalf0_ex1_op0_id_vld;          
wire           bhalf0_ex1_op1_id_vld;          
wire           bhalf0_ex1_op1_sel;             
wire           cp0_vpu_icg_en;                 
wire           cp0_yy_clk_en;                  
wire           cpurst_b;                       
wire           ctrl_dp_ex1_save_op0;           
wire           ctrl_dp_ex1_save_op0_gate;      
wire           ctrl_fdsu_ex1_stall;            
wire           ctrl_id0;                       
wire           ctrl_id1;                       
wire           ctrl_iter_start;                
wire           ctrl_iter_start_gate;           
wire           ctrl_pack;                      
wire           ctrl_result_vld;                
wire           ctrl_round;                     
wire           ctrl_sm_cmplt;                  
wire           ctrl_sm_idle;                   
wire           ctrl_sm_start;                  
wire           ctrl_srt_idle;                  
wire           ctrl_srt_itering;               
wire           ctrl_wfi2;                      
wire           ctrl_wfwb;                      
wire           double0_ex1_op0_id_vld;         
wire           double0_ex1_op1_id_vld;         
wire           double0_ex1_op1_sel;            
wire           double_pipe0_ex1_ff1_sel_op1;   
wire           double_pipe0_ex1_op0_id;        
wire           double_pipe0_ex1_op1_id;        
wire           double_pipe0_ex1_op1_sel;       
wire           double_pipe0_ex1_save_op0;      
wire           double_pipe0_ex1_srt_skip;      
wire           double_pipe0_ex2_of;            
wire           double_pipe0_ex2_uf_srt_skip;   
wire           double_pipe0_save_op0_neg_expnt; 
wire           double_pipe0_srt_remainder_zero; 
wire           double_srt_skip;                
wire           dp_ctrl_ex1_bhalf;              
wire           dp_ctrl_ex1_div;                
wire           dp_ctrl_ex1_double;             
wire           dp_ctrl_ex1_half;               
wire           dp_ctrl_ex1_single;             
wire           ex1_bhalf;                      
wire           ex1_double;                     
wire           ex1_half;                       
wire           ex1_pipe_clk;                   
wire           ex1_pipe_clk_en;                
wire           ex1_pipedown;                   
wire           ex1_pipedown_gate;              
wire           ex1_save_ff1_op1_id;            
wire           ex1_save_op0;                   
wire           ex1_save_op0_gate;              
wire           ex1_single;                     
wire           ex1_srt_skip;                   
wire           ex2_pipe_clk;                   
wire           ex2_pipe_clk_en;                
wire           ex2_pipedown;                   
wire           ex3_pipedown;                   
wire           ex4_pipe_clk;                   
wire           ex4_pipe_clk_en;                
wire           ex4_pipedown;                   
wire           expnt_rst_clk;                  
wire           expnt_rst_clk_en;               
wire           fdsu_busy;                      
wire           fdsu_clk;                       
wire           fdsu_clk_en;                    
wire           fdsu_dn_op0_id;                 
wire           fdsu_dn_op1_id;                 
wire           fdsu_dn_stall;                  
wire           fdsu_ex1_inst_vld;              
wire           fdsu_ex1_sel;                   
wire           fdsu_flush;                     
wire           fdsu_wb_grant;                  
wire           forever_cpuclk;                 
wire           half0_ex1_op0_id_vld;           
wire           half0_ex1_op1_id_vld;           
wire           half0_ex1_op1_sel;              
wire           ifu_vpu_warm_up;                
wire           pad_yy_icg_scan_en;             
wire           rbus_vfdsu_fpr_wb_grnt;         
wire           rtu_yy_xx_async_flush;          
wire           rtu_yy_xx_flush;                
wire           single0_ex1_op0_id_vld;         
wire           single0_ex1_op1_id_vld;         
wire           single0_ex1_op1_sel;            
wire    [4:0]  srt_cnt_ini;                    
wire           srt_cnt_zero;                   
wire           srt_last_round;                 
wire           srt_remainder_zero;             
wire           srt_skip;                       
wire           srt_sm_on;                      
wire           vfdsu_rbus_fflags_vld;          
wire           vfdsu_rbus_fpr_wb_req;          
wire           vfdsu_vpu_busy;                 
wire           vfdsu_vpu_ex1_denormal_stall;   
wire           vfdsu_vpu_state_idle;           
wire           vpu_vfdsu_ex1_sel;              


//==========================================================
//                       Input Signal
//==========================================================
assign fdsu_ex1_inst_vld = vpu_vfdsu_ex1_sel;
assign fdsu_ex1_sel      = vpu_vfdsu_ex1_sel;
// &Force("bus", "vpu_group_1_xx_ex1_eu_sel", 9, 0); @33

//==========================================================
//                 FDSU Main State Machine
//==========================================================
assign ex1_srt_skip      = double_pipe0_ex1_srt_skip ;
always @(posedge fdsu_clk)
begin
    if(ex1_pipedown)
      ex2_special_skip <= ex1_srt_skip;
end

//assign fdsu_ex1_res_vld  = 1'b0;//fdsu_ex1_inst_vld && ex1_srt_skip;
//assign ex2_uf_srt_skip   = double_pipe0_ex2_uf_srt_skip && single_pipe_ex2_uf_srt_skip && 
//                           half_pipe0_ex2_uf_srt_skip &&  half_pipe1_ex2_uf_srt_skip;
assign srt_remainder_zero = double_pipe0_srt_remainder_zero;
assign fdsu_wb_grant      = rbus_vfdsu_fpr_wb_grnt;

assign ctrl_iter_start      = ctrl_sm_start && !fdsu_dn_op0_id && !fdsu_dn_op1_id
                              || ctrl_id0 && !fdsu_dn_op1_id
                              || ctrl_id1;
assign ctrl_iter_start_gate = ctrl_sm_start && !fdsu_dn_stall
                              || ctrl_id0 && !fdsu_dn_op1_id
                              || ctrl_id1;
assign vfdsu_vpu_state_idle   = ctrl_srt_idle;
assign ctrl_sm_start         = fdsu_ex1_inst_vld && ctrl_srt_idle;
//assign ctrl_sm_start_gate    = fdsu_ex1_inst_vld && ctrl_srt_idle;

assign srt_last_round = (srt_skip ||
                         srt_remainder_zero ||
                         srt_cnt_zero)      &&
                         ctrl_srt_itering;
assign double_srt_skip   = (double_pipe0_ex2_of || double_pipe0_ex2_uf_srt_skip);
assign srt_skip       =  double_srt_skip || ex2_special_skip;
assign srt_cnt_zero   = ~|srt_cnt[4:0];
// part of the stall signal is handled in vpu dp
assign fdsu_dn_stall =  ctrl_wfi2 
                       || ctrl_id0 && fdsu_dn_op1_id;
//assign fdsu_dn_stall  =   && dp_ctrl_ex1_div &&
//                        (dp_ctrl_ex1_double && (double0_ex1_op1_id_vld  || double0_ex1_op0_id_vld) 
//                         dp_ctrl_ex1_single && (single0_ex1_op1_id_vld || single1_ex1_op1_id_vld || 
//                                                single0_ex1_op0_id_vld || single1_ex1_op0_id_vld) ||
//                         dp_ctrl_ex1_half   && (half3_ex1_op1_id_vld || half2_ex1_op1_id_vld  ||
//                                                half1_ex1_op1_id_vld || half0_ex1_op1_id_vld  || 
//                                                half3_ex1_op0_id_vld || half2_ex1_op0_id_vld  ||
//                                                half1_ex1_op0_id_vld || half0_ex1_op0_id_vld) || 
//                         dp_ctrl_ex1_bhalf  && (bhalf3_ex1_op1_id_vld || bhalf2_ex1_op1_id_vld ||
//                                                bhalf1_ex1_op1_id_vld || bhalf0_ex1_op1_id_vld || 
//                                                bhalf3_ex1_op0_id_vld || bhalf2_ex1_op0_id_vld ||
//                                                bhalf1_ex1_op0_id_vld || bhalf0_ex1_op0_id_vld));
assign fdsu_dn_op0_id   = fdsu_ex1_inst_vld && 
                        (dp_ctrl_ex1_double && (double0_ex1_op0_id_vld)  ||
                         dp_ctrl_ex1_single && (single0_ex1_op0_id_vld) ||
                         dp_ctrl_ex1_half   && (half0_ex1_op0_id_vld) || 
                         dp_ctrl_ex1_bhalf  && (bhalf0_ex1_op0_id_vld));
assign fdsu_dn_op1_id   = fdsu_ex1_inst_vld && dp_ctrl_ex1_div &&  
                        (dp_ctrl_ex1_double && (double0_ex1_op1_id_vld)  ||
                         dp_ctrl_ex1_single && (single0_ex1_op1_id_vld ) ||
                         dp_ctrl_ex1_half   && (half0_ex1_op1_id_vld) || 
                         dp_ctrl_ex1_bhalf  && (bhalf0_ex1_op1_id_vld));

parameter IDLE  = 3'b000;
parameter WFI2  = 3'b001;
parameter ITER  = 3'b010;
parameter RND   = 3'b011;
parameter PACK  = 3'b100;
parameter WFWB  = 3'b101;
parameter ID0   = 3'b110;
parameter ID1   = 3'b111;

always @ (posedge fdsu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    fdsu_cur_state[2:0] <= IDLE;
  else if (fdsu_flush)
    fdsu_cur_state[2:0] <= IDLE;
  else
    fdsu_cur_state[2:0] <= fdsu_next_state[2:0];
end
// add one state to inform the op0 id

// &CombBeg; @114
always @( fdsu_ex1_inst_vld
       or fdsu_dn_op0_id
       or srt_last_round
       or fdsu_cur_state
       or fdsu_dn_op1_id
       or fdsu_wb_grant)
begin
case (fdsu_cur_state)
  IDLE:
  begin
    if(fdsu_ex1_inst_vld)
      if (fdsu_dn_op0_id)
        fdsu_next_state = ID0;
      else if(fdsu_dn_op1_id)
        fdsu_next_state = WFI2;
    else
        fdsu_next_state = ITER;
    else 
      fdsu_next_state = IDLE;
  end
  ID0: 
  begin
    if(fdsu_dn_op1_id)
       fdsu_next_state = WFI2;
    else
       fdsu_next_state = ITER;
  end
  WFI2:fdsu_next_state = ID1;
  ID1: fdsu_next_state = ITER;
  ITER:
  begin
    if (srt_last_round)
      fdsu_next_state = RND;
    else
      fdsu_next_state = ITER;
  end
  RND:
    fdsu_next_state = PACK;
  PACK:
  begin
      fdsu_next_state = WFWB;
  end
  WFWB:
  begin
    if (fdsu_wb_grant)
       fdsu_next_state = IDLE;
    else
      fdsu_next_state = WFWB;
  end
  default:
    fdsu_next_state = IDLE;
endcase
// &CombEnd; @160
end

assign ctrl_sm_idle     = fdsu_cur_state == IDLE;
assign ctrl_wfi2        = fdsu_cur_state == WFI2;
assign ctrl_srt_itering = fdsu_cur_state == ITER;
assign ctrl_round       = fdsu_cur_state == RND;
assign ctrl_pack        = fdsu_cur_state == PACK;
assign ctrl_wfwb        = fdsu_cur_state == WFWB;
assign ctrl_id0         = fdsu_cur_state == ID0;
assign ctrl_id1         = fdsu_cur_state == ID1;

assign ctrl_sm_cmplt    = ctrl_wfwb;
assign ctrl_srt_idle    = ctrl_sm_idle;
//assign ctrl_sm_ex1      = ctrl_srt_idle || ctrl_wfi2;

//==========================================================
//                    Iteration Counter
//==========================================================
always @ (posedge fdsu_clk)
begin
  if (fdsu_flush)
    srt_cnt[4:0] <= 5'b0;
  else if (ctrl_iter_start)
    srt_cnt[4:0] <= srt_cnt_ini[4:0];
  else if (ctrl_srt_itering)
    srt_cnt[4:0] <= srt_cnt[4:0] - 5'b1;
  else
    srt_cnt[4:0] <= srt_cnt[4:0];
end

//srt_cnt_ini[4:0]
//For Double, initial is 5'b11100('d28), calculate 29 round
//For Single, initial is 5'b01110('d14), calculate 15 round
assign srt_cnt_ini[4:0] = {5{ex1_double}} & 5'b11100 |    // 28
                          {5{ex1_single}} & 5'b01101  |
                          {5{ex1_half}}   & 5'b00111  |
                          {5{ex1_bhalf}}  & 5'b00101;    // 14

//fdsu srt first round signal 
//For srt calculate special use
always @(posedge fdsu_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ex2_srt_first_round <= 1'b0;
  else if(fdsu_flush)
    ex2_srt_first_round <= 1'b0;
  else if(ex1_pipedown)
    ex2_srt_first_round <= 1'b1;
  else
    ex2_srt_first_round <= 1'b0;
end

//==========================================================
//                 Write Back State Machine
//==========================================================
parameter WB_IDLE  = 2'b00,
          WB_EX2   = 2'b10,
          WB_CMPLT = 2'b01;

//always @ (posedge fdsu_clk or negedge cpurst_b)
//begin
//  if (!cpurst_b)
//    wb_cur_state[1:0] <= WB_IDLE;
//  else if (fdsu_flush)
//    wb_cur_state[1:0] <= WB_IDLE;
//  else
//    wb_cur_state[1:0] <= wb_nxt_state[1:0];
//end
//
//&CombBeg;
//  case(wb_cur_state)
//    WB_IDLE:
//      if (fdsu_ex1_inst_vld)
//        if (ctrl_xx_ex1_stall || fdsu_ex1_res_vld || fdsu_dn_stall)
//          wb_nxt_state = WB_IDLE;
//        else
//          wb_nxt_state = WB_EX2;
//      else
//        wb_nxt_state = WB_IDLE;
//    WB_EX2:
//      // if (ctrl_xx_ex2_stall)
//      //   wb_nxt_state = WB_EX2;
//      // else
//        if (ctrl_fdsu_wb_vld)
//          if (ctrl_iter_start && !ctrl_xx_ex1_stall)
//            wb_nxt_state = WB_EX2;
//          else
//            wb_nxt_state = WB_IDLE;
//        else
//          wb_nxt_state = WB_CMPLT;
//    WB_CMPLT:
//      if (ctrl_fdsu_wb_vld)
//        if (ctrl_iter_start && !ctrl_xx_ex1_stall)
//          wb_nxt_state = WB_EX2;
//        else
//          wb_nxt_state = WB_IDLE;
//      else
//        wb_nxt_state = WB_CMPLT;
//    default:
//      wb_nxt_state = WB_IDLE;
//  endcase
//&CombEnd;
//
//assign ctrl_wb_idle  = wb_cur_state == WB_IDLE
//                       || wb_cur_state == WB_CMPLT && ctrl_fdsu_wb_vld;
//assign ctrl_wb_sm_idle  = wb_cur_state == WB_IDLE;
////assign ctrl_wb_sm_ex2   = wb_cur_state == WB_EX2;
//assign ctrl_wb_sm_cmplt = wb_cur_state == WB_EX2
//                       || wb_cur_state == WB_CMPLT;
//
assign ctrl_result_vld  = ctrl_sm_cmplt; //&& ctrl_wb_sm_cmplt;
//assign ctrl_fdsu_wb_vld = ctrl_result_vld && fdsu_wb_grant;

assign ctrl_fdsu_ex1_stall = fdsu_ex1_inst_vld && fdsu_dn_stall;
//assign ctrl_xx_ex1_stall   = ctrl_fdsu_ex1_stall;

//==========================================================
//                          Flush
//==========================================================
assign fdsu_flush =  ifu_vpu_warm_up
                 || rtu_yy_xx_async_flush;

//==========================================================
//                           ICG
//==========================================================
assign fdsu_busy =  !ctrl_sm_idle && !ctrl_wfi2 && !ctrl_id0 && !ctrl_id1;
assign vfdsu_vpu_busy = fdsu_busy;                
assign fdsu_clk_en = fdsu_ex1_inst_vld && ctrl_sm_idle
                  || fdsu_busy
                  || !ctrl_sm_idle
                  || rtu_yy_xx_flush;
// &Instance("gated_clk_cell", "x_fdsu_clk"); @291
gated_clk_cell  x_fdsu_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fdsu_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fdsu_clk_en       ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @292
//          .external_en (1'b0), @293
//          .global_en   (cp0_yy_clk_en), @294
//          .module_en   (cp0_vpu_icg_en), @295
//          .local_en    (fdsu_clk_en), @296
//          .clk_out     (fdsu_clk)); @297

assign ex1_pipe_clk_en = ex1_pipedown_gate;
// &Instance("gated_clk_cell","x_ex1_pipe_clk"); @300
gated_clk_cell  x_ex1_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @301
//           .clk_out        (ex1_pipe_clk),//Out Clock @302
//           .external_en    (1'b0), @303
//           .global_en      (cp0_yy_clk_en), @304
//           .local_en       (ex1_pipe_clk_en),//Local Condition @305
//           .module_en      (cp0_vpu_icg_en) @306
//         ); @307

assign ex2_pipe_clk_en = ex2_pipedown;
// &Instance("gated_clk_cell","x_ex2_pipe_clk"); @310
gated_clk_cell  x_ex2_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @311
//           .clk_out        (ex2_pipe_clk),//Out Clock @312
//           .external_en    (1'b0), @313
//           .global_en      (cp0_yy_clk_en), @314
//           .local_en       (ex2_pipe_clk_en),//Local Condition @315
//           .module_en      (cp0_vpu_icg_en) @316
//         ); @317
// &Force("output", "ex2_pipe_clk"); @318

assign expnt_rst_clk_en = ex1_save_op0_gate
                       || ctrl_id0
                       || ex1_pipedown_gate
                       || ex2_pipedown
                       || ex3_pipedown;
// &Instance("gated_clk_cell", "x_expnt_rst_clk"); @325
gated_clk_cell  x_expnt_rst_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (expnt_rst_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (expnt_rst_clk_en  ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @326
//          .external_en (1'b0), @327
//          .global_en   (cp0_yy_clk_en), @328
//          .module_en   (cp0_vpu_icg_en), @329
//          .local_en    (expnt_rst_clk_en), @330
//          .clk_out     (expnt_rst_clk)); @331

assign ex4_pipe_clk_en = ex4_pipedown;
// &Instance("gated_clk_cell","x_ex4_pipe_clk"); @334
gated_clk_cell  x_ex4_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex4_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex4_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @335
//           .clk_out        (ex4_pipe_clk),//Out Clock @336
//           .external_en    (1'b0), @337
//           .global_en      (cp0_yy_clk_en), @338
//           .local_en       (ex4_pipe_clk_en),//Local Condition @339
//           .module_en      (cp0_vpu_icg_en) @340
//         ); @341
// &Force("output", "ex2_pipe_clk"); @342

//==========================================================
//                      Output Signal
//==========================================================
//assign fdsu_yy_wb_freg[4:0]    = fdsu_wb_freg[4:0];


assign ex1_pipedown = ctrl_iter_start || ifu_vpu_warm_up;
assign ex1_pipedown_gate = ctrl_iter_start_gate || ifu_vpu_warm_up;
assign ex2_pipedown = ctrl_srt_itering && srt_last_round || ifu_vpu_warm_up;
assign ex3_pipedown = ctrl_round || ifu_vpu_warm_up;
assign ex4_pipedown = ctrl_pack || ifu_vpu_warm_up;
// &Force("output", "ex1_pipedown"); @355
// &Force("output", "ex1_pipedown_gate"); @356
// &Force("output", "ex2_pipedown"); @357
// &Force("output", "ex3_pipedown"); @358
// &Force("output", "ex4_pipedown"); @359

assign srt_sm_on = ctrl_srt_itering;

//assign fdsu_fpu_ex1_cmplt = fdsu_ex1_inst_vld;
//assign fdsu_fpu_ex1_stall = ctrl_fdsu_ex1_stall;
//assign fdsu_frbus_wb_vld  = ctrl_result_vld;
assign vfdsu_vpu_ex1_denormal_stall = ctrl_fdsu_ex1_stall;
assign vfdsu_rbus_fpr_wb_req      = ctrl_result_vld;
assign vfdsu_rbus_fflags_vld      = ctrl_result_vld;
//assign fdsu_fpu_no_op     = !fdsu_busy;

assign double0_ex1_op1_sel  = ctrl_wfi2 || ctrl_id1;
assign single0_ex1_op1_sel = ctrl_wfi2 || ctrl_id1;
assign half0_ex1_op1_sel   = ctrl_wfi2 || ctrl_id1;
assign bhalf0_ex1_op1_sel  = ctrl_wfi2 || ctrl_id1;
assign double_pipe0_ex1_op1_sel = ctrl_wfi2 || ctrl_id1;

assign double_pipe0_ex1_ff1_sel_op1 = ctrl_wfi2|| ctrl_id1;

assign double_pipe0_ex1_op0_id         = dp_ctrl_ex1_double && double0_ex1_op0_id_vld || 
                                                          dp_ctrl_ex1_single && single0_ex1_op0_id_vld ||
                                                          dp_ctrl_ex1_half  && half0_ex1_op0_id_vld    ||
                                                          dp_ctrl_ex1_bhalf && bhalf0_ex1_op0_id_vld;
assign double_pipe0_ex1_op1_id         = dp_ctrl_ex1_double && double0_ex1_op1_id_vld || 
                                                          dp_ctrl_ex1_single && single0_ex1_op1_id_vld ||
                                                          dp_ctrl_ex1_half  && half0_ex1_op1_id_vld    ||
                                                          dp_ctrl_ex1_bhalf && bhalf0_ex1_op1_id_vld;
assign ex1_save_ff1_op1_id            = ctrl_wfi2;

assign double_pipe0_ex1_save_op0       = ctrl_sm_start && double_pipe0_ex1_op0_id;
assign double_pipe0_save_op0_neg_expnt  = ctrl_id0 && fdsu_dn_op1_id;

assign ex1_save_op0              = ctrl_id0 && (double_pipe0_ex1_op1_id);
assign ex1_save_op0_gate         = ctrl_id0 || ctrl_sm_start;                                   
assign ctrl_dp_ex1_save_op0      = ex1_save_op0;
assign ctrl_dp_ex1_save_op0_gate      = ex1_save_op0_gate;
// &Force("output", "double_pipe0_ex1_save_op0"); @396


// &ModuleEnd; @402
endmodule



