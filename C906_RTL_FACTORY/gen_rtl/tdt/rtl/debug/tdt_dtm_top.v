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
module tdt_dtm_top #(
    parameter                        DTM_ABITS = 16
)(
    input                            pad_dtm_tclk,
    input                            pad_dtm_trst_b,
    input                            pad_dtm_jtag2_sel,         
    input                            pad_dtm_tap_en,        
    input                            pad_dtm_tdi,           
    input                            pad_dtm_tms_i,  
    output                           dtm_pad_tdo,           
    output                           dtm_pad_tdo_en,        
    output                           dtm_pad_tms_o,         
    output                           dtm_pad_tms_oe,

    output                           dtm_apbm_wr_vld,
    output  [DTM_ABITS-1:0]          dtm_apbm_wr_addr,
    output  [1:0]                    dtm_apbm_wr_flg,
    output  [31:0]                   dtm_apbm_wdata,
    output                           dmihardreset,
    input   [31:0]                   apbm_dtm_rdata,
    input                            apbm_dtm_wr_ready
);

    localparam                           DTM_NDMIREG_WIDTH    = 32;
    localparam                           DTM_IRREG_WIDTH      = 5; 
    localparam                           DTM_FSM2_RSTCNT      = 80; 
    localparam                           CHAIN_DW             = DTM_ABITS + 32 + 2;
    
    wire                                 chain_io_tdo;             
    wire                                 ctrl_io_tdo_en;              
    wire                                 ctrl_io_tms_oe;                          
    wire                                 io_chain_tdi;             
    wire                                 io_ctrl_tap_en;
    wire                                 idr_dmi_mode;
    wire                                 ctrl_chain_capture_dr;  
    wire                                 ctrl_chain_capture_ir;   
    wire                                 ctrl_idr_update_ir;       
    wire                                 ctrl_idr_update_dr;
    wire                                 ctrl_idr_capture_dr;
    wire                                 ctrl_chain_shift_dr;      
    wire                                 ctrl_chain_shift_ir;      
    wire                                 ctrl_chain_shift_par;     
    wire                                 ctrl_chain_shift_sync;
    wire  [CHAIN_DW-1:0]                 idr_chain_dr; 
    wire  [DTM_IRREG_WIDTH-1:0]          idr_chain_ir; 
    wire  [CHAIN_DW-1:0]                 chain_idr_data;      

    tdt_dtm_io x_tdt_dtm_io (      
        .pad_dtm_jtag2_sel               (pad_dtm_jtag2_sel),         
        .pad_dtm_tap_en                  (pad_dtm_tap_en),        
        .pad_dtm_tdi                     (pad_dtm_tdi),           
        .pad_dtm_tms_i                   (pad_dtm_tms_i),  
        .dtm_pad_tdo                     (dtm_pad_tdo),           
        .dtm_pad_tdo_en                  (dtm_pad_tdo_en),        
        .dtm_pad_tms_o                   (dtm_pad_tms_o),         
        .dtm_pad_tms_oe                  (dtm_pad_tms_oe),        
        .chain_io_tdo                    (chain_io_tdo),             
        .ctrl_io_tdo_en                  (ctrl_io_tdo_en),              
        .ctrl_io_tms_oe                  (ctrl_io_tms_oe),                          
        .io_chain_tdi                    (io_chain_tdi),             
        .io_ctrl_tap_en                  (io_ctrl_tap_en)
    );
    
    tdt_dtm_ctrl #(
        .DTM_ABITS                       (DTM_ABITS[5:0]),   
        .DTM_NDMIREG_WIDTH               (DTM_NDMIREG_WIDTH[7:0]),
        .DTM_IRREG_WIDTH                 (DTM_IRREG_WIDTH[7:0]),
        .DTM_FSM2_RSTCNT                 (DTM_FSM2_RSTCNT[6:0])
    ) x_tdt_dtm_ctrl (
        .tclk                            (pad_dtm_tclk),                    
        .trst_b                          (pad_dtm_trst_b),
        .dmihardreset                    (dmihardreset), 
        .io_ctrl_tap_en                  (io_ctrl_tap_en),            
        .pad_dtm_jtag2_sel               (pad_dtm_jtag2_sel),       
        .pad_dtm_tms_i                   (pad_dtm_tms_i),   
        .idr_dmi_mode                    (idr_dmi_mode),                    
        .ctrl_io_tdo_en                  (ctrl_io_tdo_en),            
        .ctrl_io_tms_oe                  (ctrl_io_tms_oe),            
        .ctrl_chain_capture_dr           (ctrl_chain_capture_dr), 
        .ctrl_chain_capture_ir           (ctrl_chain_capture_ir),     
        .ctrl_idr_update_ir              (ctrl_idr_update_ir),       
        .ctrl_idr_update_dr              (ctrl_idr_update_dr),
        .ctrl_idr_capture_dr             (ctrl_idr_capture_dr),
        .ctrl_chain_shift_dr             (ctrl_chain_shift_dr),      
        .ctrl_chain_shift_ir             (ctrl_chain_shift_ir),      
        .ctrl_chain_shift_par            (ctrl_chain_shift_par),     
        .ctrl_chain_shift_sync           (ctrl_chain_shift_sync)
    );
    
    tdt_dtm_chain #(
        .CHAIN_DW                        (CHAIN_DW),          
        .DTM_IRREG_WIDTH                 (DTM_IRREG_WIDTH),   
        .DTM_ABITS                       (DTM_ABITS),             
        .DTM_NDMIREG_WIDTH               (DTM_NDMIREG_WIDTH) 
    ) x_tdt_dtm_chain (
        .tclk                            (pad_dtm_tclk),                 
        .trst_b                          (pad_dtm_trst_b),   
        .dmihardreset                    (dmihardreset), 
        .io_chain_tdi                    (io_chain_tdi),
        .chain_io_tdo                    (chain_io_tdo),
        .idr_chain_dr                    (idr_chain_dr), 
        .idr_chain_ir                    (idr_chain_ir), 
        .chain_idr_data                  (chain_idr_data),      
        .idr_dmi_mode                    (idr_dmi_mode),
        .ctrl_chain_capture_dr           (ctrl_chain_capture_dr),  
        .ctrl_chain_capture_ir           (ctrl_chain_capture_ir),    
        .ctrl_chain_shift_dr             (ctrl_chain_shift_dr),      
        .ctrl_chain_shift_ir             (ctrl_chain_shift_ir),      
        .ctrl_chain_shift_par            (ctrl_chain_shift_par),     
        .ctrl_chain_shift_sync           (ctrl_chain_shift_sync)
    );
    
    tdt_dtm_idr #(
        .CHAIN_DW                        (CHAIN_DW),          
        .DTM_IRREG_WIDTH                 (DTM_IRREG_WIDTH),   
        .DTM_ABITS                       (DTM_ABITS[5:0]),             
        .DTM_NDMIREG_WIDTH               (DTM_NDMIREG_WIDTH) 
    ) x_tdt_dtm_idr (
        .tclk                            (pad_dtm_tclk),                 
        .trst_b                          (pad_dtm_trst_b),
        .dmihardreset                    (dmihardreset), 
        .idr_chain_dr                    (idr_chain_dr), 
        .idr_chain_ir                    (idr_chain_ir), 
        .idr_dmi_mode                    (idr_dmi_mode),                    
        .chain_idr_data                  (chain_idr_data), 
        .ctrl_idr_update_ir              (ctrl_idr_update_ir),       
        .ctrl_idr_update_dr              (ctrl_idr_update_dr),
        .ctrl_idr_capture_dr             (ctrl_idr_capture_dr),
        .dtm_apbm_wr_vld                 (dtm_apbm_wr_vld),
        .dtm_apbm_wr_addr                (dtm_apbm_wr_addr),
        .dtm_apbm_wr_flg                 (dtm_apbm_wr_flg),
        .dtm_apbm_wdata                  (dtm_apbm_wdata),
        .apbm_dtm_rdata                  (apbm_dtm_rdata),
        .apbm_dtm_wr_ready               (apbm_dtm_wr_ready)
    );

endmodule
