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
//                   DTU Configuration
//==========================================================
//---------------------------------------------------------
// TM Trigger Configuration
//---------------------------------------------------------
`define TDT_TM_TRIGGER_NUM     `TDT_TM_MCONTROL_TRI_NUM + `TDT_TM_OTHER_TRI_NUM

//----------------------------------------------------------
//                  HALT INFO Define 
//----------------------------------------------------------
`define TDT_HINFO_WIDTH        `TDT_HINFO_TRIGGER      + 1

`define TDT_HINFO_TRIGGER      `TDT_HINFO_CAUSE        + `TDT_TM_TRIGGER_NUM
`define TDT_HINFO_CAUSE        `TDT_HINFO_PENDING_HALT + 4
`define TDT_HINFO_PENDING_HALT `TDT_HINFO_TIMING       + 1
`define TDT_HINFO_TIMING       `TDT_HINFO_ACTION01     + 1
`define TDT_HINFO_ACTION01     `TDT_HINFO_ACTION       + 1
`define TDT_HINFO_ACTION       `TDT_HINFO_CHAIN        + 1
`define TDT_HINFO_CHAIN        `TDT_HINFO_LDST         + 1
`define TDT_HINFO_LDST         `TDT_HINFO_MATCH        + 1
`define TDT_HINFO_MATCH        `TDT_HINFO_CANCEL       + 1
`define TDT_HINFO_CANCEL                                 0

//----------------------------------------------------------
//                  Trigger Number Define 
//----------------------------------------------------------

`define TDT_DM_CORE_HALF_XLEN 32
//`define `TDT_DM_CORE_HALF_XLEN 16

`define HALF_PA_WIDTH 20
