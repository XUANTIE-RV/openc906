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
module multiplier_33x33_partial(
  mult_round,
  mult_sub,
  multiplicand,
  multiplier,
  result_0,
  result_1
);

// &Ports; @21
input   [31:0]  mult_round;    
input           mult_sub;      
input   [32:0]  multiplicand;  
input   [32:0]  multiplier;    
output  [68:0]  result_0;      
output  [68:0]  result_1;      

// &Regs; @22

// &Wires; @23
wire    [65:0]  data_for_acc;  
wire    [34:0]  data_for_code; 
wire    [65:0]  ex1_c0_0;      
wire    [65:0]  ex1_c0_1;      
wire    [65:0]  ex1_c0_2;      
wire    [65:0]  ex1_c0_3;      
wire    [65:0]  ex1_c0_4;      
wire    [65:0]  ex1_c0_5;      
wire    [65:0]  ex1_c1_0;      
wire    [65:0]  ex1_c1_1;      
wire    [65:0]  ex1_c1_2;      
wire    [65:0]  ex1_p0_0_0;    
wire    [65:0]  ex1_p0_0_1;    
wire    [65:0]  ex1_p0_0_2;    
wire    [65:0]  ex1_p0_0_3;    
wire    [65:0]  ex1_p0_0_cout; 
wire    [65:0]  ex1_p0_0_xor;  
wire    [65:0]  ex1_p0_1_0;    
wire    [65:0]  ex1_p0_1_1;    
wire    [65:0]  ex1_p0_1_2;    
wire    [65:0]  ex1_p0_2_0;    
wire    [65:0]  ex1_p0_2_1;    
wire    [65:0]  ex1_p0_2_2;    
wire    [65:0]  ex1_p0_3_0;    
wire    [65:0]  ex1_p0_3_1;    
wire    [65:0]  ex1_p0_3_2;    
wire    [65:0]  ex1_p0_4_0;    
wire    [65:0]  ex1_p0_4_1;    
wire    [65:0]  ex1_p0_4_2;    
wire    [65:0]  ex1_p0_5_0;    
wire    [65:0]  ex1_p0_5_1;    
wire    [65:0]  ex1_p0_5_2;    
wire    [65:0]  ex1_p1_0_0;    
wire    [65:0]  ex1_p1_0_1;    
wire    [65:0]  ex1_p1_0_2;    
wire    [65:0]  ex1_p1_0_3;    
wire    [65:0]  ex1_p1_0_cout; 
wire    [65:0]  ex1_p1_0_xor;  
wire    [65:0]  ex1_p1_1_0;    
wire    [65:0]  ex1_p1_1_1;    
wire    [65:0]  ex1_p1_1_2;    
wire    [65:0]  ex1_p1_1_3;    
wire    [65:0]  ex1_p1_1_cout; 
wire    [65:0]  ex1_p1_1_xor;  
wire    [65:0]  ex1_p1_2_0;    
wire    [65:0]  ex1_p1_2_1;    
wire    [65:0]  ex1_p1_2_2;    
wire    [65:0]  ex1_p1_2_3;    
wire    [65:0]  ex1_p1_2_cout; 
wire    [65:0]  ex1_p1_2_xor;  
wire    [66:0]  ex1_p2_0_0;    
wire    [66:0]  ex1_p2_0_1;    
wire    [66:0]  ex1_p2_0_2;    
wire    [66:0]  ex1_p2_1_0;    
wire    [66:0]  ex1_p2_1_1;    
wire    [66:0]  ex1_p2_1_2;    
wire    [65:0]  ex1_s0_0;      
wire    [65:0]  ex1_s0_1;      
wire    [65:0]  ex1_s0_2;      
wire    [65:0]  ex1_s0_3;      
wire    [65:0]  ex1_s0_4;      
wire    [65:0]  ex1_s0_5;      
wire    [65:0]  ex1_s1_0;      
wire    [65:0]  ex1_s1_1;      
wire    [65:0]  ex1_s1_2;      
wire    [66:0]  ex2_c2_0;      
wire    [66:0]  ex2_c2_1;      
wire    [67:0]  ex2_c3_0;      
wire    [66:0]  ex2_p2_0_0;    
wire    [66:0]  ex2_p2_0_1;    
wire    [66:0]  ex2_p2_0_2;    
wire    [66:0]  ex2_p2_1_0;    
wire    [66:0]  ex2_p2_1_1;    
wire    [66:0]  ex2_p2_1_2;    
wire    [67:0]  ex2_p3_0_0;    
wire    [67:0]  ex2_p3_0_1;    
wire    [67:0]  ex2_p3_0_2;    
wire    [67:0]  ex2_p3_0_3;    
wire    [67:0]  ex2_p3_0_cout; 
wire    [67:0]  ex2_p3_0_xor;  
wire    [66:0]  ex2_s2_0;      
wire    [66:0]  ex2_s2_1;      
wire    [67:0]  ex2_s3_0;      
wire    [1 :0]  h0;            
wire    [1 :0]  h1;            
wire    [1 :0]  h10;           
wire    [1 :0]  h11;           
wire    [1 :0]  h12;           
wire    [1 :0]  h13;           
wire    [1 :0]  h14;           
wire    [1 :0]  h15;           
wire    [1 :0]  h16;           
wire    [1 :0]  h2;            
wire    [1 :0]  h3;            
wire    [1 :0]  h4;            
wire    [1 :0]  h5;            
wire    [1 :0]  h6;            
wire    [1 :0]  h7;            
wire    [1 :0]  h8;            
wire    [1 :0]  h9;            
wire    [31:0]  mult_round;    
wire    [32:0]  mult_src;      
wire            mult_sub;      
wire    [32:0]  multiplicand;  
wire    [32:0]  multiplier;    
wire    [32:0]  part_product0; 
wire    [32:0]  part_product1; 
wire    [32:0]  part_product10; 
wire    [32:0]  part_product11; 
wire    [32:0]  part_product12; 
wire    [32:0]  part_product13; 
wire    [32:0]  part_product14; 
wire    [32:0]  part_product15; 
wire    [32:0]  part_product16; 
wire    [32:0]  part_product2; 
wire    [32:0]  part_product3; 
wire    [32:0]  part_product4; 
wire    [32:0]  part_product5; 
wire    [32:0]  part_product6; 
wire    [32:0]  part_product7; 
wire    [32:0]  part_product8; 
wire    [32:0]  part_product9; 
wire    [68:0]  result_0;      
wire    [68:0]  result_1;      
wire    [16:0]  sign_not;      


parameter SRC0_WIDTH = 33;
parameter SRC1_WIDTH = 33;
parameter DST_WIDTH  = 66;

assign mult_src[SRC1_WIDTH-1:0] = mult_sub ? (~multiplier[SRC1_WIDTH-1:0]):multiplier[SRC1_WIDTH-1:0];

assign data_for_code[SRC1_WIDTH+1:0] = {mult_src[SRC1_WIDTH-1],mult_src[SRC1_WIDTH-1:0],1'b0};

assign data_for_acc[DST_WIDTH-1:0] = mult_sub ?
                                    {{SRC1_WIDTH{multiplicand[SRC0_WIDTH-1]}},multiplicand[SRC0_WIDTH-1:0]} :
                                     {DST_WIDTH{1'b0}};

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit0"); @37
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit0 (
  .A                   (multiplicand[32:0] ),
  .code                (data_for_code[2:0] ),
  .h                   (h0[1:0]            ),
  .product             (part_product0[32:0]),
  .sn                  (sign_not[0]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @38
//          .code(data_for_code[2:0]), @39
//          .product(part_product0[SRC0_WIDTH-1:0]), @40
//          .h(h0[1:0]), @41
//          .sn(sign_not[0])); @42

// &Instance("booth_code_33_bit",   "x_pa_dsp_mult_booth_code_33_bit1"); @44
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit1 (
  .A                   (multiplicand[32:0] ),
  .code                (data_for_code[4:2] ),
  .h                   (h1[1:0]            ),
  .product             (part_product1[32:0]),
  .sn                  (sign_not[1]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @45
//          .code(data_for_code[4:2]), @46
//          .product(part_product1[SRC0_WIDTH-1:0]), @47
//          .h(h1[1:0]), @48
//          .sn(sign_not[1])); @49

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit2"); @51
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit2 (
  .A                   (multiplicand[32:0] ),
  .code                (data_for_code[6:4] ),
  .h                   (h2[1:0]            ),
  .product             (part_product2[32:0]),
  .sn                  (sign_not[2]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @52
//          .code(data_for_code[6:4]), @53
//          .product(part_product2[SRC0_WIDTH-1:0]), @54
//          .h(h2[1:0]), @55
//          .sn(sign_not[2])); @56

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit3"); @58
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit3 (
  .A                   (multiplicand[32:0] ),
  .code                (data_for_code[8:6] ),
  .h                   (h3[1:0]            ),
  .product             (part_product3[32:0]),
  .sn                  (sign_not[3]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @59
//          .code(data_for_code[8:6]), @60
//          .product(part_product3[SRC0_WIDTH-1:0]), @61
//          .h(h3[1:0]), @62
//          .sn(sign_not[3])); @63

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit4"); @65
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit4 (
  .A                   (multiplicand[32:0] ),
  .code                (data_for_code[10:8]),
  .h                   (h4[1:0]            ),
  .product             (part_product4[32:0]),
  .sn                  (sign_not[4]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @66
//          .code(data_for_code[10:8]), @67
//          .product(part_product4[SRC0_WIDTH-1:0]), @68
//          .h(h4[1:0]), @69
//          .sn(sign_not[4])); @70

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit5"); @72
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit5 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[12:10]),
  .h                    (h5[1:0]             ),
  .product              (part_product5[32:0] ),
  .sn                   (sign_not[5]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @73
//          .code(data_for_code[12:10]), @74
//          .product(part_product5[SRC0_WIDTH-1:0]), @75
//          .h(h5[1:0]), @76
//          .sn(sign_not[5])); @77

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit6"); @79
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit6 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[14:12]),
  .h                    (h6[1:0]             ),
  .product              (part_product6[32:0] ),
  .sn                   (sign_not[6]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @80
//          .code(data_for_code[14:12]), @81
//          .product(part_product6[SRC0_WIDTH-1:0]), @82
//          .h(h6[1:0]), @83
//          .sn(sign_not[6])); @84

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit7"); @86
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit7 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[16:14]),
  .h                    (h7[1:0]             ),
  .product              (part_product7[32:0] ),
  .sn                   (sign_not[7]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @87
//          .code(data_for_code[16:14]), @88
//          .product(part_product7[SRC0_WIDTH-1:0]), @89
//          .h(h7[1:0]), @90
//          .sn(sign_not[7])); @91

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit8"); @93
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit8 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[18:16]),
  .h                    (h8[1:0]             ),
  .product              (part_product8[32:0] ),
  .sn                   (sign_not[8]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @94
//          .code(data_for_code[18:16]), @95
//          .product(part_product8[SRC0_WIDTH-1:0]), @96
//          .h(h8[1:0]), @97
//          .sn(sign_not[8])); @98

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit9"); @100
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit9 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[20:18]),
  .h                    (h9[1:0]             ),
  .product              (part_product9[32:0] ),
  .sn                   (sign_not[9]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @101
//          .code(data_for_code[20:18]), @102
//          .product(part_product9[SRC0_WIDTH-1:0]), @103
//          .h(h9[1:0]), @104
//          .sn(sign_not[9])); @105

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit10"); @107
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit10 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[22:20]),
  .h                    (h10[1:0]            ),
  .product              (part_product10[32:0]),
  .sn                   (sign_not[10]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @108
//          .code(data_for_code[22:20]), @109
//          .product(part_product10[SRC0_WIDTH-1:0]), @110
//          .h(h10[1:0]), @111
//          .sn(sign_not[10])); @112

// &Instance("booth_code_33_bit",   "x_pa_dsp_mult_booth_code_33_bit11"); @114
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit11 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[24:22]),
  .h                    (h11[1:0]            ),
  .product              (part_product11[32:0]),
  .sn                   (sign_not[11]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @115
//          .code(data_for_code[24:22]), @116
//          .product(part_product11[SRC0_WIDTH-1:0]), @117
//          .h(h11[1:0]), @118
//          .sn(sign_not[11])); @119

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit12"); @121
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit12 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[26:24]),
  .h                    (h12[1:0]            ),
  .product              (part_product12[32:0]),
  .sn                   (sign_not[12]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @122
//          .code(data_for_code[26:24]), @123
//          .product(part_product12[SRC0_WIDTH-1:0]), @124
//          .h(h12[1:0]), @125
//          .sn(sign_not[12])); @126

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit13"); @128
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit13 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[28:26]),
  .h                    (h13[1:0]            ),
  .product              (part_product13[32:0]),
  .sn                   (sign_not[13]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @129
//          .code(data_for_code[28:26]), @130
//          .product(part_product13[SRC0_WIDTH-1:0]), @131
//          .h(h13[1:0]), @132
//          .sn(sign_not[13])); @133

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit14"); @135
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit14 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[30:28]),
  .h                    (h14[1:0]            ),
  .product              (part_product14[32:0]),
  .sn                   (sign_not[14]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @136
//          .code(data_for_code[30:28]), @137
//          .product(part_product14[SRC0_WIDTH-1:0]), @138
//          .h(h14[1:0]), @139
//          .sn(sign_not[14])); @140

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit15"); @142
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit15 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[32:30]),
  .h                    (h15[1:0]            ),
  .product              (part_product15[32:0]),
  .sn                   (sign_not[15]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @143
//          .code(data_for_code[32:30]), @144
//          .product(part_product15[SRC0_WIDTH-1:0]), @145
//          .h(h15[1:0]), @146
//          .sn(sign_not[15])); @147

// &Instance("booth_code_33_bit", "x_pa_dsp_mult_booth_code_33_bit16"); @149
booth_code_33_bit  x_pa_dsp_mult_booth_code_33_bit16 (
  .A                    (multiplicand[32:0]  ),
  .code                 (data_for_code[34:32]),
  .h                    (h16[1:0]            ),
  .product              (part_product16[32:0]),
  .sn                   (sign_not[16]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @150
//          .code(data_for_code[34:32]), @151
//          .product(part_product16[SRC0_WIDTH-1:0]), @152
//          .h(h16[1:0]), @153
//          .sn(sign_not[16])); @154

//=============================================================================
//    prepare for the the first compression
//=============================================================================

assign  ex1_p0_0_0[DST_WIDTH-1:0] =  data_for_acc[DST_WIDTH-1:0];
assign  ex1_p0_0_1[DST_WIDTH-1:0] =  { {30{1'b0}},      sign_not[0],{2{!sign_not[0]}},part_product0[SRC0_WIDTH-1:0]};
assign  ex1_p0_0_2[DST_WIDTH-1:0] =  { {29{1'b0}},1'b1, sign_not[1],  part_product1[SRC0_WIDTH-1:0], h0[1:0]};
assign  ex1_p0_0_3[DST_WIDTH-1:0] =  { {SRC0_WIDTH-1{1'b0}},                     h16[1:0],mult_round[31:0]};

assign  ex1_p0_1_0[DST_WIDTH-1:0] =  { {27{1'b0}},1'b1, sign_not[2],  part_product2[SRC0_WIDTH-1:0], h1[1:0], { 2{1'b0}} };
assign  ex1_p0_1_1[DST_WIDTH-1:0] =  { {25{1'b0}},1'b1, sign_not[3],  part_product3[SRC0_WIDTH-1:0], h2[1:0], { 4{1'b0}} };
assign  ex1_p0_1_2[DST_WIDTH-1:0] =  { {23{1'b0}},1'b1, sign_not[4],  part_product4[SRC0_WIDTH-1:0], h3[1:0], { 6{1'b0}} };

assign  ex1_p0_2_0[DST_WIDTH-1:0] =  { {21{1'b0}},1'b1, sign_not[5],  part_product5[SRC0_WIDTH-1:0], h4[1:0], { 8{1'b0}} };
assign  ex1_p0_2_1[DST_WIDTH-1:0] =  { {19{1'b0}},1'b1, sign_not[6],  part_product6[SRC0_WIDTH-1:0], h5[1:0], {10{1'b0}} };
assign  ex1_p0_2_2[DST_WIDTH-1:0] =  { {17{1'b0}},1'b1, sign_not[7],  part_product7[SRC0_WIDTH-1:0], h6[1:0], {12{1'b0}} };

assign  ex1_p0_3_0[DST_WIDTH-1:0] =  { {15{1'b0}},1'b1, sign_not[8],  part_product8[SRC0_WIDTH-1:0], h7[1:0], {14{1'b0}} };
assign  ex1_p0_3_1[DST_WIDTH-1:0] =  { {13{1'b0}},1'b1, sign_not[9],  part_product9[SRC0_WIDTH-1:0], h8[1:0], {16{1'b0}} };
assign  ex1_p0_3_2[DST_WIDTH-1:0] =  { {11{1'b0}},1'b1, sign_not[10], part_product10[SRC0_WIDTH-1:0],h9[1:0], {18{1'b0}} };

assign  ex1_p0_4_0[DST_WIDTH-1:0] =  { { 9{1'b0}},1'b1, sign_not[11], part_product11[SRC0_WIDTH-1:0],h10[1:0],{20{1'b0}} };
assign  ex1_p0_4_1[DST_WIDTH-1:0] =  { { 7{1'b0}},1'b1, sign_not[12], part_product12[SRC0_WIDTH-1:0],h11[1:0],{22{1'b0}} };
assign  ex1_p0_4_2[DST_WIDTH-1:0] =  { { 5{1'b0}},1'b1, sign_not[13], part_product13[SRC0_WIDTH-1:0],h12[1:0],{24{1'b0}} };

assign  ex1_p0_5_0[DST_WIDTH-1:0] =  { { 3{1'b0}},1'b1, sign_not[14], part_product14[SRC0_WIDTH-1:0],h13[1:0],{26{1'b0}} };
assign  ex1_p0_5_1[DST_WIDTH-1:0] =  { { 1{1'b0}},1'b1, sign_not[15], part_product15[SRC0_WIDTH-1:0],h14[1:0],{28{1'b0}} };
assign  ex1_p0_5_2[DST_WIDTH-1:0] =  {                  sign_not[16], part_product16[SRC0_WIDTH-1:0],h15[1:0],{30{1'b0}} };


//=========== 19 src to 12 src==========//
assign ex1_p0_0_cout[DST_WIDTH-1:0] = (ex1_p0_0_0[DST_WIDTH-1:0]  &  ex1_p0_0_1[DST_WIDTH-1:0]) |
                                      (ex1_p0_0_1[DST_WIDTH-1:0]  &  ex1_p0_0_2[DST_WIDTH-1:0]) |
                                      (ex1_p0_0_0[DST_WIDTH-1:0]  &  ex1_p0_0_2[DST_WIDTH-1:0]) ;

assign ex1_p0_0_xor[DST_WIDTH-1:0]  = (ex1_p0_0_0[DST_WIDTH-1:0]  ^  ex1_p0_0_1[DST_WIDTH-1:0]) ^
                                      (ex1_p0_0_2[DST_WIDTH-1:0]  ^  ex1_p0_0_3[DST_WIDTH-1:0]);

assign ex1_s0_0[DST_WIDTH-1:0]      =  ex1_p0_0_xor[DST_WIDTH-1:0]^ {ex1_p0_0_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c0_0[DST_WIDTH-1:0]      =  ex1_p0_0_xor[DST_WIDTH-1:0]& {ex1_p0_0_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p0_0_xor[DST_WIDTH-1:0]&  ex1_p0_0_3[DST_WIDTH-1:0]);

assign ex1_s0_1[DST_WIDTH-1:0] = ex1_p0_1_0[DST_WIDTH-1:0] ^
                                 ex1_p0_1_1[DST_WIDTH-1:0] ^
                                 ex1_p0_1_2[DST_WIDTH-1:0];

assign ex1_c0_1[DST_WIDTH-1:0] = ex1_p0_1_0[DST_WIDTH-1:0] & ex1_p0_1_1[DST_WIDTH-1:0] |
                                 ex1_p0_1_0[DST_WIDTH-1:0] & ex1_p0_1_2[DST_WIDTH-1:0] |
                                 ex1_p0_1_1[DST_WIDTH-1:0] & ex1_p0_1_2[DST_WIDTH-1:0];

assign ex1_s0_2[DST_WIDTH-1:0] = ex1_p0_2_0[DST_WIDTH-1:0] ^
                                 ex1_p0_2_1[DST_WIDTH-1:0] ^
                                 ex1_p0_2_2[DST_WIDTH-1:0];

assign ex1_c0_2[DST_WIDTH-1:0] = ex1_p0_2_0[DST_WIDTH-1:0] & ex1_p0_2_1[DST_WIDTH-1:0] |
                                 ex1_p0_2_0[DST_WIDTH-1:0] & ex1_p0_2_2[DST_WIDTH-1:0] |
                                 ex1_p0_2_1[DST_WIDTH-1:0] & ex1_p0_2_2[DST_WIDTH-1:0];

assign ex1_s0_3[DST_WIDTH-1:0] = ex1_p0_3_0[DST_WIDTH-1:0] ^
                                 ex1_p0_3_1[DST_WIDTH-1:0] ^
                                 ex1_p0_3_2[DST_WIDTH-1:0];

assign ex1_c0_3[DST_WIDTH-1:0] = ex1_p0_3_0[DST_WIDTH-1:0] & ex1_p0_3_1[DST_WIDTH-1:0] |
                                 ex1_p0_3_0[DST_WIDTH-1:0] & ex1_p0_3_2[DST_WIDTH-1:0] |
                                 ex1_p0_3_1[DST_WIDTH-1:0] & ex1_p0_3_2[DST_WIDTH-1:0];

assign ex1_s0_4[DST_WIDTH-1:0] = ex1_p0_4_0[DST_WIDTH-1:0] ^
                                 ex1_p0_4_1[DST_WIDTH-1:0] ^
                                 ex1_p0_4_2[DST_WIDTH-1:0];

assign ex1_c0_4[DST_WIDTH-1:0] = ex1_p0_4_0[DST_WIDTH-1:0] & ex1_p0_4_1[DST_WIDTH-1:0] |
                                 ex1_p0_4_0[DST_WIDTH-1:0] & ex1_p0_4_2[DST_WIDTH-1:0] |
                                 ex1_p0_4_1[DST_WIDTH-1:0] & ex1_p0_4_2[DST_WIDTH-1:0];

assign ex1_s0_5[DST_WIDTH-1:0] = ex1_p0_5_0[DST_WIDTH-1:0] ^
                                 ex1_p0_5_1[DST_WIDTH-1:0] ^
                                 ex1_p0_5_2[DST_WIDTH-1:0];

assign ex1_c0_5[DST_WIDTH-1:0] = ex1_p0_5_0[DST_WIDTH-1:0] & ex1_p0_5_1[DST_WIDTH-1:0] |
                                 ex1_p0_5_0[DST_WIDTH-1:0] & ex1_p0_5_2[DST_WIDTH-1:0] |
                                 ex1_p0_5_1[DST_WIDTH-1:0] & ex1_p0_5_2[DST_WIDTH-1:0];
//=============================================================================
//    prepare for the the second compression
//=============================================================================
assign ex1_p1_0_0[DST_WIDTH-1:0] = ex1_s0_0[DST_WIDTH-1:0];
assign ex1_p1_0_1[DST_WIDTH-1:0] ={ex1_c0_0[DST_WIDTH-2:0],1'b0};
assign ex1_p1_0_2[DST_WIDTH-1:0] = ex1_s0_1[DST_WIDTH-1:0];
assign ex1_p1_0_3[DST_WIDTH-1:0] ={ex1_c0_1[DST_WIDTH-2:0],1'b0};

assign ex1_p1_1_0[DST_WIDTH-1:0] = ex1_s0_2[DST_WIDTH-1:0];
assign ex1_p1_1_1[DST_WIDTH-1:0] ={ex1_c0_2[DST_WIDTH-2:0],1'b0};
assign ex1_p1_1_2[DST_WIDTH-1:0] = ex1_s0_3[DST_WIDTH-1:0];
assign ex1_p1_1_3[DST_WIDTH-1:0] ={ex1_c0_3[DST_WIDTH-2:0],1'b0};

assign ex1_p1_2_0[DST_WIDTH-1:0] = ex1_s0_4[DST_WIDTH-1:0];
assign ex1_p1_2_1[DST_WIDTH-1:0] ={ex1_c0_4[DST_WIDTH-2:0],1'b0};
assign ex1_p1_2_2[DST_WIDTH-1:0] = ex1_s0_5[DST_WIDTH-1:0];
assign ex1_p1_2_3[DST_WIDTH-1:0] ={ex1_c0_5[DST_WIDTH-2:0],1'b0};

//=========== 12 src to 6 src==========//
assign ex1_p1_0_cout[DST_WIDTH-1:0] = (ex1_p1_0_0[DST_WIDTH-1:0]  &  ex1_p1_0_1[DST_WIDTH-1:0]) |
                                      (ex1_p1_0_1[DST_WIDTH-1:0]  &  ex1_p1_0_2[DST_WIDTH-1:0]) |
                                      (ex1_p1_0_0[DST_WIDTH-1:0]  &  ex1_p1_0_2[DST_WIDTH-1:0]) ;

assign ex1_p1_0_xor[DST_WIDTH-1:0]  = (ex1_p1_0_0[DST_WIDTH-1:0]  ^  ex1_p1_0_1[DST_WIDTH-1:0]) ^
                                      (ex1_p1_0_2[DST_WIDTH-1:0]  ^  ex1_p1_0_3[DST_WIDTH-1:0]);

assign ex1_s1_0[DST_WIDTH-1:0]      =  ex1_p1_0_xor[DST_WIDTH-1:0]^ {ex1_p1_0_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c1_0[DST_WIDTH-1:0]      =  ex1_p1_0_xor[DST_WIDTH-1:0]& {ex1_p1_0_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p1_0_xor[DST_WIDTH-1:0]&  ex1_p1_0_3[DST_WIDTH-1:0]);
//----------------------------------------------
assign ex1_p1_1_cout[DST_WIDTH-1:0] = (ex1_p1_1_0[DST_WIDTH-1:0]  &  ex1_p1_1_1[DST_WIDTH-1:0]) |
                                      (ex1_p1_1_1[DST_WIDTH-1:0]  &  ex1_p1_1_2[DST_WIDTH-1:0]) |
                                      (ex1_p1_1_0[DST_WIDTH-1:0]  &  ex1_p1_1_2[DST_WIDTH-1:0]) ;

assign ex1_p1_1_xor[DST_WIDTH-1:0]  = (ex1_p1_1_0[DST_WIDTH-1:0]  ^  ex1_p1_1_1[DST_WIDTH-1:0]) ^
                                      (ex1_p1_1_2[DST_WIDTH-1:0]  ^  ex1_p1_1_3[DST_WIDTH-1:0]);

assign ex1_s1_1[DST_WIDTH-1:0]      =  ex1_p1_1_xor[DST_WIDTH-1:0]^ {ex1_p1_1_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c1_1[DST_WIDTH-1:0]      =  ex1_p1_1_xor[DST_WIDTH-1:0]& {ex1_p1_1_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p1_1_xor[DST_WIDTH-1:0]&  ex1_p1_1_3[DST_WIDTH-1:0]);
//----------------------------------------------
assign ex1_p1_2_cout[DST_WIDTH-1:0] = (ex1_p1_2_0[DST_WIDTH-1:0]  &  ex1_p1_2_1[DST_WIDTH-1:0]) |
                                      (ex1_p1_2_1[DST_WIDTH-1:0]  &  ex1_p1_2_2[DST_WIDTH-1:0]) |
                                      (ex1_p1_2_0[DST_WIDTH-1:0]  &  ex1_p1_2_2[DST_WIDTH-1:0]) ;

assign ex1_p1_2_xor[DST_WIDTH-1:0]  = (ex1_p1_2_0[DST_WIDTH-1:0]  ^  ex1_p1_2_1[DST_WIDTH-1:0]) ^
                                      (ex1_p1_2_2[DST_WIDTH-1:0]  ^  ex1_p1_2_3[DST_WIDTH-1:0]);

assign ex1_s1_2[DST_WIDTH-1:0]      =  ex1_p1_2_xor[DST_WIDTH-1:0]^ {ex1_p1_2_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c1_2[DST_WIDTH-1:0]      =  ex1_p1_2_xor[DST_WIDTH-1:0]& {ex1_p1_2_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p1_2_xor[DST_WIDTH-1:0]&  ex1_p1_2_3[DST_WIDTH-1:0]);

//=============================================================================
//    prepare for the the third compression
//=============================================================================
assign ex1_p2_0_0[DST_WIDTH:0] ={ex1_s1_0[DST_WIDTH-1],ex1_s1_0[DST_WIDTH-1:0]};       //all valid
assign ex1_p2_0_1[DST_WIDTH:0] ={ex1_c1_0[DST_WIDTH-1:0],1'b0}; //all valid
assign ex1_p2_0_2[DST_WIDTH:0] ={ex1_s1_1[DST_WIDTH-1],ex1_s1_1[DST_WIDTH-1:0]};       //11-bit 8-bit

assign ex1_p2_1_0[DST_WIDTH:0] ={ex1_c1_1[DST_WIDTH-1:0],1'b0}; //11-bit 8-bit
assign ex1_p2_1_1[DST_WIDTH:0] ={ex1_s1_2[DST_WIDTH-1],ex1_s1_2[DST_WIDTH-1:0]};       //0-bit 20-bit
assign ex1_p2_1_2[DST_WIDTH:0] ={ex1_c1_2[DST_WIDTH-1:0],1'b0}; //0-bit 20-bit

assign ex2_p2_0_0[DST_WIDTH:0] = ex1_p2_0_0[DST_WIDTH:0];
assign ex2_p2_0_1[DST_WIDTH:0] = ex1_p2_0_1[DST_WIDTH:0];
assign ex2_p2_0_2[DST_WIDTH:0] = ex1_p2_0_2[DST_WIDTH:0];
assign ex2_p2_1_0[DST_WIDTH:0] = ex1_p2_1_0[DST_WIDTH:0];
assign ex2_p2_1_1[DST_WIDTH:0] = ex1_p2_1_1[DST_WIDTH:0];
assign ex2_p2_1_2[DST_WIDTH:0] = ex1_p2_1_2[DST_WIDTH:0];

//=========== 6 src to 4 src==========//
assign ex2_s2_0[DST_WIDTH:0] = ex2_p2_0_0[DST_WIDTH:0] ^
                               ex2_p2_0_1[DST_WIDTH:0] ^
                               ex2_p2_0_2[DST_WIDTH:0];

assign ex2_c2_0[DST_WIDTH:0] = ex2_p2_0_0[DST_WIDTH:0] & ex2_p2_0_1[DST_WIDTH:0] |
                               ex2_p2_0_0[DST_WIDTH:0] & ex2_p2_0_2[DST_WIDTH:0] |
                               ex2_p2_0_1[DST_WIDTH:0] & ex2_p2_0_2[DST_WIDTH:0];

assign ex2_s2_1[DST_WIDTH:0] = ex2_p2_1_0[DST_WIDTH:0] ^
                               ex2_p2_1_1[DST_WIDTH:0] ^
                               ex2_p2_1_2[DST_WIDTH:0];

assign ex2_c2_1[DST_WIDTH:0] = ex2_p2_1_0[DST_WIDTH:0] & ex2_p2_1_1[DST_WIDTH:0] |
                               ex2_p2_1_0[DST_WIDTH:0] & ex2_p2_1_2[DST_WIDTH:0] |
                               ex2_p2_1_1[DST_WIDTH:0] & ex2_p2_1_2[DST_WIDTH:0];

//=============================================================================
//    prepare for  the fourth compression
//=============================================================================
assign ex2_p3_0_0[DST_WIDTH+1:0] ={ex2_s2_0[DST_WIDTH],ex2_s2_0[DST_WIDTH:0]};        //0_1_6
assign ex2_p3_0_1[DST_WIDTH+1:0] ={ex2_c2_0[DST_WIDTH:0],1'b0};
assign ex2_p3_0_2[DST_WIDTH+1:0] ={ex2_s2_1[DST_WIDTH],ex2_s2_1[DST_WIDTH:0]};
assign ex2_p3_0_3[DST_WIDTH+1:0] ={ex2_c2_1[DST_WIDTH:0],1'b0};              //24_35_36

//=========== 4 src to 2 src==========//
assign ex2_p3_0_cout[DST_WIDTH+1:0] = (ex2_p3_0_0[DST_WIDTH+1:0]  &  ex2_p3_0_1[DST_WIDTH+1:0]) |
                                      (ex2_p3_0_1[DST_WIDTH+1:0]  &  ex2_p3_0_2[DST_WIDTH+1:0]) |
                                      (ex2_p3_0_0[DST_WIDTH+1:0]  &  ex2_p3_0_2[DST_WIDTH+1:0]) ;

assign ex2_p3_0_xor[DST_WIDTH+1:0]  = (ex2_p3_0_0[DST_WIDTH+1:0]  ^  ex2_p3_0_1[DST_WIDTH+1:0]) ^
                                      (ex2_p3_0_2[DST_WIDTH+1:0]  ^  ex2_p3_0_3[DST_WIDTH+1:0]);

assign ex2_s3_0[DST_WIDTH+1:0]      =  ex2_p3_0_xor[DST_WIDTH+1:0]^ {ex2_p3_0_cout[DST_WIDTH:0],1'b0};
assign ex2_c3_0[DST_WIDTH+1:0]      =  ex2_p3_0_xor[DST_WIDTH+1:0]& {ex2_p3_0_cout[DST_WIDTH:0],1'b0}|
                                     (~ex2_p3_0_xor[DST_WIDTH+1:0]&  ex2_p3_0_3[DST_WIDTH+1:0]);

assign result_0[DST_WIDTH+2:0] ={ex2_s3_0[DST_WIDTH+1],ex2_s3_0[DST_WIDTH+1:0]};
assign result_1[DST_WIDTH+2:0] ={ex2_c3_0[DST_WIDTH+1],ex2_c3_0[DST_WIDTH:0],1'b0};

// &ModuleEnd; @347
endmodule



