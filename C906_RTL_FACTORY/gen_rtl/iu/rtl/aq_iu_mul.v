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
module aq_iu_mul(
  cp0_iu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  idu_iu_ex1_dst_preg,
  idu_iu_ex1_func,
  idu_iu_ex1_mult_dp_sel,
  idu_iu_ex1_mult_sel,
  idu_iu_ex1_src0,
  idu_iu_ex1_src1,
  idu_iu_ex1_src2,
  idu_mult_ex1_gateclk_sel,
  ifu_iu_warm_up,
  iu_idu_mult_full,
  iu_idu_mult_issue_stall,
  iu_rtu_ex1_mul_cmplt,
  iu_rtu_ex1_mul_cmplt_dp,
  iu_rtu_ex3_mul_data,
  iu_rtu_ex3_mul_preg,
  iu_rtu_ex3_mul_wb_vld,
  mul_ctrl_no_op,
  mul_dbginfo,
  pad_yy_icg_scan_en,
  rtu_iu_mul_wb_grant,
  rtu_iu_mul_wb_grant_for_full,
  rtu_yy_xx_flush_fe
);

// &Ports; @24
input            cp0_iu_icg_en;               
input            cp0_yy_clk_en;               
input            cpurst_b;                    
input            forever_cpuclk;              
input   [5  :0]  idu_iu_ex1_dst_preg;         
input   [19 :0]  idu_iu_ex1_func;             
input            idu_iu_ex1_mult_dp_sel;      
input            idu_iu_ex1_mult_sel;         
input   [63 :0]  idu_iu_ex1_src0;             
input   [63 :0]  idu_iu_ex1_src1;             
input   [63 :0]  idu_iu_ex1_src2;             
input            idu_mult_ex1_gateclk_sel;    
input            ifu_iu_warm_up;              
input            pad_yy_icg_scan_en;          
input            rtu_iu_mul_wb_grant;         
input            rtu_iu_mul_wb_grant_for_full; 
input            rtu_yy_xx_flush_fe;          
output           iu_idu_mult_full;            
output           iu_idu_mult_issue_stall;     
output           iu_rtu_ex1_mul_cmplt;        
output           iu_rtu_ex1_mul_cmplt_dp;     
output  [63 :0]  iu_rtu_ex3_mul_data;         
output  [5  :0]  iu_rtu_ex3_mul_preg;         
output           iu_rtu_ex3_mul_wb_vld;       
output           mul_ctrl_no_op;              
output  [1  :0]  mul_dbginfo;                 

// &Regs; @25
reg     [1  :0]  mul_cur_state;               
reg     [32 :0]  mul_ex1_nosplit_src0;        
reg     [32 :0]  mul_ex1_nosplit_src1;        
reg     [32 :0]  mul_ex1_split_src0;          
reg     [32 :0]  mul_ex1_split_src1;          
reg     [63 :0]  mul_ex1_src2;                
reg              mul_ex2_high;                
reg              mul_ex2_inst_vld;            
reg     [1  :0]  mul_ex2_iter_count;          
reg              mul_ex2_itering;             
reg     [4  :0]  mul_ex2_preg;                
reg     [32 :0]  mul_ex2_rs0;                 
reg     [32 :0]  mul_ex2_rs1;                 
reg              mul_ex2_rst_32;              
reg     [63 :0]  mul_ex2_src2;                
reg              mul_ex2_sub;                 
reg     [68 :0]  mul_ex3_acc_rst;             
reg     [68 :0]  mul_ex3_fwd_data;            
reg              mul_ex3_high;                
reg              mul_ex3_inst_vld;            
reg     [1  :0]  mul_ex3_iter_count;          
reg              mul_ex3_itering;             
reg     [63 :0]  mul_ex3_low_64;              
reg     [68 :0]  mul_ex3_part_p0;             
reg     [68 :0]  mul_ex3_part_p1;             
reg     [4  :0]  mul_ex3_preg;                
reg              mul_ex3_rst_32;              
reg              mul_ex3_sub;                 
reg     [1  :0]  mul_next_state;              

// &Wires; @26
wire             cp0_iu_icg_en;               
wire             cp0_yy_clk_en;               
wire             cpurst_b;                    
wire             forever_cpuclk;              
wire    [5  :0]  idu_iu_ex1_dst_preg;         
wire    [19 :0]  idu_iu_ex1_func;             
wire             idu_iu_ex1_mult_dp_sel;      
wire             idu_iu_ex1_mult_sel;         
wire    [63 :0]  idu_iu_ex1_src0;             
wire    [63 :0]  idu_iu_ex1_src1;             
wire    [63 :0]  idu_iu_ex1_src2;             
wire             idu_mult_ex1_gateclk_sel;    
wire             ifu_iu_warm_up;              
wire             iu_idu_mult_full;            
wire             iu_idu_mult_issue_stall;     
wire             iu_rtu_ex1_mul_cmplt;        
wire             iu_rtu_ex1_mul_cmplt_dp;     
wire    [63 :0]  iu_rtu_ex3_mul_data;         
wire    [5  :0]  iu_rtu_ex3_mul_preg;         
wire             iu_rtu_ex3_mul_wb_vld;       
wire             mul_clk;                     
wire             mul_clk_en;                  
wire             mul_ctrl_no_op;              
wire    [1  :0]  mul_dbginfo;                 
wire             mul_ex1_add;                 
wire             mul_ex1_choose_nosplit;      
wire             mul_ex1_cmplt_raw;           
wire             mul_ex1_ctrl_pipe_clk;       
wire             mul_ex1_ctrl_pipe_clk_en;    
wire    [19 :0]  mul_ex1_func;                
wire             mul_ex1_high;                
wire             mul_ex1_inst16;              
wire             mul_ex1_inst32;              
wire             mul_ex1_inst64;              
wire             mul_ex1_inst64_nosplit;      
wire             mul_ex1_inst_vld;            
wire             mul_ex1_iter_start;          
wire             mul_ex1_iter_start_raw;      
wire             mul_ex1_pipedown;            
wire             mul_ex1_pipedown_clk;        
wire             mul_ex1_pipedown_clk_en;     
wire    [4  :0]  mul_ex1_preg;                
wire    [32 :0]  mul_ex1_rs0;                 
wire    [32 :0]  mul_ex1_rs1;                 
wire             mul_ex1_rst_32;              
wire             mul_ex1_sign;                
wire             mul_ex1_src0_high_judge;     
wire             mul_ex1_src0_sign64;         
wire    [63 :0]  mul_ex1_src0_tmp;            
wire             mul_ex1_src1_high_judge;     
wire             mul_ex1_src1_sign64;         
wire    [63 :0]  mul_ex1_src1_tmp;            
wire    [63 :0]  mul_ex1_src2_tmp;            
wire             mul_ex1_su;                  
wire             mul_ex1_sub;                 
wire             mul_ex1_sub_add;             
wire             mul_ex1_usign;               
wire    [68 :0]  mul_ex2_accumulate_rst;      
wire             mul_ex2_accumulate_src2_sel; 
wire             mul_ex2_ctrl_pipe_clk;       
wire             mul_ex2_ctrl_pipe_clk_en;    
wire    [68 :0]  mul_ex2_part_product0;       
wire    [68 :0]  mul_ex2_part_product0_raw;   
wire    [68 :0]  mul_ex2_part_product1;       
wire    [68 :0]  mul_ex2_part_product1_raw;   
wire             mul_ex2_pipedown;            
wire             mul_ex2_pipedown_clk;        
wire             mul_ex2_pipedown_clk_en;     
wire             mul_ex2_stall;               
wire    [68 :0]  mul_ex3_4_2_rs0;             
wire    [68 :0]  mul_ex3_4_2_rs1;             
wire    [68 :0]  mul_ex3_4_2_rs2;             
wire    [127:0]  mul_ex3_adder_rst;           
wire    [68 :0]  mul_ex3_adder_rst_tmp;       
wire             mul_ex3_low_64_32_update;    
wire             mul_ex3_low_64_64_update;    
wire    [63 :0]  mul_ex3_rst;                 
wire    [63 :0]  mul_ex3_rst_high;            
wire    [63 :0]  mul_ex3_rst_inst32;          
wire             mul_ex3_shift_bit;           
wire             mul_ex3_stall;               
wire             mul_ex3_wb_vld;              
wire             mul_iter;                    
wire    [1  :0]  mul_iter_count;              
wire             mul_itering;                 
wire             mul_src2_high_32;            
wire             mul_src2_low_32;             
wire             mul_src2_zero;               
wire    [31 :0]  mult_round;                  
wire             mult_sub;                    
wire    [32 :0]  multi_rs0;                   
wire    [32 :0]  multi_rs1;                   
wire    [32 :0]  multiplicand;                
wire    [32 :0]  multiplier;                  
wire             pad_yy_icg_scan_en;          
wire    [68 :0]  result_0;                    
wire    [68 :0]  result_1;                    
wire             rtu_iu_mul_wb_grant;         
wire             rtu_iu_mul_wb_grant_for_full; 
wire             rtu_yy_xx_flush_fe;          


parameter IDLE   = 2'b00,
          SPLIT0 = 2'b01,
          SPLIT1 = 2'b10,
          CMPLT  = 2'b11; // EX2 stall set and must wait for wb.

assign mul_ex1_inst_vld = idu_iu_ex1_mult_sel;
assign mul_ex1_cmplt_raw = mul_cur_state == IDLE && !mul_ex1_iter_start_raw || mul_cur_state == CMPLT;
assign mul_dbginfo[1:0]  = mul_cur_state[1:0];


//==========================================================
//                    EX1 Operation Prepare
//==========================================================
// Operand mux
assign mul_ex1_func[19:0] = {20{idu_iu_ex1_mult_dp_sel}} & idu_iu_ex1_func[19:0];
assign mul_ex1_src0_tmp[63:0] = {64{idu_iu_ex1_mult_dp_sel}} & idu_iu_ex1_src0[63:0];
assign mul_ex1_src1_tmp[63:0] = {64{idu_iu_ex1_mult_dp_sel}} & idu_iu_ex1_src1[63:0];
assign mul_ex1_src2_tmp[63:0] = {64{idu_iu_ex1_mult_dp_sel}} & idu_iu_ex1_src2[63:0];

assign mul_ex1_inst64 = mul_ex1_func[0];
assign mul_ex1_inst32 = mul_ex1_func[1];
assign mul_ex1_inst16 = mul_ex1_func[2];
assign mul_ex1_add    = mul_ex1_func[3];
assign mul_ex1_sub    = mul_ex1_func[4];
assign mul_ex1_sign   = mul_ex1_func[5];
assign mul_ex1_su     = mul_ex1_func[6];
assign mul_ex1_usign  = mul_ex1_func[7];
assign mul_ex1_high   = mul_ex1_func[8];
assign mul_ex1_preg[4:0] = idu_iu_ex1_dst_preg[4:0];

// if not add or sub, src2 should be zero
assign mul_ex1_sub_add = mul_ex1_add || mul_ex1_sub;
assign mul_src2_zero   = !mul_ex1_sub_add && !mul_ex1_inst16;
assign mul_src2_low_32 = mul_ex1_inst16 || mul_ex1_inst32 && mul_ex1_sub_add;
assign mul_src2_high_32 = mul_ex1_inst64 && mul_ex1_sub_add;
assign mul_ex1_rst_32   = mul_ex1_inst32 || mul_ex1_inst16; // use to ex3 sign ext

// &CombBeg; @65
always @( mul_src2_high_32
       or mul_ex1_src2_tmp[63:0]
       or mul_src2_zero
       or mul_src2_low_32)
begin
  case({mul_src2_high_32, mul_src2_low_32, mul_src2_zero})
    3'b001 : mul_ex1_src2[63:0] = 64'b0;
    3'b010 : mul_ex1_src2[63:0] = {{32{mul_ex1_src2_tmp[31]}}, mul_ex1_src2_tmp[31:0]}; // 16 or 32 bit msub/madd inst
    3'b100 : mul_ex1_src2[63:0] = mul_ex1_src2_tmp[63:0];  // 64 bit madd/msub inst
    default: mul_ex1_src2[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @72
end


//----------------------------------------------------------
//                    Split Judge
//----------------------------------------------------------
//Only inst64 need judge
// 1. judge if sign op
assign mul_ex1_src0_sign64 = !mul_ex1_usign;
assign mul_ex1_src1_sign64 = mul_ex1_sign && !mul_ex1_su;

assign mul_ex1_src0_high_judge = mul_ex1_src0_tmp[63:32] == 32'b0 ||
                                 mul_ex1_src0_tmp[63:32] == {32{1'b1}} && mul_ex1_src0_sign64;
assign mul_ex1_src1_high_judge = mul_ex1_src1_tmp[63:32] == 32'b0 ||
                                 mul_ex1_src1_tmp[63:32] == {32{1'b1}} && mul_ex1_src1_sign64;

assign mul_ex1_inst64_nosplit  = mul_ex1_src0_high_judge && mul_ex1_src1_high_judge;
assign mul_ex1_iter_start      = mul_ex1_inst64 && !mul_ex1_inst64_nosplit && idu_iu_ex1_mult_sel;
assign mul_ex1_iter_start_raw  = mul_ex1_inst64 && !mul_ex1_inst64_nosplit;

// 2. judge src: split or nosplit
// nosplit src0
// &CombBeg; @94
always @( mul_ex1_inst32
       or mul_ex1_inst64
       or mul_ex1_src0_tmp[32:0]
       or mul_ex1_inst16)
begin
  case({mul_ex1_inst64, mul_ex1_inst32, mul_ex1_inst16})
    3'b001 :  mul_ex1_nosplit_src0[32:0] = {{17{mul_ex1_src0_tmp[15]}}, mul_ex1_src0_tmp[15:0]};
    3'b010 :  mul_ex1_nosplit_src0[32:0] = {mul_ex1_src0_tmp[31], mul_ex1_src0_tmp[31:0]};
    3'b100 :  mul_ex1_nosplit_src0[32:0] = mul_ex1_src0_tmp[32:0];
    default:  mul_ex1_nosplit_src0[32:0] = {33{1'bx}};
  endcase
// &CombEnd; @101
end

// nosplit src1
// &CombBeg; @104
always @( mul_ex1_inst32
       or mul_ex1_src1_tmp[32:0]
       or mul_ex1_inst64
       or mul_ex1_inst16)
begin
  case({mul_ex1_inst64, mul_ex1_inst32, mul_ex1_inst16})
    3'b001 :  mul_ex1_nosplit_src1[32:0] = {{17{mul_ex1_src1_tmp[15]}}, mul_ex1_src1_tmp[15:0]};
    3'b010 :  mul_ex1_nosplit_src1[32:0] = {mul_ex1_src1_tmp[31], mul_ex1_src1_tmp[31:0]};
    3'b100 :  mul_ex1_nosplit_src1[32:0] = mul_ex1_src1_tmp[32:0];
    default:  mul_ex1_nosplit_src1[32:0] = {33{1'bx}};
  endcase
// &CombEnd; @111
end

// split src0
// &CombBeg; @114
always @( mul_ex1_src0_tmp[63:0]
       or mul_iter_count[1:0]
       or mul_ex1_src0_sign64)
begin
  case(mul_iter_count[1:0])
    2'b00 :  mul_ex1_split_src0[32:0] = {1'b0, mul_ex1_src0_tmp[31:0]};
    2'b01 :  mul_ex1_split_src0[32:0] = {1'b0, mul_ex1_src0_tmp[31:0]};
    2'b10 :  mul_ex1_split_src0[32:0] = {mul_ex1_src0_tmp[63] & mul_ex1_src0_sign64, mul_ex1_src0_tmp[63:32]};
    2'b11 :  mul_ex1_split_src0[32:0] = {mul_ex1_src0_tmp[63] & mul_ex1_src0_sign64, mul_ex1_src0_tmp[63:32]};
    default: mul_ex1_split_src0[32:0] = {33{1'bx}};
  endcase
// &CombEnd; @122
end

// split src1
// &CombBeg; @125
always @( mul_iter_count[1:0]
       or mul_ex1_src1_sign64
       or mul_ex1_src1_tmp[63:0])
begin
  case(mul_iter_count[1:0])
    2'b00 :  mul_ex1_split_src1[32:0] = {1'b0, mul_ex1_src1_tmp[31:0]};
    2'b01 :  mul_ex1_split_src1[32:0] = {mul_ex1_src1_tmp[63] & mul_ex1_src1_sign64, mul_ex1_src1_tmp[63:32]};
    2'b10 :  mul_ex1_split_src1[32:0] = {1'b0, mul_ex1_src1_tmp[31:0]};
    2'b11 :  mul_ex1_split_src1[32:0] = {mul_ex1_src1_tmp[63] & mul_ex1_src1_sign64, mul_ex1_src1_tmp[63:32]};
    default: mul_ex1_split_src1[32:0] = {33{1'bx}};
  endcase
// &CombEnd; @133
end

assign mul_ex1_choose_nosplit = mul_iter_count[1:0] == 2'b0 && !mul_ex1_iter_start;
assign mul_ex1_rs0[32:0] = mul_ex1_choose_nosplit ? mul_ex1_nosplit_src0[32:0] : mul_ex1_split_src0[32:0];
assign mul_ex1_rs1[32:0] = mul_ex1_choose_nosplit ? mul_ex1_nosplit_src1[32:0] : mul_ex1_split_src1[32:0];


//----------------------------------------------------------
//                    Split FSM
//----------------------------------------------------------
always @ (posedge mul_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mul_cur_state[1:0] <= IDLE;
  else if(rtu_yy_xx_flush_fe)
    mul_cur_state[1:0] <= IDLE;
  else
    mul_cur_state[1:0] <= mul_next_state[1:0];
end

// &CombBeg; @153
always @( mul_ex1_iter_start
       or mul_ex2_stall
       or mul_cur_state)
begin
case (mul_cur_state)
  IDLE:
  begin
    if (mul_ex1_iter_start)
      mul_next_state = SPLIT0;
    else
      mul_next_state = IDLE;
  end
  SPLIT0:
  begin
    if (!mul_ex2_stall)
      mul_next_state = SPLIT1;
    else
      mul_next_state = SPLIT0;
  end
  SPLIT1:
  begin
    if (!mul_ex2_stall)
      mul_next_state = CMPLT;
    else
      mul_next_state = SPLIT1;
  end
  CMPLT:
  begin
      mul_next_state = IDLE;
  end
   default : mul_next_state = IDLE;
endcase
// &CombEnd; @182
end

assign mul_iter_count[1:0] =  mul_cur_state[1:0];
assign mul_itering    = mul_ex1_iter_start || mul_cur_state != IDLE;
assign mul_iter       = mul_cur_state == SPLIT0 || mul_cur_state == SPLIT1;
//assign mul_iter_cmplt = mul_cur_state == CMPLT;
//assign mul_iter_count_update[1:0] = mul_iter_count[1:0] + 2'b1;

//always @ (posedge mul_clk or negedge cpurst_b)
//begin
//  if (!cpurst_b)
//    mul_iter_count[1:0] <= 2'b0;
//  else if(rtu_yy_xx_flush_fe)
//    mul_iter_count[1:0] <= 2'b0;
//  else if(mul_iter_cmplt)
//    mul_iter_count[1:0] <= 2'b0;
//  else if(mul_itering && !mul_ex2_stall)
//    mul_iter_count[1:0] <= mul_iter_count_update[1:0];
//end


//==========================================================
//                    EX1 Pipedown to EX2
//==========================================================
assign mul_ex1_pipedown = mul_ex1_inst_vld && !mul_ex2_stall;
always @ (posedge mul_ex1_pipedown_clk)
begin
  if(mul_ex1_pipedown || ifu_iu_warm_up)
  begin
    mul_ex2_sub        <= mul_ex1_sub;
    mul_ex2_high       <= mul_ex1_high;
    mul_ex2_rst_32     <= mul_ex1_rst_32;
    mul_ex2_itering    <= mul_itering;
    mul_ex2_rs0[32:0]  <= mul_ex1_rs0[32:0];
    mul_ex2_rs1[32:0]  <= mul_ex1_rs1[32:0];
    mul_ex2_src2[63:0] <= mul_ex1_src2[63:0];
    mul_ex2_iter_count[1:0] <= mul_iter_count[1:0];
    mul_ex2_preg[4:0]       <= mul_ex1_preg[4:0];
  end
end
// &Force("bus", "idu_iu_ex1_dst_preg", 5, 0); @222

//----------------------------------------------------------
//                   33x33 Multiplication
//----------------------------------------------------------
assign multi_rs0[32:0] = mul_ex2_rs0[32:0];
assign multi_rs1[32:0] = mul_ex2_rs1[32:0];
// &Force("nonport", "multi_rs0"); @229
// &Force("nonport", "multi_rs1"); @230
// &Force("nonport", "result_0"); @231
// &Force("nonport", "result_1"); @232

// &Instance("multiplier_33x33_partial"); @235
multiplier_33x33_partial  x_multiplier_33x33_partial (
  .mult_round   (mult_round  ),
  .mult_sub     (mult_sub    ),
  .multiplicand (multiplicand),
  .multiplier   (multiplier  ),
  .result_0     (result_0    ),
  .result_1     (result_1    )
);

assign mult_round[31:0] = 32'd0;
assign mult_sub         = 1'b0;
assign multiplicand[32:0] = multi_rs0[32:0];
assign multiplier[32:0]   = multi_rs1[32:0];
// &Force("bus", "result_0", 68, 0); @240
// &Force("bus", "result_1", 68, 0); @241
assign mul_ex2_part_product0_raw[68:0] = result_0[68:0];
assign mul_ex2_part_product1_raw[68:0] = result_1[68:0];


assign mul_ex2_part_product0[68:0] = mul_ex2_sub ? ~mul_ex2_part_product0_raw[68:0] : mul_ex2_part_product0_raw[68:0];
assign mul_ex2_part_product1[68:0] = mul_ex2_sub ? ~mul_ex2_part_product1_raw[68:0] : mul_ex2_part_product1_raw[68:0];
assign mul_ex2_accumulate_src2_sel = mul_ex2_iter_count[1:0] == 2'b0;
assign mul_ex2_accumulate_rst[68:0] = mul_ex2_accumulate_src2_sel ? {{5{mul_ex2_src2[63]}}, mul_ex2_src2[63:0]} : mul_ex3_fwd_data[68:0];

assign mul_ex2_stall = mul_ex3_stall && mul_ex2_inst_vld;


//==========================================================
//                    EX2 Pipedown to EX3
//==========================================================
assign mul_ex2_pipedown = mul_ex2_inst_vld && !mul_ex3_stall;
always @ (posedge mul_ex2_pipedown_clk)
begin
  if(mul_ex2_pipedown || ifu_iu_warm_up)
  begin
    mul_ex3_acc_rst[68:0]  <= mul_ex2_accumulate_rst[68:0];
    mul_ex3_part_p0[68:0]   <= mul_ex2_part_product0[68:0];
    mul_ex3_part_p1[68:0]   <= mul_ex2_part_product1[68:0];
    mul_ex3_sub             <= mul_ex2_sub;
    mul_ex3_high            <= mul_ex2_high;
    mul_ex3_rst_32          <= mul_ex2_rst_32;
    mul_ex3_itering         <= mul_ex2_itering;
    mul_ex3_iter_count[1:0] <= mul_ex2_iter_count[1:0];
    mul_ex3_preg[4:0]       <= mul_ex2_preg[4:0];
  end
end

// part_p0 shift
//&CombBeg;
//  case(mul_ex3_iter_count[1:0])
//    2'b00 :  mul_ex3_4_2_rs0[131:0] = {{64{mul_ex3_part_p0[67]}}, mul_ex3_part_p0[67:0]};
//    2'b01 :  mul_ex3_4_2_rs0[131:0] = {{32{mul_ex3_part_p0[67]}}, mul_ex3_part_p0[67:0], 32'b0};
//    2'b10 :  mul_ex3_4_2_rs0[131:0] = {{32{mul_ex3_part_p0[67]}}, mul_ex3_part_p0[67:0], 32'b0};
//    2'b11 :  mul_ex3_4_2_rs0[131:0] = {mul_ex3_part_p0[67:0], 64'b0};
//    default: mul_ex3_4_2_rs0[131:0] = {132{1'bx}};
//  endcase
//&CombEnd;
assign mul_ex3_4_2_rs0[68:0] = mul_ex3_part_p0[68:0];

// part_p1_shift
//&CombBeg;
//  case(mul_ex3_iter_count[1:0])
//    2'b00 :  mul_ex3_4_2_rs1[131:0] = {{64{mul_ex3_part_p1[67]}}, mul_ex3_part_p1[67:0]};
//    2'b01 :  mul_ex3_4_2_rs1[131:0] = {{32{mul_ex3_part_p1[67]}}, mul_ex3_part_p1[67:0], 32'b0};
//    2'b10 :  mul_ex3_4_2_rs1[131:0] = {{32{mul_ex3_part_p1[67]}}, mul_ex3_part_p1[67:0], 32'b0};
//    2'b11 :  mul_ex3_4_2_rs1[131:0] = {mul_ex3_part_p1[67:0], 64'b0};
//    default: mul_ex3_4_2_rs1[131:0] = {132{1'bx}};
//  endcase
//&CombEnd;
assign mul_ex3_4_2_rs1[68:0] = mul_ex3_part_p1[68:0];

// 10_shiftt
assign mul_ex3_shift_bit = mul_ex3_sub;
//&CombBeg;
//  case(mul_ex3_iter_count[1:0])
//    2'b00 :  mul_ex3_4_2_rs2[65:0] = {64'b0, mul_ex3_shift_bit, 1'b0};
//    2'b01 :  mul_ex3_4_2_rs2[65:0] = {32'b0, mul_ex3_shift_bit, 33'b0};
//    2'b10 :  mul_ex3_4_2_rs2[65:0] = {32'b0, mul_ex3_shift_bit, 33'b0};
//    2'b11 :  mul_ex3_4_2_rs2[65:0] = {mul_ex3_shift_bit, 65'b0};
//    default: mul_ex3_4_2_rs2[65:0] = {66{1'bx}};
//  endcase
//&CombEnd;
assign mul_ex3_4_2_rs2[68:0] = {67'b0, mul_ex3_shift_bit, 1'b0};
//assign mul_ex3_c_in          = mul_ex3_c_in_acc & (|mul_ex3_iter_count[1:0]);



// Ex3 4-2 Compressor
assign mul_ex3_adder_rst_tmp[68:0] = mul_ex3_4_2_rs0[68:0] + mul_ex3_4_2_rs1[68:0] + mul_ex3_4_2_rs2[68:0] + mul_ex3_acc_rst[68:0];

// &CombBeg; @329
always @( mul_ex3_adder_rst_tmp[68:0]
       or mul_ex3_iter_count[0])
begin
  case(mul_ex3_iter_count[0])
    1'b0 :   mul_ex3_fwd_data[68:0] = {{32{mul_ex3_adder_rst_tmp[68]}}, mul_ex3_adder_rst_tmp[68:32]};
    1'b1 :   mul_ex3_fwd_data[68:0] = mul_ex3_adder_rst_tmp[68:0];
    default: mul_ex3_fwd_data[68:0] = {69{1'bx}};
  endcase
// &CombEnd; @335
end


assign mul_ex3_adder_rst[127:0] = mul_ex3_itering ? {mul_ex3_adder_rst_tmp[63:0], mul_ex3_low_64[63:0]} : {{59{mul_ex3_adder_rst_tmp[68]}}, mul_ex3_adder_rst_tmp[68:0]};

// Ex3 rst merge
assign mul_ex3_rst_inst32[63:0] = {{32{mul_ex3_adder_rst[31]}}, mul_ex3_adder_rst[31:0]};
assign mul_ex3_rst_high[63:0]   = mul_ex3_adder_rst[127:64];
assign mul_ex3_rst[63:0]        = mul_ex3_high ? mul_ex3_rst_high[63:0]
                                               :  mul_ex3_rst_32 ? mul_ex3_rst_inst32[63:0]
                                                                 : mul_ex3_adder_rst[63:0];

assign mul_ex3_wb_vld = (mul_ex3_itering && mul_ex3_iter_count[1:0] == 2'b11 || !mul_ex3_itering) && mul_ex3_inst_vld;
assign mul_ex3_stall  = mul_ex3_wb_vld && !rtu_iu_mul_wb_grant;

assign mul_ex3_low_64_32_update = mul_ex3_itering && !(|mul_ex3_iter_count[1:0]);
assign mul_ex3_low_64_64_update = mul_ex3_iter_count[1:0] == 2'b10;

always @ (posedge mul_ex2_pipedown_clk)
begin
  if(ifu_iu_warm_up)
    mul_ex3_low_64[31:0] <= 32'b0;
  else if(mul_ex3_low_64_32_update && mul_ex2_pipedown)
    mul_ex3_low_64[31:0] <= mul_ex3_adder_rst_tmp[31:0];
end

always @ (posedge mul_ex2_pipedown_clk)
begin
  if(ifu_iu_warm_up)
    mul_ex3_low_64[63:32] <= 32'b0;
  else if(mul_ex3_low_64_64_update && mul_ex2_pipedown)
    mul_ex3_low_64[63:32] <= mul_ex3_adder_rst_tmp[31:0];
end

//==========================================================
//                    Output signals
//==========================================================
//----------------------------------------------------------
//                   RTU signal
//----------------------------------------------------------
assign iu_rtu_ex1_mul_cmplt          = mul_ex1_inst_vld && mul_ex1_cmplt_raw;
assign iu_rtu_ex1_mul_cmplt_dp       = idu_iu_ex1_mult_dp_sel && mul_ex1_cmplt_raw;
assign iu_rtu_ex3_mul_wb_vld     = mul_ex3_wb_vld;
assign iu_rtu_ex3_mul_data[63:0] = mul_ex3_rst[63:0];
assign iu_rtu_ex3_mul_preg[5:0]  = {1'b0, mul_ex3_preg[4:0]};

//----------------------------------------------------------
//                   IDU signal
//----------------------------------------------------------
assign iu_idu_mult_issue_stall = idu_iu_ex1_mult_dp_sel && (mul_cur_state == IDLE && mul_ex1_iter_start || mul_iter);
assign iu_idu_mult_full        = mul_ex2_inst_vld && !mul_ex2_itering && mul_ex3_wb_vld && !rtu_iu_mul_wb_grant_for_full;


//==========================================================
//                    Gate Clk Cell
//==========================================================
assign mul_ex1_pipedown_clk_en  = idu_mult_ex1_gateclk_sel || ifu_iu_warm_up;
// &Instance("gated_clk_cell", "x_mul_ex1_pipe_gated_clk"); @392
gated_clk_cell  x_mul_ex1_pipe_gated_clk (
  .clk_in                  (forever_cpuclk         ),
  .clk_out                 (mul_ex1_pipedown_clk   ),
  .external_en             (1'b0                   ),
  .global_en               (cp0_yy_clk_en          ),
  .local_en                (mul_ex1_pipedown_clk_en),
  .module_en               (cp0_iu_icg_en          ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     )
);

// &Connect(.clk_in      (forever_cpuclk        ), @393
//          .external_en (1'b0                  ), @394
//          .global_en   (cp0_yy_clk_en         ), @395
//          .module_en   (cp0_iu_icg_en         ), @396
//          .local_en    (mul_ex1_pipedown_clk_en ), @397
//          .clk_out     (mul_ex1_pipedown_clk  )); @398

assign mul_ex2_pipedown_clk_en  = mul_ex2_inst_vld && !mul_ex2_stall || ifu_iu_warm_up;
// &Instance("gated_clk_cell", "x_mul_ex2_pipe_gated_clk"); @401
gated_clk_cell  x_mul_ex2_pipe_gated_clk (
  .clk_in                  (forever_cpuclk         ),
  .clk_out                 (mul_ex2_pipedown_clk   ),
  .external_en             (1'b0                   ),
  .global_en               (cp0_yy_clk_en          ),
  .local_en                (mul_ex2_pipedown_clk_en),
  .module_en               (cp0_iu_icg_en          ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     )
);

// &Connect(.clk_in      (forever_cpuclk        ), @402
//          .external_en (1'b0                  ), @403
//          .global_en   (cp0_yy_clk_en         ), @404
//          .module_en   (cp0_iu_icg_en         ), @405
//          .local_en    (mul_ex2_pipedown_clk_en ), @406
//          .clk_out     (mul_ex2_pipedown_clk  )); @407

assign mul_clk_en  = idu_mult_ex1_gateclk_sel;
// &Instance("gated_clk_cell", "x_mul_gated_clk"); @410
gated_clk_cell  x_mul_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (mul_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (mul_clk_en        ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk        ), @411
//          .external_en (1'b0                  ), @412
//          .global_en   (cp0_yy_clk_en         ), @413
//          .module_en   (cp0_iu_icg_en         ), @414
//          .local_en    (mul_clk_en            ), @415
//          .clk_out     (mul_clk              )); @416


//==========================================================
//                    Inst_vld Pipedown
//==========================================================
assign mul_ex1_ctrl_pipe_clk_en = idu_mult_ex1_gateclk_sel || mul_ex2_inst_vld;
// &Instance("gated_clk_cell", "x_mul_ex1_ctrl_pipe_gated_clk"); @423
gated_clk_cell  x_mul_ex1_ctrl_pipe_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (mul_ex1_ctrl_pipe_clk   ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (mul_ex1_ctrl_pipe_clk_en),
  .module_en                (cp0_iu_icg_en           ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect(.clk_in      (forever_cpuclk      ), @424
//          .external_en (1'b0                ), @425
//          .global_en   (cp0_yy_clk_en       ), @426
//          .module_en   (cp0_iu_icg_en       ), @427
//          .local_en    (mul_ex1_ctrl_pipe_clk_en ), @428
//          .clk_out     (mul_ex1_ctrl_pipe_clk    )); @429

always@(posedge mul_ex1_ctrl_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mul_ex2_inst_vld <= 1'b0;
  else if(!mul_ex2_stall)
    mul_ex2_inst_vld <= mul_ex1_inst_vld;
  else
    mul_ex2_inst_vld <= mul_ex2_inst_vld;
end


assign mul_ex2_ctrl_pipe_clk_en = mul_ex2_inst_vld || mul_ex3_inst_vld;
// &Instance("gated_clk_cell", "x_mul_ex2_ctrl_pipe_gated_clk"); @443
gated_clk_cell  x_mul_ex2_ctrl_pipe_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (mul_ex2_ctrl_pipe_clk   ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (mul_ex2_ctrl_pipe_clk_en),
  .module_en                (cp0_iu_icg_en           ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect(.clk_in      (forever_cpuclk      ), @444
//          .external_en (1'b0                ), @445
//          .global_en   (cp0_yy_clk_en       ), @446
//          .module_en   (cp0_iu_icg_en       ), @447
//          .local_en    (mul_ex2_ctrl_pipe_clk_en ), @448
//          .clk_out     (mul_ex2_ctrl_pipe_clk    )); @449

always@(posedge mul_ex2_ctrl_pipe_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mul_ex3_inst_vld <= 1'b0;
  else if(!mul_ex3_stall)
    mul_ex3_inst_vld <= mul_ex2_inst_vld;
  else
    mul_ex3_inst_vld <= mul_ex3_inst_vld;
end

assign mul_ctrl_no_op = !(mul_ex3_inst_vld || mul_ex2_inst_vld);





// &ModuleEnd; @481
endmodule


