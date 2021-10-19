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
module aq_vfmau_multiplier_53x27_partial(
  a,
  b,
  out0,
  out1
);

// &Ports; @21
input   [52:0]  a;             
input   [26:0]  b;             
output  [83:0]  out0;          
output  [83:0]  out1;          

// &Regs; @22

// &Wires; @23
wire    [52:0]  a;             
wire    [26:0]  b;             
wire    [29:0]  data_for_code; 
wire    [81:0]  ex1_c0_0;      
wire    [81:0]  ex1_c0_1;      
wire    [81:0]  ex1_c0_2;      
wire    [81:0]  ex1_c0_3;      
wire    [81:0]  ex1_c1_0;      
wire    [81:0]  ex1_c1_1;      
wire    [82:0]  ex1_c2_0;      
wire    [81:0]  ex1_p0_0_0;    
wire    [81:0]  ex1_p0_0_1;    
wire    [81:0]  ex1_p0_0_2;    
wire    [81:0]  ex1_p0_0_3;    
wire    [81:0]  ex1_p0_0_cout; 
wire    [81:0]  ex1_p0_0_xor;  
wire    [81:0]  ex1_p0_1_0;    
wire    [81:0]  ex1_p0_1_1;    
wire    [81:0]  ex1_p0_1_2;    
wire    [81:0]  ex1_p0_1_3;    
wire    [81:0]  ex1_p0_1_cout; 
wire    [81:0]  ex1_p0_1_xor;  
wire    [81:0]  ex1_p0_2_0;    
wire    [81:0]  ex1_p0_2_1;    
wire    [81:0]  ex1_p0_2_2;    
wire    [81:0]  ex1_p0_2_3;    
wire    [81:0]  ex1_p0_2_cout; 
wire    [81:0]  ex1_p0_2_xor;  
wire    [81:0]  ex1_p0_3_0;    
wire    [81:0]  ex1_p0_3_1;    
wire    [81:0]  ex1_p0_3_2;    
wire    [81:0]  ex1_p1_0_0;    
wire    [81:0]  ex1_p1_0_1;    
wire    [81:0]  ex1_p1_0_2;    
wire    [81:0]  ex1_p1_0_3;    
wire    [81:0]  ex1_p1_0_cout; 
wire    [81:0]  ex1_p1_0_xor;  
wire    [81:0]  ex1_p1_1_0;    
wire    [81:0]  ex1_p1_1_1;    
wire    [81:0]  ex1_p1_1_2;    
wire    [81:0]  ex1_p1_1_3;    
wire    [81:0]  ex1_p1_1_cout; 
wire    [81:0]  ex1_p1_1_xor;  
wire    [82:0]  ex1_p2_0_0;    
wire    [82:0]  ex1_p2_0_1;    
wire    [82:0]  ex1_p2_0_2;    
wire    [82:0]  ex1_p2_0_3;    
wire    [82:0]  ex1_p2_0_cout; 
wire    [82:0]  ex1_p2_0_xor;  
wire    [81:0]  ex1_s0_0;      
wire    [81:0]  ex1_s0_1;      
wire    [81:0]  ex1_s0_2;      
wire    [81:0]  ex1_s0_3;      
wire    [81:0]  ex1_s1_0;      
wire    [81:0]  ex1_s1_1;      
wire    [82:0]  ex1_s2_0;      
wire    [1 :0]  h0;            
wire    [1 :0]  h1;            
wire    [1 :0]  h10;           
wire    [1 :0]  h11;           
wire    [1 :0]  h12;           
wire    [1 :0]  h13;           
wire    [1 :0]  h2;            
wire    [1 :0]  h3;            
wire    [1 :0]  h4;            
wire    [1 :0]  h5;            
wire    [1 :0]  h6;            
wire    [1 :0]  h7;            
wire    [1 :0]  h8;            
wire    [1 :0]  h9;            
wire    [27:0]  mult_src;      
wire    [53:0]  multiplicand;  
wire    [83:0]  out0;          
wire    [83:0]  out1;          
wire    [53:0]  part_product0; 
wire    [53:0]  part_product1; 
wire    [53:0]  part_product10; 
wire    [53:0]  part_product11; 
wire    [53:0]  part_product12; 
wire    [53:0]  part_product13; 
wire    [53:0]  part_product2; 
wire    [53:0]  part_product3; 
wire    [53:0]  part_product4; 
wire    [53:0]  part_product5; 
wire    [53:0]  part_product6; 
wire    [53:0]  part_product7; 
wire    [53:0]  part_product8; 
wire    [53:0]  part_product9; 
wire    [13:0]  sign_not;      


parameter SRC0_WIDTH = 54;
parameter SRC1_WIDTH = 28;
parameter DST_WIDTH  = 82;

assign multiplicand[SRC0_WIDTH-1:0] = {1'b0,a[SRC0_WIDTH-2:0]};
assign mult_src[SRC1_WIDTH-1:0]     = {1'b0,b[SRC1_WIDTH-2:0]};

assign data_for_code[SRC1_WIDTH+1:0] = {mult_src[SRC1_WIDTH-1],mult_src[SRC1_WIDTH-1:0],1'b0};


// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit0");  @35
booth_code_54_bit  x_aq_booth_code_54_bit0 (
  .A                   (multiplicand[53:0] ),
  .code                (data_for_code[2:0] ),
  .h                   (h0[1:0]            ),
  .product             (part_product0[53:0]),
  .sn                  (sign_not[0]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @36
//          .code(data_for_code[2:0]),           @37
//          .product(part_product0[SRC0_WIDTH-1:0]),  @38
//          .h(h0[1:0]),  @39
//          .sn(sign_not[0])); @40

// &Instance("booth_code_54_bit",   "x_aq_booth_code_54_bit1");  @42
booth_code_54_bit  x_aq_booth_code_54_bit1 (
  .A                   (multiplicand[53:0] ),
  .code                (data_for_code[4:2] ),
  .h                   (h1[1:0]            ),
  .product             (part_product1[53:0]),
  .sn                  (sign_not[1]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @43
//          .code(data_for_code[4:2]),                  @44
//          .product(part_product1[SRC0_WIDTH-1:0]),  @45
//          .h(h1[1:0]),  @46
//          .sn(sign_not[1])); @47

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit2");  @49
booth_code_54_bit  x_aq_booth_code_54_bit2 (
  .A                   (multiplicand[53:0] ),
  .code                (data_for_code[6:4] ),
  .h                   (h2[1:0]            ),
  .product             (part_product2[53:0]),
  .sn                  (sign_not[2]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @50
//          .code(data_for_code[6:4]),                  @51
//          .product(part_product2[SRC0_WIDTH-1:0]),  @52
//          .h(h2[1:0]),  @53
//          .sn(sign_not[2])); @54

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit3");  @56
booth_code_54_bit  x_aq_booth_code_54_bit3 (
  .A                   (multiplicand[53:0] ),
  .code                (data_for_code[8:6] ),
  .h                   (h3[1:0]            ),
  .product             (part_product3[53:0]),
  .sn                  (sign_not[3]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @57
//          .code(data_for_code[8:6]),                  @58
//          .product(part_product3[SRC0_WIDTH-1:0]),  @59
//          .h(h3[1:0]),  @60
//          .sn(sign_not[3])); @61

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit4");  @63
booth_code_54_bit  x_aq_booth_code_54_bit4 (
  .A                   (multiplicand[53:0] ),
  .code                (data_for_code[10:8]),
  .h                   (h4[1:0]            ),
  .product             (part_product4[53:0]),
  .sn                  (sign_not[4]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @64
//          .code(data_for_code[10:8]),  @65
//          .product(part_product4[SRC0_WIDTH-1:0]),  @66
//          .h(h4[1:0]),  @67
//          .sn(sign_not[4])); @68

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit5");  @70
booth_code_54_bit  x_aq_booth_code_54_bit5 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[12:10]),
  .h                    (h5[1:0]             ),
  .product              (part_product5[53:0] ),
  .sn                   (sign_not[5]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @71
//          .code(data_for_code[12:10]),  @72
//          .product(part_product5[SRC0_WIDTH-1:0]),  @73
//          .h(h5[1:0]),  @74
//          .sn(sign_not[5])); @75

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit6");  @77
booth_code_54_bit  x_aq_booth_code_54_bit6 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[14:12]),
  .h                    (h6[1:0]             ),
  .product              (part_product6[53:0] ),
  .sn                   (sign_not[6]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @78
//          .code(data_for_code[14:12]),  @79
//          .product(part_product6[SRC0_WIDTH-1:0]),  @80
//          .h(h6[1:0]),  @81
//          .sn(sign_not[6])); @82

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit7");  @84
booth_code_54_bit  x_aq_booth_code_54_bit7 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[16:14]),
  .h                    (h7[1:0]             ),
  .product              (part_product7[53:0] ),
  .sn                   (sign_not[7]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @85
//          .code(data_for_code[16:14]),  @86
//          .product(part_product7[SRC0_WIDTH-1:0]),  @87
//          .h(h7[1:0]),  @88
//          .sn(sign_not[7])); @89

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit8");  @91
booth_code_54_bit  x_aq_booth_code_54_bit8 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[18:16]),
  .h                    (h8[1:0]             ),
  .product              (part_product8[53:0] ),
  .sn                   (sign_not[8]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @92
//          .code(data_for_code[18:16]),  @93
//          .product(part_product8[SRC0_WIDTH-1:0]),  @94
//          .h(h8[1:0]),  @95
//          .sn(sign_not[8])); @96

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit9");  @98
booth_code_54_bit  x_aq_booth_code_54_bit9 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[20:18]),
  .h                    (h9[1:0]             ),
  .product              (part_product9[53:0] ),
  .sn                   (sign_not[9]         )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @99
//          .code(data_for_code[20:18]),  @100
//          .product(part_product9[SRC0_WIDTH-1:0]),  @101
//          .h(h9[1:0]),  @102
//          .sn(sign_not[9])); @103

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit10");  @105
booth_code_54_bit  x_aq_booth_code_54_bit10 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[22:20]),
  .h                    (h10[1:0]            ),
  .product              (part_product10[53:0]),
  .sn                   (sign_not[10]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @106
//          .code(data_for_code[22:20]),           @107
//          .product(part_product10[SRC0_WIDTH-1:0]),  @108
//          .h(h10[1:0]),  @109
//          .sn(sign_not[10])); @110

// &Instance("booth_code_54_bit",   "x_aq_booth_code_54_bit11");  @112
booth_code_54_bit  x_aq_booth_code_54_bit11 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[24:22]),
  .h                    (h11[1:0]            ),
  .product              (part_product11[53:0]),
  .sn                   (sign_not[11]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @113
//          .code(data_for_code[24:22]),                  @114
//          .product(part_product11[SRC0_WIDTH-1:0]),  @115
//          .h(h11[1:0]),  @116
//          .sn(sign_not[11])); @117

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit12");  @119
booth_code_54_bit  x_aq_booth_code_54_bit12 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[26:24]),
  .h                    (h12[1:0]            ),
  .product              (part_product12[53:0]),
  .sn                   (sign_not[12]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @120
//          .code(data_for_code[26:24]),                  @121
//          .product(part_product12[SRC0_WIDTH-1:0]),  @122
//          .h(h12[1:0]),  @123
//          .sn(sign_not[12])); @124

// &Instance("booth_code_54_bit", "x_aq_booth_code_54_bit13");  @126
booth_code_54_bit  x_aq_booth_code_54_bit13 (
  .A                    (multiplicand[53:0]  ),
  .code                 (data_for_code[28:26]),
  .h                    (h13[1:0]            ),
  .product              (part_product13[53:0]),
  .sn                   (sign_not[13]        )
);

// &Connect(.A(multiplicand[SRC0_WIDTH-1:0]), @127
//          .code(data_for_code[28:26]),                  @128
//          .product(part_product13[SRC0_WIDTH-1:0]),  @129
//          .h(h13[1:0]),  @130
//          .sn(sign_not[13])); @131


//=============================================================================
//    prepare for the the first compression
//=============================================================================

assign  ex1_p0_0_0[DST_WIDTH-1:0] =  { {25{1'b0}},      sign_not[0],{2{!sign_not[0]}},part_product0[SRC0_WIDTH-1:0]};
assign  ex1_p0_0_1[DST_WIDTH-1:0] =  { {24{1'b0}},1'b1, sign_not[1],                  part_product1[SRC0_WIDTH-1:0], h0[1:0]};
assign  ex1_p0_0_2[DST_WIDTH-1:0] =  { {22{1'b0}},1'b1, sign_not[2],                  part_product2[SRC0_WIDTH-1:0], h1[1:0], { 2{1'b0}} };  
assign  ex1_p0_0_3[DST_WIDTH-1:0] =  { {20{1'b0}},1'b1, sign_not[3],                  part_product3[SRC0_WIDTH-1:0], h2[1:0], { 4{1'b0}} };      

assign  ex1_p0_1_0[DST_WIDTH-1:0] =  { {18{1'b0}},1'b1, sign_not[4],                  part_product4[SRC0_WIDTH-1:0], h3[1:0], { 6{1'b0}} };
assign  ex1_p0_1_1[DST_WIDTH-1:0] =  { {16{1'b0}},1'b1, sign_not[5],                  part_product5[SRC0_WIDTH-1:0], h4[1:0], { 8{1'b0}} }; 
assign  ex1_p0_1_2[DST_WIDTH-1:0] =  { {14{1'b0}},1'b1, sign_not[6],                  part_product6[SRC0_WIDTH-1:0], h5[1:0], {10{1'b0}} };    
assign  ex1_p0_1_3[DST_WIDTH-1:0] =  { {12{1'b0}},1'b1, sign_not[7],                  part_product7[SRC0_WIDTH-1:0], h6[1:0], {12{1'b0}} };

assign  ex1_p0_2_0[DST_WIDTH-1:0] =  { {10{1'b0}},1'b1, sign_not[8],                  part_product8[SRC0_WIDTH-1:0], h7[1:0], {14{1'b0}} }; 
assign  ex1_p0_2_1[DST_WIDTH-1:0] =  { { 8{1'b0}},1'b1, sign_not[9],                  part_product9[SRC0_WIDTH-1:0], h8[1:0], {16{1'b0}} };  
assign  ex1_p0_2_2[DST_WIDTH-1:0] =  { { 6{1'b0}},1'b1, sign_not[10],                 part_product10[SRC0_WIDTH-1:0],h9[1:0], {18{1'b0}} };
assign  ex1_p0_2_3[DST_WIDTH-1:0] =  { { 4{1'b0}},1'b1, sign_not[11],                 part_product11[SRC0_WIDTH-1:0],h10[1:0],{20{1'b0}} };

assign  ex1_p0_3_0[DST_WIDTH-1:0] =  { { 2{1'b0}},1'b1, sign_not[12],                 part_product12[SRC0_WIDTH-1:0],h11[1:0],{22{1'b0}} }; 
assign  ex1_p0_3_1[DST_WIDTH-1:0] =  {            1'b1, sign_not[13],                 part_product13[SRC0_WIDTH-1:0],h12[1:0],{24{1'b0}} };
assign  ex1_p0_3_2[DST_WIDTH-1:0] =  { {54{1'b0}},                                                                   h13[1:0],{26{1'b0}} };


//=========== 15 src to 8 src==========//
assign ex1_p0_0_cout[DST_WIDTH-1:0] = (ex1_p0_0_0[DST_WIDTH-1:0]  &  ex1_p0_0_1[DST_WIDTH-1:0]) |
                                      (ex1_p0_0_1[DST_WIDTH-1:0]  &  ex1_p0_0_2[DST_WIDTH-1:0]) |
                                      (ex1_p0_0_0[DST_WIDTH-1:0]  &  ex1_p0_0_2[DST_WIDTH-1:0]) ;

assign ex1_p0_0_xor[DST_WIDTH-1:0]  = (ex1_p0_0_0[DST_WIDTH-1:0]  ^  ex1_p0_0_1[DST_WIDTH-1:0]) ^
                                      (ex1_p0_0_2[DST_WIDTH-1:0]  ^  ex1_p0_0_3[DST_WIDTH-1:0]);

assign ex1_s0_0[DST_WIDTH-1:0]      =  ex1_p0_0_xor[DST_WIDTH-1:0]^ {ex1_p0_0_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c0_0[DST_WIDTH-1:0]      =  ex1_p0_0_xor[DST_WIDTH-1:0]& {ex1_p0_0_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p0_0_xor[DST_WIDTH-1:0]&  ex1_p0_0_3[DST_WIDTH-1:0]);

//----------------------------------------------
assign ex1_p0_1_cout[DST_WIDTH-1:0] = (ex1_p0_1_0[DST_WIDTH-1:0]  &  ex1_p0_1_1[DST_WIDTH-1:0]) |
                                      (ex1_p0_1_1[DST_WIDTH-1:0]  &  ex1_p0_1_2[DST_WIDTH-1:0]) |
                                      (ex1_p0_1_0[DST_WIDTH-1:0]  &  ex1_p0_1_2[DST_WIDTH-1:0]) ;

assign ex1_p0_1_xor[DST_WIDTH-1:0]  = (ex1_p0_1_0[DST_WIDTH-1:0]  ^  ex1_p0_1_1[DST_WIDTH-1:0]) ^
                                      (ex1_p0_1_2[DST_WIDTH-1:0]  ^  ex1_p0_1_3[DST_WIDTH-1:0]);

assign ex1_s0_1[DST_WIDTH-1:0]      =  ex1_p0_1_xor[DST_WIDTH-1:0]^ {ex1_p0_1_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c0_1[DST_WIDTH-1:0]      =  ex1_p0_1_xor[DST_WIDTH-1:0]& {ex1_p0_1_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p0_1_xor[DST_WIDTH-1:0]&  ex1_p0_1_3[DST_WIDTH-1:0]);

//----------------------------------------------
assign ex1_p0_2_cout[DST_WIDTH-1:0] = (ex1_p0_2_0[DST_WIDTH-1:0]  &  ex1_p0_2_1[DST_WIDTH-1:0]) |
                                      (ex1_p0_2_1[DST_WIDTH-1:0]  &  ex1_p0_2_2[DST_WIDTH-1:0]) |
                                      (ex1_p0_2_0[DST_WIDTH-1:0]  &  ex1_p0_2_2[DST_WIDTH-1:0]) ;

assign ex1_p0_2_xor[DST_WIDTH-1:0]  = (ex1_p0_2_0[DST_WIDTH-1:0]  ^  ex1_p0_2_1[DST_WIDTH-1:0]) ^
                                      (ex1_p0_2_2[DST_WIDTH-1:0]  ^  ex1_p0_2_3[DST_WIDTH-1:0]);

assign ex1_s0_2[DST_WIDTH-1:0]      =  ex1_p0_2_xor[DST_WIDTH-1:0]^ {ex1_p0_2_cout[DST_WIDTH-2:0],1'b0};
assign ex1_c0_2[DST_WIDTH-1:0]      =  ex1_p0_2_xor[DST_WIDTH-1:0]& {ex1_p0_2_cout[DST_WIDTH-2:0],1'b0}|
                                     (~ex1_p0_2_xor[DST_WIDTH-1:0]&  ex1_p0_2_3[DST_WIDTH-1:0]);

//----------------------------------------------
assign ex1_s0_3[DST_WIDTH-1:0] = ex1_p0_3_0[DST_WIDTH-1:0] ^ 
                                 ex1_p0_3_1[DST_WIDTH-1:0] ^ 
                                 ex1_p0_3_2[DST_WIDTH-1:0];

assign ex1_c0_3[DST_WIDTH-1:0] = ex1_p0_3_0[DST_WIDTH-1:0] & ex1_p0_3_1[DST_WIDTH-1:0] |
                                 ex1_p0_3_0[DST_WIDTH-1:0] & ex1_p0_3_2[DST_WIDTH-1:0] |
                                 ex1_p0_3_1[DST_WIDTH-1:0] & ex1_p0_3_2[DST_WIDTH-1:0];

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

//=========== 8 src to 4 src==========//
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

//=============================================================================
//    prepare for the the third compression
//=============================================================================  
assign ex1_p2_0_0[DST_WIDTH  :0] ={ex1_s1_0[DST_WIDTH-1],ex1_s1_0[DST_WIDTH-1:0]};          
assign ex1_p2_0_1[DST_WIDTH  :0] ={ex1_c1_0[DST_WIDTH-1:0],1'b0};    
assign ex1_p2_0_2[DST_WIDTH  :0] ={ex1_s1_1[DST_WIDTH-1],ex1_s1_1[DST_WIDTH-1:0]};      
assign ex1_p2_0_3[DST_WIDTH  :0] ={ex1_c1_1[DST_WIDTH-1:0],1'b0};
//=========== 4 src to 2 src==========//
assign ex1_p2_0_cout[DST_WIDTH  :0] = (ex1_p2_0_0[DST_WIDTH  :0]  &  ex1_p2_0_1[DST_WIDTH  :0]) |
                                      (ex1_p2_0_1[DST_WIDTH  :0]  &  ex1_p2_0_2[DST_WIDTH  :0]) |
                                      (ex1_p2_0_0[DST_WIDTH  :0]  &  ex1_p2_0_2[DST_WIDTH  :0]) ;

assign ex1_p2_0_xor[DST_WIDTH  :0]  = (ex1_p2_0_0[DST_WIDTH  :0]  ^  ex1_p2_0_1[DST_WIDTH  :0]) ^
                                      (ex1_p2_0_2[DST_WIDTH  :0]  ^  ex1_p2_0_3[DST_WIDTH  :0]);

assign ex1_s2_0[DST_WIDTH  :0]      =  ex1_p2_0_xor[DST_WIDTH  :0]^ {ex1_p2_0_cout[DST_WIDTH-1:0],1'b0};
assign ex1_c2_0[DST_WIDTH  :0]      =  ex1_p2_0_xor[DST_WIDTH  :0]& {ex1_p2_0_cout[DST_WIDTH-1:0],1'b0}|
                                     (~ex1_p2_0_xor[DST_WIDTH  :0]&  ex1_p2_0_3[DST_WIDTH  :0]);


assign out0[DST_WIDTH+1:0] ={ex1_s2_0[DST_WIDTH],ex1_s2_0[DST_WIDTH:0]};          
assign out1[DST_WIDTH+1:0] ={ex1_c2_0[DST_WIDTH:0],1'b0};

// &ModuleEnd; @262
endmodule



