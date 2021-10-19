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
module aq_vfmau_special_judge_double(
  cp0_vpu_xx_dqnan,
  ctrl_dp_ex1_inst_pipe_down,
  ctrl_dp_ex2_inst_pipe_down,
  ctrl_dp_ex3_inst_pipe_down,
  ex1_bf16,
  ex1_double,
  ex1_double_expnt_near_of,
  ex1_double_expnt_near_uf,
  ex1_dst_bf16,
  ex1_dst_double,
  ex1_dst_f16,
  ex1_dst_half,
  ex1_dst_single,
  ex1_half,
  ex1_mac,
  ex1_mult_expnt,
  ex1_mult_sign,
  ex1_rm,
  ex1_single,
  ex1_src2_sign,
  ex1_srcv0,
  ex1_srcv1,
  ex1_srcv2,
  ex1_widen,
  ex2_dst_bf16,
  ex2_dst_double,
  ex2_dst_f16,
  ex2_dst_half,
  ex2_dst_single,
  ex2_special_sel,
  ex3_dst_double,
  ex3_mult_double_result,
  ex3_mult_nx,
  ex3_special_data_vld,
  ex3_special_fflags,
  ex3_special_result,
  ex4_mult_double_nx,
  ex4_mult_double_result,
  fmau_ex2_data_clk,
  fmau_ex3_data_clk,
  fmau_ex4_data_clk,
  ifu_vpu_warm_up,
  vpu_group_0_xx_ex1_srcv0_type,
  vpu_group_0_xx_ex1_srcv1_type,
  vpu_group_0_xx_ex1_srcv2_type
);

// &Ports; @28
input           cp0_vpu_xx_dqnan;             
input           ctrl_dp_ex1_inst_pipe_down;   
input           ctrl_dp_ex2_inst_pipe_down;   
input           ctrl_dp_ex3_inst_pipe_down;   
input           ex1_bf16;                     
input           ex1_double;                   
input           ex1_dst_bf16;                 
input           ex1_dst_double;               
input           ex1_dst_f16;                  
input           ex1_dst_half;                 
input           ex1_dst_single;               
input           ex1_half;                     
input           ex1_mac;                      
input   [12:0]  ex1_mult_expnt;               
input           ex1_mult_sign;                
input   [2 :0]  ex1_rm;                       
input           ex1_single;                   
input           ex1_src2_sign;                
input   [63:0]  ex1_srcv0;                    
input   [63:0]  ex1_srcv1;                    
input   [63:0]  ex1_srcv2;                    
input           ex1_widen;                    
input           ex2_dst_bf16;                 
input           ex2_dst_double;               
input           ex2_dst_f16;                  
input           ex2_dst_half;                 
input           ex2_dst_single;               
input           ex3_dst_double;               
input   [63:0]  ex3_mult_double_result;       
input           ex3_mult_nx;                  
input           fmau_ex2_data_clk;            
input           fmau_ex3_data_clk;            
input           fmau_ex4_data_clk;            
input           ifu_vpu_warm_up;              
input   [47:0]  vpu_group_0_xx_ex1_srcv0_type; 
input   [47:0]  vpu_group_0_xx_ex1_srcv1_type; 
input   [47:0]  vpu_group_0_xx_ex1_srcv2_type; 
output          ex1_double_expnt_near_of;     
output          ex1_double_expnt_near_uf;     
output  [5 :0]  ex2_special_sel;              
output          ex3_special_data_vld;         
output  [1 :0]  ex3_special_fflags;           
output  [63:0]  ex3_special_result;           
output          ex4_mult_double_nx;           
output  [63:0]  ex4_mult_double_result;       

// &Regs; @29
reg     [63:0]  ex1_special_data;             
reg             ex2_fmau_nv;                  
reg             ex2_fmau_of;                  
reg     [63:0]  ex2_special_data;             
reg     [63:0]  ex2_special_result;           
reg     [5 :0]  ex2_special_sel;              
reg     [3 :0]  ex2_special_sign;             
reg             ex3_special_data_vld;         
reg     [1 :0]  ex3_special_fflags;           
reg     [63:0]  ex3_special_result;           
reg             ex4_mult_double_nx;           
reg     [63:0]  ex4_mult_double_result;       

// &Wires; @30
wire            cp0_vpu_xx_dqnan;             
wire            ctrl_dp_ex1_inst_pipe_down;   
wire            ctrl_dp_ex2_inst_pipe_down;   
wire            ctrl_dp_ex3_inst_pipe_down;   
wire            ex1_bf16;                     
wire    [2 :0]  ex1_cnan;                     
wire            ex1_double;                   
wire            ex1_double_expnt_near_of;     
wire            ex1_double_expnt_near_uf;     
wire            ex1_dst_bf16;                 
wire            ex1_dst_double;               
wire            ex1_dst_f16;                  
wire            ex1_dst_half;                 
wire            ex1_dst_single;               
wire            ex1_expnt_11bit;              
wire            ex1_expnt_11bit_of0;          
wire            ex1_expnt_11bit_of1;          
wire            ex1_expnt_5bit;               
wire            ex1_expnt_5bit_of0;           
wire            ex1_expnt_5bit_of1;           
wire            ex1_expnt_8bit;               
wire            ex1_expnt_8bit_of0;           
wire            ex1_expnt_8bit_of1;           
wire            ex1_fmau_inf_sign;            
wire            ex1_fmau_lfn_sign;            
wire            ex1_fmau_nv;                  
wire            ex1_fmau_of;                  
wire            ex1_fmau_result_cnan;         
wire            ex1_fmau_result_inf;          
wire            ex1_fmau_result_lfn;          
wire    [2 :0]  ex1_fmau_result_qnan;         
wire            ex1_fmau_result_src2;         
wire            ex1_fmau_result_zero;         
wire            ex1_fmau_src2_sign;           
wire            ex1_fmau_zero_sign;           
wire            ex1_half;                     
wire    [2 :0]  ex1_inf;                      
wire            ex1_mac;                      
wire    [12:0]  ex1_mult_expnt;               
wire            ex1_mult_sign;                
wire    [2 :0]  ex1_norm;                     
wire    [2 :0]  ex1_nv;                       
wire    [2 :0]  ex1_qnan;                     
wire    [2 :0]  ex1_result_qnan;              
wire            ex1_result_zero;              
wire    [2 :0]  ex1_rm;                       
wire            ex1_single;                   
wire            ex1_single0;                  
wire            ex1_single1;                  
wire    [2 :0]  ex1_snan;                     
wire    [5 :0]  ex1_special_sel;              
wire    [3 :0]  ex1_special_sign;             
wire            ex1_src2_sign;                
wire    [63:0]  ex1_srcv0;                    
wire    [47:0]  ex1_srcv0_type;               
wire    [63:0]  ex1_srcv1;                    
wire    [47:0]  ex1_srcv1_type;               
wire    [63:0]  ex1_srcv2;                    
wire    [47:0]  ex1_srcv2_type;               
wire            ex1_sub_vld;                  
wire            ex1_widen;                    
wire    [63:0]  ex1_widen_srcv0;              
wire    [63:0]  ex1_widen_srcv1;              
wire    [2 :0]  ex1_zero;                     
wire            ex2_dst_bf16;                 
wire            ex2_dst_double;               
wire            ex2_dst_f16;                  
wire            ex2_dst_half;                 
wire            ex2_dst_single;               
wire            ex2_special_data_vld;         
wire            ex3_dst_double;               
wire    [63:0]  ex3_mult_double_result;       
wire            ex3_mult_nx;                  
wire            fmau_ex2_data_clk;            
wire            fmau_ex3_data_clk;            
wire            fmau_ex4_data_clk;            
wire            ifu_vpu_warm_up;              
wire    [47:0]  vpu_group_0_xx_ex1_srcv0_type; 
wire    [47:0]  vpu_group_0_xx_ex1_srcv1_type; 
wire    [47:0]  vpu_group_0_xx_ex1_srcv2_type; 


parameter DOUBLE_WIDTH= 64;
parameter DOUBLE_FRAC = 52;
parameter DOUBLE_EXPN = 11;
parameter ADD_D_WIDTH = 111;

parameter SINGLE_WIDTH= 32;
parameter SINGLE_FRAC = 23;
parameter SINGLE_EXPN =  8;
parameter ADD_S_WIDTH = 53;

parameter HALF_WIDTH  = 16;
parameter HALF_FRAC   = 10;
parameter HALF_EXPN   =  5;

parameter BF16_WIDTH  = 16;
parameter BF16_FRAC   =  7;
parameter BF16_EXPN   =  8;

parameter TYPE_WIDTH   = 48;
parameter DOUBLE_SNAN  = 47;
parameter DOUBLE_QNAN  = 46;
parameter DOUBLE_INF   = 45;
parameter DOUBLE_ZERO  = 44;
parameter DOUBLE_ID    = 43;
parameter DOUBLE_NORM  = 42;
parameter SINGLE0_CNAN = 41;
parameter SINGLE0_SNAN = 40;
parameter SINGLE0_QNAN = 39;
parameter SINGLE0_INF  = 38;
parameter SINGLE0_ZERO = 37;
parameter SINGLE0_ID   = 36;
parameter SINGLE0_NORM = 35;
parameter SINGLE1_CNAN = 34;
parameter SINGLE1_SNAN = 33;
parameter SINGLE1_QNAN = 32;
parameter SINGLE1_INF  = 31;
parameter SINGLE1_ZERO = 30;
parameter SINGLE1_ID   = 29;
parameter SINGLE1_NORM = 28;
parameter HALF0_CNAN   = 27;
parameter HALF0_SNAN   = 26;
parameter HALF0_QNAN   = 25;
parameter HALF0_INF    = 24;
parameter HALF0_ZERO   = 23;
parameter HALF0_ID     = 22;
parameter HALF0_NORM   = 21;
parameter HALF1_CNAN   = 20;
parameter HALF1_SNAN   = 19;
parameter HALF1_QNAN   = 18;
parameter HALF1_INF    = 17;
parameter HALF1_ZERO   = 16;
parameter HALF1_ID     = 15;
parameter HALF1_NORM   = 14;
parameter HALF2_CNAN   = 13;
parameter HALF2_SNAN   = 12;
parameter HALF2_QNAN   = 11;
parameter HALF2_INF    = 10;
parameter HALF2_ZERO   = 9;
parameter HALF2_ID     = 8;
parameter HALF2_NORM   = 7;
parameter HALF3_CNAN   = 6;
parameter HALF3_SNAN   = 5;
parameter HALF3_QNAN   = 4;
parameter HALF3_INF    = 3;
parameter HALF3_ZERO   = 2;
parameter HALF3_ID     = 1;
parameter HALF3_NORM   = 0;

// &Force("bus","vpu_group_0_xx_ex2_srcv2",`VEC_WIDTH-1,0); @100

//==========================================================
//                     EX1 special judge
//==========================================================
assign ex1_srcv0_type[TYPE_WIDTH-1:0] = vpu_group_0_xx_ex1_srcv0_type[TYPE_WIDTH-1:0];
assign ex1_srcv1_type[TYPE_WIDTH-1:0] = vpu_group_0_xx_ex1_srcv1_type[TYPE_WIDTH-1:0];
assign ex1_srcv2_type[TYPE_WIDTH-1:0] = vpu_group_0_xx_ex1_srcv2_type[TYPE_WIDTH-1:0];

assign ex1_single0 = ex1_single;
assign ex1_single1 = 1'b0;

//cnan
assign ex1_cnan[2]   = ex1_dst_single && ex1_srcv2_type[SINGLE0_CNAN] && ex1_mac
                    || ex1_dst_half   && ex1_srcv2_type[HALF0_CNAN]   && ex1_mac;
assign ex1_cnan[1]   = ex1_single0    && ex1_srcv1_type[SINGLE0_CNAN]
                    || ex1_single1    && ex1_srcv1_type[SINGLE1_CNAN]
                    || ex1_half       && ex1_srcv1_type[HALF0_CNAN];
assign ex1_cnan[0]   = ex1_single0    && ex1_srcv0_type[SINGLE0_CNAN]
                    || ex1_single1    && ex1_srcv0_type[SINGLE1_CNAN]
                    || ex1_half       && ex1_srcv0_type[HALF0_CNAN];
//snan
assign ex1_snan[2]   = ex1_dst_double && ex1_srcv2_type[DOUBLE_SNAN]  && ex1_mac
                    || ex1_dst_single && ex1_srcv2_type[SINGLE0_SNAN] && ex1_mac
                    || ex1_dst_half   && ex1_srcv2_type[HALF0_SNAN]   && ex1_mac;
assign ex1_snan[1]   = ex1_double     && ex1_srcv1_type[DOUBLE_SNAN]
                    || ex1_single0    && ex1_srcv1_type[SINGLE0_SNAN]
                    || ex1_single1    && ex1_srcv1_type[SINGLE1_SNAN]
                    || ex1_half       && ex1_srcv1_type[HALF0_SNAN];
assign ex1_snan[0]   = ex1_double     && ex1_srcv0_type[DOUBLE_SNAN]
                    || ex1_single0    && ex1_srcv0_type[SINGLE0_SNAN]
                    || ex1_single1    && ex1_srcv0_type[SINGLE1_SNAN]
                    || ex1_half       && ex1_srcv0_type[HALF0_SNAN];

//qnan
assign ex1_qnan[2]   = ex1_dst_double && ex1_srcv2_type[DOUBLE_QNAN]  && ex1_mac
                    || ex1_dst_single && ex1_srcv2_type[SINGLE0_QNAN] && ex1_mac
                    || ex1_dst_half   && ex1_srcv2_type[HALF0_QNAN]   && ex1_mac;
assign ex1_qnan[1]   = ex1_double     && ex1_srcv1_type[DOUBLE_QNAN]
                    || ex1_single0    && ex1_srcv1_type[SINGLE0_QNAN]
                    || ex1_single1    && ex1_srcv1_type[SINGLE1_QNAN]
                    || ex1_half       && ex1_srcv1_type[HALF0_QNAN];
assign ex1_qnan[0]   = ex1_double     && ex1_srcv0_type[DOUBLE_QNAN]
                    || ex1_single0    && ex1_srcv0_type[SINGLE0_QNAN]
                    || ex1_single1    && ex1_srcv0_type[SINGLE1_QNAN]
                    || ex1_half       && ex1_srcv0_type[HALF0_QNAN];

//norm
assign ex1_norm[2]   = ex1_dst_double && ex1_srcv2_type[DOUBLE_NORM]  && ex1_mac
                    || ex1_dst_single && ex1_srcv2_type[SINGLE0_NORM] && ex1_mac
                    || ex1_dst_half   && ex1_srcv2_type[HALF0_NORM]   && ex1_mac;
assign ex1_norm[1]   = ex1_double     && ex1_srcv1_type[DOUBLE_NORM]
                    || ex1_single0    && ex1_srcv1_type[SINGLE0_NORM]
                    || ex1_single1    && ex1_srcv1_type[SINGLE1_NORM]
                    || ex1_half       && ex1_srcv1_type[HALF0_NORM];
assign ex1_norm[0]   = ex1_double     && ex1_srcv0_type[DOUBLE_NORM]
                    || ex1_single0    && ex1_srcv0_type[SINGLE0_NORM]
                    || ex1_single1    && ex1_srcv0_type[SINGLE1_NORM]
                    || ex1_half       && ex1_srcv0_type[HALF0_NORM];                    

//zero
assign ex1_zero[2]   = ex1_dst_double && ex1_srcv2_type[DOUBLE_ZERO]  && ex1_mac
                    || ex1_dst_single && ex1_srcv2_type[SINGLE0_ZERO] && ex1_mac
                    || ex1_dst_half   && ex1_srcv2_type[HALF0_ZERO]   && ex1_mac
                    || !ex1_mac;
assign ex1_zero[1]   = ex1_double     && ex1_srcv1_type[DOUBLE_ZERO]
                    || ex1_single0    && ex1_srcv1_type[SINGLE0_ZERO]
                    || ex1_single1    && ex1_srcv1_type[SINGLE1_ZERO]
                    || ex1_half       && ex1_srcv1_type[HALF0_ZERO];
assign ex1_zero[0]   = ex1_double     && ex1_srcv0_type[DOUBLE_ZERO]
                    || ex1_single0    && ex1_srcv0_type[SINGLE0_ZERO]
                    || ex1_single1    && ex1_srcv0_type[SINGLE1_ZERO]
                    || ex1_half       && ex1_srcv0_type[HALF0_ZERO];

//inf
assign ex1_inf[2]    = ex1_dst_double && ex1_srcv2_type[DOUBLE_INF]  && ex1_mac
                    || ex1_dst_single && ex1_srcv2_type[SINGLE0_INF] && ex1_mac
                    || ex1_dst_half   && ex1_srcv2_type[HALF0_INF]   && ex1_mac;
assign ex1_inf[1]    = ex1_double     && ex1_srcv1_type[DOUBLE_INF]
                    || ex1_single0    && ex1_srcv1_type[SINGLE0_INF]
                    || ex1_single1    && ex1_srcv1_type[SINGLE1_INF]
                    || ex1_half       && ex1_srcv1_type[HALF0_INF];
assign ex1_inf[0]    = ex1_double     && ex1_srcv0_type[DOUBLE_INF]
                    || ex1_single0    && ex1_srcv0_type[SINGLE0_INF]
                    || ex1_single1    && ex1_srcv0_type[SINGLE1_INF]
                    || ex1_half       && ex1_srcv0_type[HALF0_INF];

                    
//potnt uf/of signal
assign ex1_double_expnt_near_uf = (ex1_mult_expnt[DOUBLE_EXPN+1]  //<-127/-1023
                                   || ! (|ex1_mult_expnt[DOUBLE_EXPN+1:0])) //=-127/-1023
                               && (&ex1_norm[1:0]);

assign ex1_double_expnt_near_of = (ex1_mult_expnt[9 :0]==10'b00_1111_1110)     && ex1_bf16        //126
                               || (ex1_mult_expnt[6 :0]==7'b00_1_1110)         && ex1_dst_f16     //14
                               || (ex1_mult_expnt[9 :0]==10'b00_1111_1110)     && ex1_dst_single  //126
                               || (ex1_mult_expnt[12:0]==13'b00_111_1111_1110) && ex1_dst_double; //1022                    
//Invalid Operation
//BIT0 : sNaN
//BIT1 : INF*0
//BIT3 : INF-INF
assign ex1_nv[0] = |ex1_snan[2:0];   //sNan

assign ex1_nv[1] = (ex1_zero[0] && ex1_inf[1]) //0*inf
                || (ex1_zero[1] && ex1_inf[0]);//inf*0
 
assign ex1_nv[2] = (ex1_inf[0]  && ex1_norm[1] && ex1_inf[2] && ex1_sub_vld)  //inf*F -inf 
                || (ex1_inf[1]  && ex1_norm[0] && ex1_inf[2] && ex1_sub_vld)  //inf*F -inf 
                || (ex1_inf[0]  && ex1_inf[1]  && ex1_inf[2] && ex1_sub_vld); //inf*inf -inf

assign ex1_fmau_nv = |ex1_nv[2:0];

//Overflow
assign ex1_expnt_5bit      = ex1_dst_f16;
assign ex1_expnt_8bit      = ex1_dst_bf16 || ex1_dst_single;
assign ex1_expnt_11bit     = ex1_dst_double;

//of0: expnt>15/127/1023
//of1: expnt== 15/127/1013 && !mac
assign ex1_expnt_5bit_of0  = ex1_mult_expnt[6:5] == 2'b01; 
assign ex1_expnt_5bit_of1  = ex1_mult_expnt[6:0] == 7'b001_1111;
assign ex1_expnt_8bit_of0  = ex1_mult_expnt[9:8] == 2'b01;
assign ex1_expnt_8bit_of1  = ex1_mult_expnt[9:0] == 10'b00_1111_1111;
assign ex1_expnt_11bit_of0 = ex1_mult_expnt[12:11] == 2'b01;
assign ex1_expnt_11bit_of1 = ex1_mult_expnt[12:0] == 13'b00_111_1111_1111;

assign ex1_fmau_of         = (ex1_expnt_5bit_of0  && ex1_expnt_5bit
                              || ex1_expnt_8bit_of0  && ex1_expnt_8bit
                              || ex1_expnt_11bit_of0 && ex1_expnt_11bit)
                              && ((&ex1_norm[1:0]) && (ex1_norm[2] || ex1_zero[2] || !ex1_mac))
                           || (ex1_expnt_5bit_of1  && ex1_expnt_5bit
                              || ex1_expnt_8bit_of1  && ex1_expnt_8bit
                              || ex1_expnt_11bit_of1 && ex1_expnt_11bit)
                              && (&ex1_norm[1:0])
                              && !ex1_mac;

//qNaN
assign ex1_result_qnan[0] = ex1_snan[0]
                         || ex1_qnan[0] && !ex1_snan[1] && !ex1_snan[2];

assign ex1_result_qnan[1] = !ex1_snan[0] && ex1_snan[1]
                         || !ex1_snan[0] &&!ex1_qnan[0] && ex1_qnan[1] && !ex1_snan[2];

assign ex1_result_qnan[2] = !ex1_snan[0] && !ex1_snan[1] &&  ex1_snan[2]
                         || !ex1_snan[0] && !ex1_snan[1] && !ex1_qnan[0] && !ex1_qnan[1] && ex1_qnan[2];

assign ex1_fmau_result_cnan = ex1_result_qnan[0] && (ex1_cnan[0] || !cp0_vpu_xx_dqnan)
                            ||ex1_result_qnan[1] && (ex1_cnan[1] || !cp0_vpu_xx_dqnan)
                            ||ex1_result_qnan[2] && (ex1_cnan[2] || !cp0_vpu_xx_dqnan)
                            ||ex1_nv[1] && !ex1_result_qnan[2]
                            ||ex1_nv[2];

assign ex1_fmau_result_qnan[2:0] = ex1_result_qnan[2:0] & {3{cp0_vpu_xx_dqnan}} & {~ex1_cnan[2:0]};

//zero
assign ex1_result_zero = ex1_zero[0] && ex1_norm[1] && ex1_zero[2]
                      || ex1_zero[1] && ex1_norm[0] && ex1_zero[2] 
                      || ex1_zero[0] && ex1_zero[1] && ex1_zero[2];

assign ex1_fmau_result_zero = ex1_result_zero;

assign ex1_sub_vld        = (ex1_mult_sign ^ ex1_src2_sign) && ex1_mac;
assign ex1_fmau_zero_sign = ex1_sub_vld ? (ex1_rm[2:0]==3'b010) : ex1_mult_sign;

//inf
assign ex1_fmau_result_inf = (|ex1_inf[2:0]) && !(|ex1_result_qnan[2:0]) && !ex1_nv[1] && !ex1_nv[2]
                             ||ex1_fmau_of && 
                             ((ex1_rm[1:0]==2'b00) 
                            || ex1_mult_sign && (ex1_rm[2:0]==3'b010)
                            ||!ex1_mult_sign && (ex1_rm[2:0]==3'b011)); 

assign ex1_fmau_inf_sign   = (|ex1_inf[1:0] || ex1_fmau_of) ? ex1_mult_sign : ex1_src2_sign;

//lfn
assign ex1_fmau_result_lfn = ex1_fmau_of && 
                             ((ex1_rm[2:0]==3'b001) 
                              ||!ex1_mult_sign && (ex1_rm[2:0]==3'b010)
                              || ex1_mult_sign && (ex1_rm[2:0]==3'b011));

assign ex1_fmau_lfn_sign = ex1_mult_sign;

//src2
assign ex1_fmau_result_src2 =  ex1_zero[0] && ex1_norm[1] && ex1_norm[2]  //zero * normal
                            || ex1_zero[1] && ex1_norm[0] && ex1_norm[2]
                            || ex1_zero[0] && ex1_zero[1] && ex1_norm[2];

assign ex1_fmau_src2_sign = ex1_src2_sign;

assign ex1_special_sel[5:0] = {|ex1_fmau_result_qnan[2:0],
                               ex1_fmau_result_cnan,
                               ex1_fmau_result_lfn,
                               ex1_fmau_result_inf,
                               ex1_fmau_result_zero,
                               ex1_fmau_result_src2};

assign ex1_special_sign[3:0] = {ex1_fmau_lfn_sign, ex1_fmau_inf_sign, ex1_fmau_zero_sign, ex1_fmau_src2_sign};


// &CombBeg; @304
// &CombEnd; @312
// &CombBeg; @314
// &CombEnd; @322
assign ex1_widen_srcv0[DOUBLE_WIDTH-1:0] = {ex1_bf16} ? {32'b0,ex1_srcv0[15:0],16'b0} : {32'b0,ex1_srcv0[15],3'b0,ex1_srcv0[14:0],13'b0};
assign ex1_widen_srcv1[DOUBLE_WIDTH-1:0] = {ex1_bf16} ? {32'b0,ex1_srcv1[15:0],16'b0} : {32'b0,ex1_srcv1[15],3'b0,ex1_srcv1[14:0],13'b0};

// &CombBeg; @328
always @( ex1_srcv2[63:0]
       or ex1_srcv1[63:0]
       or ex1_widen_srcv0[63:0]
       or ex1_srcv0[63:0]
       or ex1_fmau_result_qnan[2:0]
       or ex1_widen_srcv1[63:0]
       or ex1_widen)
begin
case(ex1_fmau_result_qnan[2:0])
  3'b001 : ex1_special_data[DOUBLE_WIDTH-1:0] = (ex1_widen) ? ex1_widen_srcv0[DOUBLE_WIDTH-1:0] : ex1_srcv0[DOUBLE_WIDTH-1:0];
  3'b010 : ex1_special_data[DOUBLE_WIDTH-1:0] = (ex1_widen) ? ex1_widen_srcv1[DOUBLE_WIDTH-1:0] : ex1_srcv1[DOUBLE_WIDTH-1:0];
  3'b100 : ex1_special_data[DOUBLE_WIDTH-1:0] = ex1_srcv2[DOUBLE_WIDTH-1:0];
  default: ex1_special_data[DOUBLE_WIDTH-1:0] = ex1_srcv2[DOUBLE_WIDTH-1:0];
endcase
// &CombEnd; @335
end
always @(posedge fmau_ex2_data_clk)
begin
 if(ctrl_dp_ex1_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex2_special_sel[5:0]   <= ex1_special_sel[5:0];
    ex2_special_sign[3:0]  <= ex1_special_sign[3:0];
    ex2_special_data[63:0] <= ex1_special_data[63:0];
    ex2_fmau_of            <= ex1_fmau_of;
    ex2_fmau_nv            <= ex1_fmau_nv;
  end
end

//==========================================================
//                     EX2 special result
//==========================================================
// &Force("output","ex2_special_sel"); @375
// &CombBeg; @388
// &CombEnd; @414
// &Force("bus","ex3_mult_double_rnd_bit",2,0); @460
// &Force("output","ex3_special_sel"); @462
// &Force("output","ex3_special_result"); @463
// &Force("output","ex3_special_fflags"); @464
// &Force("output","ex2_special_sel"); @476
assign ex2_special_data_vld = |ex2_special_sel[5:0];

//BIT0:srcv2
//BTI1:zero
//BIT2:inf
//BIT3:lfn
//BIT4:cnan
//BIT5:qnan
//default:vm/vl                                     
// &CombBeg; @486
always @( ex2_dst_f16
       or ex2_dst_double
       or ex2_dst_bf16
       or ex2_special_sign[2:0]
       or ex2_special_sel[5:0]
       or ex2_dst_half
       or ex2_dst_single
       or ex2_special_data[63:0])
begin
case(ex2_special_sel[5:0])
  6'b000001 : ex2_special_result[63:0] = {64{ex2_dst_half  }} & {48'hffffffffffff,ex2_special_sign[0],ex2_special_data[HALF_WIDTH-2:0]}
                                       | {64{ex2_dst_single}} & {32'hffffffff,ex2_special_sign[0],ex2_special_data[SINGLE_WIDTH-2:0]}
                                       | {64{ex2_dst_double}} & {ex2_special_sign[0],ex2_special_data[DOUBLE_WIDTH-2:0]};
  6'b000010 : ex2_special_result[63:0] = {64{ex2_dst_half  }} & {48'hffffffffffff,ex2_special_sign[1],15'b0}
                                       | {64{ex2_dst_single}} & {32'hffffffff,ex2_special_sign[1],31'b0}
                                       | {64{ex2_dst_double}} & {ex2_special_sign[1],63'b0};
  6'b000100 : ex2_special_result[63:0] = {64{ex2_dst_f16   }} & {48'hffffffffffff,ex2_special_sign[2],{5{1'b1}},10'b0}
                                       | {64{ex2_dst_bf16  }} & {48'hffffffffffff,ex2_special_sign[2],{8{1'b1}},7'b0}
                                       | {64{ex2_dst_single}} & {32'hffffffff,ex2_special_sign[2],{8{1'b1}},23'b0}
                                       | {64{ex2_dst_double}} & {ex2_special_sign[2],{11{1'b1}},52'b0};
  6'b001000 : ex2_special_result[63:0] = {64{ex2_dst_f16   }} & {48'hffffffffffff,ex2_special_sign[2],{4{1'b1}},1'b0,{10{1'b1}}}
                                       | {64{ex2_dst_bf16  }} & {48'hffffffffffff,ex2_special_sign[2],{7{1'b1}},1'b0,{7{1'b1}}}
                                       | {64{ex2_dst_single}} & {32'hffffffff,ex2_special_sign[2],{7{1'b1}},1'b0,{23{1'b1}}}
                                       | {64{ex2_dst_double}} & {ex2_special_sign[2],{10{1'b1}},1'b0,{52{1'b1}}};
  6'b010000 : ex2_special_result[63:0] = {64{ex2_dst_f16   }} & {48'hffffffffffff,1'b0,{5{1'b1}},1'b1,{9{1'b0}}}
                                       | {64{ex2_dst_bf16  }} & {48'hffffffffffff,1'b0,{8{1'b1}},1'b1,{6{1'b0}}}
                                       | {64{ex2_dst_single}} & {32'hffffffff,1'b0,{8{1'b1}},1'b1,{22{1'b0}}}
                                       | {64{ex2_dst_double}} & {1'b0,{11{1'b1}},1'b1,{51'b0}};
  6'b100000 : ex2_special_result[63:0] = {64{ex2_dst_f16   }} & {48'hffffffffffff,ex2_special_data[15],{5{1'b1}},1'b1,ex2_special_data[8:0]}
                                       | {64{ex2_dst_bf16  }} & {48'hffffffffffff,ex2_special_data[15],{8{1'b1}},1'b1,ex2_special_data[5:0]}
                                       | {64{ex2_dst_single}} & {32'hffffffff,ex2_special_data[31],{8{1'b1}},1'b1,ex2_special_data[21:0]}
                                       | {64{ex2_dst_double}} & {ex2_special_data[63],{11{1'b1}},1'b1,ex2_special_data[50:0]};
  default   : ex2_special_result[63:0] = {64{1'bx}};
endcase                                            
// &CombEnd; @512
end

always @(posedge fmau_ex3_data_clk)
begin
 if(ctrl_dp_ex2_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex3_special_data_vld     <= ex2_special_data_vld;
    ex3_special_result[63:0] <= ex2_special_result[63:0];
    ex3_special_fflags[1:0]  <= {ex2_fmau_nv,ex2_fmau_of};
  end
end

// &Force("output","ex3_special_data_vld"); @524
// &Force("output","ex3_special_result"); @525
// &Force("output","ex3_special_fflags"); @526

always @(posedge fmau_ex4_data_clk)
begin
 if(ctrl_dp_ex3_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex4_mult_double_result[63:0] <= ex3_mult_double_result[63:0];
    ex4_mult_double_nx           <= ex3_mult_nx & ex3_dst_double;
  end
end

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @551
// &Force("nonport","clk"); @552
// &Force("nonport","rst"); @553

// &ModuleEnd; @572
endmodule


