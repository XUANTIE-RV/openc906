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

//==========================================================
//                  IDU Config Macros
//==========================================================
`ifdef VLEN_64
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VEC_1_BANK
    `define BANK_NUM 1
  `endif //VEC_DP_64
`endif //VLEN_64

`ifdef VLEN_128
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define BANK_NUM 2
  `endif //VEC_DP_64

  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define BANK_NUM 2
  `endif //VEC_DP_128
`endif //VLEN_128

`ifdef VLEN_256
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
    `define BANK_NUM 4
  `endif //VEC_DP_64

  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
  `endif //VEC_DP_256
`endif //VLEN_256

`ifdef VLEN_512
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
    `define VLEN_BANK4
    `define VLEN_BANK5
    `define VLEN_BANK6
    `define VLEN_BANK7
  `endif //VEC_DP_64

  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
  `endif //VEC_DP_512
`endif //VLEN_512

`ifdef VLEN_1024
  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
    `define VLEN_BANK4
    `define VLEN_BANK5
    `define VLEN_BANK6
    `define VLEN_BANK7
  `endif //VEC_DP_128
`endif //VLEN_1024

//==========================================================
//                     Execute Units
//==========================================================
//1.the EU_xxx_SEL bit should be one hot within int/fp/vec
//2.[MSB:MSB-1] should be used for FP and VEC one hot sel
//3.int/fp/vec could use same [MSB-2:0] encodings
//4.LSU/VLSU/FLSU should use same one hot bit
//5.[MSB-2:MSB-3] should be used to indicate vec eu groups
//----------------------------------------------------------
//                      EU WIDTH
//----------------------------------------------------------
`define EU_WIDTH           10

//----------------------------------------------------------
//                     Integer EU
//----------------------------------------------------------
`define EU_ALU             10'b0000000001
`define EU_BJU             10'b0000000010
`define EU_MULT            10'b0000000100
`define EU_DIV             10'b0000001000
`define EU_CP0             10'b0000010000
`define EU_LSU             10'b0000100000

`define EU_ALU_SEL         0
`define EU_BJU_SEL         1
`define EU_MULT_SEL        2
`define EU_DIV_SEL         3
`define EU_CP0_SEL         4
`define EU_LSU_SEL         5

//----------------------------------------------------------
//                       FP EU
//----------------------------------------------------------
`define EU_FP_SEL          8

`define EU_FMAU            10'b0100000001
`define EU_FALU            10'b0101000001
`define EU_FCVT            10'b0110000001
`define EU_FSPU            10'b0110000010
`define EU_FDSU            10'b0111000001
`define EU_FLSU            10'b0111100000

`define EU_FLSU_SEL        5

//----------------------------------------------------------
//                     Vector EU
//----------------------------------------------------------
`define EU_VEC_SEL         9
`define EU_VGROUP_SEL      7

`define EU_VFMAU           10'b1000000001
`define EU_VMULU           10'b1000000010
`define EU_VFALU           10'b1001000001
`define EU_VALU            10'b1001000010
`define EU_VREDU           10'b1001000100
`define EU_VFCVT           10'b1010000001
`define EU_VFSPU           10'b1010000010
`define EU_VMISC           10'b1010000100
`define EU_VSHIFT          10'b1010001000
`define EU_VPERMU          10'b1010010000
`define EU_VFDSU           10'b1011000001
`define EU_VDIVU           10'b1011000010
`define EU_VLSU            10'b1011100000

`define EU_VLSU_SEL        5

//==========================================================
//                 Write Back Table Type
//==========================================================
//----------------------------------------------------------
//               Integer Write Back Table
//----------------------------------------------------------
`define WB_INT_WIDTH       `WB_INT_WB_CNT2     + 1

`define WB_INT_WB_CNT2     `WB_INT_CNT         + 1
`define WB_INT_CNT         `WB_INT_TYPE        + 2
`define WB_INT_TYPE        `WB_INT_VLD         + 3
`define WB_INT_VLD                               0

`define WB_INT_TYPE_OTHER                        3'd0
`define WB_INT_TYPE_ALU                          3'd1
`define WB_INT_TYPE_BJU                          3'd2
`define WB_INT_TYPE_MULT                         3'd3
`define WB_INT_TYPE_LSU                          3'd4

//----------------------------------------------------------
//                Vector Write Back Table
//----------------------------------------------------------
`define WB_VEC_WIDTH       `WB_VEC_CNT         + 1

`define WB_VEC_CNT         `WB_VEC_TYPE        + 1
`define WB_VEC_TYPE        `WB_VEC_VLD         + 1
`define WB_VEC_VLD                               0

`define WB_VEC_TYPE_OTHER                        1'd0
`define WB_VEC_TYPE_VLSU                         1'd1

//==========================================================
//                   Vector Split Type
//==========================================================
`define VEC_SPLIT_NON                            4'b0

//==========================================================
//                    ID data path
//==========================================================
`define IDU_WIDTH              `IDU_FUNC                + 1

`define IDU_FUNC               `IDU_EU                  + 20
`define IDU_EU                 `IDU_OPCODE              + 10
`define IDU_OPCODE             `IDU_VEC_SPLIT_TYPE      + 32
`define IDU_VEC_SPLIT_TYPE     `IDU_SPLIT               + 4
`define IDU_SPLIT              `IDU_ILLEGAL             + 1
`define IDU_ILLEGAL            `IDU_LENGTH              + 1
`define IDU_LENGTH             `IDU_SRC2_IMM            + 1
`define IDU_SRC2_IMM           `IDU_SRC1_IMM            + 64
`define IDU_SRC1_IMM           `IDU_SRC2_IMM_VLD        + 64
`define IDU_SRC2_IMM_VLD       `IDU_SRC1_IMM_VLD        + 1
`define IDU_SRC1_IMM_VLD       `IDU_DSTV_REG            + 1
`define IDU_DSTV_REG           `IDU_SRCV2_REG           + 5
`define IDU_SRCV2_REG          `IDU_SRCV1_REG           + 5
`define IDU_SRCV1_REG          `IDU_SRCV0_REG           + 5
`define IDU_SRCV0_REG          `IDU_DST1_REG            + 5
`define IDU_DST1_REG           `IDU_DST0_REG            + 6
`define IDU_DST0_REG           `IDU_SRC2_REG            + 6
`define IDU_SRC2_REG           `IDU_SRC1_REG            + 6
`define IDU_SRC1_REG           `IDU_SRC0_REG            + 6
`define IDU_SRC0_REG           `IDU_DSTV_LATE_VLD       + 6
`define IDU_DSTV_LATE_VLD      `IDU_DSTV_VLD            + 1
`define IDU_DSTV_VLD           `IDU_SRCVM_VLD           + 1
`define IDU_SRCVM_VLD          `IDU_SRCV2_VLD           + 1
`define IDU_SRCV2_VLD          `IDU_SRCV1_VLD           + 1
`define IDU_SRCV1_VLD          `IDU_SRCV0_VLD           + 1
`define IDU_SRCV0_VLD          `IDU_DSTE_VLD            + 1
`define IDU_DSTE_VLD           `IDU_DSTF_VLD            + 1
`define IDU_DSTF_VLD           `IDU_SRCF2_VLD           + 1
`define IDU_SRCF2_VLD          `IDU_SRCF1_VLD           + 1
`define IDU_SRCF1_VLD          `IDU_SRCF0_VLD           + 1
`define IDU_SRCF0_VLD          `IDU_DST1_VLD            + 1
`define IDU_DST1_VLD           `IDU_DST0_VLD            + 1
`define IDU_DST0_VLD           `IDU_SRC2_VLD            + 1
`define IDU_SRC2_VLD           `IDU_SRC1_VLD            + 1
`define IDU_SRC1_VLD           `IDU_SRC0_VLD            + 1
`define IDU_SRC0_VLD                                      0

//==========================================================
//                  Dispatch data path
//==========================================================
//----------------------------------------------------------
//                   Integer Dispatch
//----------------------------------------------------------
`define DIS_INT_WIDTH          `DIS_INT_HINFO_MSB      + 1

`define DIS_INT_HINFO_MSB      `DIS_INT_OPCODE         + `TDT_HINFO_WIDTH
`define DIS_INT_HINFO_LSB      `DIS_INT_OPCODE         + 1
`define DIS_INT_OPCODE         `DIS_INT_FUNC           + 32
`define DIS_INT_FUNC           `DIS_INT_VSEW           + 20
`define DIS_INT_VSEW           `DIS_INT_VLMUL          + 2
`define DIS_INT_VLMUL          `DIS_INT_BHT_PRED       + 2
`define DIS_INT_BHT_PRED       `DIS_INT_EXPT_ILLE      + 2
`define DIS_INT_EXPT_ILLE      `DIS_INT_EXPT_HIGH      + 1
`define DIS_INT_EXPT_HIGH      `DIS_INT_EXPT_PAGE      + 1
`define DIS_INT_EXPT_PAGE      `DIS_INT_EXPT_ACC       + 1
`define DIS_INT_EXPT_ACC       `DIS_INT_SPLIT          + 1
`define DIS_INT_SPLIT          `DIS_INT_LENGTH         + 1
`define DIS_INT_LENGTH         `DIS_INT_DST1_REG       + 1
`define DIS_INT_DST1_REG       `DIS_INT_DST0_REG       + 6
`define DIS_INT_DST0_REG       `DIS_INT_SRC2_RDY       + 6
`define DIS_INT_SRC2_RDY       `DIS_INT_SRC1_RDY       + 1
`define DIS_INT_SRC1_RDY       `DIS_INT_SRC0_RDY       + 1
`define DIS_INT_SRC0_RDY       `DIS_INT_SRC2_REG       + 1
`define DIS_INT_SRC2_REG       `DIS_INT_SRC1_REG       + 6
`define DIS_INT_SRC1_REG       `DIS_INT_SRC0_REG       + 6
`define DIS_INT_SRC0_REG       `DIS_INT_SRC2_DATA      + 6
`define DIS_INT_SRC2_DATA      `DIS_INT_SRC1_DATA      + 64
`define DIS_INT_SRC1_DATA      `DIS_INT_SRC0_DATA      + 64
`define DIS_INT_SRC0_DATA                                63

//----------------------------------------------------------
//                   Vector Dispatch
//----------------------------------------------------------
`define DIS_VEC_WIDTH          `DIS_VEC_FUNC           + 1

`define DIS_VEC_FUNC           `DIS_VEC_EU             + 20
`define DIS_VEC_EU             `DIS_VEC_VSEW           + 10
`define DIS_VEC_VSEW           `DIS_VEC_VLMUL          + 2
`define DIS_VEC_VLMUL          `DIS_VEC_SPLIT_TYPE     + 2
`define DIS_VEC_SPLIT_TYPE     `DIS_VEC_DSTV_REG       + 4
`define DIS_VEC_DSTV_REG       `DIS_VEC_SRCVM_REG      + 13
`define DIS_VEC_SRCVM_REG      `DIS_VEC_SRCV2_REG      + 8
`define DIS_VEC_SRCV2_REG      `DIS_VEC_SRCV1_REG      + 13
`define DIS_VEC_SRCV1_REG      `DIS_VEC_SRCV0_REG      + 13
`define DIS_VEC_SRCV0_REG      `DIS_VEC_DST0_REG       + 13
`define DIS_VEC_DST0_REG       `DIS_VEC_DST0_VLD       + 6
`define DIS_VEC_DST0_VLD       `DIS_VEC_DSTV_LATE_VLD  + 1
`define DIS_VEC_DSTV_LATE_VLD  `DIS_VEC_DSTV_VLD       + 1
`define DIS_VEC_DSTV_VLD       `DIS_VEC_SRCVM_VLD      + 1
`define DIS_VEC_SRCVM_VLD      `DIS_VEC_SRCV2_VLD      + 1
`define DIS_VEC_SRCV2_VLD      `DIS_VEC_SRCV1_VLD      + 1
`define DIS_VEC_SRCV1_VLD      `DIS_VEC_SRCV0_VLD      + 1
`define DIS_VEC_SRCV0_VLD      `DIS_VEC_DSTE_VLD       + 1
`define DIS_VEC_DSTE_VLD       `DIS_VEC_DSTF_VLD       + 1
`define DIS_VEC_DSTF_VLD       `DIS_VEC_SRCF2_VLD      + 1
`define DIS_VEC_SRCF2_VLD      `DIS_VEC_SRCF1_VLD      + 1
`define DIS_VEC_SRCF1_VLD      `DIS_VEC_SRCF0_VLD      + 1
`define DIS_VEC_SRCF0_VLD      `DIS_VEC_SRC1_DATA      + 1
`define DIS_VEC_SRC1_DATA                                63

//==========================================================
//                      Function
//==========================================================
//----------------------------------------------------------
//                    Width Define
//----------------------------------------------------------
`define FUNC_WIDTH             20

//----------------------------------------------------------
//                   Function Selection
//----------------------------------------------------------
//follow bits are used in IDU to directly select certain bit
//in functions, so these bits should be one hot in its eu
//function encodings
`define FUNC_STORE_SEL         0
`define FUNC_NO_FENCE_SEL      3
`define FUNC_CONDBR_SEL        6
`define FUNC_AUIPC_SEL         7

//----------------------------------------------------------
//                   IU 32 bit Full Decoder
//----------------------------------------------------------
//----------------------------------------------------------
//                   ALU ADDER Decoder
//----------------------------------------------------------
`define FUNC_LUI         {{`FUNC_WIDTH-19{1'b0}}, 19'b1000001_010000000001}
`define FUNC_ADD         {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_ADDDI       {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_ADDSL       {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000100001}
`define FUNC_ADDW        {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_010001000001}
`define FUNC_ADDIW       {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_010001000001}
`define FUNC_SUB         {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_011000000001}
`define FUNC_SUBW        {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_011001000001}
`define FUNC_SLT         {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_111010000001}
`define FUNC_SLTI        {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_111010000001}
`define FUNC_SLTU        {{`FUNC_WIDTH-19{1'b0}}, 19'b0000100_101010000001}
`define FUNC_SLTIU       {{`FUNC_WIDTH-19{1'b0}}, 19'b0000100_101010000001}
`define FUNC_MIN         {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_111100000001}
`define FUNC_MAX         {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_011100000001}
`define FUNC_MINU        {{`FUNC_WIDTH-19{1'b0}}, 19'b0000100_101100000001}
`define FUNC_MAXU        {{`FUNC_WIDTH-19{1'b0}}, 19'b0000100_001100000001}
`define FUNC_MINW        {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_111101000001}
`define FUNC_MAXW        {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_011101000001}
`define FUNC_MINUW       {{`FUNC_WIDTH-19{1'b0}}, 19'b0010000_101101000001}
`define FUNC_MAXUW       {{`FUNC_WIDTH-19{1'b0}}, 19'b0010000_001101000001}

//----------------------------------------------------------
//                   ALU SHIFT Decoder
//----------------------------------------------------------
`define FUNC_SLL         {{`FUNC_WIDTH-17{1'b0}}, 17'b10000_00000_0100010}
`define FUNC_SLLI        {{`FUNC_WIDTH-17{1'b0}}, 17'b10000_00000_0100010}
`define FUNC_SLLW        {{`FUNC_WIDTH-17{1'b0}}, 17'b10000_00000_1100010}
`define FUNC_SLLIW       {{`FUNC_WIDTH-17{1'b0}}, 17'b10000_00000_1100010}
`define FUNC_SRL         {{`FUNC_WIDTH-17{1'b0}}, 17'b11000_10000_0000010}
`define FUNC_SRLI        {{`FUNC_WIDTH-17{1'b0}}, 17'b11000_10000_0000010}
`define FUNC_SRLW        {{`FUNC_WIDTH-17{1'b0}}, 17'b10100_10000_1000010}
`define FUNC_SRLIW       {{`FUNC_WIDTH-17{1'b0}}, 17'b10100_10000_1000010}
`define FUNC_SRA         {{`FUNC_WIDTH-17{1'b0}}, 17'b01000_00001_0000010}
`define FUNC_SRAI        {{`FUNC_WIDTH-17{1'b0}}, 17'b01000_00001_0000010}
`define FUNC_SRAW        {{`FUNC_WIDTH-17{1'b0}}, 17'b00001_00001_1000010}
`define FUNC_SRAIW       {{`FUNC_WIDTH-17{1'b0}}, 17'b00001_00001_1000010}
`define FUNC_SRRI        {{`FUNC_WIDTH-17{1'b0}}, 17'b01000_00010_0000010}
`define FUNC_SRRIW       {{`FUNC_WIDTH-17{1'b0}}, 17'b00010_00010_1000010}
`define FUNC_EXT         {{`FUNC_WIDTH-17{1'b0}}, 17'b11000_01100_0000010}
`define FUNC_EXTU        {{`FUNC_WIDTH-17{1'b0}}, 17'b11000_00100_0000010}

//----------------------------------------------------------
//                   ALU LOGIC Decoder
//----------------------------------------------------------
`define FUNC_AND         {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100100}
`define FUNC_ANDI        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100100}
`define FUNC_XOR         {{`FUNC_WIDTH-12{1'b0}}, 12'b000001000100}
`define FUNC_XORI        {{`FUNC_WIDTH-12{1'b0}}, 12'b000001000100}
`define FUNC_OR          {{`FUNC_WIDTH-12{1'b0}}, 12'b000010000100}
`define FUNC_ORI         {{`FUNC_WIDTH-12{1'b0}}, 12'b000010000100}

//----------------------------------------------------------
//                   ALU MSIC Decoder
//----------------------------------------------------------
`define FUNC_FF0         {{`FUNC_WIDTH-12{1'b0}}, 12'b011000001000}
`define FUNC_FF1         {{`FUNC_WIDTH-12{1'b0}}, 12'b001000001000}
`define FUNC_REV         {{`FUNC_WIDTH-12{1'b0}}, 12'b000001001000}
`define FUNC_REVW        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000101000}
`define FUNC_TST         {{`FUNC_WIDTH-12{1'b0}}, 12'b000100001000}
`define FUNC_TSTNBZ      {{`FUNC_WIDTH-12{1'b0}}, 12'b000010001000}
`define FUNC_MVEQZ       {{`FUNC_WIDTH-12{1'b0}}, 12'b110000001000}
`define FUNC_MVNEZ       {{`FUNC_WIDTH-12{1'b0}}, 12'b100000001000}
 
//----------------------------------------------------------
//                      MULT Decoder
//----------------------------------------------------------
`define FUNC_MUL         {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100001}
`define FUNC_MULW        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100010}
`define FUNC_MULH        {{`FUNC_WIDTH-12{1'b0}}, 12'b000100100001}
`define FUNC_MULHU       {{`FUNC_WIDTH-12{1'b0}}, 12'b000110000001}
`define FUNC_MULHSU      {{`FUNC_WIDTH-12{1'b0}}, 12'b000101000001}
`define FUNC_MULA        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000101001}
`define FUNC_MULAH       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000101100}
`define FUNC_MULAW       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000101010}
`define FUNC_MULS        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000110001}
`define FUNC_MULSW       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000110010}
`define FUNC_MULSH       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000110100}

//----------------------------------------------------------
//                      BJU Decoder
//----------------------------------------------------------
`define FUNC_JAL         {{`FUNC_WIDTH-12{1'b0}}, 12'b100100100001}
`define FUNC_JALR        {{`FUNC_WIDTH-12{1'b0}}, 12'b100000100010}
`define FUNC_BEQ         {{`FUNC_WIDTH-12{1'b0}}, 12'b000101000100}
`define FUNC_BNE         {{`FUNC_WIDTH-12{1'b0}}, 12'b000101001100}
`define FUNC_BLT         {{`FUNC_WIDTH-12{1'b0}}, 12'b000101010010}
`define FUNC_BGE         {{`FUNC_WIDTH-12{1'b0}}, 12'b000101011010}
`define FUNC_BLTU        {{`FUNC_WIDTH-12{1'b0}}, 12'b000101000010}
`define FUNC_BGEU        {{`FUNC_WIDTH-12{1'b0}}, 12'b000101001010}
`define FUNC_AUIPC       {{`FUNC_WIDTH-12{1'b0}}, 12'b100110000000}

//----------------------------------------------------------
//                      DIV Decoder
//----------------------------------------------------------
`define FUNC_DIV         {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000110}
`define FUNC_DIVU        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000010}
`define FUNC_DIVW        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000111}
`define FUNC_DIVUW       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000011}
`define FUNC_REM         {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000100}
`define FUNC_REMU        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000000}
`define FUNC_REMW        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000101}
`define FUNC_REMUW       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000000001}

//----------------------------------------------------------
//                IU 16 bits Full Decoder
//----------------------------------------------------------
`define FUNC_C_ADD       {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_C_ADDI      {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_C_ADDIW     {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_010001000001}
`define FUNC_C_ADDI4SPN  {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_C_ADDI16SP  {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_C_ADDW      {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_010001000001}
`define FUNC_C_AND       {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100100}
`define FUNC_C_ANDI      {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100100}
`define FUNC_C_LI        {{`FUNC_WIDTH-19{1'b0}}, 19'b1000001_010000000001}
`define FUNC_C_LUI       {{`FUNC_WIDTH-19{1'b0}}, 19'b0000011_010000000001}
`define FUNC_C_MV        {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_C_NOP       {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_010000000001}
`define FUNC_C_OR        {{`FUNC_WIDTH-12{1'b0}}, 12'b000010000100}
`define FUNC_C_SLLI      {{`FUNC_WIDTH-17{1'b0}}, 17'b10000_00000_0100010}
`define FUNC_C_SRAI      {{`FUNC_WIDTH-17{1'b0}}, 17'b01000_00001_0000010}
`define FUNC_C_SRLI      {{`FUNC_WIDTH-17{1'b0}}, 17'b11000_10000_0000010}
`define FUNC_C_SUB       {{`FUNC_WIDTH-19{1'b0}}, 19'b1100000_011000000001}
`define FUNC_C_SUBW      {{`FUNC_WIDTH-19{1'b0}}, 19'b0001000_011001000001}
`define FUNC_C_XOR       {{`FUNC_WIDTH-12{1'b0}}, 12'b000001000100}
`define FUNC_C_BEQZ      {{`FUNC_WIDTH-12{1'b0}}, 12'b000101000100}
`define FUNC_C_BNEZ      {{`FUNC_WIDTH-12{1'b0}}, 12'b000101001100}
`define FUNC_C_J         {{`FUNC_WIDTH-12{1'b0}}, 12'b000100100001}
`define FUNC_C_JALR      {{`FUNC_WIDTH-12{1'b0}}, 12'b100000100010}
`define FUNC_C_JR        {{`FUNC_WIDTH-12{1'b0}}, 12'b000000100010}

//----------------------------------------------------------
//                      CP0 Decoder 
//----------------------------------------------------------
`define FUNC_ECALL       {{`FUNC_WIDTH-10{1'b0}}, 10'b000001_0010}
`define FUNC_EBREAK      {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_0010}
`define FUNC_MRET        {{`FUNC_WIDTH-10{1'b0}}, 10'b000100_0010}
`define FUNC_SRET        {{`FUNC_WIDTH-10{1'b0}}, 10'b001000_0010}
`define FUNC_WFI         {{`FUNC_WIDTH-10{1'b0}}, 10'b010000_0010}
`define FUNC_DRET        {{`FUNC_WIDTH-10{1'b0}}, 10'b100000_0010}
`define FUNC_FENCE       {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_1000}
`define FUNC_FENCEI      {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_0100}
`define FUNC_SFENCE      {{`FUNC_WIDTH-10{1'b0}}, 10'b000100_0100}
`define FUNC_SYNC        {{`FUNC_WIDTH-10{1'b0}}, 10'b001000_0100}
`define FUNC_SYNCI       {{`FUNC_WIDTH-10{1'b0}}, 10'b010000_0100}
`define FUNC_CACHE       {{`FUNC_WIDTH-10{1'b0}}, 10'b100000_0100}
`define FUNC_VSETVL      {{`FUNC_WIDTH-10{1'b0}}, 10'b000001_1000}
`define FUNC_VSETVLI     {{`FUNC_WIDTH-10{1'b0}}, 10'b100001_1000}
`define FUNC_CSRRW       {{`FUNC_WIDTH-10{1'b0}}, 10'b000001_0001}
`define FUNC_CSRRS       {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_0001}
`define FUNC_CSRRC       {{`FUNC_WIDTH-10{1'b0}}, 10'b000100_0001}
`define FUNC_CSRRWI      {{`FUNC_WIDTH-10{1'b0}}, 10'b100001_0001}
`define FUNC_CSRRSI      {{`FUNC_WIDTH-10{1'b0}}, 10'b100010_0001}
`define FUNC_CSRRCI      {{`FUNC_WIDTH-10{1'b0}}, 10'b100100_0001}

`define FUNC_DCACHE_IALL       {{`FUNC_WIDTH-16{1'b0}}, 6'b00_01_01, 10'b100000_0100}
`define FUNC_DCACHE_CALL       {{`FUNC_WIDTH-16{1'b0}}, 6'b00_10_01, 10'b100000_0100}
`define FUNC_DCACHE_CIALL      {{`FUNC_WIDTH-16{1'b0}}, 6'b00_11_01, 10'b100000_0100}
`define FUNC_DCACHE_ISW        {{`FUNC_WIDTH-16{1'b0}}, 6'b01_01_01, 10'b100000_0100}
`define FUNC_DCACHE_CSW        {{`FUNC_WIDTH-16{1'b0}}, 6'b01_10_01, 10'b100000_0100}
`define FUNC_DCACHE_CISW       {{`FUNC_WIDTH-16{1'b0}}, 6'b01_11_01, 10'b100000_0100}
`define FUNC_ICACHE_IVA        {{`FUNC_WIDTH-16{1'b0}}, 6'b10_01_10, 10'b100000_0100}
`define FUNC_ICACHE_IPA        {{`FUNC_WIDTH-16{1'b0}}, 6'b11_01_10, 10'b100000_0100}
//----------------------------------------------------------
//                   LSU 16 Bits Decoder 
//----------------------------------------------------------
`define FUNC_C_FLD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1100}
`define FUNC_C_LW    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1010}
`define FUNC_C_LD    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1110}
`define FUNC_C_FSD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1101}
`define FUNC_C_SW    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1001}
`define FUNC_C_SD    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1101}
`define FUNC_C_FLDSP {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1100}
`define FUNC_C_LWSP  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1010}
`define FUNC_C_SWSP  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1001}
`define FUNC_C_FSDSP {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1101}
`define FUNC_C_SDSP  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1101}
`define FUNC_C_LDSP  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1110}

//----------------------------------------------------------
//                   LSU 32 Bits Decoder 
//----------------------------------------------------------
`define FUNC_LB    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0010}
`define FUNC_LH    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0110}
`define FUNC_LW    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1010}
`define FUNC_LD    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1110}
`define FUNC_LBU   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0000}
`define FUNC_LHU   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0100}
`define FUNC_LWU   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1000}
`define FUNC_FLH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_0100}
`define FUNC_FLW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1000}
`define FUNC_FLD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1100}
`define FUNC_SB    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0001}
`define FUNC_SH    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0101}
`define FUNC_SW    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1001}
`define FUNC_SD    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1101}
`define FUNC_FSH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_0101}
`define FUNC_FSW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1001}
`define FUNC_FSD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1101}
`define FUNC_LR_W  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1010}
`define FUNC_SC_W  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1001}
`define FUNC_LR_D  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1100}
`define FUNC_SC_D  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1101}

`define FUNC_AMO_W {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0011_1011}
`define FUNC_AMO_D {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0011_1111}

//----------------------------------------------------------
//                   LSU Vector Decoder 
//----------------------------------------------------------
`define FUNC_VLH   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0110}
`define FUNC_VLB   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0010}
`define FUNC_VLW   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1010}
`define FUNC_VLHU  {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0100}
`define FUNC_VLBU  {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0000}
`define FUNC_VLWU  {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1000}
`define FUNC_VLE   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1100}
`define FUNC_VLSB  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0010}
`define FUNC_VLSH  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0110}
`define FUNC_VLSW  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1010}
`define FUNC_VLSBU {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0000}
`define FUNC_VLSHU {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0100}
`define FUNC_VLSWU {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1000}
`define FUNC_VLSE  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1100}
`define FUNC_VLXB  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0010}
`define FUNC_VLXH  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0110}
`define FUNC_VLXW  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1010}
`define FUNC_VLXBU {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0000}
`define FUNC_VLXHU {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0100}
`define FUNC_VLXWU {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1000}
`define FUNC_VLXE  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1100}
`define FUNC_VSB   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0001}
`define FUNC_VSH   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0101}
`define FUNC_VSW   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1001}
`define FUNC_VSE   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1101}
`define FUNC_VSSB  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0001}
`define FUNC_VSSH  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0101}
`define FUNC_VSSW  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1001}
`define FUNC_VSSE  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1101}
`define FUNC_VSXB  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0001}
`define FUNC_VSXH  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0101}
`define FUNC_VXSW  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1001}
`define FUNC_VXSE  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1101}

`define FUNC_VLHFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0110}
`define FUNC_VLBFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0010}
`define FUNC_VLWFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_1010}
`define FUNC_VLHUFF {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0100}
`define FUNC_VLBUFF {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0000}
`define FUNC_VLWUFF {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_1000}
`define FUNC_VLEFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_1100}

`define FUNC_ZVAMO  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0011_0011}
//----------------------------------------------------------
//                   LSU Dcache Decoder 
//----------------------------------------------------------
`define FUNC_DCACHE_IVA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_0010}
`define FUNC_DCACHE_CVA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_0100}
`define FUNC_DCACHE_CVAL1  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0101_0100}
`define FUNC_DCACHE_CIVA   {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_0110}
`define FUNC_DCACHE_IPA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_1010}
`define FUNC_DCACHE_CPA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_1100}
`define FUNC_DCACHE_CPAL1  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0101_1100}
`define FUNC_DCACHE_CIPA   {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_1110}

//----------------------------------------------------------
//                   LSU Performance  Decoder 
//----------------------------------------------------------
`define FUNC_LRB   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0010}
`define FUNC_LRH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0110}
`define FUNC_LRW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1010}
`define FUNC_LRD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1110}
`define FUNC_LRBU  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0000}
`define FUNC_LRHU  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0100}
`define FUNC_LRWU  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1000}
`define FUNC_LURB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0010}
`define FUNC_LURH  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0110}
`define FUNC_LURW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1010}
`define FUNC_LURD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1110}
`define FUNC_LURBU {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0000}
`define FUNC_LURHU {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0100}
`define FUNC_LURWU {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1000}
`define FUNC_LBIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0010}
`define FUNC_LBIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0010}
`define FUNC_LHIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0110}
`define FUNC_LHIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0110}
`define FUNC_LWIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1010}
`define FUNC_LWIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1010}
`define FUNC_LDIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1110}
`define FUNC_LDIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1110}
`define FUNC_LBUIB {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0000}
`define FUNC_LBUIA {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0000}
`define FUNC_LHUIB {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0100}
`define FUNC_LHUIA {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0100}
`define FUNC_LWUIB {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1000}
`define FUNC_LWUIA {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1000}
`define FUNC_LDIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1110}
`define FUNC_LDIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1110}
`define FUNC_SRB   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0011}
`define FUNC_SRH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0111}
`define FUNC_SRW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1011}
`define FUNC_SRD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1111}
`define FUNC_SURB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0011}
`define FUNC_SURH  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0111}
`define FUNC_SURW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1011}
`define FUNC_SURD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1111}
`define FUNC_FLRW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1010}
`define FUNC_FLRD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1110}
`define FUNC_FLURW {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1010}
`define FUNC_FLURD {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1110}
`define FUNC_FSRW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1011}
`define FUNC_FSRD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1111}
`define FUNC_FSURW {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1011}
`define FUNC_FSURD {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1111}
`define FUNC_SBIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0011}
`define FUNC_SBIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0011}
`define FUNC_SHIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0111}
`define FUNC_SHIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0111}
`define FUNC_SWIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1011}
`define FUNC_SWIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1011}
`define FUNC_SDIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1111}
`define FUNC_SDIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1111}

//----------------------------------------------------------
//VFDSU Func
//  19       18      17       16                                         10
//+-------+------+--------+--------+---------------------------------------+
//|  SIMD | HALF | SINGLE | DOUBLE |        RESERVED                       |
//+-------+------+--------+--------+---------------------------------------+

// 9                                                          1       0
//+--------------------------------------------------------+-------+-------+
//|                  RESERVED                              | FSQRT |  DIV  |
//+--------------------------------------------------------+-------+-------+
// Just Use Simple onehot
// Half
`define FUNC_FDIVH  20'b0000_0001_0000_0000_00_01
`define FUNC_FSQRTH 20'b0000_0001_0000_0000_00_10
// Single
`define FUNC_FDIVS  20'b0000_0010_0000_0000_00_01
`define FUNC_FSQRTS 20'b0000_1010_0000_0000_00_10
// Double
`define FUNC_FDIVD  20'b0000_0011_0000000000_01
`define FUNC_FSQRTD 20'b0000_0011_0000000000_10

`define FUNC_VFDIV  20'b0000_0000_1000000000_01
`define FUNC_VFSQRT 20'b0000_0000_1000000000_10
//  Just use simple Onehot
//  19       17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   |   |SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv | clas |
//+------+------+-----+--+--------+------+------+-------+-----------------+

//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|             |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+

`define FUNC_VFSGNJ         20'b0000_0000_1000_0100_0001
`define FUNC_VFSGNJX        20'b0000_0000_1000_0100_0100
`define FUNC_VFSGNJN        20'b0000_0000_1000_0100_0010
`define FUNC_VFCLASS        20'b0000_0000_1000_1000_0000
`define FUNC_VFMERG         20'b0000_0000_1000_0010_0010
`define FUNC_VFMVSF         20'b0000_0000_1000_0010_1000
`define FUNC_VFMVFS         20'b0000_0000_1000_0011_0000


//convert
// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+
`define FUNC_VFCVTXUF        20'b0000_0000_1000_0001_1001
`define FUNC_VFCVTXF         20'b0000_0000_1000_0001_1000
`define FUNC_VFCVTFXU        20'b0000_0000_1000_0001_0110
`define FUNC_VFCVTFX         20'b0000_0000_1000_0001_0010
`define FUNC_VFWCVTXUF       20'b0000_0000_1000_0100_1001
`define FUNC_VFWCVTXF        20'b0000_0000_1000_0100_1000
`define FUNC_VFWCVTFXU       20'b0000_0000_1000_0100_0110
`define FUNC_VFWCVTFX        20'b0000_0000_1000_0100_0010
`define FUNC_VFWCVTFF        20'b0000_0000_1000_0100_1010
`define FUNC_VFNCVTXUF       20'b0000_0000_1000_0010_1001
`define FUNC_VFNCVTXF        20'b0000_0000_1000_0010_1000
`define FUNC_VFNCVTFXU       20'b0000_0000_1000_0010_0110
`define FUNC_VFNCVTFX        20'b0000_0000_1000_0010_0010
`define FUNC_VFNCVTFF        20'b0000_0000_1000_0010_1010


//VFADD
//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
//+------+------+-----+--+--------+------+------+-------+-----------------+

//convert
//  10                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |             fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+

//  12                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| add |      |                         |      |   red | order |
//+------+------+-----+--+--------+------+------+-------+-------+
//add and sub
//  a                                       11      10       9
//+------+------+-----+--+--------+------+------+-------+-------+
//|                           fmt   fmt  |scalar | reduc | unord |
//+------+------+-----+--+--------+------+------+-------+-------+

//   8      7           5     4      3      2        1       0
//+------+------+-----+----+------+------+------+-------+-------+
//|rever | add  |      max | add  |      |      | src1_w|       |
//+------+------+-----+----+------+------+------+-------+-------+


//   8      7           5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|rever | add/s |           add  | sub  | dst_w| src1_w|  f    |
//+------+------+-----+--+--------+------+------+-------+-------+
`define FUNC_VFADD        20'b0000_0000_1000_1001_0000
`define FUNC_VFSUB        20'b0000_0000_1000_1000_1000
`define FUNC_VFWADD       20'b0000_0000_1000_1001_0100
`define FUNC_VFWSUB       20'b0000_0000_1000_1000_1100
`define FUNC_VFWADDW      20'b0000_0000_1000_1001_0010
`define FUNC_VFWSUBW      20'b0000_0000_1000_1000_1010
`define FUNC_VFMIN        20'b0000_0000_1000_0010_1000
`define FUNC_VFMAX        20'b0000_0000_1000_0011_0000
`define FUNC_VFEQ         20'b0000_0000_1000_0100_0001
`define FUNC_VFNE         20'b0000_0000_1000_0101_0000
`define FUNC_VFLT         20'b0000_0000_1000_0100_0010
`define FUNC_VFLE         20'b0000_0000_1000_0100_0100
`define FUNC_VFORD        20'b0000_0000_1000_0100_1000
`define FUNC_VFREDSUM     20'b0000_0000_1110_1001_0000
`define FUNC_VFREDSUM64   20'b0000_0000_1100_1001_0000
`define FUNC_VFOREDSUM    20'b0000_0000_1100_1001_0000
`define FUNC_VFWREDSUM    20'b0000_0000_1100_1001_0010
`define FUNC_VFWREDSUM64  20'b0000_0000_1100_1001_0010
`define FUNC_VFWOREDSUM   20'b0000_0000_1100_1001_0010
`define FUNC_VFREDMAX     20'b0000_0000_1110_0011_0000
`define FUNC_VFREDMAX64   20'b0000_0000_1100_0011_0000
`define FUNC_VFREDMIN     20'b0000_0000_1110_0010_1000
`define FUNC_VFREDMIN64   20'b0000_0000_1100_0010_1000

//Single
//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
//+------+------+-----+--+--------+------+------+-------+-----------------+

//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|             |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+
//half
`define FUNC_FMV_SI16_F16 20'b0000_0001_0000_0010_0100
`define FUNC_FMV_F16_SI16 20'b0000_0001_0000_0010_0001
`define FUNC_FSGNJH       20'b0000_0001_0000_0100_0001
`define FUNC_FSGNJNH      20'b0000_0001_0000_0100_0010
`define FUNC_FSGNJXH      20'b0000_0001_0000_0100_0100
`define FUNC_FCLASSH      20'b0100_0001_0000_1000_0000
//single
`define FUNC_FMV_SI32_F32 20'b0000_0010_0000_0010_0100
`define FUNC_FMV_F32_SI32 20'b0000_0010_0000_0010_0001
`define FUNC_FSGNJS       20'b0000_0010_0000_0100_0001
`define FUNC_FSGNJNS      20'b0000_0010_0000_0100_0010
`define FUNC_FSGNJXS      20'b0000_0010_0000_0100_0100
`define FUNC_FCLASSS      20'b0100_0010_0000_1000_0000

//Double
`define FUNC_FMV_SI64_F64 20'b0000_0011_0000_0010_0100
`define FUNC_FMV_F64_SI64 20'b0000_0011_0000_0010_0001
`define FUNC_FSGNJD       20'b0000_0011_0000_0100_0001
`define FUNC_FSGNJND      20'b0000_0011_0000_0100_0010
`define FUNC_FSGNJXD      20'b0000_0011_0000_0100_0100
`define FUNC_FCLASSD      20'b0100_0011_0000_1000_0000

//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
//+------+------+-----+--+--------+------+------+-------+-----------------+
//convert
//  10                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |             fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+

//  12                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| add |      |                         |      |   red | order |
//+------+------+-----+--+--------+------+------+-------+-------+
//half 
`define FUNC_FADDH 20'b0000_0001_0000_1001_0000     
`define FUNC_FSUBH 20'b0000_0001_0000_1000_1000
              
`define FUNC_FMAXH 20'b0000_0001_0000_0011_0000
`define FUNC_FMINH 20'b0000_0001_0000_0010_1000
              
`define FUNC_FEQH  20'b0000_0001_0000_0100_0001
`define FUNC_FLTH  20'b0000_0001_0000_0100_0010
`define FUNC_FLEH  20'b0000_0001_0000_0100_0100

//Single
`define FUNC_FADDS 20'b0000_0010_0000_1001_0000     
`define FUNC_FSUBS 20'b0000_0010_0000_1000_1000
              
`define FUNC_FMAXS 20'b0000_0010_0000_0011_0000
`define FUNC_FMINS 20'b0000_0010_0000_0010_1000
              
`define FUNC_FEQS  20'b0000_0010_0000_0100_0001
`define FUNC_FLTS  20'b0000_0010_0000_0100_0010
`define FUNC_FLES  20'b0000_0010_0000_0100_0100
              
//Double      
`define FUNC_FADDD 20'b0000_0011_0000_1001_0000     
`define FUNC_FSUBD 20'b0000_0011_0000_1000_1000
              
`define FUNC_FMAXD 20'b0000_0011_0000_0011_0000
`define FUNC_FMIND 20'b0000_0011_0000_0010_1000
              
`define FUNC_FEQD  20'b0000_0011_0000_0100_0001
`define FUNC_FLTD  20'b0000_0011_0000_0100_0010
`define FUNC_FLED  20'b0000_0011_0000_0100_0100



//Scalar FCNVT Func
//  19       18      17       16                                         10
//+-------+------+--------+--------+---------------------------------------+
//|  SIMD | HALF | SINGLE | DOUBLE |        RESERVED                       |
//+-------+------+--------+--------+---------------------------------------+

//    9                                  5     4      3     2     1     0
//+----------------------------------+------+------+-----+-----+-----+-----+
//|  ITOF |      RESERVED            |   D  |  S   | LU  |  L  |  WU |  W  |
//+----------------------------------+------+------+-----+-----+-----+-----+
//ITOF: 1: covert integer to floating-point
//      0: covert floating-point to intege
//
//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
//+------+------+-----+--+--------+------+------+-------+-----------------+
//convert
// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+
`define FUNC_FCVT_SI16_F16  20'b0000_0001_0000_0001_1000
`define FUNC_FCVT_UI16_F16  20'b0000_0001_0000_0001_1001
`define FUNC_FCVT_SI32_F16  20'b0000_0001_0000_0100_1000
`define FUNC_FCVT_UI32_F16  20'b0000_0001_0000_0100_1001
`define FUNC_FCVT_F16_SI16  20'b0000_0001_0000_0001_0010
`define FUNC_FCVT_F16_UI16  20'b0000_0001_0000_0001_0110
`define FUNC_FCVT_F16_SI32  20'b0000_0001_0000_0010_0010
`define FUNC_FCVT_F16_UI32  20'b0000_0001_0000_0010_0110
`define FUNC_FCVT_F16_F32   20'b0000_0001_0000_0010_1010
`define FUNC_FCVT_F32_F16   20'b0000_0001_0000_0100_1010

`define FUNC_FCVT_SI64_F16  20'b0000_0101_0001_0000_1000
`define FUNC_FCVT_UI64_F16  20'b0000_0101_0001_0000_1001
`define FUNC_FCVT_F16_SI64  20'b0000_0101_0000_1000_0010
`define FUNC_FCVT_F16_UI64  20'b0000_0101_0000_1000_0110
`define FUNC_FCVT_F16_F64   20'b0000_0101_0000_1000_1010
`define FUNC_FCVT_F64_F16   20'b0000_0101_0001_0000_1010
//single
`define FUNC_FCVT_SI32_F32  20'b0000_0110_0000_1001_1000
`define FUNC_FCVT_UI32_F32  20'b0000_0110_0000_1001_1001
`define FUNC_FCVT_SI64_F32  20'b0000_0110_0000_0100_1000
`define FUNC_FCVT_UI64_F32  20'b0000_0110_0000_0100_1001
`define FUNC_FCVT_F32_SI32  20'b0000_0110_0000_0001_0010
`define FUNC_FCVT_F32_UI32  20'b0000_0110_0000_0001_0110
`define FUNC_FCVT_F32_SI64  20'b0000_0110_0000_0010_0010
`define FUNC_FCVT_F32_UI64  20'b0000_0110_0000_0010_0110

//Double
`define FUNC_FCVT_SI32_F64  20'b0000_0010_0000_0010_1000
`define FUNC_FCVT_UI32_F64  20'b0000_0010_0000_0010_1001
`define FUNC_FCVT_SI64_F64  20'b0000_0011_0000_0001_1000
`define FUNC_FCVT_UI64_F64  20'b0000_0011_0000_0001_1001
`define FUNC_FCVT_F64_SI32  20'b0000_0010_0000_0100_0010
`define FUNC_FCVT_F64_UI32  20'b0000_0010_0000_0100_0110
`define FUNC_FCVT_F64_SI64  20'b0000_0011_0000_0001_0010
`define FUNC_FCVT_F64_UI64  20'b0000_0011_0000_0001_0110
`define FUNC_FCVT_F32_F64   20'b0000_0010_0000_0010_1010
`define FUNC_FCVT_F64_F32   20'b0000_0010_0000_0100_1010

//VFMAU
//  19       18      17       16                                         10
//+-------+------+--------+--------+---------------------------------------+
//|  SIMD | HALF | SINGLE | DOUBLE |        RESERVED                       |
//+-------+------+--------+--------+---------------------------------------+

// 9                                 4        3        2       1       0
//+-----------------------------+--------+---------+-------+-------+-------+
//|                  RESERVED   | CHANGE |  WIDEN  |  NEG  |  SUB  | FUSED |
//+-----------------------------+--------+---------+-------+-------+-------+

//VFMAU  scalar
//1. single
`define FUNC_FMULS    20'b0000000000000010_0_000
                                      
`define FUNC_FMADDS   20'b0000000000000010_0_001
`define FUNC_FMSUBS   20'b0000000000000010_0_011
`define FUNC_FNMSUBS  20'b0000000000000010_0_111
`define FUNC_FNMADDS  20'b0000000000000010_0_101
                                      
//2. double                           
`define FUNC_FMULD    20'b0000000000000100_0_000
                                      
`define FUNC_FMADDD   20'b0000000000000100_0_001
`define FUNC_FMSUBD   20'b0000000000000100_0_011
`define FUNC_FNMSUBD  20'b0000000000000100_0_111
`define FUNC_FNMADDD  20'b0000000000000100_0_101
                                      
//3. half                             
`define FUNC_FMULH    20'b0000000000000001_0_000
                                      
`define FUNC_FMADDH   20'b0000000000000001_0_001
`define FUNC_FMSUBH   20'b0000000000000001_0_011
`define FUNC_FNMSUBH  20'b0000000000000001_0_111
`define FUNC_FNMADDH  20'b0000000000000001_0_101
                                      
//VFMAU simd                          
`define FUNC_VFMUL    20'b0000000010000000_0_000
`define FUNC_VFWMUL   20'b0000000010000000_1_000
                                       
`define FUNC_VFMACC   20'b0000000010000000_0_001
`define FUNC_VFNMACC  20'b0000000010000000_0_101
`define FUNC_VFMSAC   20'b0000000010000000_0_011
`define FUNC_VFNMSAC  20'b0000000010000000_0_111
`define FUNC_VFMADD   20'b0000000010010000_0_001
`define FUNC_VFNMADD  20'b0000000010010000_0_101
`define FUNC_VFMSUB   20'b0000000010010000_0_011
`define FUNC_VFNMSUB  20'b0000000010010000_0_111
                                       
`define FUNC_VFWMACC  20'b0000000010000000_1_001
`define FUNC_VFWNMACC 20'b0000000010000000_1_101
`define FUNC_VFWMSAC  20'b0000000010000000_1_011
`define FUNC_VFWNMSAC 20'b0000000010000000_1_111

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//| VMV  | VMAX | DSTW |SRC2W |      | CMP  | ADD  | C_IN |C_OUT | SIGN |ROUND | SAT  |
//-------------------------------------------------------------------------------------
`define FUNC_VADD    20'b0000_0000_0000_0010_0000
`define FUNC_VSUB    20'b0000_0000_0000_0000_0000
`define FUNC_VRSUB   20'b0000_0000_0000_0000_0000
`define FUNC_VWADDU  20'b0000_0000_0011_1010_0000
`define FUNC_VWADD   20'b0000_0000_0011_1010_0100
`define FUNC_VWSUBU  20'b0000_0000_0011_1000_0000
`define FUNC_VWSUB   20'b0000_0000_0011_1000_0100
`define FUNC_VWADDUW 20'b0000_0000_0011_0010_0000
`define FUNC_VWADDW  20'b0000_0000_0011_0010_0100
`define FUNC_VWSUBUW 20'b0000_0000_0010_1000_0000
`define FUNC_VWSUBW  20'b0000_0000_0010_1000_0100
`define FUNC_VADC    20'b0000_0000_0000_0011_0000
`define FUNC_VMADC   20'b0000_0000_0000_0011_1000
`define FUNC_VSBC    20'b0000_0000_0000_0001_0000
`define FUNC_VMSBC   20'b0000_0000_0000_0001_1000
`define FUNC_VAADD   20'b0000_0000_0000_0010_0110
`define FUNC_VASUB   20'b0000_0000_0000_0000_0110
`define FUNC_VSADDU  20'b0000_0000_0000_0010_0001
`define FUNC_VSADD   20'b0000_0000_0000_0010_0101
`define FUNC_VSSUBU  20'b0000_0000_0000_0000_0001
`define FUNC_VSSUB   20'b0000_0000_0000_0000_0101

`define FUNC_VMSEQ   20'b0000_0000_0000_0100_1100
`define FUNC_VMSNE   20'b0000_0000_0000_0100_0100
`define FUNC_VMSLTU  20'b0000_0000_0000_0101_0000
`define FUNC_VMSLT   20'b0000_0000_0000_0101_0100
`define FUNC_VMSLEU  20'b0000_0000_0000_0101_1000
`define FUNC_VMSLE   20'b0000_0000_0000_0101_1100
`define FUNC_VMSGTU  20'b0000_0000_0000_0101_0000
`define FUNC_VMSGT   20'b0000_0000_0000_0101_0100

`define FUNC_VMINU   20'b0000_0000_0100_0110_0000
`define FUNC_VMIN    20'b0000_0000_0100_0110_0100
`define FUNC_VMAXU   20'b0000_0000_0000_0110_0000
`define FUNC_VMAX    20'b0000_0000_0000_0110_0100

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |      | SLUP |SLDOWN|STRID1|GATHER|VIOTA |      | VEXT |
//-------------------------------------------------------------------------------------
`define FUNC_VMV         20'b0000_0000_0000_0010_0100 
`define FUNC_VEXT        20'b0000_0000_0000_0000_0001
`define FUNC_VSLIDEUP    20'b0000_0000_0000_0100_1000
`define FUNC_VSLIDEDOWN  20'b0000_0000_1000_0010_1000
`define FUNC_VSLIDE1UP   20'b0000_0000_0000_0101_0000
`define FUNC_VSLIDE1DOWN 20'b0000_0000_0000_0011_0000
`define FUNC_VRGATHERVV  20'b0000_0000_0000_0000_0010
`define FUNC_VRGATHERVK  20'b0000_0000_1100_0000_0010
`define FUNC_VCOMPRESS   20'b0000_0000_0000_0000_0100
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//| VMV  | VMG  | XOR  |  OR  | AND  |      |      |      |      |LOGIC |      |      |
//-------------------------------------------------------------------------------------
`define FUNC_VAND    20'b0000_0000_0000_1000_0100               
`define FUNC_VORR    20'b0000_0000_0001_0000_0100               
`define FUNC_VXOR    20'b0000_0000_0010_0000_0100               
`define FUNC_VMGE    20'b0000_0000_0100_0000_0100               
`define FUNC_VMOV    20'b0000_0000_1000_0000_0100               
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//| NOTB | NOTA | XOR  |  OR  | AND  | AND  |      |      | MLG  |      |      |      |
//-------------------------------------------------------------------------------------
`define FUNC_VMAND    20'b0000_0000_0000_1000_1000               
`define FUNC_VMNAND   20'b0000_0000_0100_1000_1000               
`define FUNC_VMANDN   20'b0000_0000_1000_1000_1000               
`define FUNC_VMXOR    20'b0000_0000_0010_0000_1000               
`define FUNC_VMNXOR   20'b0000_0000_0110_0000_1000               
`define FUNC_VMORR    20'b0000_0000_0001_0000_1000               
`define FUNC_VMNORR   20'b0000_0000_0101_0000_1000               
`define FUNC_VMORRN   20'b0000_0000_1001_0000_1000               
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |MUNARY|FIRST | POPC | MSK  |      |      |      |      |
//-------------------------------------------------------------------------------------
`define FUNC_VMPOP    20'b0000_0000_0000_0011_0000               
`define FUNC_VMFIRST  20'b0000_0000_0000_0101_0000               
`define FUNC_VMUNARY0 20'b0000_0000_0000_1001_0000      
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|WIDEN | SIGN | MIN  | MAX  | SUM  | XOR  |  OR  | AND  |LOGIC |      |      |      |
//-------------------------------------------------------------------------------------
`define FUNC_VREDAND    20'b0000_0000_0000_0001_1000
`define FUNC_VREDORR    20'b0000_0000_0000_0010_1000
`define FUNC_VREDXOR    20'b0000_0000_0000_0100_1000
`define FUNC_VREDSUM    20'b0000_0000_0000_1000_0000
`define FUNC_VREDMAXU   20'b0000_0000_0001_0000_0000
`define FUNC_VREDMAX    20'b0000_0000_0101_0000_0000
`define FUNC_VREDMINU   20'b0000_0000_0010_0000_0000
`define FUNC_VREDMIN    20'b0000_0000_0110_0000_0000
`define FUNC_VWREDSUMU  20'b0000_0000_1000_1000_0000
`define FUNC_VWREDSUM   20'b0000_0000_1100_1000_0000

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |      |      |      |      |ARITH |NARROW|ROUND | LEFT |
//-------------------------------------------------------------------------------------
`define FUNC_VSLL       20'b0000_0000_0000_0000_0001
`define FUNC_VSRL       20'b0000_0000_0000_0000_0000
`define FUNC_VSRA       20'b0000_0000_0000_0000_1000
`define FUNC_VSSRL      20'b0000_0000_0000_0000_0100
`define FUNC_VSSRA      20'b0000_0000_0000_0000_1100
`define FUNC_VNSRL      20'b0000_0000_0000_0000_0010
`define FUNC_VNSRA      20'b0000_0000_0000_0000_1010
`define FUNC_VNCLIPU    20'b0000_0000_0000_0000_0110
`define FUNC_VNCLIP     20'b0000_0000_0000_0000_1110

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|SEW/2 |SEW-1 |RECUR | SUB  | ACC  | SAT  |ROUND | WIDE | LOW  | HIGH |SIGN1 |SIGN0 |
//-------------------------------------------------------------------------------------
`define FUNC_VMUL       20'b0000_0000_0000_0000_1000
`define FUNC_VMULH      20'b0000_0000_0000_0000_0111
`define FUNC_VMULHU     20'b0000_0000_0000_0000_0100
`define FUNC_VMULHSU    20'b0000_0000_0000_0000_0101
`define FUNC_VMACC      20'b0000_0000_0000_1000_1000
`define FUNC_VNMSAC     20'b0000_0000_0001_1000_1000
`define FUNC_VMADD      20'b0000_0000_0010_1000_1000
`define FUNC_VNMSUB     20'b0000_0000_0011_1000_1000
`define FUNC_VSMUL      20'b0000_0000_0100_0110_0111
`define FUNC_VWMUL      20'b0000_0000_0000_0001_0011
`define FUNC_VWMULU     20'b0000_0000_0000_0001_0000
`define FUNC_VWMULSU    20'b0000_0000_0000_0001_0001
`define FUNC_VWMACCU    20'b0000_0000_0000_1001_0000
`define FUNC_VWMACC     20'b0000_0000_0000_1001_0011
`define FUNC_VWMACCSU   20'b0000_0000_0000_1001_0010
`define FUNC_VWMACCUS   20'b0000_0000_0000_1001_0001
`define FUNC_VWSMACCU   20'b0000_0000_1000_1111_0000
`define FUNC_VWSMACC    20'b0000_0000_1000_1111_0011
`define FUNC_VWSMACCSU  20'b0000_0000_1001_1111_0010
`define FUNC_VWSMACCUS  20'b0000_0000_1001_1111_0001

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |      | SIGN | REM  | DIV  |      |      |      |      |
//-------------------------------------------------------------------------------------
`define FUNC_VDIVU  20'b0000_0000_0000_0001_0000
`define FUNC_VDIV   20'b0000_0000_0000_0101_0000
`define FUNC_VREMU  20'b0000_0000_0000_0010_0000
`define FUNC_VREM   20'b0000_0000_0000_0110_0000

