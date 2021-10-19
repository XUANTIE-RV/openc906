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

// &ModuleBeg; @22
module aq_fdsu_denorm_shift(
  bhalf0_denorm_to_tiny_frac,
  bhalf0_shift_num,
  bhalf0_shift_num_in,
  bhalf0_shift_val,
  bhalf1_denorm_to_tiny_frac,
  bhalf1_shift_num,
  bhalf1_shift_num_in,
  bhalf1_shift_val,
  bhalf2_denorm_to_tiny_frac,
  bhalf2_shift_num,
  bhalf2_shift_num_in,
  bhalf2_shift_val,
  bhalf3_denorm_to_tiny_frac,
  bhalf3_shift_num,
  bhalf3_shift_num_in,
  bhalf3_shift_val,
  double_denorm_to_tiny_frac,
  double_shift_num,
  double_shift_num_in,
  double_shift_val,
  half0_denorm_to_tiny_frac,
  half0_shift_num,
  half0_shift_num_in,
  half0_shift_val,
  half1_denorm_to_tiny_frac,
  half1_shift_num,
  half1_shift_num_in,
  half1_shift_val,
  half2_denorm_to_tiny_frac,
  half2_shift_num,
  half2_shift_num_in,
  half2_shift_val,
  half3_denorm_to_tiny_frac,
  half3_shift_num,
  half3_shift_num_in,
  half3_shift_val,
  input_bhalf,
  input_double,
  input_half,
  input_single,
  single0_denorm_to_tiny_frac,
  single0_shift_num,
  single0_shift_num_in,
  single0_shift_val,
  single1_denorm_to_tiny_frac,
  single1_shift_num,
  single1_shift_num_in,
  single1_shift_val
);

// &Ports; @23
input           bhalf0_denorm_to_tiny_frac; 
input   [6 :0]  bhalf0_shift_num_in;        
input   [8 :0]  bhalf0_shift_val;           
input           bhalf1_denorm_to_tiny_frac; 
input   [6 :0]  bhalf1_shift_num_in;        
input   [8 :0]  bhalf1_shift_val;           
input           bhalf2_denorm_to_tiny_frac; 
input   [6 :0]  bhalf2_shift_num_in;        
input   [8 :0]  bhalf2_shift_val;           
input           bhalf3_denorm_to_tiny_frac; 
input   [6 :0]  bhalf3_shift_num_in;        
input   [8 :0]  bhalf3_shift_val;           
input           double_denorm_to_tiny_frac; 
input   [51:0]  double_shift_num_in;        
input   [11:0]  double_shift_val;           
input           half0_denorm_to_tiny_frac;  
input   [9 :0]  half0_shift_num_in;         
input   [5 :0]  half0_shift_val;            
input           half1_denorm_to_tiny_frac;  
input   [9 :0]  half1_shift_num_in;         
input   [5 :0]  half1_shift_val;            
input           half2_denorm_to_tiny_frac;  
input   [9 :0]  half2_shift_num_in;         
input   [5 :0]  half2_shift_val;            
input           half3_denorm_to_tiny_frac;  
input   [9 :0]  half3_shift_num_in;         
input   [5 :0]  half3_shift_val;            
input           input_bhalf;                
input           input_double;               
input           input_half;                 
input           input_single;               
input           single0_denorm_to_tiny_frac; 
input   [22:0]  single0_shift_num_in;       
input   [8 :0]  single0_shift_val;          
input           single1_denorm_to_tiny_frac; 
input   [22:0]  single1_shift_num_in;       
input   [8 :0]  single1_shift_val;          
output  [6 :0]  bhalf0_shift_num;           
output  [6 :0]  bhalf1_shift_num;           
output  [6 :0]  bhalf2_shift_num;           
output  [6 :0]  bhalf3_shift_num;           
output  [51:0]  double_shift_num;           
output  [9 :0]  half0_shift_num;            
output  [9 :0]  half1_shift_num;            
output  [9 :0]  half2_shift_num;            
output  [9 :0]  half3_shift_num;            
output  [22:0]  single0_shift_num;          
output  [22:0]  single1_shift_num;          

// &Regs; @24
reg     [51:0]  double_shift_num;           
reg     [22:0]  single0_shift_num;          
reg     [22:0]  single1_shift_num;          

// &Wires; @25
wire            bhalf0_denorm_to_tiny_frac; 
wire    [6 :0]  bhalf0_shift_num;           
wire    [6 :0]  bhalf0_shift_num_in;        
wire    [8 :0]  bhalf0_shift_val;           
wire            bhalf0_tiny_num;            
wire            bhalf1_denorm_to_tiny_frac; 
wire    [6 :0]  bhalf1_shift_num;           
wire    [6 :0]  bhalf1_shift_num_in;        
wire    [8 :0]  bhalf1_shift_val;           
wire            bhalf1_tiny_num;            
wire            bhalf2_denorm_to_tiny_frac; 
wire    [6 :0]  bhalf2_shift_num;           
wire    [6 :0]  bhalf2_shift_num_in;        
wire    [8 :0]  bhalf2_shift_val;           
wire            bhalf2_tiny_num;            
wire            bhalf3_denorm_to_tiny_frac; 
wire    [6 :0]  bhalf3_shift_num;           
wire    [6 :0]  bhalf3_shift_num_in;        
wire    [8 :0]  bhalf3_shift_val;           
wire            bhalf3_tiny_num;            
wire            double_denorm_to_tiny_frac; 
wire    [51:0]  double_shift_num_in;        
wire    [51:0]  double_shift_sel0_num;      
wire    [51:0]  double_shift_sel1_num;      
wire    [51:0]  double_shift_sel2_num;      
wire    [51:0]  double_shift_sel3_num;      
wire    [51:0]  double_shift_sel4_num;      
wire    [51:0]  double_shift_sel5_num;      
wire    [51:0]  double_shift_sel6_num;      
wire    [11:0]  double_shift_val;           
wire            double_tiny_num;            
wire            half0_denorm_to_tiny_frac;  
wire    [9 :0]  half0_shift_num;            
wire    [9 :0]  half0_shift_num_in;         
wire    [5 :0]  half0_shift_val;            
wire            half0_tiny_num;             
wire            half1_denorm_to_tiny_frac;  
wire    [9 :0]  half1_shift_num;            
wire    [9 :0]  half1_shift_num_in;         
wire    [5 :0]  half1_shift_val;            
wire            half1_tiny_num;             
wire            half2_denorm_to_tiny_frac;  
wire    [9 :0]  half2_shift_num;            
wire    [9 :0]  half2_shift_num_in;         
wire    [5 :0]  half2_shift_val;            
wire            half2_tiny_num;             
wire            half3_denorm_to_tiny_frac;  
wire    [9 :0]  half3_shift_num;            
wire    [9 :0]  half3_shift_num_in;         
wire    [5 :0]  half3_shift_val;            
wire            half3_tiny_num;             
wire            input_bhalf;                
wire            input_double;               
wire            input_half;                 
wire            input_single;               
wire    [15:0]  right_8_0_num_in;           
wire    [2 :0]  right_8_0_shift_cnt;        
wire    [15:0]  right_8_0_shift_num;        
wire    [15:0]  right_8_1_num_in;           
wire    [2 :0]  right_8_1_shift_cnt;        
wire    [15:0]  right_8_1_shift_num;        
wire    [15:0]  right_8_2_num_in;           
wire    [2 :0]  right_8_2_shift_cnt;        
wire    [15:0]  right_8_2_shift_num;        
wire    [15:0]  right_8_3_num_in;           
wire    [2 :0]  right_8_3_shift_cnt;        
wire    [15:0]  right_8_3_shift_num;        
wire    [15:0]  right_8_4_num_in;           
wire    [2 :0]  right_8_4_shift_cnt;        
wire    [15:0]  right_8_4_shift_num;        
wire    [15:0]  right_8_5_num_in;           
wire    [2 :0]  right_8_5_shift_cnt;        
wire    [15:0]  right_8_5_shift_num;        
wire    [15:0]  right_8_6_num_in;           
wire    [2 :0]  right_8_6_shift_cnt;        
wire    [15:0]  right_8_6_shift_num;        
wire            single0_denorm_to_tiny_frac; 
wire    [22:0]  single0_shift_num_in;       
wire    [8 :0]  single0_shift_val;          
wire            single0_tiny_num;           
wire            single1_denorm_to_tiny_frac; 
wire    [22:0]  single1_shift_num_in;       
wire    [8 :0]  single1_shift_val;          
wire            single1_tiny_num;           

//******************************************
//  right first 8 bit
//  handle the half0 and part of single 
//******************************************
assign right_8_0_num_in[15:0] = {16{input_half  }} & {half0_shift_num_in[9:0],6'b0}    | 
                                {16{input_bhalf }} & {bhalf0_shift_num_in[6:0],9'b0}  |
                                {16{input_single}} & {single0_shift_num_in[14:0],1'b0} |
                                {16{input_double}} & {double_shift_num_in[11:0],4'b0};


assign right_8_0_shift_cnt[2:0] = {3{input_half}}   & half0_shift_val[2:0]     |
                                  {3{input_bhalf}}  & bhalf0_shift_val[2:0]    |
                                  {3{input_single}} & single0_shift_val[2:0]   |
                                  {3{input_double}} & double_shift_val[2:0];
// &ConnRule(s/frac_/right_8_0_/); @40
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_0"); @41
aq_fdsu_right_shift  aq_fdsu_right_shift_8_0 (
  .frac_num_in         (right_8_0_num_in   ),
  .frac_shift_cnt      (right_8_0_shift_cnt),
  .frac_shift_num      (right_8_0_shift_num)
);



assign half0_tiny_num         = half0_shift_val[5] && (half0_shift_val[4:0] < 5'h17);
assign half0_shift_num[9:0]   = half0_tiny_num     ? {9'b0,half0_denorm_to_tiny_frac} :
                               half0_shift_val[3] ? right_8_0_shift_num[14:5] 
                                                  : {8'b0,half0_shift_num_in[9:8]};
assign bhalf0_tiny_num        = bhalf0_shift_val[8] && (bhalf0_shift_val[7:0] < 8'hfa);
assign bhalf0_shift_num[6:0]  = bhalf0_tiny_num   ? {6'b0,bhalf0_denorm_to_tiny_frac} 
                                                  : right_8_0_shift_num[14:8];

//******************************************
//  right secod 8 bit right
//
//******************************************

assign right_8_1_num_in[15:0]  = {16{input_half  }} & {half1_shift_num_in[9:0],6'b0}  | 
                                 {16{input_bhalf }} & {bhalf1_shift_num_in[6:0],9'b0} |
                                 {16{input_single}} & {single0_shift_num_in[22:7]}|
                                 {16{input_double}} & {double_shift_num_in[19:4]};


assign right_8_1_shift_cnt[2:0] = {3{input_half}}   & half1_shift_val[2:0]     |
                                  {3{input_bhalf}}  & bhalf1_shift_val[2:0]    |
                                  {3{input_single}} & single0_shift_val[2:0]   |
                                  {3{input_double}} & double_shift_val[2:0];
// &ConnRule(s/frac_/right_8_1_/); @67
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_1"); @68
aq_fdsu_right_shift  aq_fdsu_right_shift_8_1 (
  .frac_num_in         (right_8_1_num_in   ),
  .frac_shift_cnt      (right_8_1_shift_cnt),
  .frac_shift_num      (right_8_1_shift_num)
);



assign half1_tiny_num          = half1_shift_val[5] && (half1_shift_val[4:0] < 5'h17);
assign half1_shift_num[9:0]    = half1_tiny_num     ? {9'b0,half1_denorm_to_tiny_frac} :
                                 half1_shift_val[3] ? right_8_1_shift_num[14:5] 
                                                    : {8'b0,half1_shift_num_in[9:8]};
assign bhalf1_tiny_num         = bhalf1_shift_val[8] && (bhalf1_shift_val[7:0] < 8'hfa);
assign bhalf1_shift_num[6:0]   = bhalf1_tiny_num   ? {6'b0,bhalf1_denorm_to_tiny_frac} 
                                                  : right_8_1_shift_num[14:8];

//******************************************
//  right secod 8 bit right
//
//******************************************


assign  right_8_2_num_in[15:0]  = {16{input_half  }} & {half2_shift_num_in[9:0],6'b0}   | 
                                  {16{input_bhalf }} & {bhalf2_shift_num_in[6:0],9'b0} |
                                  {16{input_single}} & {8'b0,single0_shift_num_in[22:15]}|
                                  {16{input_double}} & {double_shift_num_in[27:12]};

assign right_8_2_shift_cnt[2:0] = {3{input_half}}   & half2_shift_val[2:0]     |
                                  {3{input_bhalf}}  & bhalf2_shift_val[2:0]    |
                                  {3{input_single}} & single0_shift_val[2:0]   |
                                  {3{input_double}} & double_shift_val[2:0];

// &ConnRule(s/frac_/right_8_2_/); @95
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_2"); @96
aq_fdsu_right_shift  aq_fdsu_right_shift_8_2 (
  .frac_num_in         (right_8_2_num_in   ),
  .frac_shift_cnt      (right_8_2_shift_cnt),
  .frac_shift_num      (right_8_2_shift_num)
);


assign half2_tiny_num        = half2_shift_val[5] && (half2_shift_val[4:0] < 5'h17);
assign half2_shift_num[9:0]  = half2_tiny_num     ? {9'b0,half2_denorm_to_tiny_frac} :
                               half2_shift_val[3] ? right_8_2_shift_num[14:5] 
                                                  : {8'b0,half2_shift_num_in[9:8]};
assign bhalf2_tiny_num        = bhalf2_shift_val[8] && (bhalf2_shift_val[7:0] < 8'hfa);
assign bhalf2_shift_num[6:0]  = bhalf2_tiny_num   ? {6'b0,bhalf2_denorm_to_tiny_frac} 
                                                  : right_8_2_shift_num[14:8];


assign single0_tiny_num       = single0_shift_val[8:0] <= 9'h1e9;

// &CombBeg; @109
always @( right_8_0_shift_num[7:0]
       or right_8_1_shift_num[7:0]
       or single0_shift_val[8:3]
       or single0_denorm_to_tiny_frac
       or single0_tiny_num
       or right_8_2_shift_num[7:0])
begin
casez(single0_shift_val[8:3])
  6'h3f: single0_shift_num[22:0]  = {right_8_2_shift_num[6:0],right_8_1_shift_num[7:0],right_8_0_shift_num[7:0]};
  6'h3e: single0_shift_num[22:0]  = {7'b0,right_8_2_shift_num[7:0],right_8_1_shift_num[7:0]};
  6'h3d: single0_shift_num[22:0]  = single0_tiny_num ? {22'b0,single0_denorm_to_tiny_frac}
  				                     : {15'b0,right_8_2_shift_num[7:0]};
  default:single0_shift_num[22:0] = {22'b0,single0_denorm_to_tiny_frac}; 
endcase
// &CombEnd; @117
end



//******************************************
//  right secod 8 bit right
//
//******************************************

assign  right_8_3_num_in[15:0] =  {16{input_half  }} & {half3_shift_num_in[9:0],6'b0}   | 
                                  {16{input_bhalf }} & {bhalf3_shift_num_in[6:0],9'b0}   |
                                  {16{input_single}} & {single1_shift_num_in[14:0],1'b0} |
                                  {16{input_double}} & {double_shift_num_in[35:20]};



assign right_8_3_shift_cnt[2:0] = {3{input_half}}   & half3_shift_val[2:0]     |
                                  {3{input_bhalf}}  & bhalf3_shift_val[2:0]    |
                                  {3{input_single}} & single1_shift_val[2:0]   |
                                  {3{input_double}} & double_shift_val[2:0];

// &ConnRule(s/frac_/right_8_3_/); @138
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_3"); @139
aq_fdsu_right_shift  aq_fdsu_right_shift_8_3 (
  .frac_num_in         (right_8_3_num_in   ),
  .frac_shift_cnt      (right_8_3_shift_cnt),
  .frac_shift_num      (right_8_3_shift_num)
);


assign half3_tiny_num          = half3_shift_val[5] && (half3_shift_val[4:0] < 5'h17);
assign half3_shift_num[9:0]    = half3_tiny_num     ? {9'b0,half3_denorm_to_tiny_frac} :
                                 half3_shift_val[3] ? right_8_3_shift_num[14:5] 
                                                    : {8'b0,half3_shift_num_in[9:8]};
assign bhalf3_tiny_num         = bhalf3_shift_val[8] && (bhalf3_shift_val[7:0] < 8'hfa);
assign bhalf3_shift_num[6:0]   = bhalf3_tiny_num   ? {6'b0,bhalf3_denorm_to_tiny_frac} 
                                                   : right_8_3_shift_num[14:8];


//******************************************
//  right secod 8 bit right
//
//******************************************

assign  right_8_4_num_in[15:0]  =  {16{input_single}} & {single1_shift_num_in[22:7]}     |
                                   {16{input_double}} & {double_shift_num_in[43:28]};



assign right_8_4_shift_cnt[2:0] = {3{input_single}} & single1_shift_val[2:0]   |
                                {3{input_double}} & double_shift_val[2:0];

// &ConnRule(s/frac_/right_8_4_/); @163
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_4"); @164
aq_fdsu_right_shift  aq_fdsu_right_shift_8_4 (
  .frac_num_in         (right_8_4_num_in   ),
  .frac_shift_cnt      (right_8_4_shift_cnt),
  .frac_shift_num      (right_8_4_shift_num)
);









//******************************************
//  right secod 8 bit right
//
//******************************************

assign  right_8_5_num_in[15:0]  = {16{input_single}} & {8'b0,single1_shift_num_in[22:15]} |
                                  {16{input_double}} & {double_shift_num_in[51:36]};



                              

assign right_8_5_shift_cnt[2:0] = {3{input_single}} & single1_shift_val[2:0]   |
                                  {3{input_double}} & double_shift_val[2:0];

// &ConnRule(s/frac_/right_8_5_/); @188
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_5"); @189
aq_fdsu_right_shift  aq_fdsu_right_shift_8_5 (
  .frac_num_in         (right_8_5_num_in   ),
  .frac_shift_cnt      (right_8_5_shift_cnt),
  .frac_shift_num      (right_8_5_shift_num)
);


// the single 1 output signals
assign single1_tiny_num       = single1_shift_val[8:0] <= 9'h1e9;
// &CombBeg; @193
always @( right_8_4_shift_num[7:0]
       or single1_tiny_num
       or single1_denorm_to_tiny_frac
       or right_8_3_shift_num[7:0]
       or right_8_5_shift_num[7:0]
       or single1_shift_val[8:3])
begin
casez(single1_shift_val[8:3])
  6'h3f: single1_shift_num[22:0]  = {right_8_5_shift_num[6:0],right_8_4_shift_num[7:0],right_8_3_shift_num[7:0]};
  6'h3e: single1_shift_num[22:0]  = {7'b0,right_8_5_shift_num[7:0],right_8_4_shift_num[7:0]};
  6'h3d: single1_shift_num[22:0]  = single1_tiny_num ? {22'b0,single1_denorm_to_tiny_frac}
  					             : {15'b0,right_8_5_shift_num[7:0]};
  default:single1_shift_num[22:0] = {22'b0,single1_denorm_to_tiny_frac}; 
endcase
// &CombEnd; @201
end



//******************************************
//  right secod 8 bit right
//
//******************************************



assign  right_8_6_num_in[15:0]      =  {8'b0,double_shift_num_in[51:44]};

assign right_8_6_shift_cnt[2:0]    = double_shift_val[2:0];

// &ConnRule(s/frac_/right_8_6_/); @216
// &Instance("aq_fdsu_right_shift","aq_fdsu_right_shift_8_6"); @217
aq_fdsu_right_shift  aq_fdsu_right_shift_8_6 (
  .frac_num_in         (right_8_6_num_in   ),
  .frac_shift_cnt      (right_8_6_shift_cnt),
  .frac_shift_num      (right_8_6_shift_num)
);



assign double_tiny_num             = double_shift_val[11:0] <= 12'hfcc;
assign double_shift_sel6_num[51:0] = {right_8_6_shift_num[6:0],right_8_5_shift_num[7:0],right_8_4_shift_num[7:0],
                                      right_8_3_shift_num[7:0],right_8_2_shift_num[7:0],right_8_1_shift_num[7:0],
                                      right_8_0_shift_num[7:3]};
assign double_shift_sel5_num[51:0] = {7'b0,right_8_6_shift_num[7:0],right_8_5_shift_num[7:0],right_8_4_shift_num[7:0],
                                      right_8_3_shift_num[7:0],right_8_2_shift_num[7:0],right_8_1_shift_num[7:3]};
                                     
assign double_shift_sel4_num[51:0] = {15'b0,right_8_6_shift_num[7:0],right_8_5_shift_num[7:0],right_8_4_shift_num[7:0],
                                      right_8_3_shift_num[7:0],right_8_2_shift_num[7:3]};                                     
assign double_shift_sel3_num[51:0] = {23'b0,right_8_6_shift_num[7:0],right_8_5_shift_num[7:0],right_8_4_shift_num[7:0],
                                      right_8_3_shift_num[7:3]}; 
assign double_shift_sel2_num[51:0] = {31'b0,right_8_6_shift_num[7:0],right_8_5_shift_num[7:0],right_8_4_shift_num[7:3]}; 
assign double_shift_sel1_num[51:0] = {39'b0,right_8_6_shift_num[7:0],right_8_5_shift_num[7:3]};
assign double_shift_sel0_num[51:0] = {47'b0,right_8_6_shift_num[7:3]}; 
//assign double_right_sel[6:0]         = {right_8_6_sel_next,right_8_5_sel_next,right_8_4_sel_next,
//                                      right_8_3_sel_next,right_8_2_sel_next,right_8_1_sel_next,right_8_0_sel_next};
                                    
// &CombBeg; @237
always @( double_shift_sel0_num[51:0]
       or double_tiny_num
       or double_shift_sel2_num[51:0]
       or double_shift_sel4_num[51:0]
       or double_shift_sel1_num[51:0]
       or double_shift_sel5_num[51:0]
       or double_shift_val[11:3]
       or double_denorm_to_tiny_frac
       or double_shift_sel3_num[51:0]
       or double_shift_sel6_num[51:0])
begin
casez(double_shift_val[11:3])
  9'h1ff: double_shift_num[51:0] = double_shift_sel6_num[51:0];
  9'h1fe: double_shift_num[51:0] = double_shift_sel5_num[51:0]; 
  9'h1fd: double_shift_num[51:0] = double_shift_sel4_num[51:0];
  9'h1fc: double_shift_num[51:0] = double_shift_sel3_num[51:0];
  9'h1fb: double_shift_num[51:0] = double_shift_sel2_num[51:0]; 
  9'h1fa: double_shift_num[51:0] = double_shift_sel1_num[51:0];
  9'h1f9: double_shift_num[51:0] = double_tiny_num ? {51'b0,double_denorm_to_tiny_frac} : double_shift_sel0_num[51:0];
  default:double_shift_num[51:0] = {51'b0,double_denorm_to_tiny_frac};  
endcase
// &CombEnd; @248
end



// &ModuleEnd; @252
endmodule


