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
// TDT_DMI_SYSAPB_EN : system bus apb access tdt_top enable
//==========================================================

//`define TDT_DMI_SYSAPB_EN

//==========================================================
// TDT_DMI_SLAVE_* : apb slave number, 0 must define, max to
//                   63. Number must be sequence
//==========================================================

`define TDT_DMI_SLAVE_0
//`define TDT_DMI_SLAVE_1
//`define TDT_DMI_SLAVE_2
//`define TDT_DMI_SLAVE_3
//`define TDT_DMI_SLAVE_4
//`define TDT_DMI_SLAVE_5
//`define TDT_DMI_SLAVE_6
//`define TDT_DMI_SLAVE_7
//`define TDT_DMI_SLAVE_8
//`define TDT_DMI_SLAVE_9
//`define TDT_DMI_SLAVE_10
//`define TDT_DMI_SLAVE_11
//`define TDT_DMI_SLAVE_12
//`define TDT_DMI_SLAVE_13
//`define TDT_DMI_SLAVE_14
//`define TDT_DMI_SLAVE_15
//`define TDT_DMI_SLAVE_16
//`define TDT_DMI_SLAVE_17
//`define TDT_DMI_SLAVE_18
//`define TDT_DMI_SLAVE_19
//`define TDT_DMI_SLAVE_20
//`define TDT_DMI_SLAVE_21
//`define TDT_DMI_SLAVE_22
//`define TDT_DMI_SLAVE_23
//`define TDT_DMI_SLAVE_24
//`define TDT_DMI_SLAVE_25
//`define TDT_DMI_SLAVE_26
//`define TDT_DMI_SLAVE_27
//`define TDT_DMI_SLAVE_28
//`define TDT_DMI_SLAVE_29
//`define TDT_DMI_SLAVE_30
//`define TDT_DMI_SLAVE_31

`ifdef TDT_DMI_SLAVE_31
  `define TDT_DMI_SLAVE_NUM                                                                 32
`else
  `ifdef TDT_DMI_SLAVE_30
    `define TDT_DMI_SLAVE_NUM                                                               31
  `else
    `ifdef TDT_DMI_SLAVE_29
      `define TDT_DMI_SLAVE_NUM                                                             30
    `else
      `ifdef TDT_DMI_SLAVE_28
        `define TDT_DMI_SLAVE_NUM                                                           29
      `else
        `ifdef TDT_DMI_SLAVE_27
          `define TDT_DMI_SLAVE_NUM                                                         28
        `else
          `ifdef TDT_DMI_SLAVE_26
            `define TDT_DMI_SLAVE_NUM                                                       27
          `else
            `ifdef TDT_DMI_SLAVE_25
              `define TDT_DMI_SLAVE_NUM                                                     26
            `else
              `ifdef TDT_DMI_SLAVE_24
                `define TDT_DMI_SLAVE_NUM                                                   25
              `else
                `ifdef TDT_DMI_SLAVE_23
                  `define TDT_DMI_SLAVE_NUM                                                 24
                `else
                  `ifdef TDT_DMI_SLAVE_22
                    `define TDT_DMI_SLAVE_NUM                                               23
                  `else 
                    `ifdef TDT_DMI_SLAVE_21
                      `define TDT_DMI_SLAVE_NUM                                             22
                    `else
                      `ifdef TDT_DMI_SLAVE_20
                        `define TDT_DMI_SLAVE_NUM                                           21
                      `else
                        `ifdef TDT_DMI_SLAVE_19 
                          `define TDT_DMI_SLAVE_NUM                                         20
                        `else
                          `ifdef TDT_DMI_SLAVE_18
                            `define TDT_DMI_SLAVE_NUM                                       19
                          `else
                            `ifdef TDT_DMI_SLAVE_17
                              `define TDT_DMI_SLAVE_NUM                                     18
                            `else
                              `ifdef TDT_DMI_SLAVE_16
                                `define TDT_DMI_SLAVE_NUM                                   17
                              `else
                                `ifdef TDT_DMI_SLAVE_15
                                  `define TDT_DMI_SLAVE_NUM                                 16
                                `else
                                  `ifdef TDT_DMI_SLAVE_14
                                    `define TDT_DMI_SLAVE_NUM                               15
                                  `else
                                    `ifdef TDT_DMI_SLAVE_13
                                      `define TDT_DMI_SLAVE_NUM                             14
                                    `else
                                      `ifdef TDT_DMI_SLAVE_12
                                        `define TDT_DMI_SLAVE_NUM                           13
                                      `else
                                        `ifdef TDT_DMI_SLAVE_11
                                          `define TDT_DMI_SLAVE_NUM                         12
                                        `else
                                          `ifdef TDT_DMI_SLAVE_10
                                            `define TDT_DMI_SLAVE_NUM                       11
                                          `else
                                            `ifdef TDT_DMI_SLAVE_9
                                              `define TDT_DMI_SLAVE_NUM                     10
                                            `else
                                              `ifdef TDT_DMI_SLAVE_8
                                                `define TDT_DMI_SLAVE_NUM                   9
                                              `else
                                                `ifdef TDT_DMI_SLAVE_7
                                                  `define TDT_DMI_SLAVE_NUM                 8
                                                `else
                                                  `ifdef TDT_DMI_SLAVE_6
                                                    `define TDT_DMI_SLAVE_NUM               7
                                                  `else
                                                    `ifdef TDT_DMI_SLAVE_5
                                                      `define TDT_DMI_SLAVE_NUM             6
                                                    `else
                                                      `ifdef TDT_DMI_SLAVE_4
                                                        `define TDT_DMI_SLAVE_NUM           5
                                                      `else
                                                        `ifdef TDT_DMI_SLAVE_3
                                                          `define TDT_DMI_SLAVE_NUM         4
                                                        `else
                                                          `ifdef TDT_DMI_SLAVE_2
                                                            `define TDT_DMI_SLAVE_NUM       3
                                                          `else
                                                            `ifdef TDT_DMI_SLAVE_1
                                                              `define TDT_DMI_SLAVE_NUM     2
                                                            `else
                                                              `ifdef TDT_DMI_SLAVE_0
                                                               `define TDT_DMI_SLAVE_NUM    1
                                                               `define TDT_DMI_SINGLE_SLAVE
                                                              `endif
                                                            `endif
                                                          `endif
                                                        `endif
                                                      `endif
                                                    `endif
                                                  `endif
                                                `endif
                                              `endif
                                            `endif
                                          `endif
                                        `endif
                                      `endif
                                    `endif
                                  `endif
                                `endif
                              `endif
                            `endif
                          `endif
                        `endif
                      `endif
                    `endif
                  `endif
                `endif
              `endif
            `endif
          `endif
        `endif
      `endif
    `endif
  `endif
`endif

//==========================================================
// TDT_DMI_HIGH_ADDR_W : apb component decode address(each 
//                       component have 4KB space), 
//                       must >= clog2(SLAVE_NUM).
//==========================================================

`ifdef TDT_DMI_SINGLE_SLAVE
    `define TDT_DMI_HIGH_ADDR_W                  0
`else
    `define TDT_DMI_HIGH_ADDR_W                  6
`endif 

//==========================================================
// TDT_DMI_SLAVE_*_BASEADDR : each component base address,
//                            width is TDT_DMI_HIGH_ADDR_W
//==========================================================

`ifdef TDT_DMI_SLAVE_31
    `define TDT_DMI_SLAVE_31_BASEADDR            'd31
`endif
`ifdef TDT_DMI_SLAVE_30
    `define TDT_DMI_SLAVE_30_BASEADDR            'd30
`endif
`ifdef TDT_DMI_SLAVE_29
    `define TDT_DMI_SLAVE_29_BASEADDR            'd29
`endif
`ifdef TDT_DMI_SLAVE_28
    `define TDT_DMI_SLAVE_28_BASEADDR            'd28
`endif
`ifdef TDT_DMI_SLAVE_27
    `define TDT_DMI_SLAVE_27_BASEADDR            'd27
`endif
`ifdef TDT_DMI_SLAVE_26
    `define TDT_DMI_SLAVE_26_BASEADDR            'd26
`endif
`ifdef TDT_DMI_SLAVE_25
    `define TDT_DMI_SLAVE_25_BASEADDR            'd25
`endif
`ifdef TDT_DMI_SLAVE_24
    `define TDT_DMI_SLAVE_24_BASEADDR            'd24
`endif
`ifdef TDT_DMI_SLAVE_23
    `define TDT_DMI_SLAVE_23_BASEADDR            'd23
`endif
`ifdef TDT_DMI_SLAVE_22
    `define TDT_DMI_SLAVE_22_BASEADDR            'd22
`endif
`ifdef TDT_DMI_SLAVE_21
    `define TDT_DMI_SLAVE_21_BASEADDR            'd21
`endif
`ifdef TDT_DMI_SLAVE_20
    `define TDT_DMI_SLAVE_20_BASEADDR            'd20
`endif
`ifdef TDT_DMI_SLAVE_19
    `define TDT_DMI_SLAVE_19_BASEADDR            'd19
`endif
`ifdef TDT_DMI_SLAVE_18
    `define TDT_DMI_SLAVE_18_BASEADDR            'd18
`endif
`ifdef TDT_DMI_SLAVE_17
    `define TDT_DMI_SLAVE_17_BASEADDR            'd17
`endif
`ifdef TDT_DMI_SLAVE_16
    `define TDT_DMI_SLAVE_16_BASEADDR            'd16
`endif
`ifdef TDT_DMI_SLAVE_15
    `define TDT_DMI_SLAVE_15_BASEADDR            'd15
`endif
`ifdef TDT_DMI_SLAVE_14
    `define TDT_DMI_SLAVE_14_BASEADDR            'd14
`endif
`ifdef TDT_DMI_SLAVE_13
    `define TDT_DMI_SLAVE_13_BASEADDR            'd13
`endif
`ifdef TDT_DMI_SLAVE_12
    `define TDT_DMI_SLAVE_12_BASEADDR            'd12
`endif
`ifdef TDT_DMI_SLAVE_11
    `define TDT_DMI_SLAVE_11_BASEADDR            'd11
`endif
`ifdef TDT_DMI_SLAVE_10
    `define TDT_DMI_SLAVE_10_BASEADDR            'd10
`endif
`ifdef TDT_DMI_SLAVE_9
    `define TDT_DMI_SLAVE_9_BASEADDR             'd9
`endif
`ifdef TDT_DMI_SLAVE_8
    `define TDT_DMI_SLAVE_8_BASEADDR             'd8
`endif
`ifdef TDT_DMI_SLAVE_7
    `define TDT_DMI_SLAVE_7_BASEADDR             'd7
`endif
`ifdef TDT_DMI_SLAVE_6
    `define TDT_DMI_SLAVE_6_BASEADDR             'd6
`endif
`ifdef TDT_DMI_SLAVE_5
    `define TDT_DMI_SLAVE_5_BASEADDR             'd5
`endif
`ifdef TDT_DMI_SLAVE_4
    `define TDT_DMI_SLAVE_4_BASEADDR             'd4
`endif
`ifdef TDT_DMI_SLAVE_3
    `define TDT_DMI_SLAVE_3_BASEADDR             'd3
`endif
`ifdef TDT_DMI_SLAVE_2
    `define TDT_DMI_SLAVE_2_BASEADDR             'd2
`endif
`ifdef TDT_DMI_SLAVE_1
    `define TDT_DMI_SLAVE_1_BASEADDR             'd1
`endif

//==========================================================
// DTMCS IDLE CYCLE, [5, 7]
// IDLE_CYCLE and freq.tlk/freq.pclk must meet this relation when TDT_DMI_SYSAPB_EN is undefined
// Freq.pclk/Freq.tclk > 8/(IDLE_CYCLE-4)
// IDLE_CYCLE and freq.tlk/freq.pclk must meet this relation when TDT_DMI_SYSAPB_EN is defined
// Freq.pclk/Freq.tclk > 11/(IDLE_CYCLE-4)
//==========================================================

`define TDT_DMI_IDLE_CYCLE                       3'h7

