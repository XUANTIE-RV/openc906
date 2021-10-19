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
module aq_iu_div(
  cp0_iu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  div_ctrl_no_op,
  div_dbginfo,
  forever_cpuclk,
  idu_div_ex1_gateclk_sel,
  idu_iu_ex1_div_dp_sel,
  idu_iu_ex1_div_sel,
  idu_iu_ex1_dst_preg,
  idu_iu_ex1_func,
  idu_iu_ex1_src0,
  idu_iu_ex1_src1,
  ifu_iu_warm_up,
  iu_idu_div_full,
  iu_rtu_div_data,
  iu_rtu_div_preg,
  iu_rtu_div_wb_dp,
  iu_rtu_div_wb_vld,
  iu_rtu_ex1_div_cmplt,
  iu_rtu_ex1_div_cmplt_dp,
  pad_yy_icg_scan_en,
  rtu_iu_div_wb_grant,
  rtu_iu_div_wb_grant_for_full
);

// &Ports; @24
input           cp0_iu_icg_en;               
input           cp0_yy_clk_en;               
input           cpurst_b;                    
input           forever_cpuclk;              
input           idu_div_ex1_gateclk_sel;     
input           idu_iu_ex1_div_dp_sel;       
input           idu_iu_ex1_div_sel;          
input   [5 :0]  idu_iu_ex1_dst_preg;         
input   [19:0]  idu_iu_ex1_func;             
input   [63:0]  idu_iu_ex1_src0;             
input   [63:0]  idu_iu_ex1_src1;             
input           ifu_iu_warm_up;              
input           pad_yy_icg_scan_en;          
input           rtu_iu_div_wb_grant;         
input           rtu_iu_div_wb_grant_for_full; 
output          div_ctrl_no_op;              
output  [2 :0]  div_dbginfo;                 
output          iu_idu_div_full;             
output  [63:0]  iu_rtu_div_data;             
output  [5 :0]  iu_rtu_div_preg;             
output          iu_rtu_div_wb_dp;            
output          iu_rtu_div_wb_vld;           
output          iu_rtu_ex1_div_cmplt;        
output          iu_rtu_ex1_div_cmplt_dp;     

// &Regs; @25
reg     [2 :0]  div_cur_state;               
reg     [63:0]  div_dividend;                
reg     [63:0]  div_dividend_raw;            
reg     [63:0]  div_divisor;                 
reg             div_divisor_63;              
reg     [63:0]  div_divisor_reg;             
reg     [4 :0]  div_dst_preg;                
reg     [3 :0]  div_ex1_res_onehot_flop;     
reg     [5 :0]  div_ff1_res_pos;             
reg     [2 :0]  div_next_state;              
reg             div_oper_is_signed_flop;     
reg             div_oper_is_word_flop;       
reg     [63:0]  div_quotient_reg;            
reg     [63:0]  div_remainder_reg;           
reg             div_res_sel_quotient_flop;   
reg     [63:0]  div_special_res_quotient;    
reg     [63:0]  div_special_res_remainder;   
reg             div_special_res_vld;         

// &Wires; @26
wire            cp0_iu_icg_en;               
wire            cp0_yy_clk_en;               
wire            cpurst_b;                    
wire            div_abnormal_res_vld;        
wire    [63:0]  div_abs_res;                 
wire    [63:0]  div_abs_src;                 
wire            div_align;                   
wire            div_buffer_update;           
wire            div_clk;                     
wire            div_clk_en;                  
wire            div_clk_en_raw;              
wire            div_cmplt;                   
wire            div_ctrl_no_op;              
wire    [2 :0]  div_dbginfo;                 
wire            div_dividend_63;             
wire            div_dividend_eq0;            
wire            div_dividend_hit_buffer;     
wire    [63:0]  div_dividend_overflow;       
wire    [63:0]  div_dividend_tmp;            
wire    [63:0]  div_diviosr_abs_data;        
wire            div_divisor_eq0;             
wire    [63:0]  div_divisor_eq0_remainder;   
wire            div_divisor_hit_buffer;      
wire    [63:0]  div_divisor_raw;             
wire            div_divisor_raw_is_neg;      
wire    [63:0]  div_divisor_tmp;             
wire            div_divisor_update;          
wire    [63:0]  div_divisor_update_data;     
wire    [63:0]  div_ex1_dividend_overflow;   
wire    [3 :0]  div_ex1_res_onehot;          
wire            div_ex1_res_vld;             
wire            div_ex1_res_vld_raw;         
wire            div_ex2_enable_wb;           
wire    [63:0]  div_ex2_res;                 
wire    [63:0]  div_ex2_res_raw;             
wire            div_ex2_res_vld;             
wire            div_ex2_res_vld_raw;         
wire    [5 :0]  div_ff1_res;                 
wire    [5 :0]  div_ff1_res_neg;             
wire    [63:0]  div_ff1_src;                 
wire    [19:0]  div_func;                    
wire            div_hit_buffer;              
wire            div_hit_buffer_res_vld;      
wire            div_inst_vld;                
wire            div_is_idle;                 
wire            div_is_signed;               
wire            div_iter_cmplt;              
wire            div_iter_start;              
wire            div_iterating;               
wire    [63:0]  div_normal_quotient;         
wire    [63:0]  div_normal_quotient_raw;     
wire    [63:0]  div_normal_remainder;        
wire    [63:0]  div_normal_remainder_raw;    
wire            div_oper_is_signed;          
wire            div_oper_is_word;            
wire            div_prepare_src0;            
wire            div_prepare_src1;            
wire    [63:0]  div_quotient_reg_updt;       
wire    [63:0]  div_quotient_res;            
wire    [63:0]  div_remainder_reg_updt;      
wire    [63:0]  div_remainder_res;           
wire            div_res_overflow;            
wire            div_res_quotient_neg;        
wire            div_res_remainder_neg;       
wire            div_res_sel_quotient;        
wire            div_sign_ext;                
wire            div_signed_hit_buffer;       
wire    [63:0]  div_special_res;             
wire            div_special_res_vld_update;  
wire            div_src_is_neg;              
wire            div_unsign_ext;              
wire            div_wfwb;                    
wire            div_word_hit_buffer;         
wire            forever_cpuclk;              
wire            idu_div_ex1_gateclk_sel;     
wire            idu_iu_ex1_div_dp_sel;       
wire            idu_iu_ex1_div_sel;          
wire    [5 :0]  idu_iu_ex1_dst_preg;         
wire    [19:0]  idu_iu_ex1_func;             
wire    [63:0]  idu_iu_ex1_src0;             
wire    [63:0]  idu_iu_ex1_src1;             
wire            ifu_iu_warm_up;              
wire            iu_idu_div_full;             
wire    [63:0]  iu_rtu_div_data;             
wire    [5 :0]  iu_rtu_div_preg;             
wire    [4 :0]  iu_rtu_div_preg_raw;         
wire            iu_rtu_div_wb_dp;            
wire            iu_rtu_div_wb_vld;           
wire            iu_rtu_ex1_div_cmplt;        
wire            iu_rtu_ex1_div_cmplt_dp;     
wire            pad_yy_icg_scan_en;          
wire            rtu_iu_div_wb_grant;         
wire            rtu_iu_div_wb_grant_for_full; 


assign div_inst_vld         = idu_iu_ex1_div_sel;
assign div_func[19:0]       = idu_iu_ex1_func[19:0] & {20{idu_div_ex1_gateclk_sel}};

// div func
// sign, quo, word
assign div_oper_is_signed   = div_func[2];
assign div_res_sel_quotient = div_func[1];
assign div_oper_is_word     = div_func[0];

assign div_dividend_tmp[63:0]   = {64{idu_div_ex1_gateclk_sel}} & idu_iu_ex1_src0[63:0];
assign div_divisor_tmp[63:0]    = {64{idu_div_ex1_gateclk_sel}} & idu_iu_ex1_src1[63:0];

assign div_sign_ext   = div_oper_is_word && div_oper_is_signed;
assign div_unsign_ext = div_oper_is_word && !div_oper_is_signed;

// operand prepare : merge inst64 and inst32
// &CombBeg; @44
always @( div_dividend_tmp[63:0]
       or div_sign_ext
       or div_unsign_ext)
begin
  casez({div_sign_ext, div_unsign_ext})
    2'b01 :   div_dividend[63:0] = {32'b0, div_dividend_tmp[31:0]};
    2'b10 :   div_dividend[63:0] = {{32{div_dividend_tmp[31]}}, div_dividend_tmp[31:0]};
    default : div_dividend[63:0] = div_dividend_tmp[63:0];
  endcase
// &CombEnd @50
end

// &CombBeg; @52
always @( div_divisor_tmp[63:0]
       or div_sign_ext
       or div_unsign_ext)
begin
  casez({div_sign_ext, div_unsign_ext})
    2'b01 :   div_divisor[63:0] = {32'b0, div_divisor_tmp[31:0]};
    2'b10 :   div_divisor[63:0] = {{32{div_divisor_tmp[31]}}, div_divisor_tmp[31:0]};
    default : div_divisor[63:0] = div_divisor_tmp[63:0];
  endcase
// &CombEnd @58
end


// &Force("bus", "idu_iu_ex1_dst_preg", 5, 0); @61
always @ (posedge div_clk)
begin
  if (ifu_iu_warm_up)
    div_dst_preg[4:0] <= 5'b0;
  else if (div_inst_vld)
    div_dst_preg[4:0] <= idu_iu_ex1_dst_preg[4:0];
end


//==========================================================
//                  DIV Main State Machine
//==========================================================
parameter IDLE  = 3'b000,
          WFI2  = 3'b001,
          ALIGN = 3'b010,
          ITER  = 3'b011,
          CMPLT = 3'b100,
          WFWB  = 3'b101; // EX2 stall set and must wait for wb.

always @ (posedge div_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    div_cur_state[2:0] <= IDLE;
  else
    div_cur_state[2:0] <= div_next_state[2:0];
end

// &CombBeg; @89
always @( div_iter_start
       or div_ex2_enable_wb
       or div_ex1_res_vld
       or div_cur_state
       or div_iter_cmplt)
begin
case (div_cur_state)
  IDLE:
  begin
    if (div_iter_start)
      div_next_state = WFI2;
    else if (div_ex1_res_vld)
      div_next_state = WFWB;
    else
      div_next_state = IDLE;
  end
  WFI2:
    div_next_state = ALIGN;
  ALIGN:
    div_next_state = ITER;
  ITER:
  begin
    if (div_iter_cmplt)
      div_next_state = CMPLT;
    else
      div_next_state = ITER;
  end
  CMPLT:
  begin
    if (div_ex2_enable_wb)
      if (div_iter_start)
        div_next_state = WFI2;
      else if (div_ex1_res_vld)
        div_next_state = WFWB;
      else
        div_next_state = IDLE;
    else
      div_next_state = WFWB;
  end
  WFWB:
  begin
    if (div_ex2_enable_wb)
      if (div_iter_start)
        div_next_state = WFI2;
      else if (div_ex1_res_vld)
        div_next_state = WFWB;
      else
        div_next_state = IDLE;
    else
      div_next_state = WFWB;
  end
  default:
    div_next_state = IDLE;
endcase
// &CombEnd; @138
end


assign div_is_idle      = div_cur_state == IDLE
                       || div_ex2_res_vld;       // Next state will be IDLE;
assign div_iter_start   = div_inst_vld && !div_ex1_res_vld_raw;
assign div_prepare_src0 = div_is_idle &&  div_iter_start;
assign div_prepare_src1 = div_cur_state == WFI2;
assign div_align        = div_cur_state == ALIGN;
assign div_iterating    = div_cur_state == ITER;
assign div_cmplt        = div_cur_state == CMPLT;
assign div_wfwb         = div_cur_state == WFWB;


//==========================================================
//                 Special Result Judgement
//==========================================================
// Judge if abnormal result or not
assign div_dividend_eq0                 = div_dividend[63:0] == 64'b0;
assign div_divisor_eq0                  = div_divisor[63:0] == 64'b0;

assign div_ex1_dividend_overflow[63:0]  = div_oper_is_word ? 64'hffff_ffff_8000_0000 : 64'h8000_0000_0000_0000;
assign div_res_overflow                 = div_oper_is_signed
                                       && (div_dividend[63:0] == div_ex1_dividend_overflow[63:0])
                                       && (div_divisor[63:0] == 64'hffff_ffff_ffff_ffff);

assign div_abnormal_res_vld             = div_dividend_eq0
                                       || div_divisor_eq0
                                       || div_res_overflow;

assign div_hit_buffer_res_vld           = div_hit_buffer && !div_abnormal_res_vld;

assign div_ex1_res_vld_raw              = (div_abnormal_res_vld || div_hit_buffer_res_vld) && div_is_idle;
assign div_ex1_res_vld                  = div_ex1_res_vld_raw && div_inst_vld;

// two cycle op
assign div_ex1_res_onehot[3:0]          = {div_hit_buffer_res_vld, div_dividend_eq0 && !div_divisor_eq0, div_divisor_eq0, div_res_overflow};

always @(posedge div_clk)
begin
  if (ifu_iu_warm_up) begin
    div_ex1_res_onehot_flop[3:0] <= 4'b0;
  end
  else if (div_ex1_res_vld)begin
    div_ex1_res_onehot_flop[3:0] <= div_ex1_res_onehot[3:0];
  end
end

assign div_special_res_vld_update = div_is_idle && div_inst_vld;
assign div_buffer_update          = div_is_idle && div_inst_vld;
always @(posedge div_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    div_special_res_vld <= 1'b0;
  end
  else if (div_special_res_vld_update)begin
    div_special_res_vld <= div_ex1_res_vld_raw;
  end
end

// special result merge
assign div_dividend_overflow[63:0]      = div_oper_is_word_flop ? 64'hffff_ffff_8000_0000 : 64'h8000_0000_0000_0000;
assign div_divisor_eq0_remainder[63:0]  = div_oper_is_word_flop ? {{32{div_dividend_raw[31]}}, div_dividend_raw[31:0]} : div_dividend_raw[63:0];
assign div_special_res[63:0]            = div_res_sel_quotient_flop ? div_special_res_quotient[63:0] : div_special_res_remainder[63:0];

// &CombBeg; @203
always @( div_dividend_overflow[63:0]
       or div_ex1_res_onehot_flop[3:0]
       or div_quotient_res[63:0])
begin
  casez(div_ex1_res_onehot_flop[3:0])
    4'b0001 :  div_special_res_quotient[63:0] = div_dividend_overflow[63:0];
    4'b0010 :  div_special_res_quotient[63:0] = 64'hffff_ffff_ffff_ffff;
    4'b0100 :  div_special_res_quotient[63:0] = 64'b0;
    4'b1000 :  div_special_res_quotient[63:0] = div_quotient_res[63:0];
    default:   div_special_res_quotient[63:0] = {64{1'bx}};
  endcase
// &CombEnd @211
end

// &CombBeg; @213
always @( div_remainder_res[63:0]
       or div_ex1_res_onehot_flop[3:0]
       or div_divisor_eq0_remainder[63:0])
begin
  casez(div_ex1_res_onehot_flop[3:0])
    4'b0001 :  div_special_res_remainder[63:0] = 64'b0;
    4'b0010 :  div_special_res_remainder[63:0] = div_divisor_eq0_remainder[63:0];
    4'b0100 :  div_special_res_remainder[63:0] = 64'b0;
    4'b1000 :  div_special_res_remainder[63:0] = div_remainder_res[63:0];
    default:   div_special_res_remainder[63:0] = {64{1'bx}};
  endcase
// &CombEnd @221
end


//==========================================================
//                       Abs and FF1
//==========================================================
// Calculate ABS and find first 1 @ IDLE and WFI2
// div_prepare_src0 is dirty. Must use other signal as ctrl signal.
assign div_abs_src[63:0] = div_prepare_src1 ? div_divisor_reg[63:0]
                                            : div_dividend[63:0];

assign div_is_signed     = div_prepare_src1 ? div_oper_is_signed_flop
                                            : div_oper_is_signed;

assign div_src_is_neg    = div_is_signed ? div_abs_src[63]
                                         : 1'b0;

assign div_abs_res[63:0] = div_src_is_neg ? ~div_abs_src[63:0] + 64'b1
                                          :  div_abs_src[63:0];

assign div_ff1_src[63:0] = div_abs_src[63:0];
// &CombBeg; @242
always @( div_ff1_src[63:0])
begin
  casez(div_ff1_src[63:0])
    64'b1???????????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd63;
    64'b01??????????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd62;
    64'b001?????????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd61;
    64'b0001????????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd60;
    64'b00001???????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd59;
    64'b000001??????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd58;
    64'b0000001?????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd57;
    64'b00000001????????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd56;
    64'b000000001???????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd55;
    64'b0000000001??????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd54;
    64'b00000000001?????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd53;
    64'b000000000001????????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd52;
    64'b0000000000001???????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd51;
    64'b00000000000001??????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd50;
    64'b000000000000001?????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd49;
    64'b0000000000000001????????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd48;
    64'b00000000000000001???????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd47;
    64'b000000000000000001??????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd46;
    64'b0000000000000000001?????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd45;
    64'b00000000000000000001????????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd44;
    64'b000000000000000000001???????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd43;
    64'b0000000000000000000001??????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd42;
    64'b00000000000000000000001?????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd41;
    64'b000000000000000000000001????????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd40;
    64'b0000000000000000000000001???????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd39;
    64'b00000000000000000000000001??????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd38;
    64'b000000000000000000000000001?????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd37;
    64'b0000000000000000000000000001????????????????????????????????????: div_ff1_res_pos[5:0] = 6'd36;
    64'b00000000000000000000000000001???????????????????????????????????: div_ff1_res_pos[5:0] = 6'd35;
    64'b000000000000000000000000000001??????????????????????????????????: div_ff1_res_pos[5:0] = 6'd34;
    64'b0000000000000000000000000000001?????????????????????????????????: div_ff1_res_pos[5:0] = 6'd33;
    64'b00000000000000000000000000000001????????????????????????????????: div_ff1_res_pos[5:0] = 6'd32;
    64'b000000000000000000000000000000001???????????????????????????????: div_ff1_res_pos[5:0] = 6'd31;
    64'b0000000000000000000000000000000001??????????????????????????????: div_ff1_res_pos[5:0] = 6'd30;
    64'b00000000000000000000000000000000001?????????????????????????????: div_ff1_res_pos[5:0] = 6'd29;
    64'b000000000000000000000000000000000001????????????????????????????: div_ff1_res_pos[5:0] = 6'd28;
    64'b0000000000000000000000000000000000001???????????????????????????: div_ff1_res_pos[5:0] = 6'd27;
    64'b00000000000000000000000000000000000001??????????????????????????: div_ff1_res_pos[5:0] = 6'd26;
    64'b000000000000000000000000000000000000001?????????????????????????: div_ff1_res_pos[5:0] = 6'd25;
    64'b0000000000000000000000000000000000000001????????????????????????: div_ff1_res_pos[5:0] = 6'd24;
    64'b00000000000000000000000000000000000000001???????????????????????: div_ff1_res_pos[5:0] = 6'd23;
    64'b000000000000000000000000000000000000000001??????????????????????: div_ff1_res_pos[5:0] = 6'd22;
    64'b0000000000000000000000000000000000000000001?????????????????????: div_ff1_res_pos[5:0] = 6'd21;
    64'b00000000000000000000000000000000000000000001????????????????????: div_ff1_res_pos[5:0] = 6'd20;
    64'b000000000000000000000000000000000000000000001???????????????????: div_ff1_res_pos[5:0] = 6'd19;
    64'b0000000000000000000000000000000000000000000001??????????????????: div_ff1_res_pos[5:0] = 6'd18;
    64'b00000000000000000000000000000000000000000000001?????????????????: div_ff1_res_pos[5:0] = 6'd17;
    64'b000000000000000000000000000000000000000000000001????????????????: div_ff1_res_pos[5:0] = 6'd16;
    64'b0000000000000000000000000000000000000000000000001???????????????: div_ff1_res_pos[5:0] = 6'd15;
    64'b00000000000000000000000000000000000000000000000001??????????????: div_ff1_res_pos[5:0] = 6'd14;
    64'b000000000000000000000000000000000000000000000000001?????????????: div_ff1_res_pos[5:0] = 6'd13;
    64'b0000000000000000000000000000000000000000000000000001????????????: div_ff1_res_pos[5:0] = 6'd12;
    64'b00000000000000000000000000000000000000000000000000001???????????: div_ff1_res_pos[5:0] = 6'd11;
    64'b000000000000000000000000000000000000000000000000000001??????????: div_ff1_res_pos[5:0] = 6'd10;
    64'b0000000000000000000000000000000000000000000000000000001?????????: div_ff1_res_pos[5:0] = 6'd9;
    64'b00000000000000000000000000000000000000000000000000000001????????: div_ff1_res_pos[5:0] = 6'd8;
    64'b000000000000000000000000000000000000000000000000000000001???????: div_ff1_res_pos[5:0] = 6'd7;
    64'b0000000000000000000000000000000000000000000000000000000001??????: div_ff1_res_pos[5:0] = 6'd6;
    64'b00000000000000000000000000000000000000000000000000000000001?????: div_ff1_res_pos[5:0] = 6'd5;
    64'b000000000000000000000000000000000000000000000000000000000001????: div_ff1_res_pos[5:0] = 6'd4;
    64'b0000000000000000000000000000000000000000000000000000000000001???: div_ff1_res_pos[5:0] = 6'd3;
    64'b00000000000000000000000000000000000000000000000000000000000001??: div_ff1_res_pos[5:0] = 6'd2;
    64'b000000000000000000000000000000000000000000000000000000000000001?: div_ff1_res_pos[5:0] = 6'd1;
    64'b0000000000000000000000000000000000000000000000000000000000000001: div_ff1_res_pos[5:0] = 6'd0;
    64'b0000000000000000000000000000000000000000000000000000000000000000: div_ff1_res_pos[5:0] = 6'd0;
    default:                                                              div_ff1_res_pos[5:0] = {6{1'bx}};
endcase
// &CombEnd; @311
end


//----------------------------------------------------------
//                       Negetive FF1
//----------------------------------------------------------
assign div_ff1_res_neg[5:0] =
//  {6{ !div_ff1_src[63]                 && !(|div_ff1_src[61:0])}} & 6'd63
//| {6{ !div_ff1_src[63]                 &&  (|div_ff1_src[61:0])}} & 6'd0
  {6{  div_ff1_src[63]     && !div_ff1_src[62] && !(|div_ff1_src[61:0])}} & 6'd63
| {6{  div_ff1_src[63]     && !div_ff1_src[62] &&  (|div_ff1_src[61:0])}} & 6'd62
| {6{(&div_ff1_src[63:62]) && !div_ff1_src[61] && !(|div_ff1_src[60:0])}} & 6'd62
| {6{(&div_ff1_src[63:62]) && !div_ff1_src[61] &&  (|div_ff1_src[60:0])}} & 6'd61
| {6{(&div_ff1_src[63:61]) && !div_ff1_src[60] && !(|div_ff1_src[59:0])}} & 6'd61
| {6{(&div_ff1_src[63:61]) && !div_ff1_src[60] &&  (|div_ff1_src[59:0])}} & 6'd60
| {6{(&div_ff1_src[63:60]) && !div_ff1_src[59] && !(|div_ff1_src[58:0])}} & 6'd60
| {6{(&div_ff1_src[63:60]) && !div_ff1_src[59] &&  (|div_ff1_src[58:0])}} & 6'd59
| {6{(&div_ff1_src[63:59]) && !div_ff1_src[58] && !(|div_ff1_src[57:0])}} & 6'd59
| {6{(&div_ff1_src[63:59]) && !div_ff1_src[58] &&  (|div_ff1_src[57:0])}} & 6'd58
| {6{(&div_ff1_src[63:58]) && !div_ff1_src[57] && !(|div_ff1_src[56:0])}} & 6'd58
| {6{(&div_ff1_src[63:58]) && !div_ff1_src[57] &&  (|div_ff1_src[56:0])}} & 6'd57
| {6{(&div_ff1_src[63:57]) && !div_ff1_src[56] && !(|div_ff1_src[55:0])}} & 6'd57
| {6{(&div_ff1_src[63:57]) && !div_ff1_src[56] &&  (|div_ff1_src[55:0])}} & 6'd56
| {6{(&div_ff1_src[63:56]) && !div_ff1_src[55] && !(|div_ff1_src[54:0])}} & 6'd56
| {6{(&div_ff1_src[63:56]) && !div_ff1_src[55] &&  (|div_ff1_src[54:0])}} & 6'd55
| {6{(&div_ff1_src[63:55]) && !div_ff1_src[54] && !(|div_ff1_src[53:0])}} & 6'd55
| {6{(&div_ff1_src[63:55]) && !div_ff1_src[54] &&  (|div_ff1_src[53:0])}} & 6'd54
| {6{(&div_ff1_src[63:54]) && !div_ff1_src[53] && !(|div_ff1_src[52:0])}} & 6'd54
| {6{(&div_ff1_src[63:54]) && !div_ff1_src[53] &&  (|div_ff1_src[52:0])}} & 6'd53
| {6{(&div_ff1_src[63:53]) && !div_ff1_src[52] && !(|div_ff1_src[51:0])}} & 6'd53
| {6{(&div_ff1_src[63:53]) && !div_ff1_src[52] &&  (|div_ff1_src[51:0])}} & 6'd52
| {6{(&div_ff1_src[63:52]) && !div_ff1_src[51] && !(|div_ff1_src[50:0])}} & 6'd52
| {6{(&div_ff1_src[63:52]) && !div_ff1_src[51] &&  (|div_ff1_src[50:0])}} & 6'd51
| {6{(&div_ff1_src[63:51]) && !div_ff1_src[50] && !(|div_ff1_src[49:0])}} & 6'd51
| {6{(&div_ff1_src[63:51]) && !div_ff1_src[50] &&  (|div_ff1_src[49:0])}} & 6'd50
| {6{(&div_ff1_src[63:50]) && !div_ff1_src[49] && !(|div_ff1_src[48:0])}} & 6'd50
| {6{(&div_ff1_src[63:50]) && !div_ff1_src[49] &&  (|div_ff1_src[48:0])}} & 6'd49
| {6{(&div_ff1_src[63:49]) && !div_ff1_src[48] && !(|div_ff1_src[47:0])}} & 6'd49
| {6{(&div_ff1_src[63:49]) && !div_ff1_src[48] &&  (|div_ff1_src[47:0])}} & 6'd48
| {6{(&div_ff1_src[63:48]) && !div_ff1_src[47] && !(|div_ff1_src[46:0])}} & 6'd48
| {6{(&div_ff1_src[63:48]) && !div_ff1_src[47] &&  (|div_ff1_src[46:0])}} & 6'd47
| {6{(&div_ff1_src[63:47]) && !div_ff1_src[46] && !(|div_ff1_src[45:0])}} & 6'd47
| {6{(&div_ff1_src[63:47]) && !div_ff1_src[46] &&  (|div_ff1_src[45:0])}} & 6'd46
| {6{(&div_ff1_src[63:46]) && !div_ff1_src[45] && !(|div_ff1_src[44:0])}} & 6'd46
| {6{(&div_ff1_src[63:46]) && !div_ff1_src[45] &&  (|div_ff1_src[44:0])}} & 6'd45
| {6{(&div_ff1_src[63:45]) && !div_ff1_src[44] && !(|div_ff1_src[43:0])}} & 6'd45
| {6{(&div_ff1_src[63:45]) && !div_ff1_src[44] &&  (|div_ff1_src[43:0])}} & 6'd44
| {6{(&div_ff1_src[63:44]) && !div_ff1_src[43] && !(|div_ff1_src[42:0])}} & 6'd44
| {6{(&div_ff1_src[63:44]) && !div_ff1_src[43] &&  (|div_ff1_src[42:0])}} & 6'd43
| {6{(&div_ff1_src[63:43]) && !div_ff1_src[42] && !(|div_ff1_src[41:0])}} & 6'd43
| {6{(&div_ff1_src[63:43]) && !div_ff1_src[42] &&  (|div_ff1_src[41:0])}} & 6'd42
| {6{(&div_ff1_src[63:42]) && !div_ff1_src[41] && !(|div_ff1_src[40:0])}} & 6'd42
| {6{(&div_ff1_src[63:42]) && !div_ff1_src[41] &&  (|div_ff1_src[40:0])}} & 6'd41
| {6{(&div_ff1_src[63:41]) && !div_ff1_src[40] && !(|div_ff1_src[39:0])}} & 6'd41
| {6{(&div_ff1_src[63:41]) && !div_ff1_src[40] &&  (|div_ff1_src[39:0])}} & 6'd40
| {6{(&div_ff1_src[63:40]) && !div_ff1_src[39] && !(|div_ff1_src[38:0])}} & 6'd40
| {6{(&div_ff1_src[63:40]) && !div_ff1_src[39] &&  (|div_ff1_src[38:0])}} & 6'd39
| {6{(&div_ff1_src[63:39]) && !div_ff1_src[38] && !(|div_ff1_src[37:0])}} & 6'd39
| {6{(&div_ff1_src[63:39]) && !div_ff1_src[38] &&  (|div_ff1_src[37:0])}} & 6'd38
| {6{(&div_ff1_src[63:38]) && !div_ff1_src[37] && !(|div_ff1_src[36:0])}} & 6'd38
| {6{(&div_ff1_src[63:38]) && !div_ff1_src[37] &&  (|div_ff1_src[36:0])}} & 6'd37
| {6{(&div_ff1_src[63:37]) && !div_ff1_src[36] && !(|div_ff1_src[35:0])}} & 6'd37
| {6{(&div_ff1_src[63:37]) && !div_ff1_src[36] &&  (|div_ff1_src[35:0])}} & 6'd36
| {6{(&div_ff1_src[63:36]) && !div_ff1_src[35] && !(|div_ff1_src[34:0])}} & 6'd36
| {6{(&div_ff1_src[63:36]) && !div_ff1_src[35] &&  (|div_ff1_src[34:0])}} & 6'd35
| {6{(&div_ff1_src[63:35]) && !div_ff1_src[34] && !(|div_ff1_src[33:0])}} & 6'd35
| {6{(&div_ff1_src[63:35]) && !div_ff1_src[34] &&  (|div_ff1_src[33:0])}} & 6'd34
| {6{(&div_ff1_src[63:34]) && !div_ff1_src[33] && !(|div_ff1_src[32:0])}} & 6'd34
| {6{(&div_ff1_src[63:34]) && !div_ff1_src[33] &&  (|div_ff1_src[32:0])}} & 6'd33
| {6{(&div_ff1_src[63:33]) && !div_ff1_src[32] && !(|div_ff1_src[31:0])}} & 6'd33
| {6{(&div_ff1_src[63:33]) && !div_ff1_src[32] &&  (|div_ff1_src[31:0])}} & 6'd32
| {6{(&div_ff1_src[63:32]) && !div_ff1_src[31] && !(|div_ff1_src[30:0])}} & 6'd32
| {6{(&div_ff1_src[63:32]) && !div_ff1_src[31] &&  (|div_ff1_src[30:0])}} & 6'd31
| {6{(&div_ff1_src[63:31]) && !div_ff1_src[30] && !(|div_ff1_src[29:0])}} & 6'd31
| {6{(&div_ff1_src[63:31]) && !div_ff1_src[30] &&  (|div_ff1_src[29:0])}} & 6'd30
| {6{(&div_ff1_src[63:30]) && !div_ff1_src[29] && !(|div_ff1_src[28:0])}} & 6'd30
| {6{(&div_ff1_src[63:30]) && !div_ff1_src[29] &&  (|div_ff1_src[28:0])}} & 6'd29
| {6{(&div_ff1_src[63:29]) && !div_ff1_src[28] && !(|div_ff1_src[27:0])}} & 6'd29
| {6{(&div_ff1_src[63:29]) && !div_ff1_src[28] &&  (|div_ff1_src[27:0])}} & 6'd28
| {6{(&div_ff1_src[63:28]) && !div_ff1_src[27] && !(|div_ff1_src[26:0])}} & 6'd28
| {6{(&div_ff1_src[63:28]) && !div_ff1_src[27] &&  (|div_ff1_src[26:0])}} & 6'd27
| {6{(&div_ff1_src[63:27]) && !div_ff1_src[26] && !(|div_ff1_src[25:0])}} & 6'd27
| {6{(&div_ff1_src[63:27]) && !div_ff1_src[26] &&  (|div_ff1_src[25:0])}} & 6'd26
| {6{(&div_ff1_src[63:26]) && !div_ff1_src[25] && !(|div_ff1_src[24:0])}} & 6'd26
| {6{(&div_ff1_src[63:26]) && !div_ff1_src[25] &&  (|div_ff1_src[24:0])}} & 6'd25
| {6{(&div_ff1_src[63:25]) && !div_ff1_src[24] && !(|div_ff1_src[23:0])}} & 6'd25
| {6{(&div_ff1_src[63:25]) && !div_ff1_src[24] &&  (|div_ff1_src[23:0])}} & 6'd24
| {6{(&div_ff1_src[63:24]) && !div_ff1_src[23] && !(|div_ff1_src[22:0])}} & 6'd24
| {6{(&div_ff1_src[63:24]) && !div_ff1_src[23] &&  (|div_ff1_src[22:0])}} & 6'd23
| {6{(&div_ff1_src[63:23]) && !div_ff1_src[22] && !(|div_ff1_src[21:0])}} & 6'd23
| {6{(&div_ff1_src[63:23]) && !div_ff1_src[22] &&  (|div_ff1_src[21:0])}} & 6'd22
| {6{(&div_ff1_src[63:22]) && !div_ff1_src[21] && !(|div_ff1_src[20:0])}} & 6'd22
| {6{(&div_ff1_src[63:22]) && !div_ff1_src[21] &&  (|div_ff1_src[20:0])}} & 6'd21
| {6{(&div_ff1_src[63:21]) && !div_ff1_src[20] && !(|div_ff1_src[19:0])}} & 6'd21
| {6{(&div_ff1_src[63:21]) && !div_ff1_src[20] &&  (|div_ff1_src[19:0])}} & 6'd20
| {6{(&div_ff1_src[63:20]) && !div_ff1_src[19] && !(|div_ff1_src[18:0])}} & 6'd20
| {6{(&div_ff1_src[63:20]) && !div_ff1_src[19] &&  (|div_ff1_src[18:0])}} & 6'd19
| {6{(&div_ff1_src[63:19]) && !div_ff1_src[18] && !(|div_ff1_src[17:0])}} & 6'd19
| {6{(&div_ff1_src[63:19]) && !div_ff1_src[18] &&  (|div_ff1_src[17:0])}} & 6'd18
| {6{(&div_ff1_src[63:18]) && !div_ff1_src[17] && !(|div_ff1_src[16:0])}} & 6'd18
| {6{(&div_ff1_src[63:18]) && !div_ff1_src[17] &&  (|div_ff1_src[16:0])}} & 6'd17
| {6{(&div_ff1_src[63:17]) && !div_ff1_src[16] && !(|div_ff1_src[15:0])}} & 6'd17
| {6{(&div_ff1_src[63:17]) && !div_ff1_src[16] &&  (|div_ff1_src[15:0])}} & 6'd16
| {6{(&div_ff1_src[63:16]) && !div_ff1_src[15] && !(|div_ff1_src[14:0])}} & 6'd16
| {6{(&div_ff1_src[63:16]) && !div_ff1_src[15] &&  (|div_ff1_src[14:0])}} & 6'd15
| {6{(&div_ff1_src[63:15]) && !div_ff1_src[14] && !(|div_ff1_src[13:0])}} & 6'd15
| {6{(&div_ff1_src[63:15]) && !div_ff1_src[14] &&  (|div_ff1_src[13:0])}} & 6'd14
| {6{(&div_ff1_src[63:14]) && !div_ff1_src[13] && !(|div_ff1_src[12:0])}} & 6'd14
| {6{(&div_ff1_src[63:14]) && !div_ff1_src[13] &&  (|div_ff1_src[12:0])}} & 6'd13
| {6{(&div_ff1_src[63:13]) && !div_ff1_src[12] && !(|div_ff1_src[11:0])}} & 6'd13
| {6{(&div_ff1_src[63:13]) && !div_ff1_src[12] &&  (|div_ff1_src[11:0])}} & 6'd12
| {6{(&div_ff1_src[63:12]) && !div_ff1_src[11] && !(|div_ff1_src[10:0])}} & 6'd12
| {6{(&div_ff1_src[63:12]) && !div_ff1_src[11] &&  (|div_ff1_src[10:0])}} & 6'd11
| {6{(&div_ff1_src[63:11]) && !div_ff1_src[10] && !(|div_ff1_src[9:0])}}  & 6'd11
| {6{(&div_ff1_src[63:11]) && !div_ff1_src[10] &&  (|div_ff1_src[9:0])}}  & 6'd10
| {6{(&div_ff1_src[63:10]) && !div_ff1_src[9]  && !(|div_ff1_src[8:0])}}  & 6'd10
| {6{(&div_ff1_src[63:10]) && !div_ff1_src[9]  &&  (|div_ff1_src[8:0])}}  & 6'd9
| {6{(&div_ff1_src[63:9])  && !div_ff1_src[8]  && !(|div_ff1_src[7:0])}}  & 6'd9
| {6{(&div_ff1_src[63:9])  && !div_ff1_src[8]  &&  (|div_ff1_src[7:0])}}  & 6'd8
| {6{(&div_ff1_src[63:8])  && !div_ff1_src[7]  && !(|div_ff1_src[6:0])}}  & 6'd8
| {6{(&div_ff1_src[63:8])  && !div_ff1_src[7]  &&  (|div_ff1_src[6:0])}}  & 6'd7
| {6{(&div_ff1_src[63:7])  && !div_ff1_src[6]  && !(|div_ff1_src[5:0])}}  & 6'd7
| {6{(&div_ff1_src[63:7])  && !div_ff1_src[6]  &&  (|div_ff1_src[5:0])}}  & 6'd6
| {6{(&div_ff1_src[63:6])  && !div_ff1_src[5]  && !(|div_ff1_src[4:0])}}  & 6'd6
| {6{(&div_ff1_src[63:6])  && !div_ff1_src[5]  &&  (|div_ff1_src[4:0])}}  & 6'd5
| {6{(&div_ff1_src[63:5])  && !div_ff1_src[4]  && !(|div_ff1_src[3:0])}}  & 6'd5
| {6{(&div_ff1_src[63:5])  && !div_ff1_src[4]  &&  (|div_ff1_src[3:0])}}  & 6'd4
| {6{(&div_ff1_src[63:4])  && !div_ff1_src[3]  && !(|div_ff1_src[2:0])}}  & 6'd4
| {6{(&div_ff1_src[63:4])  && !div_ff1_src[3]  &&  (|div_ff1_src[2:0])}}  & 6'd3
| {6{(&div_ff1_src[63:3])  && !div_ff1_src[2]  && !(|div_ff1_src[1:0])}}  & 6'd3
| {6{(&div_ff1_src[63:3])  && !div_ff1_src[2]  &&  (|div_ff1_src[1:0])}}  & 6'd2
| {6{(&div_ff1_src[63:2])  && !div_ff1_src[1]  &&   !div_ff1_src[0]}}     & 6'd2
| {6{(&div_ff1_src[63:2])  && !div_ff1_src[1]  &&    div_ff1_src[0]}}     & 6'd1
| {6{(&div_ff1_src[63:1])  && !div_ff1_src[0]}}                           & 6'd1
| {6{(&div_ff1_src[63:0])}}                                               & 6'd0;

assign div_ff1_res[5:0] = div_src_is_neg ? div_ff1_res_neg[5:0]
                                         : div_ff1_res_pos[5:0];

always @ (posedge div_clk)
begin
  if (ifu_iu_warm_up) begin
    div_oper_is_signed_flop   <= 1'b0;
    div_divisor_63            <= 1'b0;
  end
  else if (div_inst_vld) begin
    div_oper_is_signed_flop   <= div_oper_is_signed;
    div_divisor_63            <= div_divisor[63];
  end
end

always @ (posedge div_clk)
begin
  if (ifu_iu_warm_up) begin
    div_res_sel_quotient_flop <= 1'b0;
    div_oper_is_word_flop     <= 1'b0;
  end
  else if (div_prepare_src0 || div_ex1_res_vld) begin
    div_res_sel_quotient_flop <= div_res_sel_quotient;
    div_oper_is_word_flop     <= div_oper_is_word;
  end
end

assign div_dividend_63       = div_dividend_raw[63];
assign div_res_quotient_neg  = div_oper_is_signed_flop && (div_dividend_63 ^ div_divisor_63);
assign div_res_remainder_neg = div_oper_is_signed_flop && div_dividend_63;

// Save div_divisor @ WFI2, hold the value @ ITERdiv_ex1_res_vld
// divisor_raw will be saved in div_divisor_reg after DIV_CMPLT.
always @ (posedge div_clk)
begin
  if (ifu_iu_warm_up)
    div_divisor_reg[63:0] <= 64'b0;
  else if (div_buffer_update)
    div_divisor_reg[63:0] <= div_divisor[63:0];
  else if (div_prepare_src1)
    div_divisor_reg[63:0] <= div_abs_res[63:0];
  else if (div_divisor_update)
    div_divisor_reg[63:0] <= div_divisor_update_data[63:0];
  else if (div_iter_cmplt)
    div_divisor_reg[63:0] <= div_divisor_raw[63:0];
end

assign div_divisor_update     = div_cur_state == ALIGN || div_cur_state == ITER && !div_iter_cmplt;
assign div_divisor_raw_is_neg = div_oper_is_signed_flop && div_divisor_63;
assign div_diviosr_abs_data[63:0]  = div_divisor_reg[63:0];
assign div_divisor_raw[63:0]       = div_divisor_raw_is_neg ? ~div_diviosr_abs_data[63:0] + 64'b1
                                                            :  div_diviosr_abs_data[63:0];

// Save the initial value @ IDLE, change the value @ITER
always @ (posedge div_clk)
begin
  if (ifu_iu_warm_up) begin
    div_quotient_reg[63:0]  <= 64'b0;
    div_remainder_reg[63:0] <= 64'b0;
  end
  else if (div_prepare_src0) begin
    div_quotient_reg[63:0]  <= 64'b0;
    div_remainder_reg[63:0] <= div_abs_res[63:0];
  end
  else if (div_cmplt) begin
    div_quotient_reg[63:0]  <= div_normal_quotient[63:0];
    div_remainder_reg[63:0] <= div_normal_remainder[63:0];
  end
  else if (div_iterating) begin
    div_quotient_reg[63:0]  <= div_quotient_reg_updt[63:0];
    div_remainder_reg[63:0] <= div_remainder_reg_updt[63:0];
  end
end

// Do iteration compare @ ITER.
// &Instance("aq_iu_div_shift2_kernel", "x_aq_iu_div_kernel"); @522
aq_iu_div_shift2_kernel  x_aq_iu_div_kernel (
  .cpurst_b                (cpurst_b               ),
  .div_align               (div_align              ),
  .div_clk                 (div_clk                ),
  .div_divisor_reg         (div_divisor_reg        ),
  .div_divisor_update_data (div_divisor_update_data),
  .div_ff1_res             (div_ff1_res            ),
  .div_iter_cmplt          (div_iter_cmplt         ),
  .div_iterating           (div_iterating          ),
  .div_prepare_src0        (div_prepare_src0       ),
  .div_prepare_src1        (div_prepare_src1       ),
  .div_quotient_reg        (div_quotient_reg       ),
  .div_quotient_reg_updt   (div_quotient_reg_updt  ),
  .div_remainder_reg       (div_remainder_reg      ),
  .div_remainder_reg_updt  (div_remainder_reg_updt ),
  .ifu_iu_warm_up          (ifu_iu_warm_up         )
);


assign div_normal_quotient_raw[63:0]  = div_res_quotient_neg ? ~div_quotient_reg[63:0] + 64'b1
                                                             :  div_quotient_reg[63:0];
assign div_normal_remainder_raw[63:0] = div_res_remainder_neg ? ~div_remainder_reg[63:0] + 64'b1
                                                              :  div_remainder_reg[63:0];

assign div_normal_quotient[63:0] = div_oper_is_word_flop ? {{32{div_normal_quotient_raw[31]}}, div_normal_quotient_raw[31:0]}
                                                          : div_normal_quotient_raw[63:0];
assign div_normal_remainder[63:0] = div_oper_is_word_flop ? {{32{div_normal_remainder_raw[31]}}, div_normal_remainder_raw[31:0]}
                                                          : div_normal_remainder_raw[63:0];

assign div_quotient_res[63:0]  = div_cmplt ? div_normal_quotient[63:0]
                                           : div_quotient_reg[63:0];
assign div_remainder_res[63:0] = div_cmplt ? div_normal_remainder[63:0]
                                           : div_remainder_reg[63:0];

assign div_ex2_enable_wb       = rtu_iu_div_wb_grant;
assign div_ex2_res_vld_raw     = div_cmplt || div_wfwb;    // div main state
assign div_ex2_res_vld         = div_ex2_res_vld_raw && rtu_iu_div_wb_grant;
assign div_ex2_res_raw[63:0]   = div_res_sel_quotient_flop ? div_quotient_res[63:0] : div_remainder_res[63:0];
assign div_ex2_res[63:0]       = div_special_res_vld       ? div_special_res[63:0]  : div_ex2_res_raw[63:0];


//==========================================================
//                   Rename for Output
//==========================================================
assign iu_rtu_ex1_div_cmplt      = idu_iu_ex1_div_sel;
assign iu_rtu_ex1_div_cmplt_dp   = idu_iu_ex1_div_dp_sel;

assign iu_rtu_div_wb_dp      = div_cmplt || div_wfwb;
assign iu_rtu_div_wb_vld     = div_cmplt || div_wfwb;
assign iu_rtu_div_preg_raw[4:0]  =  div_dst_preg[4:0];
assign iu_rtu_div_preg[5:0]      = {1'b0, iu_rtu_div_preg_raw[4:0]};
assign iu_rtu_div_data[63:0]     = div_ex2_res[63:0];

assign iu_idu_div_full = (div_cmplt || div_wfwb) && !rtu_iu_div_wb_grant_for_full || div_prepare_src1 || div_align || div_iterating;


//==========================================================
//                      DIV buffer
//==========================================================
// DIV Has one buffer for div fuse and speed up calculation
always @ (posedge div_clk)
begin
  if (ifu_iu_warm_up)
    div_dividend_raw[63:0] <= 64'b0;
  else if (div_buffer_update)
    div_dividend_raw[63:0] <= div_dividend[63:0];
end

assign div_dividend_hit_buffer = div_dividend_raw[63:0] == div_dividend[63:0];
assign div_divisor_hit_buffer  = div_divisor_reg[63:0]  == div_divisor[63:0];
assign div_signed_hit_buffer   = div_oper_is_signed_flop == div_oper_is_signed;
assign div_word_hit_buffer     = div_oper_is_word_flop  == div_oper_is_word;

assign div_hit_buffer = div_dividend_hit_buffer
                     && div_divisor_hit_buffer
                     && div_signed_hit_buffer
                     && div_word_hit_buffer;


//==========================================================
//                       Gate Cell
//==========================================================
assign div_clk_en_raw   = idu_div_ex1_gateclk_sel || div_cur_state != IDLE;
assign div_ctrl_no_op   = div_cur_state == IDLE;


//==========================================================
//                  DIV gateclk
//==========================================================
assign div_clk_en = div_clk_en_raw
                 || ifu_iu_warm_up;

// &Instance("gated_clk_cell", "x_div_clk"); @597
gated_clk_cell  x_div_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (div_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (div_clk_en        ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @598
//          .external_en (1'b0), @599
//          .global_en   (cp0_yy_clk_en), @600
//          .module_en   (cp0_iu_icg_en), @601
//          .local_en    (div_clk_en), @602
//          .clk_out     (div_clk)); @603


assign div_dbginfo[2:0] = div_cur_state[2:0];





// &ModuleEnd; @625
endmodule


