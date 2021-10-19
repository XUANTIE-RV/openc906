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
module aq_fadd_lop_s1_sb(
  act_sub,
  ff1_mask,
  ff1_pred_bh,
  ff1_pred_d,
  ff1_pred_h,
  ff1_pred_s,
  src0_adder,
  src1_adder
);

// &Ports; @23
input           act_sub;               
input   [53:0]  ff1_mask;              
input   [53:0]  src0_adder;            
input   [53:0]  src1_adder;            
output  [4 :0]  ff1_pred_bh;           
output  [5 :0]  ff1_pred_d;            
output  [4 :0]  ff1_pred_h;            
output  [4 :0]  ff1_pred_s;            

// &Regs; @24
reg     [4 :0]  ff1_l_pred_bh;         
reg     [4 :0]  ff1_l_pred_e_d;        
reg     [4 :0]  ff1_l_pred_h;          
reg     [5 :0]  ff1_l_pred_t0_d;       
reg     [24:0]  ff1_l_pred_t0_d_onehot; 
reg     [4 :0]  ff1_pred_e_d;          
reg             sel_h;                 

// &Wires; @25
wire            act_sub;               
wire    [53:0]  close_adder0_t0;       
wire    [53:0]  close_adder1_t0;       
wire    [53:0]  close_ff1_a_t0;        
wire    [53:0]  close_ff1_b_t0;        
wire    [53:0]  close_ff1_c_t0;        
wire    [53:0]  close_ff1_f_t0;        
wire    [53:0]  close_ff1_g_t0;        
wire    [53:0]  close_ff1_t_t0;        
wire    [53:0]  close_ff1_z_t0;        
wire    [53:0]  ff1_code;              
wire    [53:0]  ff1_mask;              
wire    [4 :0]  ff1_pred_bh;           
wire    [5 :0]  ff1_pred_d;            
wire    [4 :0]  ff1_pred_h;            
wire    [4 :0]  ff1_pred_s;            
wire    [53:0]  src0_adder;            
wire    [53:0]  src1_adder;            



//assign ff1_pred_onehot[53:0] = ff1_pred_t0_d_onehot[53:0];
assign ff1_pred_d[5:0]         = sel_h ? {1'b0,ff1_pred_e_d[4:0]} : ff1_l_pred_t0_d[5:0];
assign ff1_pred_s[4:0]       = ff1_l_pred_e_d[4:0];
assign ff1_pred_h[4:0]       = ff1_l_pred_h[4:0];
assign ff1_pred_bh[4:0]      = ff1_l_pred_bh[4:0];
assign close_adder0_t0[53:0] = src0_adder[53:0];
assign close_adder1_t0[53:0] = src1_adder[53:0];

//close_sum0 for F1-F0
//close_sum select, keep sum not negative
//close_sum0_m1
//assign close_sum_m1_t0[53:0] = $unsigned($signed(close_adder0_t0[53:0])
//                                        - $signed(close_adder1_t0[53:0])
//                                        + $signed(close_m1_oper2[53:0]));
//csky vperl_on
//FF1 Logic of Close Path S0
//If predict first 1 set at r[n]
//Actual first 1 may set at r[n+1] or r[n]
//A and B are to oprand
assign close_ff1_a_t0[53:0] = close_adder0_t0[53:0];
assign close_ff1_b_t0[53:0] = close_adder1_t0[53:0];

//C = B && act_add || ~B && act_sub
assign close_ff1_c_t0[53:0] = close_ff1_b_t0[53:0];
//T = A^C  G=A&C  Z=(~A)&(~C)
assign close_ff1_t_t0[53:0] = close_ff1_a_t0[53:0] ^ close_ff1_c_t0[53:0];
assign close_ff1_g_t0[53:0] = close_ff1_a_t0[53:0] & close_ff1_c_t0[53:0];
assign close_ff1_z_t0[53:0] = (~close_ff1_a_t0[53:0]) & (~close_ff1_c_t0[53:0]);
//F :
//fn-1 = En[gi(~zi-1) + zi(~gi-1)] + (~En)[gi(~gi-1) + zi(~zi-1)], En=act_sub
//f0   = t1(g0En+z0) + (~t1)(z0En+g0)
//fi   = ti+1[gi(~zi-1) + zi(~gi-1)] + (~ti+1)[gi(~gi-1) + zi(~zi-1)]
assign close_ff1_f_t0[53]   =  act_sub && (( close_ff1_g_t0[53] & (~close_ff1_z_t0[52])) |
                                           ( close_ff1_z_t0[53] & (~close_ff1_g_t0[52]))) ||  
                               !act_sub && (( close_ff1_g_t0[53] & (~close_ff1_g_t0[52])) |
                                            ( close_ff1_z_t0[53] & (~close_ff1_z_t0[52])));
assign close_ff1_f_t0[0]    = (( close_ff1_t_t0[1]) & ((close_ff1_g_t0[0]&act_sub) | close_ff1_z_t0[0])) |
                              ((~close_ff1_t_t0[1]) & ((close_ff1_z_t0[0]&act_sub) | close_ff1_g_t0[0]));
assign close_ff1_f_t0[52:1] = (( close_ff1_t_t0[53:2]) & ((close_ff1_g_t0[52:1] & (~close_ff1_z_t0[51:0])) |
                               ( close_ff1_z_t0[52:1]  & (~close_ff1_g_t0[51:0]))))                     |
                              ((~close_ff1_t_t0[53:2]) & ((close_ff1_g_t0[52:1] & (~close_ff1_g_t0[51:0])) |
                               ( close_ff1_z_t0[52:1]  & (~close_ff1_z_t0[51:0]))));
assign ff1_code[53:0] = close_ff1_f_t0[53:0] | ff1_mask[53:0];

// &CombBeg; @72
always @( ff1_code[53:25])
begin
casez(ff1_code[53:25])
  29'b1???_????_????_????_????_????_?????: begin
    ff1_pred_e_d[4:0]          = 5'b0;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b01??_????_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd0;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b001?_????_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd1;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0001_????_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd2;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_1???_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd3;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_01??_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd4;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_001?_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd5;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0001_????_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd6;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_1???_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd7;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_01??_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd8;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_001?_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd9;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0001_????_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd10;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_1???_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd11;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_01??_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd12;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_001?_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd13;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0001_????_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd14;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_1???_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd15;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_01??_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd16;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_001?_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd17;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0001_????_????? : begin
    ff1_pred_e_d[4:0]          = 5'd18;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_1???_????? : begin
    ff1_pred_e_d[4:0]          = 5'd19;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_01??_????? : begin
    ff1_pred_e_d[4:0]          = 5'd20;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_001?_????? : begin
    ff1_pred_e_d[4:0]          = 5'd21;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_0001_????? : begin
    ff1_pred_e_d[4:0]          = 5'd22;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_0000_1???? : begin
    ff1_pred_e_d[4:0]          = 5'd23;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_0000_01??? : begin
    ff1_pred_e_d[4:0]          = 5'd24;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_0000_001?? : begin
    ff1_pred_e_d[4:0]          = 5'd25;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_0000_0001? : begin
    ff1_pred_e_d[4:0]          = 5'd26;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
  29'b0000_0000_0000_0000_0000_0000_00001 : begin
    ff1_pred_e_d[4:0]          = 5'd27;
    sel_h                      = 1'b1;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end

  default : begin
    ff1_pred_e_d[4:0]          = {5{1'bx}};
    sel_h                      = 1'b0;
    //ff1_pred_t0_s[4:0]         = {5{1'bx}};
  end
endcase
// &CombEnd; @226
end
// &Force("nonport","ff1_l_pred_t0_d_onehot"); @227
// &CombBeg; @228
always @( ff1_code[24:0])
begin
casez(ff1_code[24:0])
  25'b1???_????_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b1000_0000_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd28;
    ff1_l_pred_e_d[4:0]          = 5'b0;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b01??_????_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0100_0000_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd29;
    ff1_l_pred_e_d[4:0]          = 5'd0;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b001?_????_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0010_0000_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd30;
    ff1_l_pred_e_d[4:0]          = 5'd1;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0001_????_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0001_0000_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd31;
    ff1_l_pred_e_d[4:0]          = 5'd2;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_1???_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_1000_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd32;
    ff1_l_pred_e_d[4:0]          = 5'd3;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_01??_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0100_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd33;
    ff1_l_pred_e_d[4:0]          = 5'd4;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_001?_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0010_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd34;
    ff1_l_pred_e_d[4:0]          = 5'd5;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0001_????_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0001_0000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd35;
    ff1_l_pred_e_d[4:0]          = 5'd6;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_1???_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_1000_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd36;
    ff1_l_pred_e_d[4:0]          = 5'd7;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_01??_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0100_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd37;
    ff1_l_pred_e_d[4:0]          = 5'd8;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_001?_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0010_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd38;
    ff1_l_pred_e_d[4:0]          = 5'd9;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0001_????_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0001_0000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd39;
    ff1_l_pred_e_d[4:0]          = 5'd10;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_1???_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_1000_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd40;
    ff1_l_pred_e_d[4:0]          = 5'd11;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_01??_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0100_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd41;
    ff1_l_pred_e_d[4:0]          = 5'd12;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_001?_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0010_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd42;
    ff1_l_pred_e_d[4:0]          = 5'd13;
    ff1_l_pred_h[4:0]            = 5'b0;
    ff1_l_pred_bh[4:0]           = 5'b0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0001_????_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0001_0000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd43;
    ff1_l_pred_e_d[4:0]          = 5'd14;
    ff1_l_pred_h[4:0]            = 5'd1;
    ff1_l_pred_bh[4:0]           = 5'd0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_1???_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_1000_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd44;
    ff1_l_pred_e_d[4:0]          = 5'd15;
    ff1_l_pred_h[4:0]            = 5'd2;
    ff1_l_pred_bh[4:0]           = 5'd0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_01??_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0100_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd45;
    ff1_l_pred_e_d[4:0]          = 5'd16;
    ff1_l_pred_h[4:0]            = 5'd3;
    ff1_l_pred_bh[4:0]           = 5'd0;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_001?_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0010_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd46;
    ff1_l_pred_e_d[4:0]          = 5'd17;
    ff1_l_pred_h[4:0]            = 5'd4;
    ff1_l_pred_bh[4:0]           = 5'd1;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_0001_????_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0001_0000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd47;
    ff1_l_pred_e_d[4:0]          = 5'd18;
    ff1_l_pred_h[4:0]            = 5'd5;
    ff1_l_pred_bh[4:0]           = 5'd2;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_0000_1???_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0000_1000_0;
    ff1_l_pred_t0_d[5:0]         = 6'd48;
    ff1_l_pred_e_d[4:0]          = 5'd19;
    ff1_l_pred_h[4:0]            = 5'd6;
    ff1_l_pred_bh[4:0]           = 5'd3;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_0000_01??_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0000_0100_0;
    ff1_l_pred_t0_d[5:0]         = 6'd49;
    ff1_l_pred_e_d[4:0]          = 5'd20;
    ff1_l_pred_h[4:0]            = 5'd7;
    ff1_l_pred_bh[4:0]           = 5'd4;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_0000_001?_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0000_0010_0;
    ff1_l_pred_t0_d[5:0]         = 6'd50;
    ff1_l_pred_e_d[4:0]          = 5'd21;
    ff1_l_pred_h[4:0]            = 5'd8;
    ff1_l_pred_bh[4:0]           = 5'd5;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_0000_0001_?: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0000_0001_0;
    ff1_l_pred_t0_d[5:0]         = 6'd51;
    ff1_l_pred_e_d[4:0]          = 5'd22;
    ff1_l_pred_h[4:0]            = 5'd9;
    ff1_l_pred_bh[4:0]           = 5'd6;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  25'b0000_0000_0000_0000_0000_0000_1: begin
    ff1_l_pred_t0_d_onehot[24:0] = 25'b0000_0000_0000_0000_0000_0000_1;
    ff1_l_pred_t0_d[5:0]         = 6'd52;
    ff1_l_pred_e_d[4:0]          = 5'd23;
    ff1_l_pred_h[4:0]            = 5'd10;
    ff1_l_pred_bh[4:0]           = 5'd7;
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
  default : begin
    ff1_l_pred_t0_d_onehot[24:0] = {25{1'bx}};
    ff1_l_pred_t0_d[5:0]         = {6{1'bx}};
    ff1_l_pred_e_d[4:0]          = {5{1'bx}};
    ff1_l_pred_h[4:0]            = {5{1'bx}};
    ff1_l_pred_bh[4:0]           = {5{1'bx}};
    //ff1_l_pred_t0_s[4:0]         = {5{1'bx}};
  end
endcase
// &CombEnd; @439
end




// &ModuleEnd; @444
endmodule


