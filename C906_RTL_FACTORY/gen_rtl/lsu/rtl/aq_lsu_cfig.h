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
`define LSU_LD_REG_0    0
`define LSU_LD_REG_5    5
`define LSU_LD_FLS      6
`define LSU_LD_VLS      7
`define LSU_LD_SLAST    8
`define LSU_LD_SPLIT    9
`define LSU_LD_BYTE_0   10

`ifdef DPLEN_128
  `define LSU_LD_BYTE_15    25
  `define LSU_LD_SEXT       26
  `define LSU_LD_ADDR_3     27
  `define LSU_LD_WB_EN      28
  `define LSU_LD_SIZE_0     29
  `define LSU_LD_SIZE_1     30
  `define LSU_LD_PTW        31
  `define LSU_LD_LOCK       32
  `define LSU_LD_SHIFT_0    33
  `define LSU_LD_SHIFT_3    36
  `define LSU_LD_STB_ID_0   37 
  `define LSU_LD_STB_ID_1   38 
  `define LSU_LD_AMO_INST   39 
  `define LSU_LD_AMO_FUNC_0 40 
  `define LSU_LD_AMO_FUNC_4 44 
  `define LSU_LD_WIDTH      45 
  
  `define LSU_DATAW       128 
  `define LSU_BYTEW       16 

  `define LSU_VM_FFLEN    32 
  `define VLSU_BLKW       32 
`else//DPLEN_64
    //LFB LDBUS
  `define LSU_LD_BYTE_7   17
  `define LSU_LD_SEXT     18
  `define LSU_LD_ADDR_3   19
  `define LSU_LD_WB_EN    20
  `define LSU_LD_SIZE_0   21
  `define LSU_LD_SIZE_1   22
  `define LSU_LD_PTW      23
  `define LSU_LD_LOCK     24
  `define LSU_LD_SHIFT_0  25
  `define LSU_LD_SHIFT_3  28
  `define LSU_LD_STB_ID_0   29
  `define LSU_LD_STB_ID_1   30 
  `define LSU_LD_AMO_INST   31 
  `define LSU_LD_AMO_FUNC_0 32 
  `define LSU_LD_AMO_FUNC_4 36
  `define LSU_LD_WIDTH      37
  
  `define LSU_DATAW       64 
  `define LSU_BYTEW       8 
  
  `define LSU_VM_FFLEN    16 
  `define VLSU_BLKW       16 
`endif
