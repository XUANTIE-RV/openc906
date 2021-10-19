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

`ifdef TDT_DM_EXT_TRIGGER_EN
  `define TDT_DM_GROUP_TRI_EN
`else
  `ifdef PROCESSOR_3
    `define TDT_DM_GROUP_TRI_EN
  `else 
    `ifdef PROCESSOR_2
      `define TDT_DM_GROUP_TRI_EN
    `else
      `ifdef PROCESSOR_1
        `define TDT_DM_GROUP_TRI_EN
      `endif
    `endif
  `endif  
`endif

`ifdef TDT_DM_EXT_TRIGGER_EN
  `ifdef TDT_DM_EXTHALTTRI_4
    `define TDT_DM_EXTHALTTRI_NUM 4
  `endif
  `ifdef TDT_DM_EXTHALTTRI_3
    `define TDT_DM_EXTHALTTRI_NUM 3
  `endif
  `ifdef TDT_DM_EXTHALTTRI_2
    `define TDT_DM_EXTHALTTRI_NUM 2
  `endif
  `ifdef TDT_DM_EXTHALTTRI_1
    `define TDT_DM_EXTHALTTRI_NUM 1
  `endif

  `ifdef TDT_DM_EXTRESUMETRI_4
    `define TDT_DM_EXTRESUMETRI_NUM 4
  `endif
  `ifdef TDT_DM_EXTRESUMETRI_3
    `define TDT_DM_EXTRESUMETRI_NUM 3
  `endif
  `ifdef TDT_DM_EXTRESUMETRI_2
    `define TDT_DM_EXTRESUMETRI_NUM 2
  `endif
  `ifdef TDT_DM_EXTRESUMETRI_1
    `define TDT_DM_EXTRESUMETRI_NUM 1
  `endif
`endif


`ifdef TDT_DM_CORE_RV64
  `define TDT_DM_CORE_ISA            4'h0
`else
  `ifdef TDT_DM_CORE_RV32
    `define TDT_DM_CORE_ISA            4'h1
  `else 
    `define TDT_DM_CORE_ISA            4'h2
  `endif
`endif


`ifdef TDT_DM_CORE_RV64
    `define TDT_DM_CORE_MAX_XLEN              64
`else
    `define TDT_DM_CORE_MAX_XLEN              32
`endif

`ifdef PROCESSOR_3
     `define TDT_DM_CORE_NUM                  4
     `define TDT_DM_ALLCORE_NSCRATCH          {`TDT_DM_CORE_NSCRATCH, `TDT_DM_CORE_NSCRATCH, `TDT_DM_CORE_NSCRATCH, `TDT_DM_CORE_NSCRATCH}
     `define TDT_DM_ALLCORE_ISA               {`TDT_DM_CORE_ISA, `TDT_DM_CORE_ISA, `TDT_DM_CORE_ISA, `TDT_DM_CORE_ISA}
`else
  `ifdef PROCESSOR_2
     `define TDT_DM_CORE_NUM                  3
     `define TDT_DM_ALLCORE_NSCRATCH          {`TDT_DM_CORE_NSCRATCH, `TDT_DM_CORE_NSCRATCH, `TDT_DM_CORE_NSCRATCH}
     `define TDT_DM_ALLCORE_ISA               {`TDT_DM_CORE_ISA, `TDT_DM_CORE_ISA, `TDT_DM_CORE_ISA}
  `else
    `ifdef PROCESSOR_1
       `define TDT_DM_CORE_NUM                  2
       `define TDT_DM_ALLCORE_NSCRATCH          {`TDT_DM_CORE_NSCRATCH, `TDT_DM_CORE_NSCRATCH}
       `define TDT_DM_ALLCORE_ISA               {`TDT_DM_CORE_ISA, `TDT_DM_CORE_ISA}
    `else
       `define TDT_DM_CORE_NUM                  1
       `define TDT_DM_SINGLE_CORE
       `define TDT_DM_ALLCORE_NSCRATCH          `TDT_DM_CORE_NSCRATCH
       `define TDT_DM_ALLCORE_ISA               `TDT_DM_CORE_ISA
    `endif
  `endif
`endif

`ifdef TDT_DM_PB_EN
   `ifdef TDT_DM_IEBREAK
      `define TDT_DM_IMPEBREAK                1'b1
   `else
      `define TDT_DM_IMPEBREAK                1'b0
   `endif
   //to fix lint warning
   `define PB_SIZE_WITH_WIDTH                 5'd`TDT_DM_PB_SIZE 
`else
      `define TDT_DM_IMPEBREAK                1'b0
`endif

//`define TDT_DM_BUF_MOVE

`ifdef TDT_DM_BUF_MOVE
    `define TDT_DM_CUSTOM_BUF_CNT             8
`endif

//`define TDT_TRACE_ENC_EN

`ifdef TDT_TRACE_ENC_EN
  `ifdef PROCESSOR_3
    `define TDT_COMP_NUM                      5
  `else 
    `ifdef PROCESSOR_2
      `define TDT_COMP_NUM                    4
    `else
      `ifdef PROCESSOR_1
        `define TDT_COMP_NUM                  3
      `else
        `define TDT_COMP_NUM                  2
      `endif
    `endif
  `endif
`else
  `define TDT_COMP_NUM                        1
  `define TDT_SINGLE_COMP
`endif

`define TDT_ACC_CSR

`ifdef TDT_DM_SBA_DW_128
    `define TDT_DM_SBA_DW         128
    `define TDT_DM_SBA_BW         16    
`else
  `ifdef TDT_DM_SBA_DW_64
    `define TDT_DM_SBA_DW         64
    `define TDT_DM_SBA_BW         8    
  `else 
    `define TDT_DM_SBA_DW         32
    `define TDT_DM_SBA_BW         4        
  `endif
`endif

//to fix lint warning
`ifdef TDT_DM_SBA
  `define SBAW_WITH_WIDTH          7'd`TDT_DM_SBAW            
`endif
//==========================================================
// INTERNAL DEFINES END
//==========================================================
