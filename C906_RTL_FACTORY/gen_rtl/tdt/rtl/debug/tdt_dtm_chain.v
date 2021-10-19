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
module tdt_dtm_chain #(
    parameter                        CHAIN_DW          = 64,
    parameter                        DTM_IRREG_WIDTH   = 5,
    parameter                        DTM_ABITS         = 16,    
    parameter                        DTM_NDMIREG_WIDTH = 32

)(
    input                            tclk,                 
    input                            trst_b,   
    input                            dmihardreset,
    input                            io_chain_tdi,
    output                           chain_io_tdo,

    input   [CHAIN_DW-1:0]           idr_chain_dr, 
    input   [DTM_IRREG_WIDTH-1:0]    idr_chain_ir, 
    output  [CHAIN_DW-1:0]           chain_idr_data,      
     
    input                            idr_dmi_mode,
    input                            ctrl_chain_capture_dr,  
    input                            ctrl_chain_capture_ir,    
    input                            ctrl_chain_shift_dr,      
    input                            ctrl_chain_shift_ir,      
    input                            ctrl_chain_shift_par,     
    input                            ctrl_chain_shift_sync
);

        
    localparam  [DTM_IRREG_WIDTH-1:0] IDCODE               = 5'h01;
    localparam  [DTM_IRREG_WIDTH-1:0] DMI_ACC              = 5'h02;
    localparam  [DTM_IRREG_WIDTH-1:0] DTMCS                = 5'h10;
    localparam  [DTM_IRREG_WIDTH-1:0] DMI                  = 5'h11;
    
    localparam                        DTM_DMIREG_WIDTH     = DTM_ABITS + 2 + 32;   
    localparam                        DTM_DMIACCREG_WIDTH  = 1;
    
    reg  [CHAIN_DW-1:0] chain_shifter_pre;
    reg  [CHAIN_DW-1:0] chain_shifter;
    reg                 parity;
    reg                 tdo;
    wire                tdi;
    
    always @ (ctrl_chain_shift_ir                or
              tdi                                or
              chain_shifter                      or
              ctrl_chain_capture_dr              or
              idr_chain_dr[CHAIN_DW-1:0]         or
              ctrl_chain_capture_ir              or
              idr_chain_ir[DTM_IRREG_WIDTH-1:0]  or
              ctrl_chain_shift_dr                or
              idr_dmi_mode
              ) begin
        chain_shifter_pre[CHAIN_DW-1:0] = {CHAIN_DW{1'b0}};
        if (ctrl_chain_shift_ir)
            chain_shifter_pre[DTM_IRREG_WIDTH-1:0] = {tdi, chain_shifter[DTM_IRREG_WIDTH-1:1]};
        else if (ctrl_chain_capture_dr)
            chain_shifter_pre[CHAIN_DW-1:0] = idr_chain_dr[CHAIN_DW-1:0];
        else if (ctrl_chain_capture_ir)
            chain_shifter_pre[CHAIN_DW-1:0] = {{CHAIN_DW-DTM_IRREG_WIDTH{1'b0}}, idr_chain_ir[DTM_IRREG_WIDTH-1:0]};
        else if (ctrl_chain_shift_dr) 
            case (idr_chain_ir[DTM_IRREG_WIDTH-1:0]) 
                DMI_ACC   : chain_shifter_pre[DTM_DMIACCREG_WIDTH-1:0] = tdi;//1bit
                DMI       : if (idr_dmi_mode) 
                                chain_shifter_pre[DTM_DMIREG_WIDTH-DTM_ABITS-1:0] = {tdi, chain_shifter[DTM_DMIREG_WIDTH-DTM_ABITS-1:1]};//44bit
                            else 
                                chain_shifter_pre[DTM_DMIREG_WIDTH-1:0] = {tdi, chain_shifter[DTM_DMIREG_WIDTH-1:1]};//34bit
                DTMCS     : chain_shifter_pre[DTM_NDMIREG_WIDTH-1:0] = {tdi, chain_shifter[DTM_NDMIREG_WIDTH-1:1]};//32bit
                IDCODE    : chain_shifter_pre[DTM_NDMIREG_WIDTH-1:0] = {tdi, chain_shifter[DTM_NDMIREG_WIDTH-1:1]};//32bit
                default   : chain_shifter_pre[DTM_DMIACCREG_WIDTH-1:0] = tdi;//1bit,use DTM_DMIACCREG_WIDTH
            endcase
        else
            chain_shifter_pre[CHAIN_DW-1:0] = chain_shifter[CHAIN_DW-1:0];
    end
    
    // data shift from the lowest bit
    // sample tdi on the posedge of JTAG clock
    always @ (posedge tclk) begin
        chain_shifter[CHAIN_DW-1:0] <= chain_shifter_pre[CHAIN_DW-1:0];
    end
    
    assign chain_idr_data[CHAIN_DW-1:0] = chain_shifter[CHAIN_DW-1:0];
    //==============================================
    // calculate the parity bit when read DR
    //==============================================
    always @ (posedge tclk) begin
        if (ctrl_chain_capture_dr)
            parity <= 1'b1;
        else if (ctrl_chain_shift_dr)
            parity <= parity ^ chain_shifter[0];
    end
    
    //==============================================
    // set tdo on the negedge of tclk
    // set tdo to logic 1 when IDLE
    //==============================================
    always @ (negedge tclk or negedge trst_b) begin
        if (!trst_b)
            tdo <= 1'b1;
        else if (dmihardreset)
            tdo <= 1'b1;
        else if (ctrl_chain_shift_sync)
            tdo <= 1'b0;
        else if (ctrl_chain_shift_dr || ctrl_chain_shift_ir)
            tdo <= chain_shifter[0];
        else if (ctrl_chain_shift_par)
            tdo <= parity;
        else
            tdo <= 1'b1;
    end
    
    //==========================================================
    //               jtag input and output
    //==========================================================
    
    assign tdi = io_chain_tdi;
    
    assign chain_io_tdo = tdo;

endmodule



