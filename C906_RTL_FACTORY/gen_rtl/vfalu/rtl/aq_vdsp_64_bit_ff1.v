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

// &ModuleBeg; @17
module aq_vdsp_64_bit_ff1(
  ex1_sign,
  ex1_size,
  ex1_src,
  ff1_16_bit,
  ff1_32_bit,
  ff1_64_bit,
  ff1_8_bit
);

// &Ports; @18
input           ex1_sign;  
input   [3 :0]  ex1_size;  
input   [63:0]  ex1_src;   
output  [23:0]  ff1_16_bit; 
output  [13:0]  ff1_32_bit; 
output  [7 :0]  ff1_64_bit; 
output  [39:0]  ff1_8_bit; 

// &Regs; @19
reg     [7 :0]  d_ff1;     
reg     [6 :0]  w0_ff1;    
reg     [6 :0]  w1_ff1;    

// &Wires; @20
wire    [4 :0]  b0_ff1;    
wire    [4 :0]  b1_ff1;    
wire    [4 :0]  b2_ff1;    
wire    [4 :0]  b3_ff1;    
wire    [4 :0]  b4_ff1;    
wire    [4 :0]  b5_ff1;    
wire    [4 :0]  b6_ff1;    
wire    [4 :0]  b7_ff1;    
wire            b_sign_0;  
wire            b_sign_1;  
wire            b_sign_2;  
wire            b_sign_3;  
wire            b_sign_4;  
wire            b_sign_5;  
wire            b_sign_6;  
wire            b_sign_7;  
wire    [7 :0]  byte_0;    
wire    [7 :0]  byte_1;    
wire    [7 :0]  byte_2;    
wire    [7 :0]  byte_3;    
wire    [7 :0]  byte_4;    
wire    [7 :0]  byte_5;    
wire    [7 :0]  byte_6;    
wire    [7 :0]  byte_7;    
wire    [7 :0]  byte_inc;  
wire    [7 :0]  byte_neg;  
wire    [7 :0]  byte_rem;  
wire    [7 :0]  byte_zero; 
wire            d_sign;    
wire    [7 :0]  dbwd_inc;  
wire            ex1_sign;  
wire    [3 :0]  ex1_size;  
wire    [63:0]  ex1_src;   
wire    [4 :0]  ff1_0;     
wire    [4 :0]  ff1_1;     
wire    [23:0]  ff1_16_bit; 
wire    [4 :0]  ff1_2;     
wire    [4 :0]  ff1_3;     
wire    [13:0]  ff1_32_bit; 
wire    [4 :0]  ff1_4;     
wire    [4 :0]  ff1_5;     
wire    [4 :0]  ff1_6;     
wire    [7 :0]  ff1_64_bit; 
wire    [4 :0]  ff1_7;     
wire    [39:0]  ff1_8_bit; 
wire    [5 :0]  h0_ff1;    
wire    [5 :0]  h1_ff1;    
wire    [5 :0]  h2_ff1;    
wire    [5 :0]  h3_ff1;    
wire            h_sign_0;  
wire            h_sign_1;  
wire            h_sign_2;  
wire            h_sign_3;  
wire    [7 :0]  half_inc;  
wire    [7 :0]  src_sign;  
wire            w_sign_0;  
wire            w_sign_1;  
wire    [7 :0]  word_inc;  

parameter BYTE  = 8;
parameter ELEM  = 9;
parameter SILEN = 64;

// &Force("bus","ex1_src",SILEN-1,0); @25
assign src_sign[7] = ex1_src[63] & ex1_sign;
assign src_sign[6] = ex1_src[55] & ex1_sign;
assign src_sign[5] = ex1_src[47] & ex1_sign;
assign src_sign[4] = ex1_src[39] & ex1_sign;
assign src_sign[3] = ex1_src[31] & ex1_sign;
assign src_sign[2] = ex1_src[23] & ex1_sign;
assign src_sign[1] = ex1_src[15] & ex1_sign;
assign src_sign[0] = ex1_src[7]  & ex1_sign;

assign d_sign   = src_sign[7] && ex1_size[3];

assign w_sign_0 = src_sign[3] && ex1_size[2];
assign w_sign_1 = src_sign[7] && ex1_size[2];

assign h_sign_0 = src_sign[1] && ex1_size[1];
assign h_sign_1 = src_sign[3] && ex1_size[1];
assign h_sign_2 = src_sign[5] && ex1_size[1];
assign h_sign_3 = src_sign[7] && ex1_size[1];

assign b_sign_0 = src_sign[0] && ex1_size[0];
assign b_sign_1 = src_sign[1] && ex1_size[0];
assign b_sign_2 = src_sign[2] && ex1_size[0];
assign b_sign_3 = src_sign[3] && ex1_size[0];
assign b_sign_4 = src_sign[4] && ex1_size[0];
assign b_sign_5 = src_sign[5] && ex1_size[0];
assign b_sign_6 = src_sign[6] && ex1_size[0];
assign b_sign_7 = src_sign[7] && ex1_size[0];

assign byte_neg[0] =  d_sign || w_sign_0 || h_sign_0 || b_sign_0;
assign byte_neg[1] =  d_sign || w_sign_0 || h_sign_0 || b_sign_1;
assign byte_neg[2] =  d_sign || w_sign_0 || h_sign_1 || b_sign_2;
assign byte_neg[3] =  d_sign || w_sign_0 || h_sign_1 || b_sign_3;
assign byte_neg[4] =  d_sign || w_sign_1 || h_sign_2 || b_sign_4;
assign byte_neg[5] =  d_sign || w_sign_1 || h_sign_2 || b_sign_5;
assign byte_neg[6] =  d_sign || w_sign_1 || h_sign_3 || b_sign_6;
assign byte_neg[7] =  d_sign || w_sign_1 || h_sign_3 || b_sign_7;

assign byte_0[BYTE-1:0] = byte_neg[0] ? ~ex1_src[BYTE-1  :     0] : ex1_src[BYTE-1  :     0];
assign byte_1[BYTE-1:0] = byte_neg[1] ? ~ex1_src[2*BYTE-1:  BYTE] : ex1_src[2*BYTE-1:  BYTE];
assign byte_2[BYTE-1:0] = byte_neg[2] ? ~ex1_src[3*BYTE-1:2*BYTE] : ex1_src[3*BYTE-1:2*BYTE];
assign byte_3[BYTE-1:0] = byte_neg[3] ? ~ex1_src[4*BYTE-1:3*BYTE] : ex1_src[4*BYTE-1:3*BYTE];
assign byte_4[BYTE-1:0] = byte_neg[4] ? ~ex1_src[5*BYTE-1:4*BYTE] : ex1_src[5*BYTE-1:4*BYTE];
assign byte_5[BYTE-1:0] = byte_neg[5] ? ~ex1_src[6*BYTE-1:5*BYTE] : ex1_src[6*BYTE-1:5*BYTE];
assign byte_6[BYTE-1:0] = byte_neg[6] ? ~ex1_src[7*BYTE-1:6*BYTE] : ex1_src[7*BYTE-1:6*BYTE];
assign byte_7[BYTE-1:0] = byte_neg[7] ? ~ex1_src[8*BYTE-1:7*BYTE] : ex1_src[8*BYTE-1:7*BYTE];

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_0"); @72
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_0 (
  .out          (ff1_0[4:0]  ),
  .rem          (byte_rem[0] ),
  .src          (byte_0[7:0] ),
  .zero         (byte_zero[0])
);

// &Connect(.src    (byte_0[BYTE-1:0]), @73
//          .rem    (byte_rem[0]     ), @74
//          .zero   (byte_zero[0]    ), @75
//          .out    (ff1_0[4:0]      )); @76

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_1"); @78
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_1 (
  .out          (ff1_1[4:0]  ),
  .rem          (byte_rem[1] ),
  .src          (byte_1[7:0] ),
  .zero         (byte_zero[1])
);

// &Connect(.src    (byte_1[BYTE-1:0]), @79
//          .rem    (byte_rem[1]     ), @80
//          .zero   (byte_zero[1]    ), @81
//          .out    (ff1_1[4:0]      )); @82

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_2"); @84
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_2 (
  .out          (ff1_2[4:0]  ),
  .rem          (byte_rem[2] ),
  .src          (byte_2[7:0] ),
  .zero         (byte_zero[2])
);

// &Connect(.src    (byte_2[BYTE-1:0]), @85
//          .rem    (byte_rem[2]     ), @86
//          .zero   (byte_zero[2]    ), @87
//          .out    (ff1_2[4:0]      )); @88

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_3"); @90
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_3 (
  .out          (ff1_3[4:0]  ),
  .rem          (byte_rem[3] ),
  .src          (byte_3[7:0] ),
  .zero         (byte_zero[3])
);

// &Connect(.src    (byte_3[BYTE-1:0]), @91
//          .rem    (byte_rem[3]     ), @92
//          .zero   (byte_zero[3]    ), @93
//          .out    (ff1_3[4:0]      )); @94

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_4"); @96
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_4 (
  .out          (ff1_4[4:0]  ),
  .rem          (byte_rem[4] ),
  .src          (byte_4[7:0] ),
  .zero         (byte_zero[4])
);

// &Connect(.src    (byte_4[BYTE-1:0]), @97
//          .rem    (byte_rem[4]     ), @98
//          .zero   (byte_zero[4]    ), @99
//          .out    (ff1_4[4:0]      )); @100

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_5"); @102
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_5 (
  .out          (ff1_5[4:0]  ),
  .rem          (byte_rem[5] ),
  .src          (byte_5[7:0] ),
  .zero         (byte_zero[5])
);

// &Connect(.src    (byte_5[BYTE-1:0]), @103
//          .rem    (byte_rem[5]     ), @104
//          .zero   (byte_zero[5]    ), @105
//          .out    (ff1_5[4:0]      )); @106

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_6"); @108
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_6 (
  .out          (ff1_6[4:0]  ),
  .rem          (byte_rem[6] ),
  .src          (byte_6[7:0] ),
  .zero         (byte_zero[6])
);

// &Connect(.src    (byte_6[BYTE-1:0]), @109
//          .rem    (byte_rem[6]     ), @110
//          .zero   (byte_zero[6]    ), @111
//          .out    (ff1_6[4:0]      )); @112

// &Instance("aq_vdsp_8_bit_ff1","x_aq_vdsp_8_bit_ff1_7"); @114
aq_vdsp_8_bit_ff1  x_aq_vdsp_8_bit_ff1_7 (
  .out          (ff1_7[4:0]  ),
  .rem          (byte_rem[7] ),
  .src          (byte_7[7:0] ),
  .zero         (byte_zero[7])
);

// &Connect(.src    (byte_7[BYTE-1:0]), @115
//          .rem    (byte_rem[7]     ), @116
//          .zero   (byte_zero[7]    ), @117
//          .out    (ff1_7[4:0]      )); @118

//FF1 calculation for BYTE
assign byte_inc[7:0] = ~(byte_rem[7:0] & src_sign[7:0]);

assign b0_ff1[4:0] = ff1_0[4:0]+{4'b0,byte_inc[0]};
assign b1_ff1[4:0] = ff1_1[4:0]+{4'b0,byte_inc[1]};
assign b2_ff1[4:0] = ff1_2[4:0]+{4'b0,byte_inc[2]};
assign b3_ff1[4:0] = ff1_3[4:0]+{4'b0,byte_inc[3]};
assign b4_ff1[4:0] = ff1_4[4:0]+{4'b0,byte_inc[4]};
assign b5_ff1[4:0] = ff1_5[4:0]+{4'b0,byte_inc[5]};
assign b6_ff1[4:0] = ff1_6[4:0]+{4'b0,byte_inc[6]};
assign b7_ff1[4:0] = ff1_7[4:0]+{4'b0,byte_inc[7]};

assign half_inc[7] = !(byte_rem[7] & src_sign[7] & !(|ex1_src[7*BYTE-1:6*BYTE]));
assign half_inc[6] = !(byte_rem[6] & src_sign[7]);
assign half_inc[5] = !(byte_rem[5] & src_sign[5] & !(|ex1_src[5*BYTE-1:4*BYTE]));
assign half_inc[4] = !(byte_rem[4] & src_sign[5]);
assign half_inc[3] = !(byte_rem[3] & src_sign[3] & !(|ex1_src[3*BYTE-1:2*BYTE]));
assign half_inc[2] = !(byte_rem[2] & src_sign[3]);
assign half_inc[1] = !(byte_rem[1] & src_sign[1] & !(|ex1_src[1*BYTE-1:0*BYTE]));
assign half_inc[0] = !(byte_rem[0] & src_sign[1]);
//FF1 calculation for HALF

assign h0_ff1[5:0] = byte_zero[1] ? (6'b00_1000 + {ff1_0[4],ff1_0[4:0]} + { {5{1'b0}},half_inc[0]} )
                                  : (             {ff1_1[4],ff1_1[4:0]} + { {5{1'b0}},half_inc[1]} );

assign h1_ff1[5:0] = byte_zero[3] ? (6'b00_1000 + {ff1_2[4],ff1_2[4:0]} + { {5{1'b0}},half_inc[2]} )
                                  : (             {ff1_3[4],ff1_3[4:0]} + { {5{1'b0}},half_inc[3]} );

assign h2_ff1[5:0] = byte_zero[5] ? (6'b00_1000 + {ff1_4[4],ff1_4[4:0]} + { {5{1'b0}},half_inc[4]} )
                                  : (             {ff1_5[4],ff1_5[4:0]} + { {5{1'b0}},half_inc[5]} );

assign h3_ff1[5:0] = byte_zero[7] ? (6'b00_1000 + {ff1_6[4],ff1_6[4:0]} + { {5{1'b0}},half_inc[6]} )
                                  : (             {ff1_7[4],ff1_7[4:0]} + { {5{1'b0}},half_inc[7]} );
                 
assign word_inc[7] = !(byte_rem[7] & src_sign[7] & !(|ex1_src[7*BYTE-1:4*BYTE]));
assign word_inc[6] = !(byte_rem[6] & src_sign[7] & !(|ex1_src[6*BYTE-1:4*BYTE]));
assign word_inc[5] = !(byte_rem[5] & src_sign[7] & !(|ex1_src[5*BYTE-1:4*BYTE]));
assign word_inc[4] = !(byte_rem[4] & src_sign[7]);
assign word_inc[3] = !(byte_rem[3] & src_sign[3] & !(|ex1_src[3*BYTE-1:0*BYTE]));
assign word_inc[2] = !(byte_rem[2] & src_sign[3] & !(|ex1_src[2*BYTE-1:0*BYTE]));
assign word_inc[1] = !(byte_rem[1] & src_sign[3] & !(|ex1_src[1*BYTE-1:0*BYTE]));
assign word_inc[0] = !(byte_rem[0] & src_sign[3]);

// &CombBeg; @163
always @( ff1_1[4:0]
       or ff1_3[4:0]
       or word_inc[3:0]
       or byte_zero[3:1]
       or ff1_2[4:0]
       or ff1_0[4:0])
begin
casez(byte_zero[3:1])
  3'b0??: w0_ff1[6:0] = 7'b000_0000 + { {2{ff1_3[4]}},ff1_3[4:0]} + { {6{1'b0}},word_inc[3]};  
  3'b10?: w0_ff1[6:0] = 7'b000_1000 + { {2{ff1_2[4]}},ff1_2[4:0]} + { {6{1'b0}},word_inc[2]};
  3'b110: w0_ff1[6:0] = 7'b001_0000 + { {2{ff1_1[4]}},ff1_1[4:0]} + { {6{1'b0}},word_inc[1]};
  3'b111: w0_ff1[6:0] = 7'b001_1000 + { {2{ff1_0[4]}},ff1_0[4:0]} + { {6{1'b0}},word_inc[0]};
default : w0_ff1[6:0] = {7{1'bx}};
endcase
// &CombEnd; @171
end

// &CombBeg; @173
always @( ff1_6[4:0]
       or ff1_5[4:0]
       or byte_zero[7:5]
       or ff1_7[4:0]
       or ff1_4[4:0]
       or word_inc[7:4])
begin
casez(byte_zero[7:5])
  3'b0??: w1_ff1[6:0] = 7'b000_0000 + { {2{ff1_7[4]}},ff1_7[4:0]} + { {6{1'b0}},word_inc[7]};  
  3'b10?: w1_ff1[6:0] = 7'b000_1000 + { {2{ff1_6[4]}},ff1_6[4:0]} + { {6{1'b0}},word_inc[6]};
  3'b110: w1_ff1[6:0] = 7'b001_0000 + { {2{ff1_5[4]}},ff1_5[4:0]} + { {6{1'b0}},word_inc[5]};
  3'b111: w1_ff1[6:0] = 7'b001_1000 + { {2{ff1_4[4]}},ff1_4[4:0]} + { {6{1'b0}},word_inc[4]};
default : w1_ff1[6:0] = {7{1'bx}};
endcase
// &CombEnd; @181
end

assign dbwd_inc[7] = !(byte_rem[7] & src_sign[7] & !(|ex1_src[7*BYTE-1:0*BYTE]));
assign dbwd_inc[6] = !(byte_rem[6] & src_sign[7] & !(|ex1_src[6*BYTE-1:0*BYTE]));
assign dbwd_inc[5] = !(byte_rem[5] & src_sign[7] & !(|ex1_src[5*BYTE-1:0*BYTE]));
assign dbwd_inc[4] = !(byte_rem[4] & src_sign[7] & !(|ex1_src[4*BYTE-1:0*BYTE]));
assign dbwd_inc[3] = !(byte_rem[3] & src_sign[7] & !(|ex1_src[3*BYTE-1:0*BYTE]));
assign dbwd_inc[2] = !(byte_rem[2] & src_sign[7] & !(|ex1_src[2*BYTE-1:0*BYTE]));
assign dbwd_inc[1] = !(byte_rem[1] & src_sign[7] & !(|ex1_src[1*BYTE-1:0*BYTE]));
assign dbwd_inc[0] = !(byte_rem[0] & src_sign[7]);

// &CombBeg; @192
always @( ff1_1[4:0]
       or ff1_3[4:0]
       or ff1_2[4:0]
       or ff1_7[4:0]
       or ff1_0[4:0]
       or ff1_4[4:0]
       or ff1_6[4:0]
       or byte_zero[7:1]
       or ff1_5[4:0]
       or dbwd_inc[7:0])
begin
casez(byte_zero[7:1])
  7'b0???_??? : d_ff1[7:0] = 8'b0000_0000 + { {3{ff1_7[4]}},ff1_7[4:0]} + { {7{1'b0}},dbwd_inc[7]};
  7'b10??_??? : d_ff1[7:0] = 8'b0000_1000 + { {3{ff1_6[4]}},ff1_6[4:0]} + { {7{1'b0}},dbwd_inc[6]};
  7'b110?_??? : d_ff1[7:0] = 8'b0001_0000 + { {3{ff1_5[4]}},ff1_5[4:0]} + { {7{1'b0}},dbwd_inc[5]};
  7'b1110_??? : d_ff1[7:0] = 8'b0001_1000 + { {3{ff1_4[4]}},ff1_4[4:0]} + { {7{1'b0}},dbwd_inc[4]};
  7'b1111_0?? : d_ff1[7:0] = 8'b0010_0000 + { {3{ff1_3[4]}},ff1_3[4:0]} + { {7{1'b0}},dbwd_inc[3]};
  7'b1111_10? : d_ff1[7:0] = 8'b0010_1000 + { {3{ff1_2[4]}},ff1_2[4:0]} + { {7{1'b0}},dbwd_inc[2]};
  7'b1111_110 : d_ff1[7:0] = 8'b0011_0000 + { {3{ff1_1[4]}},ff1_1[4:0]} + { {7{1'b0}},dbwd_inc[1]};
  7'b1111_111 : d_ff1[7:0] = 8'b0011_1000 + { {3{ff1_0[4]}},ff1_0[4:0]} + { {7{1'b0}},dbwd_inc[0]};
default       : d_ff1[7:0] = {8{1'bx}};
endcase
// &CombEnd; @204
end

assign ff1_8_bit[39:0] = {b7_ff1[4:0],b6_ff1[4:0],b5_ff1[4:0],b4_ff1[4:0],
                          b3_ff1[4:0],b2_ff1[4:0],b1_ff1[4:0],b0_ff1[4:0]};

assign ff1_16_bit[23:0] = {h3_ff1[5:0], h2_ff1[5:0], h1_ff1[5:0], h0_ff1[5:0]};

assign ff1_32_bit[13:0] = {w1_ff1[6:0], w0_ff1[6:0]};

assign ff1_64_bit[7:0]  = d_ff1[7:0];

// &ModuleEnd; @215
endmodule



