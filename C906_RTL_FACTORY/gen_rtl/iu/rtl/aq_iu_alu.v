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

// &ModuleBeg; @26
module aq_iu_alu(
  idu_alu_ex1_gateclk_sel,
  idu_iu_ex1_alu_dp_sel,
  idu_iu_ex1_alu_sel,
  idu_iu_ex1_dst0_reg,
  idu_iu_ex1_func,
  idu_iu_ex1_inst_len,
  idu_iu_ex1_split,
  idu_iu_ex1_src0,
  idu_iu_ex1_src1,
  idu_iu_ex1_src2,
  iu_rtu_ex1_alu_cmplt,
  iu_rtu_ex1_alu_cmplt_dp,
  iu_rtu_ex1_alu_data,
  iu_rtu_ex1_alu_inst_len,
  iu_rtu_ex1_alu_inst_split,
  iu_rtu_ex1_alu_preg,
  iu_rtu_ex1_alu_wb_dp,
  iu_rtu_ex1_alu_wb_vld
);

// &Ports; @27
input            idu_alu_ex1_gateclk_sel;   
input            idu_iu_ex1_alu_dp_sel;     
input            idu_iu_ex1_alu_sel;        
input   [5  :0]  idu_iu_ex1_dst0_reg;       
input   [19 :0]  idu_iu_ex1_func;           
input            idu_iu_ex1_inst_len;       
input            idu_iu_ex1_split;          
input   [63 :0]  idu_iu_ex1_src0;           
input   [63 :0]  idu_iu_ex1_src1;           
input   [63 :0]  idu_iu_ex1_src2;           
output           iu_rtu_ex1_alu_cmplt;      
output           iu_rtu_ex1_alu_cmplt_dp;   
output  [63 :0]  iu_rtu_ex1_alu_data;       
output           iu_rtu_ex1_alu_inst_len;   
output           iu_rtu_ex1_alu_inst_split; 
output  [5  :0]  iu_rtu_ex1_alu_preg;       
output           iu_rtu_ex1_alu_wb_dp;      
output           iu_rtu_ex1_alu_wb_vld;     

// &Regs; @28
reg     [64 :0]  alu_adder_rs0;             
reg     [64 :0]  alu_adder_rs1_raw;         
reg     [63 :0]  alu_adder_rst;             
reg     [63 :0]  alu_misc_ff1_rst;          
reg     [63 :0]  alu_misc_rst;              
reg              alu_misc_tst_bit;          
reg              alu_shift_ext_sign;        
reg     [63 :0]  alu_shift_input_127_64;    
reg     [63 :0]  alu_shift_input_63_0;      
reg     [63 :0]  alu_shifter_extu_mask;     

// &Wires; @29
wire    [64 :0]  alu_adder_add_rst;         
wire             alu_adder_cin;             
wire             alu_adder_op_addsl;        
wire             alu_adder_op_cmp;          
wire             alu_adder_op_lt;           
wire             alu_adder_op_sub;          
wire             alu_adder_op_word;         
wire    [4  :0]  alu_adder_rs0_sel_onehot;  
wire    [64 :0]  alu_adder_rs1;             
wire    [4  :0]  alu_adder_rs1_sel_onehot;  
wire             alu_adder_rst_lt;          
wire             alu_adder_rst_normal;      
wire             alu_adder_rst_word;        
wire             alu_adder_sel;             
wire    [63 :0]  alu_adder_src0;            
wire    [63 :0]  alu_adder_src1;            
wire    [63 :0]  alu_adder_src1_tmp;        
wire    [63 :0]  alu_adder_src2;            
wire    [19 :0]  alu_func;                  
wire    [63 :0]  alu_logic_and_rst;         
wire             alu_logic_op_and;          
wire             alu_logic_op_or;           
wire             alu_logic_op_xor;          
wire    [63 :0]  alu_logic_or_rst;          
wire    [63 :0]  alu_logic_rst;             
wire             alu_logic_sel;             
wire    [63 :0]  alu_logic_src0;            
wire    [63 :0]  alu_logic_src1;            
wire    [63 :0]  alu_logic_xor_rst;         
wire    [63 :0]  alu_misc_ff1_src;          
wire    [63 :0]  alu_misc_mov_rst;          
wire             alu_misc_op_ff;            
wire             alu_misc_op_ff0;           
wire             alu_misc_op_mov;           
wire             alu_misc_op_mveqz;         
wire             alu_misc_op_mvnez;         
wire             alu_misc_op_rev;           
wire             alu_misc_op_revw;          
wire             alu_misc_op_tst;           
wire             alu_misc_op_tstnbz;        
wire    [63 :0]  alu_misc_rev_rst;          
wire    [63 :0]  alu_misc_revw_rst;         
wire             alu_misc_rst_ff1;          
wire             alu_misc_rst_mov;          
wire             alu_misc_rst_rev;          
wire             alu_misc_rst_revw;         
wire             alu_misc_rst_tst;          
wire             alu_misc_rst_tstnbz;       
wire             alu_misc_sel;              
wire             alu_misc_sel_src2;         
wire    [63 :0]  alu_misc_src0;             
wire    [63 :0]  alu_misc_src1;             
wire    [63 :0]  alu_misc_src2;             
wire             alu_misc_src_not_zero;     
wire    [63 :0]  alu_misc_tst_rst;          
wire    [63 :0]  alu_misc_tstnbz_rst;       
wire    [63 :0]  alu_rst;                   
wire    [5  :0]  alu_shift_count;           
wire    [63 :0]  alu_shift_ext_and_mask;    
wire             alu_shift_ext_and_sel_mask; 
wire    [5  :0]  alu_shift_ext_count;       
wire    [63 :0]  alu_shift_ext_or_mask;     
wire             alu_shift_ext_or_sel_mask; 
wire    [63 :0]  alu_shift_ext_rst;         
wire             alu_shift_ext_sign_op;     
wire             alu_shift_high_zero;       
wire             alu_shift_left;            
wire    [63 :0]  alu_shift_left_rst_rev;    
wire             alu_shift_normal;          
wire             alu_shift_op_ar;           
wire             alu_shift_op_circle;       
wire             alu_shift_op_ext;          
wire             alu_shift_op_left;         
wire             alu_shift_op_sign;         
wire             alu_shift_op_word;         
wire    [63 :0]  alu_shift_rst;             
wire    [63 :0]  alu_shift_rst_raw0;        
wire    [63 :0]  alu_shift_rst_raw1;        
wire             alu_shift_sel;             
wire    [127:0]  alu_shift_shifter_rst;     
wire    [63 :0]  alu_shift_src0;            
wire    [63 :0]  alu_shift_src0_rev;        
wire    [63 :0]  alu_shift_src1;            
wire             alu_shift_word;            
wire             alu_shift_word_ar;         
wire             alu_shift_word_circle;     
wire             alu_shift_word_logic_right; 
wire             idu_alu_ex1_gateclk_sel;   
wire             idu_iu_ex1_alu_dp_sel;     
wire             idu_iu_ex1_alu_sel;        
wire    [5  :0]  idu_iu_ex1_dst0_reg;       
wire    [19 :0]  idu_iu_ex1_func;           
wire             idu_iu_ex1_inst_len;       
wire             idu_iu_ex1_split;          
wire    [63 :0]  idu_iu_ex1_src0;           
wire    [63 :0]  idu_iu_ex1_src1;           
wire    [63 :0]  idu_iu_ex1_src2;           
wire             iu_rtu_ex1_alu_cmplt;      
wire             iu_rtu_ex1_alu_cmplt_dp;   
wire    [63 :0]  iu_rtu_ex1_alu_data;       
wire             iu_rtu_ex1_alu_inst_len;   
wire             iu_rtu_ex1_alu_inst_split; 
wire    [5  :0]  iu_rtu_ex1_alu_preg;       
wire             iu_rtu_ex1_alu_wb_dp;      
wire             iu_rtu_ex1_alu_wb_vld;     


// &Force("input", "idu_alu_ex1_gateclk_sel"); @31
assign alu_func[19:0] = idu_iu_ex1_func[19:0] & {20{idu_alu_ex1_gateclk_sel}};


//==========================================================
//                        Adder
//==========================================================
//Adder func: start form 5
//lt, sign, sub, sel, cmp, word, addsl
assign alu_adder_sel = alu_func[0];
assign alu_adder_src0[63:0] = {64{alu_adder_sel}} & idu_iu_ex1_src0[63:0];
assign alu_adder_src1[63:0] = {64{alu_adder_sel}} & idu_iu_ex1_src1[63:0];
assign alu_adder_src2[63:0] = {64{alu_adder_sel}} & idu_iu_ex1_src2[63:0];

assign alu_adder_op_addsl = alu_func[5];
assign alu_adder_op_word  = alu_func[6];
assign alu_adder_op_cmp   = alu_func[7];
//assign alu_adder_op_sel   = alu_func[8];
assign alu_adder_op_sub   = alu_func[9];
assign alu_adder_op_lt    = alu_func[11];
assign alu_adder_rs0_sel_onehot[4:0] = {alu_func[17], alu_func[16], alu_func[15], alu_func[14], alu_func[12]};
assign alu_adder_rs1_sel_onehot[4:0] = {alu_func[18], alu_func[16], alu_func[15], alu_func[14], alu_func[13]};

// adder rs0 prepare
// &CombBeg; @55
always @( alu_adder_rs0_sel_onehot[4:0]
       or alu_adder_src0[63:0])
begin
  case(alu_adder_rs0_sel_onehot[4:0])
    5'b00001 : alu_adder_rs0[64:0] = 65'b0;                                            // li/lui
    5'b00010 : alu_adder_rs0[64:0] = {1'b0, alu_adder_src0[63:0]};                     // unsign 64 op
    5'b00100 : alu_adder_rs0[64:0] = {{33{alu_adder_src0[31]}}, alu_adder_src0[31:0]}; // sign 32 op
    5'b01000 : alu_adder_rs0[64:0] = {33'b0, alu_adder_src0[31:0]};                    // unsign 32 op
    5'b10000 : alu_adder_rs0[64:0] = {alu_adder_src0[63], alu_adder_src0[63:0]};       // sign 64 op
    default:   alu_adder_rs0[64:0] = {65{1'bx}};
  endcase
// &CombEnd; @64
end

// adder rs0 prepare
assign alu_adder_src1_tmp[63:0] = alu_adder_op_addsl ? alu_adder_src1[63:0] << alu_adder_src2[6:5]
                                                     : alu_adder_src1[63:0];
assign alu_adder_rs1[64:0]      = alu_adder_op_sub   ? ~alu_adder_rs1_raw[64:0] : alu_adder_rs1_raw[64:0];

// &CombBeg; @71
always @( alu_adder_src1_tmp[63:0]
       or alu_adder_rs1_sel_onehot[4:0]
       or alu_adder_src1[51:0])
begin
  case(alu_adder_rs1_sel_onehot[4:0])
    5'b00001 : alu_adder_rs1_raw[64:0] = {alu_adder_src1[51], alu_adder_src1[51:0], 12'b0};        // lui
    5'b00010 : alu_adder_rs1_raw[64:0] = {1'b0, alu_adder_src1_tmp[63:0]};                         // unsign 64 op
    5'b00100 : alu_adder_rs1_raw[64:0] = {{33{alu_adder_src1_tmp[31]}}, alu_adder_src1_tmp[31:0]}; // sign 32 op
    5'b01000 : alu_adder_rs1_raw[64:0] = {33'b0, alu_adder_src1_tmp[31:0]};                        // unsign 32 op
    5'b10000 : alu_adder_rs1_raw[64:0] = {alu_adder_src1_tmp[63], alu_adder_src1_tmp[63:0]};       // sign 64 op
    default:   alu_adder_rs1_raw[64:0] = {65{1'bx}};
  endcase
// &CombEnd; @80
end

// ALU adder
assign alu_adder_add_rst[64:0] = alu_adder_rs0[64:0] + alu_adder_rs1[64:0] + {64'b0, alu_adder_op_sub};
assign alu_adder_cin           = alu_adder_add_rst[64];

// result select : 1. 64 bit add/sub : adder rst 
//                 2. 32 bit add/sub : low 32 bits of adder rst, then sign ext
//                 3. cmp : 1 or 0
//                 4. max/min : src0 or src1
//assign alu_adder_rst_sel  = alu_adder_op_sel;
//assign alu_adder_rst_max  = alu_adder_op_sel  && !alu_adder_op_lt;
assign alu_adder_rst_lt     = alu_adder_op_cmp  &&  alu_adder_op_lt;
//assign alu_adder_rst_word   = alu_adder_op_word && !alu_adder_op_sel;
assign alu_adder_rst_word   = alu_adder_op_word;
//assign alu_adder_rst_normal = !(alu_adder_op_sel || alu_adder_op_cmp || alu_adder_op_word);
assign alu_adder_rst_normal = !(alu_adder_op_cmp || alu_adder_op_word);

//assign alu_adder_sel_rst_src0  = alu_adder_rst_max ^ alu_adder_cin;
//assign alu_adder_sel_rst[63:0] = alu_adder_sel_rst_src0 ? alu_adder_src0[63:0] : alu_adder_src1[63:0];

//&CombBeg;
//  case({alu_adder_rst_sel, alu_adder_rst_lt, alu_adder_rst_word, alu_adder_rst_normal})
//    4'b0001 :  alu_adder_rst[63:0] = alu_adder_add_rst[63:0];
//    4'b0010 :  alu_adder_rst[63:0] = {{32{alu_adder_add_rst[31]}}, alu_adder_add_rst[31:0]};
//    4'b0100 :  alu_adder_rst[63:0] = {63'b0, alu_adder_cin};
//    4'b1000 :  alu_adder_rst[63:0] = alu_adder_sel_rst[63:0];
//    default :  alu_adder_rst[63:0] = {64{1'bx}};
//  endcase
//&CombEnd;
// &CombBeg; @110
always @( alu_adder_rst_normal
       or alu_adder_add_rst[63:0]
       or alu_adder_rst_word
       or alu_adder_rst_lt
       or alu_adder_cin)
begin
  case({alu_adder_rst_lt, alu_adder_rst_word, alu_adder_rst_normal})
    3'b001 :  alu_adder_rst[63:0] = alu_adder_add_rst[63:0];
    3'b010 :  alu_adder_rst[63:0] = {{32{alu_adder_add_rst[31]}}, alu_adder_add_rst[31:0]};
    3'b100 :  alu_adder_rst[63:0] = {63'b0, alu_adder_cin};
    default : alu_adder_rst[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @117
end

//==========================================================
//                        SHIFT
//==========================================================
//shift func:
//logic, sign, ext, circle, ar, word, left
assign alu_shift_sel = alu_func[1];
assign alu_shift_src0[63:0] = {64{alu_shift_sel}} & idu_iu_ex1_src0[63:0];
assign alu_shift_src1[63:0] = {64{alu_shift_sel}} & idu_iu_ex1_src1[63:0];

assign alu_shift_op_left   = alu_func[5];
assign alu_shift_op_word   = alu_func[6];
assign alu_shift_op_ar     = alu_func[7];
assign alu_shift_op_circle = alu_func[8];
assign alu_shift_op_ext    = alu_func[9];
assign alu_shift_op_sign   = alu_func[10];

assign alu_shift_word_ar          = alu_func[12];
assign alu_shift_word_circle      = alu_func[13];
assign alu_shift_word_logic_right = alu_func[14];
assign alu_shift_normal           = alu_func[15];
assign alu_shift_high_zero        = alu_func[16];

assign alu_shift_src0_rev[63:0] = {alu_shift_src0[0],  alu_shift_src0[1],  alu_shift_src0[2],  alu_shift_src0[3],
                                   alu_shift_src0[4],  alu_shift_src0[5],  alu_shift_src0[6],  alu_shift_src0[7],
                                   alu_shift_src0[8],  alu_shift_src0[9],  alu_shift_src0[10], alu_shift_src0[11],
                                   alu_shift_src0[12], alu_shift_src0[13], alu_shift_src0[14], alu_shift_src0[15],
                                   alu_shift_src0[16], alu_shift_src0[17], alu_shift_src0[18], alu_shift_src0[19],
                                   alu_shift_src0[20], alu_shift_src0[21], alu_shift_src0[22], alu_shift_src0[23],
                                   alu_shift_src0[24], alu_shift_src0[25], alu_shift_src0[26], alu_shift_src0[27],
                                   alu_shift_src0[28], alu_shift_src0[29], alu_shift_src0[30], alu_shift_src0[31],
                                   alu_shift_src0[32], alu_shift_src0[33], alu_shift_src0[34], alu_shift_src0[35],
                                   alu_shift_src0[36], alu_shift_src0[37], alu_shift_src0[38], alu_shift_src0[39],
                                   alu_shift_src0[40], alu_shift_src0[41], alu_shift_src0[42], alu_shift_src0[43],
                                   alu_shift_src0[44], alu_shift_src0[45], alu_shift_src0[46], alu_shift_src0[47],
                                   alu_shift_src0[48], alu_shift_src0[49], alu_shift_src0[50], alu_shift_src0[51],
                                   alu_shift_src0[52], alu_shift_src0[53], alu_shift_src0[54], alu_shift_src0[55],
                                   alu_shift_src0[56], alu_shift_src0[57], alu_shift_src0[58], alu_shift_src0[59],
                                   alu_shift_src0[60], alu_shift_src0[61], alu_shift_src0[62], alu_shift_src0[63]};

// Shifter input[128:64]
// 1. 001: SLL[I], SLLW[I], SRL[I], SRLW[I], EXT[U]
// 2. 010: SRRI, SRRIW
// 3. 100: SRA[I], SRA[I]W
// &CombBeg; @162
always @( alu_shift_op_ar
       or alu_shift_op_circle
       or alu_shift_high_zero
       or alu_shift_src0[63:0])
begin
  case({alu_shift_op_ar, alu_shift_op_circle, alu_shift_high_zero})
    3'b001 : alu_shift_input_127_64[63:0] = 64'b0;
    3'b010 : alu_shift_input_127_64[63:0] = alu_shift_src0[63:0];
    3'b100 : alu_shift_input_127_64[63:0] = {64{alu_shift_src0[63]}};
    default: alu_shift_input_127_64[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @169
end

assign alu_shift_word = alu_shift_op_word;
assign alu_shift_left = alu_shift_op_left;

// Shifter input[63:0]
// 1. 00001: SRL[I], SRRI, EXT[U]
// 2. 00010: SRLW[I]
// 3. 00100: SRRIW
// 4. 01000: SRA[I]W
// 5. 10000: SLL[I], SLL[I]W 
// &CombBeg; @180
always @( alu_shift_src0_rev[63:0]
       or alu_shift_word_ar
       or alu_shift_word_logic_right
       or alu_shift_left
       or alu_shift_word_circle
       or alu_shift_normal
       or alu_shift_src0[63:0])
begin
  case({alu_shift_left, alu_shift_word_ar, alu_shift_word_circle, alu_shift_word_logic_right, alu_shift_normal})
    5'b00001 : alu_shift_input_63_0[63:0] = alu_shift_src0[63:0];
    5'b00010 : alu_shift_input_63_0[63:0] = {32'b0, alu_shift_src0[31:0]};
    5'b00100 : alu_shift_input_63_0[63:0] = {alu_shift_src0[31:0], alu_shift_src0[31:0]};
    5'b01000 : alu_shift_input_63_0[63:0] = {{32{alu_shift_src0[31]}}, alu_shift_src0[31:0]};
    5'b10000 : alu_shift_input_63_0[63:0] = alu_shift_src0_rev[63:0];
    default:   alu_shift_input_63_0[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @189
end

// ALU Shifter
assign alu_shift_ext_count[5:0]     = alu_shift_src1[11:6] - alu_shift_src1[5:0];
assign alu_shift_count[5:0]         = alu_shift_op_word ? {1'b0, alu_shift_src1[4:0]} : {alu_shift_src1[5:0]};
assign alu_shift_shifter_rst[127:0] = {alu_shift_input_127_64[63:0], alu_shift_input_63_0[63:0]} >> alu_shift_count[5:0];

assign alu_shift_left_rst_rev[63:0] = {alu_shift_shifter_rst[0],  alu_shift_shifter_rst[1],  alu_shift_shifter_rst[2],  alu_shift_shifter_rst[3],
                                       alu_shift_shifter_rst[4],  alu_shift_shifter_rst[5],  alu_shift_shifter_rst[6],  alu_shift_shifter_rst[7],
                                       alu_shift_shifter_rst[8],  alu_shift_shifter_rst[9],  alu_shift_shifter_rst[10], alu_shift_shifter_rst[11],
                                       alu_shift_shifter_rst[12], alu_shift_shifter_rst[13], alu_shift_shifter_rst[14], alu_shift_shifter_rst[15],
                                       alu_shift_shifter_rst[16], alu_shift_shifter_rst[17], alu_shift_shifter_rst[18], alu_shift_shifter_rst[19],
                                       alu_shift_shifter_rst[20], alu_shift_shifter_rst[21], alu_shift_shifter_rst[22], alu_shift_shifter_rst[23],
                                       alu_shift_shifter_rst[24], alu_shift_shifter_rst[25], alu_shift_shifter_rst[26], alu_shift_shifter_rst[27],
                                       alu_shift_shifter_rst[28], alu_shift_shifter_rst[29], alu_shift_shifter_rst[30], alu_shift_shifter_rst[31],
                                       alu_shift_shifter_rst[32], alu_shift_shifter_rst[33], alu_shift_shifter_rst[34], alu_shift_shifter_rst[35],
                                       alu_shift_shifter_rst[36], alu_shift_shifter_rst[37], alu_shift_shifter_rst[38], alu_shift_shifter_rst[39],
                                       alu_shift_shifter_rst[40], alu_shift_shifter_rst[41], alu_shift_shifter_rst[42], alu_shift_shifter_rst[43],
                                       alu_shift_shifter_rst[44], alu_shift_shifter_rst[45], alu_shift_shifter_rst[46], alu_shift_shifter_rst[47],
                                       alu_shift_shifter_rst[48], alu_shift_shifter_rst[49], alu_shift_shifter_rst[50], alu_shift_shifter_rst[51],
                                       alu_shift_shifter_rst[52], alu_shift_shifter_rst[53], alu_shift_shifter_rst[54], alu_shift_shifter_rst[55],
                                       alu_shift_shifter_rst[56], alu_shift_shifter_rst[57], alu_shift_shifter_rst[58], alu_shift_shifter_rst[59],
                                       alu_shift_shifter_rst[60], alu_shift_shifter_rst[61], alu_shift_shifter_rst[62], alu_shift_shifter_rst[63]};

// left or right
assign alu_shift_rst_raw0[63:0] = alu_shift_left ? alu_shift_left_rst_rev[63:0] : alu_shift_shifter_rst[63:0];
assign alu_shift_rst_raw1[63:0] = alu_shift_word ? {{32{alu_shift_rst_raw0[31]}}, alu_shift_rst_raw0[31:0]} : alu_shift_rst_raw0[63:0];

// EXT op:
// &CombBeg; @218
always @( alu_shift_ext_count[5:0])
begin
  case(alu_shift_ext_count[5:0])
    6'd0 :   alu_shifter_extu_mask[63:0] = 64'h0000000000000001;
    6'd1 :   alu_shifter_extu_mask[63:0] = 64'h0000000000000003;
    6'd2 :   alu_shifter_extu_mask[63:0] = 64'h0000000000000007;
    6'd3 :   alu_shifter_extu_mask[63:0] = 64'h000000000000000f;
    6'd4 :   alu_shifter_extu_mask[63:0] = 64'h000000000000001f;
    6'd5 :   alu_shifter_extu_mask[63:0] = 64'h000000000000003f;
    6'd6 :   alu_shifter_extu_mask[63:0] = 64'h000000000000007f;
    6'd7 :   alu_shifter_extu_mask[63:0] = 64'h00000000000000ff;
    6'd8 :   alu_shifter_extu_mask[63:0] = 64'h00000000000001ff;
    6'd9 :   alu_shifter_extu_mask[63:0] = 64'h00000000000003ff;
    6'd10:   alu_shifter_extu_mask[63:0] = 64'h00000000000007ff;
    6'd11:   alu_shifter_extu_mask[63:0] = 64'h0000000000000fff;
    6'd12:   alu_shifter_extu_mask[63:0] = 64'h0000000000001fff;
    6'd13:   alu_shifter_extu_mask[63:0] = 64'h0000000000003fff;
    6'd14:   alu_shifter_extu_mask[63:0] = 64'h0000000000007fff;
    6'd15:   alu_shifter_extu_mask[63:0] = 64'h000000000000ffff;
    6'd16:   alu_shifter_extu_mask[63:0] = 64'h000000000001ffff;
    6'd17:   alu_shifter_extu_mask[63:0] = 64'h000000000003ffff;
    6'd18:   alu_shifter_extu_mask[63:0] = 64'h000000000007ffff;
    6'd19:   alu_shifter_extu_mask[63:0] = 64'h00000000000fffff;
    6'd20:   alu_shifter_extu_mask[63:0] = 64'h00000000001fffff;
    6'd21:   alu_shifter_extu_mask[63:0] = 64'h00000000003fffff;
    6'd22:   alu_shifter_extu_mask[63:0] = 64'h00000000007fffff;
    6'd23:   alu_shifter_extu_mask[63:0] = 64'h0000000000ffffff;
    6'd24:   alu_shifter_extu_mask[63:0] = 64'h0000000001ffffff;
    6'd25:   alu_shifter_extu_mask[63:0] = 64'h0000000003ffffff;
    6'd26:   alu_shifter_extu_mask[63:0] = 64'h0000000007ffffff;
    6'd27:   alu_shifter_extu_mask[63:0] = 64'h000000000fffffff;
    6'd28:   alu_shifter_extu_mask[63:0] = 64'h000000001fffffff;
    6'd29:   alu_shifter_extu_mask[63:0] = 64'h000000003fffffff;
    6'd30:   alu_shifter_extu_mask[63:0] = 64'h000000007fffffff;
    6'd31:   alu_shifter_extu_mask[63:0] = 64'h00000000ffffffff;
    6'd32:   alu_shifter_extu_mask[63:0] = 64'h00000001ffffffff;
    6'd33:   alu_shifter_extu_mask[63:0] = 64'h00000003ffffffff;
    6'd34:   alu_shifter_extu_mask[63:0] = 64'h00000007ffffffff;
    6'd35:   alu_shifter_extu_mask[63:0] = 64'h0000000fffffffff;
    6'd36:   alu_shifter_extu_mask[63:0] = 64'h0000001fffffffff;
    6'd37:   alu_shifter_extu_mask[63:0] = 64'h0000003fffffffff;
    6'd38:   alu_shifter_extu_mask[63:0] = 64'h0000007fffffffff;
    6'd39:   alu_shifter_extu_mask[63:0] = 64'h000000ffffffffff;
    6'd40:   alu_shifter_extu_mask[63:0] = 64'h000001ffffffffff;
    6'd41:   alu_shifter_extu_mask[63:0] = 64'h000003ffffffffff;
    6'd42:   alu_shifter_extu_mask[63:0] = 64'h000007ffffffffff;
    6'd43:   alu_shifter_extu_mask[63:0] = 64'h00000fffffffffff;
    6'd44:   alu_shifter_extu_mask[63:0] = 64'h00001fffffffffff;
    6'd45:   alu_shifter_extu_mask[63:0] = 64'h00003fffffffffff;
    6'd46:   alu_shifter_extu_mask[63:0] = 64'h00007fffffffffff;
    6'd47:   alu_shifter_extu_mask[63:0] = 64'h0000ffffffffffff;
    6'd48:   alu_shifter_extu_mask[63:0] = 64'h0001ffffffffffff;
    6'd49:   alu_shifter_extu_mask[63:0] = 64'h0003ffffffffffff;
    6'd50:   alu_shifter_extu_mask[63:0] = 64'h0007ffffffffffff;
    6'd51:   alu_shifter_extu_mask[63:0] = 64'h000fffffffffffff;
    6'd52:   alu_shifter_extu_mask[63:0] = 64'h001fffffffffffff;
    6'd53:   alu_shifter_extu_mask[63:0] = 64'h003fffffffffffff;
    6'd54:   alu_shifter_extu_mask[63:0] = 64'h007fffffffffffff;
    6'd55:   alu_shifter_extu_mask[63:0] = 64'h00ffffffffffffff;
    6'd56:   alu_shifter_extu_mask[63:0] = 64'h01ffffffffffffff;
    6'd57:   alu_shifter_extu_mask[63:0] = 64'h03ffffffffffffff;
    6'd58:   alu_shifter_extu_mask[63:0] = 64'h07ffffffffffffff;
    6'd59:   alu_shifter_extu_mask[63:0] = 64'h0fffffffffffffff;
    6'd60:   alu_shifter_extu_mask[63:0] = 64'h1fffffffffffffff;
    6'd61:   alu_shifter_extu_mask[63:0] = 64'h3fffffffffffffff;
    6'd62:   alu_shifter_extu_mask[63:0] = 64'h7fffffffffffffff;
    6'd63:   alu_shifter_extu_mask[63:0] = 64'hffffffffffffffff;
    default: alu_shifter_extu_mask[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @286
end


// &CombBeg; @289
always @( alu_shift_src0[28:27]
       or alu_shift_src0[52:46]
       or alu_shift_src0[25:24]
       or alu_shift_src0[4:0]
       or alu_shift_src0[38:37]
       or alu_shift_src0[48:35]
       or alu_shift_src1[11:6]
       or alu_shift_src0[21:15]
       or alu_shift_src0[7:5]
       or alu_shift_src0[34:22]
       or alu_shift_src0[63:52]
       or alu_shift_src0[16:8])
begin
  case(alu_shift_src1[11:6])
    6'd0 :   alu_shift_ext_sign = alu_shift_src0[0];
    6'd1 :   alu_shift_ext_sign = alu_shift_src0[1];
    6'd2 :   alu_shift_ext_sign = alu_shift_src0[2];
    6'd3 :   alu_shift_ext_sign = alu_shift_src0[3];
    6'd4 :   alu_shift_ext_sign = alu_shift_src0[4];
    6'd5 :   alu_shift_ext_sign = alu_shift_src0[5];
    6'd6 :   alu_shift_ext_sign = alu_shift_src0[6];
    6'd7 :   alu_shift_ext_sign = alu_shift_src0[7];
    6'd8 :   alu_shift_ext_sign = alu_shift_src0[8];
    6'd9 :   alu_shift_ext_sign = alu_shift_src0[9];
    6'd10:   alu_shift_ext_sign = alu_shift_src0[10];
    6'd11:   alu_shift_ext_sign = alu_shift_src0[11];
    6'd12:   alu_shift_ext_sign = alu_shift_src0[12];
    6'd13:   alu_shift_ext_sign = alu_shift_src0[13];
    6'd14:   alu_shift_ext_sign = alu_shift_src0[14];
    6'd15:   alu_shift_ext_sign = alu_shift_src0[15];
    6'd16:   alu_shift_ext_sign = alu_shift_src0[16];
    6'd17:   alu_shift_ext_sign = alu_shift_src0[17];
    6'd18:   alu_shift_ext_sign = alu_shift_src0[18];
    6'd19:   alu_shift_ext_sign = alu_shift_src0[19];
    6'd20:   alu_shift_ext_sign = alu_shift_src0[20];
    6'd21:   alu_shift_ext_sign = alu_shift_src0[21];
    6'd22:   alu_shift_ext_sign = alu_shift_src0[22];
    6'd23:   alu_shift_ext_sign = alu_shift_src0[23];
    6'd24:   alu_shift_ext_sign = alu_shift_src0[24];
    6'd25:   alu_shift_ext_sign = alu_shift_src0[25];
    6'd26:   alu_shift_ext_sign = alu_shift_src0[26];
    6'd27:   alu_shift_ext_sign = alu_shift_src0[27];
    6'd28:   alu_shift_ext_sign = alu_shift_src0[28];
    6'd29:   alu_shift_ext_sign = alu_shift_src0[29];
    6'd30:   alu_shift_ext_sign = alu_shift_src0[30];
    6'd31:   alu_shift_ext_sign = alu_shift_src0[31];
    6'd32:   alu_shift_ext_sign = alu_shift_src0[32];
    6'd33:   alu_shift_ext_sign = alu_shift_src0[33];
    6'd34:   alu_shift_ext_sign = alu_shift_src0[34];
    6'd35:   alu_shift_ext_sign = alu_shift_src0[35];
    6'd36:   alu_shift_ext_sign = alu_shift_src0[36];
    6'd37:   alu_shift_ext_sign = alu_shift_src0[37];
    6'd38:   alu_shift_ext_sign = alu_shift_src0[38];
    6'd39:   alu_shift_ext_sign = alu_shift_src0[39];
    6'd40:   alu_shift_ext_sign = alu_shift_src0[40];
    6'd41:   alu_shift_ext_sign = alu_shift_src0[41];
    6'd42:   alu_shift_ext_sign = alu_shift_src0[42];
    6'd43:   alu_shift_ext_sign = alu_shift_src0[43];
    6'd44:   alu_shift_ext_sign = alu_shift_src0[44];
    6'd45:   alu_shift_ext_sign = alu_shift_src0[45];
    6'd46:   alu_shift_ext_sign = alu_shift_src0[46];
    6'd47:   alu_shift_ext_sign = alu_shift_src0[47];
    6'd48:   alu_shift_ext_sign = alu_shift_src0[48];
    6'd49:   alu_shift_ext_sign = alu_shift_src0[49];
    6'd50:   alu_shift_ext_sign = alu_shift_src0[50];
    6'd51:   alu_shift_ext_sign = alu_shift_src0[51];
    6'd52:   alu_shift_ext_sign = alu_shift_src0[52];
    6'd53:   alu_shift_ext_sign = alu_shift_src0[53];
    6'd54:   alu_shift_ext_sign = alu_shift_src0[54];
    6'd55:   alu_shift_ext_sign = alu_shift_src0[55];
    6'd56:   alu_shift_ext_sign = alu_shift_src0[56];
    6'd57:   alu_shift_ext_sign = alu_shift_src0[57];
    6'd58:   alu_shift_ext_sign = alu_shift_src0[58];
    6'd59:   alu_shift_ext_sign = alu_shift_src0[59];
    6'd60:   alu_shift_ext_sign = alu_shift_src0[60];
    6'd61:   alu_shift_ext_sign = alu_shift_src0[61];
    6'd62:   alu_shift_ext_sign = alu_shift_src0[62];
    6'd63:   alu_shift_ext_sign = alu_shift_src0[63];
    default: alu_shift_ext_sign = 1'bx;
  endcase
// &CombEnd; @357
end

assign alu_shift_ext_sign_op      = alu_shift_op_sign;
assign alu_shift_ext_and_sel_mask = alu_shift_ext_sign_op && !alu_shift_ext_sign || !alu_shift_ext_sign_op; // high bit is 0
assign alu_shift_ext_or_sel_mask  = alu_shift_ext_sign_op && alu_shift_ext_sign;  // high bit is 1
// high bit is 0 : rst[63:0] & 64'b0000...111 | 64'b000...000
// high bit is 1 : rst[63:0] & 64'b1111...111 | 64'b111...000
assign alu_shift_ext_and_mask[63:0] = alu_shift_ext_and_sel_mask ?  alu_shifter_extu_mask[63:0] : {64{1'b1}};
assign alu_shift_ext_or_mask[63:0]  = alu_shift_ext_or_sel_mask  ? ~alu_shifter_extu_mask[63:0] : {64{1'b0}};
assign alu_shift_ext_rst[63:0]      = alu_shift_shifter_rst[63:0] & alu_shift_ext_and_mask[63:0] | alu_shift_ext_or_mask[63:0];

// shift rst
assign alu_shift_rst[63:0] = alu_shift_op_ext ? alu_shift_ext_rst[63:0] : alu_shift_rst_raw1[63:0];


//==========================================================
//                        LOGIC
//==========================================================
//logic func:
//or, xor, and
assign alu_logic_sel = alu_func[2];
assign alu_logic_src0[63:0] = {64{alu_logic_sel}} & idu_iu_ex1_src0[63:0];
assign alu_logic_src1[63:0] = {64{alu_logic_sel}} & idu_iu_ex1_src1[63:0];

assign alu_logic_op_and = alu_func[5];
assign alu_logic_op_xor = alu_func[6];
assign alu_logic_op_or  = alu_func[7];

assign alu_logic_and_rst[63:0] = alu_logic_src0[63:0] & alu_logic_src1[63:0];
assign alu_logic_xor_rst[63:0] = alu_logic_src0[63:0] ^ alu_logic_src1[63:0];
assign alu_logic_or_rst[63:0]  = alu_logic_src0[63:0] | alu_logic_src1[63:0];

assign alu_logic_rst[63:0] = {64{alu_logic_op_and}} & alu_logic_and_rst[63:0] |
                             {64{alu_logic_op_xor}} & alu_logic_xor_rst[63:0] |
                             {64{alu_logic_op_or}}  & alu_logic_or_rst[63:0];


//==========================================================
//                        MISC
//==========================================================
// misc func:
// mvnez, mveqz, ff0, ff, tst, tstnbz, rev, revw
assign alu_misc_sel       = alu_func[3];
assign alu_misc_op_revw   = alu_func[5];
assign alu_misc_op_rev    = alu_func[6];
assign alu_misc_op_tstnbz = alu_func[7];
assign alu_misc_op_tst    = alu_func[8];
assign alu_misc_op_ff     = alu_func[9];
assign alu_misc_op_ff0    = alu_func[10];
assign alu_misc_op_mov    = alu_func[11];

assign alu_misc_src0[63:0] = {64{alu_misc_sel}} & idu_iu_ex1_src0[63:0];
assign alu_misc_src1[63:0] = {64{alu_misc_sel}} & idu_iu_ex1_src1[63:0];
assign alu_misc_src2[63:0] = {64{alu_misc_sel}} & idu_iu_ex1_src2[63:0];


// FF0/FF1
assign alu_misc_ff1_src[63:0] = alu_misc_op_ff0 ? ~alu_misc_src0[63:0] : alu_misc_src0[63:0];
// execution of FF1
// &CombBeg; @416
always @( alu_misc_ff1_src[63:0])
begin
  casez(alu_misc_ff1_src[63:0])
    64'b1???????????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd0;
    64'b01??????????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd1;
    64'b001?????????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd2;
    64'b0001????????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd3;
    64'b00001???????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd4;
    64'b000001??????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd5;
    64'b0000001?????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd6;
    64'b00000001????????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd7;
    64'b000000001???????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd8;
    64'b0000000001??????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd9;
    64'b00000000001?????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd10;
    64'b000000000001????????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd11;
    64'b0000000000001???????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd12;
    64'b00000000000001??????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd13;
    64'b000000000000001?????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd14;
    64'b0000000000000001????????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd15;
    64'b00000000000000001???????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd16;
    64'b000000000000000001??????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd17;
    64'b0000000000000000001?????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd18;
    64'b00000000000000000001????????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd19;
    64'b000000000000000000001???????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd20;
    64'b0000000000000000000001??????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd21;
    64'b00000000000000000000001?????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd22;
    64'b000000000000000000000001????????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd23;
    64'b0000000000000000000000001???????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd24;
    64'b00000000000000000000000001??????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd25;
    64'b000000000000000000000000001?????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd26;
    64'b0000000000000000000000000001????????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd27;
    64'b00000000000000000000000000001???????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd28;
    64'b000000000000000000000000000001??????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd29;
    64'b0000000000000000000000000000001?????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd30;
    64'b00000000000000000000000000000001????????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd31;
    64'b000000000000000000000000000000001???????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd32;
    64'b0000000000000000000000000000000001??????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd33;
    64'b00000000000000000000000000000000001?????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd34;
    64'b000000000000000000000000000000000001????????????????????????????: alu_misc_ff1_rst[63:0] = 64'd35;
    64'b0000000000000000000000000000000000001???????????????????????????: alu_misc_ff1_rst[63:0] = 64'd36;
    64'b00000000000000000000000000000000000001??????????????????????????: alu_misc_ff1_rst[63:0] = 64'd37;
    64'b000000000000000000000000000000000000001?????????????????????????: alu_misc_ff1_rst[63:0] = 64'd38;
    64'b0000000000000000000000000000000000000001????????????????????????: alu_misc_ff1_rst[63:0] = 64'd39;
    64'b00000000000000000000000000000000000000001???????????????????????: alu_misc_ff1_rst[63:0] = 64'd40;
    64'b000000000000000000000000000000000000000001??????????????????????: alu_misc_ff1_rst[63:0] = 64'd41;
    64'b0000000000000000000000000000000000000000001?????????????????????: alu_misc_ff1_rst[63:0] = 64'd42;
    64'b00000000000000000000000000000000000000000001????????????????????: alu_misc_ff1_rst[63:0] = 64'd43;
    64'b000000000000000000000000000000000000000000001???????????????????: alu_misc_ff1_rst[63:0] = 64'd44;
    64'b0000000000000000000000000000000000000000000001??????????????????: alu_misc_ff1_rst[63:0] = 64'd45;
    64'b00000000000000000000000000000000000000000000001?????????????????: alu_misc_ff1_rst[63:0] = 64'd46;
    64'b000000000000000000000000000000000000000000000001????????????????: alu_misc_ff1_rst[63:0] = 64'd47;
    64'b0000000000000000000000000000000000000000000000001???????????????: alu_misc_ff1_rst[63:0] = 64'd48;
    64'b00000000000000000000000000000000000000000000000001??????????????: alu_misc_ff1_rst[63:0] = 64'd49;
    64'b000000000000000000000000000000000000000000000000001?????????????: alu_misc_ff1_rst[63:0] = 64'd50;
    64'b0000000000000000000000000000000000000000000000000001????????????: alu_misc_ff1_rst[63:0] = 64'd51;
    64'b00000000000000000000000000000000000000000000000000001???????????: alu_misc_ff1_rst[63:0] = 64'd52;
    64'b000000000000000000000000000000000000000000000000000001??????????: alu_misc_ff1_rst[63:0] = 64'd53;
    64'b0000000000000000000000000000000000000000000000000000001?????????: alu_misc_ff1_rst[63:0] = 64'd54;
    64'b00000000000000000000000000000000000000000000000000000001????????: alu_misc_ff1_rst[63:0] = 64'd55;
    64'b000000000000000000000000000000000000000000000000000000001???????: alu_misc_ff1_rst[63:0] = 64'd56;
    64'b0000000000000000000000000000000000000000000000000000000001??????: alu_misc_ff1_rst[63:0] = 64'd57;
    64'b00000000000000000000000000000000000000000000000000000000001?????: alu_misc_ff1_rst[63:0] = 64'd58;
    64'b000000000000000000000000000000000000000000000000000000000001????: alu_misc_ff1_rst[63:0] = 64'd59;
    64'b0000000000000000000000000000000000000000000000000000000000001???: alu_misc_ff1_rst[63:0] = 64'd60;
    64'b00000000000000000000000000000000000000000000000000000000000001??: alu_misc_ff1_rst[63:0] = 64'd61;
    64'b000000000000000000000000000000000000000000000000000000000000001?: alu_misc_ff1_rst[63:0] = 64'd62;
    64'b0000000000000000000000000000000000000000000000000000000000000001: alu_misc_ff1_rst[63:0] = 64'd63;
    64'b0000000000000000000000000000000000000000000000000000000000000000: alu_misc_ff1_rst[63:0] = 64'd64;
    default:                                                              alu_misc_ff1_rst[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @485
end

// REV
assign alu_misc_rev_rst[7:0]   = alu_misc_src0[63:56];
assign alu_misc_rev_rst[15:8]  = alu_misc_src0[55:48];
assign alu_misc_rev_rst[23:16] = alu_misc_src0[47:40];
assign alu_misc_rev_rst[31:24] = alu_misc_src0[39:32];
assign alu_misc_rev_rst[39:32] = alu_misc_src0[31:24];
assign alu_misc_rev_rst[47:40] = alu_misc_src0[23:16];
assign alu_misc_rev_rst[55:48] = alu_misc_src0[15:8];
assign alu_misc_rev_rst[63:56] = alu_misc_src0[7:0];

// REVW
assign alu_misc_revw_rst[7:0]   = alu_misc_src0[31:24];
assign alu_misc_revw_rst[15:8]  = alu_misc_src0[23:16];
assign alu_misc_revw_rst[23:16] = alu_misc_src0[15:8];
assign alu_misc_revw_rst[31:24] = alu_misc_src0[7:0];
assign alu_misc_revw_rst[63:32] = {32{alu_misc_src0[7]}};

// TST
// &CombBeg; @505
always @( alu_misc_src1[5:0]
       or alu_misc_src0[23:19]
       or alu_misc_src0[38:32]
       or alu_misc_src0[46:44]
       or alu_misc_src0[42:39]
       or alu_misc_src0[63:58]
       or alu_misc_src0[49:40]
       or alu_misc_src0[31:24]
       or alu_misc_src0[18:0]
       or alu_misc_src0[57:48])
begin
  case(alu_misc_src1[5:0])
    6'd0 :   alu_misc_tst_bit = alu_misc_src0[0];
    6'd1 :   alu_misc_tst_bit = alu_misc_src0[1];
    6'd2 :   alu_misc_tst_bit = alu_misc_src0[2];
    6'd3 :   alu_misc_tst_bit = alu_misc_src0[3];
    6'd4 :   alu_misc_tst_bit = alu_misc_src0[4];
    6'd5 :   alu_misc_tst_bit = alu_misc_src0[5];
    6'd6 :   alu_misc_tst_bit = alu_misc_src0[6];
    6'd7 :   alu_misc_tst_bit = alu_misc_src0[7];
    6'd8 :   alu_misc_tst_bit = alu_misc_src0[8];
    6'd9 :   alu_misc_tst_bit = alu_misc_src0[9];
    6'd10:   alu_misc_tst_bit = alu_misc_src0[10];
    6'd11:   alu_misc_tst_bit = alu_misc_src0[11];
    6'd12:   alu_misc_tst_bit = alu_misc_src0[12];
    6'd13:   alu_misc_tst_bit = alu_misc_src0[13];
    6'd14:   alu_misc_tst_bit = alu_misc_src0[14];
    6'd15:   alu_misc_tst_bit = alu_misc_src0[15];
    6'd16:   alu_misc_tst_bit = alu_misc_src0[16];
    6'd17:   alu_misc_tst_bit = alu_misc_src0[17];
    6'd18:   alu_misc_tst_bit = alu_misc_src0[18];
    6'd19:   alu_misc_tst_bit = alu_misc_src0[19];
    6'd20:   alu_misc_tst_bit = alu_misc_src0[20];
    6'd21:   alu_misc_tst_bit = alu_misc_src0[21];
    6'd22:   alu_misc_tst_bit = alu_misc_src0[22];
    6'd23:   alu_misc_tst_bit = alu_misc_src0[23];
    6'd24:   alu_misc_tst_bit = alu_misc_src0[24];
    6'd25:   alu_misc_tst_bit = alu_misc_src0[25];
    6'd26:   alu_misc_tst_bit = alu_misc_src0[26];
    6'd27:   alu_misc_tst_bit = alu_misc_src0[27];
    6'd28:   alu_misc_tst_bit = alu_misc_src0[28];
    6'd29:   alu_misc_tst_bit = alu_misc_src0[29];
    6'd30:   alu_misc_tst_bit = alu_misc_src0[30];
    6'd31:   alu_misc_tst_bit = alu_misc_src0[31];
    6'd32:   alu_misc_tst_bit = alu_misc_src0[32];
    6'd33:   alu_misc_tst_bit = alu_misc_src0[33];
    6'd34:   alu_misc_tst_bit = alu_misc_src0[34];
    6'd35:   alu_misc_tst_bit = alu_misc_src0[35];
    6'd36:   alu_misc_tst_bit = alu_misc_src0[36];
    6'd37:   alu_misc_tst_bit = alu_misc_src0[37];
    6'd38:   alu_misc_tst_bit = alu_misc_src0[38];
    6'd39:   alu_misc_tst_bit = alu_misc_src0[39];
    6'd40:   alu_misc_tst_bit = alu_misc_src0[40];
    6'd41:   alu_misc_tst_bit = alu_misc_src0[41];
    6'd42:   alu_misc_tst_bit = alu_misc_src0[42];
    6'd43:   alu_misc_tst_bit = alu_misc_src0[43];
    6'd44:   alu_misc_tst_bit = alu_misc_src0[44];
    6'd45:   alu_misc_tst_bit = alu_misc_src0[45];
    6'd46:   alu_misc_tst_bit = alu_misc_src0[46];
    6'd47:   alu_misc_tst_bit = alu_misc_src0[47];
    6'd48:   alu_misc_tst_bit = alu_misc_src0[48];
    6'd49:   alu_misc_tst_bit = alu_misc_src0[49];
    6'd50:   alu_misc_tst_bit = alu_misc_src0[50];
    6'd51:   alu_misc_tst_bit = alu_misc_src0[51];
    6'd52:   alu_misc_tst_bit = alu_misc_src0[52];
    6'd53:   alu_misc_tst_bit = alu_misc_src0[53];
    6'd54:   alu_misc_tst_bit = alu_misc_src0[54];
    6'd55:   alu_misc_tst_bit = alu_misc_src0[55];
    6'd56:   alu_misc_tst_bit = alu_misc_src0[56];
    6'd57:   alu_misc_tst_bit = alu_misc_src0[57];
    6'd58:   alu_misc_tst_bit = alu_misc_src0[58];
    6'd59:   alu_misc_tst_bit = alu_misc_src0[59];
    6'd60:   alu_misc_tst_bit = alu_misc_src0[60];
    6'd61:   alu_misc_tst_bit = alu_misc_src0[61];
    6'd62:   alu_misc_tst_bit = alu_misc_src0[62];
    6'd63:   alu_misc_tst_bit = alu_misc_src0[63];
    default: alu_misc_tst_bit = 1'bx;
  endcase
// &CombEnd; @573
end
assign alu_misc_tst_rst[63:0] = {63'b0, alu_misc_tst_bit};

// TSTNBZ
assign alu_misc_tstnbz_rst[63:56] = (alu_misc_src0[63:56] == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[55:48] = (alu_misc_src0[55:48] == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[47:40] = (alu_misc_src0[47:40] == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[39:32] = (alu_misc_src0[39:32] == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[31:24] = (alu_misc_src0[31:24] == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[23:16] = (alu_misc_src0[23:16] == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[15:8]  = (alu_misc_src0[15:8]  == 8'b0) ? 8'hff : 8'b0;
assign alu_misc_tstnbz_rst[7:0]   = (alu_misc_src0[7:0]   == 8'b0) ? 8'hff : 8'b0;

// MOV
assign alu_misc_src_not_zero  = |alu_misc_src1[63:0];
assign alu_misc_op_mveqz      = alu_misc_op_mov && alu_misc_op_ff0;
assign alu_misc_op_mvnez      = alu_misc_op_mov && !alu_misc_op_ff0;
assign alu_misc_sel_src2      = alu_misc_op_mveqz && alu_misc_src_not_zero ||
                                alu_misc_op_mvnez && !alu_misc_src_not_zero;
assign alu_misc_mov_rst[63:0] = alu_misc_sel_src2 ? alu_misc_src2[63:0] : alu_misc_src0[63:0];

// Result select
assign alu_misc_rst_mov    = alu_misc_op_mov;
assign alu_misc_rst_ff1    = alu_misc_op_ff;
assign alu_misc_rst_tst    = alu_misc_op_tst;
assign alu_misc_rst_rev    = alu_misc_op_rev;
assign alu_misc_rst_revw   = alu_misc_op_revw;
assign alu_misc_rst_tstnbz = alu_misc_op_tstnbz;

// Reult merge
// &CombBeg; @603
always @( alu_misc_tst_rst[63:0]
       or alu_misc_rev_rst[63:0]
       or alu_misc_rst_mov
       or alu_misc_rst_tst
       or alu_misc_ff1_rst[63:0]
       or alu_misc_rst_revw
       or alu_misc_tstnbz_rst[63:0]
       or alu_misc_rst_tstnbz
       or alu_misc_mov_rst[63:0]
       or alu_misc_revw_rst[63:0]
       or alu_misc_rst_ff1
       or alu_misc_rst_rev)
begin
  case({alu_misc_rst_mov, alu_misc_rst_ff1, alu_misc_rst_tst, alu_misc_rst_rev, alu_misc_rst_revw, alu_misc_rst_tstnbz})
    6'b000001 : alu_misc_rst[63:0] = alu_misc_tstnbz_rst[63:0];
    6'b000010 : alu_misc_rst[63:0] = alu_misc_revw_rst[63:0];
    6'b000100 : alu_misc_rst[63:0] = alu_misc_rev_rst[63:0];
    6'b001000 : alu_misc_rst[63:0] = alu_misc_tst_rst[63:0];
    6'b010000 : alu_misc_rst[63:0] = alu_misc_ff1_rst[63:0];
    6'b100000 : alu_misc_rst[63:0] = alu_misc_mov_rst[63:0];
    default:    alu_misc_rst[63:0] = {64{1'bx}};
  endcase
// &CombEnd @613
end


//==========================================================
//                    ALU Result Merge
//==========================================================
// ALU result
assign alu_rst[63:0] = {64{alu_adder_sel}} & alu_adder_rst[63:0] |
                       {64{alu_shift_sel}} & alu_shift_rst[63:0] |
                       {64{alu_logic_sel}} & alu_logic_rst[63:0] |
                       {64{alu_misc_sel}}  & alu_misc_rst[63:0];


//==========================================================
//                   Output for RTU
//==========================================================
assign iu_rtu_ex1_alu_wb_vld     = idu_iu_ex1_alu_sel;
assign iu_rtu_ex1_alu_wb_dp      = idu_iu_ex1_alu_dp_sel;
assign iu_rtu_ex1_alu_cmplt      = idu_iu_ex1_alu_sel;
assign iu_rtu_ex1_alu_cmplt_dp   = idu_iu_ex1_alu_dp_sel;
assign iu_rtu_ex1_alu_inst_len   = idu_iu_ex1_inst_len;
assign iu_rtu_ex1_alu_inst_split = idu_iu_ex1_split;
assign iu_rtu_ex1_alu_data[63:0]     = alu_rst[63:0];
assign iu_rtu_ex1_alu_preg[5:0]      = idu_iu_ex1_dst0_reg[5:0];


// &Force("input", "forever_cpuclk") @640

// &ModuleEnd; @687
endmodule


