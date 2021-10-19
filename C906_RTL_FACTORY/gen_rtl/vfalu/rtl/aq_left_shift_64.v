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

// &ModuleBeg; @27
module aq_left_shift_64(
  input_l16_0_shift_cnt,
  input_l16_1_shift_cnt,
  input_l16_2_shift_cnt,
  input_l16_3_shift_cnt,
  input_l32_0_shift_cnt,
  input_l32_1_shift_cnt,
  input_l64_shift_cnt,
  input_org_src,
  input_size,
  l16_0_shift_out_val,
  l16_1_shift_out_val,
  l16_2_shift_out_val,
  l16_3_shift_out_val,
  l32_0_shift_out_val,
  l32_1_shift_out_val,
  l64_shift_out_val
);

// &Ports; @28
input   [3 :0]  input_l16_0_shift_cnt; 
input   [3 :0]  input_l16_1_shift_cnt; 
input   [3 :0]  input_l16_2_shift_cnt; 
input   [3 :0]  input_l16_3_shift_cnt; 
input   [4 :0]  input_l32_0_shift_cnt; 
input   [4 :0]  input_l32_1_shift_cnt; 
input   [5 :0]  input_l64_shift_cnt;  
input   [63:0]  input_org_src;        
input   [2 :0]  input_size;           
output  [15:0]  l16_0_shift_out_val;  
output  [15:0]  l16_1_shift_out_val;  
output  [15:0]  l16_2_shift_out_val;  
output  [15:0]  l16_3_shift_out_val;  
output  [31:0]  l32_0_shift_out_val;  
output  [31:0]  l32_1_shift_out_val;  
output  [63:0]  l64_shift_out_val;    

// &Regs; @29
reg     [63:0]  l64_shift_out_val;    

// &Wires; @30
wire    [3 :0]  h16_shift_cnt_0;      
wire    [3 :0]  h16_shift_cnt_1;      
wire    [3 :0]  h16_shift_cnt_2;      
wire    [3 :0]  h16_shift_cnt_3;      
wire    [15:0]  h16_shift_in_val_0;   
wire    [15:0]  h16_shift_in_val_1;   
wire    [15:0]  h16_shift_in_val_2;   
wire    [15:0]  h16_shift_in_val_3;   
wire            input_16;             
wire            input_32;             
wire            input_64;             
wire    [3 :0]  input_l16_0_shift_cnt; 
wire    [3 :0]  input_l16_1_shift_cnt; 
wire    [3 :0]  input_l16_2_shift_cnt; 
wire    [3 :0]  input_l16_3_shift_cnt; 
wire    [4 :0]  input_l32_0_shift_cnt; 
wire    [4 :0]  input_l32_1_shift_cnt; 
wire    [5 :0]  input_l64_shift_cnt;  
wire    [63:0]  input_org_src;        
wire    [2 :0]  input_size;           
wire    [15:0]  l16_0_shift_out_val;  
wire    [15:0]  l16_1_shift_out_val;  
wire    [15:0]  l16_2_shift_out_val;  
wire    [15:0]  l16_3_shift_out_val;  
wire    [31:0]  l16_shift_result_0;   
wire    [31:0]  l16_shift_result_1;   
wire    [31:0]  l16_shift_result_2;   
wire    [31:0]  l16_shift_result_3;   
wire    [31:0]  l32_0_shift_out_val;  
wire    [47:0]  l32_0_shift_result;   
wire    [31:0]  l32_1_shift_out_val;  
wire    [47:0]  l32_1_shift_result;   
wire            shift_cnt_0_bit4;     
wire            shift_cnt_1_bit4;     


assign input_64            = input_size[2];
assign input_32            = input_size[1];
assign input_16            = input_size[0];
assign h16_shift_cnt_0[3:0] = {4{input_64}} & input_l64_shift_cnt[3:0]   |
                             {4{input_32}} & input_l32_0_shift_cnt[3:0] |
                             {4{input_16}} & input_l16_0_shift_cnt[3:0];
assign h16_shift_cnt_1[3:0] = {4{input_64}} & input_l64_shift_cnt[3:0]   |
                             {4{input_32}} & input_l32_0_shift_cnt[3:0] |
                             {4{input_16}} & input_l16_1_shift_cnt[3:0];
assign h16_shift_cnt_2[3:0] = {4{input_64}} & input_l64_shift_cnt[3:0]   |
                             {4{input_32}} & input_l32_1_shift_cnt[3:0] |
                             {4{input_16}} & input_l16_2_shift_cnt[3:0];
assign h16_shift_cnt_3[3:0] = {4{input_64}} & input_l64_shift_cnt[3:0]   |
                             {4{input_32}} & input_l32_1_shift_cnt[3:0] |
                             {4{input_16}} & input_l16_3_shift_cnt[3:0];

assign h16_shift_in_val_0[15:0] = input_org_src[15:0];
assign h16_shift_in_val_1[15:0] = input_org_src[31:16];
assign h16_shift_in_val_2[15:0] = input_org_src[47:32];
assign h16_shift_in_val_3[15:0] = input_org_src[63:48];

assign l16_shift_result_0[31:0] = {16'b0,h16_shift_in_val_0[15:0]} << h16_shift_cnt_0[3:0];
assign l16_shift_result_1[31:0] = {16'b0,h16_shift_in_val_1[15:0]} << h16_shift_cnt_1[3:0];
assign l16_shift_result_2[31:0] = {16'b0,h16_shift_in_val_2[15:0]} << h16_shift_cnt_2[3:0];
assign l16_shift_result_3[31:0] = {16'b0,h16_shift_in_val_3[15:0]} << h16_shift_cnt_3[3:0];

assign l16_0_shift_out_val[15:0] = l16_shift_result_0[15:0]; 
assign l16_1_shift_out_val[15:0] = l16_shift_result_1[15:0]; 
assign l16_2_shift_out_val[15:0] = l16_shift_result_2[15:0]; 
assign l16_3_shift_out_val[15:0] = l16_shift_result_3[15:0]; 

assign shift_cnt_0_bit4          = input_64 && input_l64_shift_cnt[4] ||
                                     input_32 && input_l32_0_shift_cnt[4];
assign shift_cnt_1_bit4          = input_64 && input_l64_shift_cnt[4] ||
                                     input_32 && input_l32_1_shift_cnt[4];
                                   
assign l32_0_shift_result[47:0] = shift_cnt_0_bit4 ? {l16_shift_result_0[31:0],16'b0}
                                                    : {l16_shift_result_1[31:16],
                                                       l16_shift_result_1[15:0]| l16_shift_result_0[31:16],
                                                       l16_shift_result_0[15:0]};
assign l32_1_shift_result[47:0] = shift_cnt_1_bit4 ? {l16_shift_result_2[31:0],16'b0}
                                                    : {l16_shift_result_3[31:16],
                                                       l16_shift_result_3[15:0]| l16_shift_result_2[31:16],
                                                       l16_shift_result_2[15:0]};
assign l32_0_shift_out_val[31:0]  = l32_0_shift_result[31:0];
assign l32_1_shift_out_val[31:0]  = l32_1_shift_result[31:0];


//assign l64_shift_out_val[63:0]   = input_l64_shift_cnt[5] ? {l32_0_shift_result[31:0],32'b0} 
//                                                          : {l32_1_shift_result[32:16], 
//                                                             l32_1_shift_result[15:0] | l32_0_shift_result[47:32],
//                                                             l32_0_shift_result[31:0]};
// &CombBeg; @84
always @( l16_shift_result_2[31:0]
       or l16_shift_result_3[15:0]
       or input_l64_shift_cnt[5:4]
       or l16_shift_result_1[31:0]
       or l16_shift_result_0[31:0])
begin
  casez(input_l64_shift_cnt[5:4])
    2'b00: l64_shift_out_val[63:0] = {l16_shift_result_3[15:0] | l16_shift_result_2[31:16],
                                      l16_shift_result_2[15:0] | l16_shift_result_1[31:16],
                                      l16_shift_result_1[15:0] | l16_shift_result_0[31:16],l16_shift_result_0[15:0]};
    2'b01: l64_shift_out_val[63:0] = {l16_shift_result_2[15:0] | l16_shift_result_1[31:16],
                                      l16_shift_result_1[15:0] | l16_shift_result_0[31:16],l16_shift_result_0[15:0],16'b0};
    2'b10: l64_shift_out_val[63:0] = {l16_shift_result_1[15:0] | l16_shift_result_0[31:16],l16_shift_result_0[15:0],32'b0};
    2'b11: l64_shift_out_val[63:0] = {l16_shift_result_0[15:0],48'b0};
    default: l64_shift_out_val[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @95
end


// &ModuleEnd; @98
endmodule



