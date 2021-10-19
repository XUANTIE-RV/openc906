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


























`define REVISION    4'd2
`define SUB_VERSION 6'd1
`define PATCH       6'd7




`define PRODUCT_ID 12'h000




`define FPGA





















































`define DFT_AT_SPEED







`define JTLB_ENTRY_128






`define PMP

`ifdef PMP
`define PMP_REGION_8

`endif







`define BHT_16K






`define ICACHE_32K







`define DCACHE_32K

















`define FPU











`define HPCP

`ifdef HPCP
  //`define HPCP_CNT_NUM_4
  `define HPCP_CNT_NUM_8
  //`define HPCP_CNT_NUM_16
  //`define HPCP_CNT_NUM_29
`endif  





`define PLIC
`ifdef PLIC
  `define PLIC_INT_NUM   240   //NOTE: step of 32, min value:16; max value:1008
  `define PLIC_ID_NUM    10    //NOTE: it means the length of int number:128=7,256=8,BUT 
                               //      in order eliminate the lint err ,we FIX it to 10 
  `define PLIC_PRIO_BIT  5     //NOTE: Priority level bits, depends on timing
  `define MAX_HART_NUM   32    //NOTE: the hart number cannot be larger than MAX_HART_NUM
                               //      unless you changge this parameter, but it may affect
                               //      the maximum frequency                  
`endif




`define THEAD_IP








`define TDT_DM_SBA


`ifdef TDT_DM_SBA
  `define TDT_DM_SBA_AXI

`endif





`define TDT_DM_PB_EN




`ifdef TDT_DM_PB_EN
  `define TDT_DM_IEBREAK                  
  `define TDT_DM_PB_SIZE                    4
`endif















`define TDT_DM_NEXTDM_BA                    32'h00000000








`define TDT_TM_MCONTROL_TRI_NUM_8



`define TDT_TM_OTHER_TRI_NUM_2




`define TDT_DEBUG_PCFIFO


`ifdef TDT_DEBUG_PCFIFO
  //`define TDT_DEBUG_PCFIFO_8_ENTRY
  `define TDT_DEBUG_PCFIFO_16_ENTRY
`endif




`define TDT_DEBUG_INFO





`define TDT_SYSAPB_ASYNC_CLK










`define PROCESSOR_0

`define MULTI_PROCESSING

`ifdef MULTI_PROCESSING




`endif


`ifdef HPCP_CNT_NUM_4
  `define HPCP_CNT_GROUP0
`endif 

`ifdef HPCP_CNT_NUM_8
  `define HPCP_CNT_GROUP0
  `define HPCP_CNT_GROUP1
`endif 

`ifdef HPCP_CNT_NUM_16
  `define HPCP_CNT_GROUP0
  `define HPCP_CNT_GROUP1
  `define HPCP_CNT_GROUP2
`endif 


`ifdef HPCP_CNT_NUM_29
  `define HPCP_CNT_GROUP0 
  `define HPCP_CNT_GROUP1 
  `define HPCP_CNT_GROUP2 
  `define HPCP_CNT_GROUP3 
`endif












`ifdef BHT_2K
  `define BHT_INDEX_WIDTH 7
`endif

`ifdef BHT_4K
  `define BHT_INDEX_WIDTH 8
`endif

`ifdef BHT_8K
  `define BHT_INDEX_WIDTH 9
`endif

`ifdef BHT_16K
  `define BHT_INDEX_WIDTH 10
`endif





`ifdef ICACHE_8K
  `define I_TAG_INDEX_WIDTH 6
  `define I_DATA_INDEX_WIDTH 9
`endif

`ifdef ICACHE_16K
  `define I_TAG_INDEX_WIDTH 7
  `define I_DATA_INDEX_WIDTH 10
`endif

`ifdef ICACHE_32K
  `define I_TAG_INDEX_WIDTH 8
  `define I_DATA_INDEX_WIDTH 11
`endif

`ifdef ICACHE_64K
  `define I_TAG_INDEX_WIDTH 9
  `define I_DATA_INDEX_WIDTH 12
`endif





`ifdef DCACHE_8K
  `define D_TAG_INDEX_WIDTH 5
  `define D_TAG_TAG_WIDTH   29
  `define D_DATA_INDEX_WIDTH 8
`endif

`ifdef DCACHE_16K
  `define D_TAG_INDEX_WIDTH 6
  `define D_TAG_TAG_WIDTH   28
  `define D_DATA_INDEX_WIDTH 9
`endif

`ifdef DCACHE_32K
  `define D_TAG_INDEX_WIDTH 6
  `define D_TAG_TAG_WIDTH   28
  `define D_DATA_INDEX_WIDTH 10
`endif

`ifdef DCACHE_64K
  `define D_TAG_INDEX_WIDTH 6
  `define D_TAG_TAG_WIDTH   28
  `define D_DATA_INDEX_WIDTH 11
`endif





`ifdef PROCESSOR_3
  `define PLIC_HART_NUM  5'h4
`else
  `ifdef PROCESSOR_2
    `define PLIC_HART_NUM  5'h3
  `else
    `ifdef PROCESSOR_1
      `define PLIC_HART_NUM  5'h2
    `else
      `ifdef PROCESSOR_0
          `define PLIC_HART_NUM  5'h1
      `endif
    `endif
  `endif
`endif









`define PA_WIDTH 40
`define VA_WIDTH 39





`define INDEPENDENT_AXI_SLAVE_ENV





`define TDT_DM_CORE_RV64

`define TDT_DM_CORE_NSCRATCH            4'h2






`ifdef TDT_DM_SBA
    `define TDT_DM_SBA_DW_128
    //`define TDT_DM_SBA_DW_64
    //`define TDT_DM_SBA_DW_32
    `ifdef TDT_DM_SBA_AHB
        `define TDT_DM_SBAW                   `PA_WIDTH
    `else
        `define TDT_DM_SBAW                   `PA_WIDTH
    `endif
`endif




`ifdef TDT_TM_MCONTROL_TRI_NUM_0
  `define TDT_TM_MCONTROL_TRI_NUM         0
`else
  `ifdef TDT_TM_MCONTROL_TRI_NUM_2
     `define TDT_TM_MCONTROL_TRI_NUM 2
   `else
     `ifdef TDT_TM_MCONTROL_TRI_NUM_4
       `define TDT_TM_MCONTROL_TRI_NUM    4
     `else
        `ifdef TDT_TM_MCONTROL_TRI_NUM_8
          `define TDT_TM_MCONTROL_TRI_NUM 8
        `endif
     `endif
   `endif
`endif

`ifdef TDT_TM_OTHER_TRI_NUM_0
  `define TDT_TM_OTHER_TRI_NUM            0
`else
   `ifdef TDT_TM_OTHER_TRI_NUM_2
       `define TDT_TM_OTHER_TRI_NUM       2
    `endif
`endif
