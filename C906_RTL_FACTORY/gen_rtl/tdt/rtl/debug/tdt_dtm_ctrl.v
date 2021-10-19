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
module tdt_dtm_ctrl #(
    parameter [5:0] DTM_ABITS            = 6'd16,    
    parameter [7:0] DTM_NDMIREG_WIDTH    = 8'd31,//32 - 1
    parameter [7:0] DTM_IRREG_WIDTH      = 8'd4,//5-  1  
    parameter [6:0] DTM_FSM2_RSTCNT      = 7'd80 
)(
    input           tclk,                    
    input           trst_b,
    input           dmihardreset,
    input           io_ctrl_tap_en,            
    input           pad_dtm_jtag2_sel,       
    input           pad_dtm_tms_i,   
    input           idr_dmi_mode,                    
    output          ctrl_io_tdo_en,            
    output          ctrl_io_tms_oe,            
    output          ctrl_chain_capture_dr,   
    output          ctrl_chain_capture_ir,   
    output          ctrl_idr_update_ir,       
    output          ctrl_idr_update_dr,
    output          ctrl_idr_capture_dr,
    output          ctrl_chain_shift_dr,      
    output          ctrl_chain_shift_ir,      
    output          ctrl_chain_shift_par,     
    output          ctrl_chain_shift_sync
);

    localparam [7:0]  DTM_DMIREG_WIDTH     = DTM_ABITS + 8'd2 + 8'd32 -1'b1;    //50 -1
    localparam [7:0]  DTM_DMIREG_ACC_WIDTH = DTM_DMIREG_WIDTH - DTM_ABITS;//50 -1 -16
    localparam [7:0]  DTM_DMIACCREG_WIDTH  = 8'b1;           
    
    reg        [7:0]  fsm2_data_counter;        
    reg               fsm2_parity;              
    reg               fsm2_read_vld;            
    reg        [1:0]  fsm2_rs;                  
    reg        [1:0]  fsm2_rs_counter;          
    reg        [3:0]  tap2_cur_st;             
    reg        [3:0]  tap2_nxt_st;             
    reg        [6:0]  tap2_rst_cnt;            
    reg        [3:0]  tap5_cur_st;             
    reg        [3:0]  tap5_nxt_st;             
    reg               tdo_en;                  
    reg               tms_oe;                  
    
    wire              jtag2_sel;               
    wire              fsm2_capture_dr;   
    wire              fsm2_capture_ir;                 
    wire              fsm2_load_rs;             
    wire              fsm2_load_rw;             
    wire              fsm2_parity_vld;          
    wire              fsm2_rs_had_dr_dmi_sel; 
    wire              fsm2_rs_had_dr_sel;       
    wire              fsm2_rs_had_dr_ndmi_sel;          
    wire              fsm2_rs_had_ir_sel;       
    wire              fsm2_shift_dr;            
    wire              fsm2_shift_ir;            
    wire              fsm2_shift_vld;           
    wire              fsm2_start_vld;           
    wire              fsm2_sync_vld;            
    wire              fsm2_trn1;                
    wire              fsm2_trn2;                
    wire              fsm2_update_dr;           
    wire              fsm2_update_ir;           
    wire              fsm2_update_vld;          
    wire              fsm5_capture_dr;    
    wire              fsm5_capture_ir;                
    wire              fsm5_shift_dr;            
    wire              fsm5_shift_ir;            
    wire              fsm5_update_dr;           
    wire              fsm5_update_ir;           
    wire              fsm2_rs_had_dr_dmiacc_sel;
    wire              tap2_rst_vld;
    wire              tms_i;
    assign tms_i = pad_dtm_tms_i;
    assign jtag2_sel = pad_dtm_jtag2_sel;
    
    //==============================================================================
    //                    TAP5 controller state machine
    //==============================================================================
    localparam TAP5_RESET          = 4'b0000;
    localparam TAP5_IDLE           = 4'b0001;
    localparam TAP5_SELECT_DR_SCAN = 4'b0011;
    localparam TAP5_SELECT_IR_SCAN = 4'b0010;
    localparam TAP5_CAPTURE_IR     = 4'b0110;
    localparam TAP5_SHIFT_IR       = 4'b0100;
    localparam TAP5_EXIT1_IR       = 4'b0101;
    localparam TAP5_UPDATE_IR      = 4'b0111;
    localparam TAP5_CAPTURE_DR     = 4'b1011;
    localparam TAP5_SHIFT_DR       = 4'b1010;
    localparam TAP5_EXIT1_DR       = 4'b1000;
    localparam TAP5_UPDATE_DR      = 4'b1001;
    localparam TAP5_PAUSE_IR       = 4'b1101;
    localparam TAP5_EXIT2_IR       = 4'b1111;
    localparam TAP5_PAUSE_DR       = 4'b1100;
    localparam TAP5_EXIT2_DR       = 4'b1110;
    
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b)
            tap5_cur_st[3:0] <= TAP5_RESET;
        else if (dmihardreset)
            tap5_cur_st[3:0] <= TAP5_RESET;
        else if (jtag2_sel)
            tap5_cur_st[3:0] <= TAP5_RESET;
        else 
            tap5_cur_st[3:0] <= tap5_nxt_st[3:0];
    end
    
    always @ (tap5_cur_st[3:0] or
              io_ctrl_tap_en or
              tms_i) begin
        case(tap5_cur_st[3:0])
            TAP5_RESET:
                if (io_ctrl_tap_en && !tms_i)
                    tap5_nxt_st[3:0] = TAP5_IDLE;
                else
                    tap5_nxt_st[3:0] = TAP5_RESET;
            TAP5_IDLE:
                if (tms_i)      
                    tap5_nxt_st[3:0] = TAP5_SELECT_DR_SCAN;
                else
                    tap5_nxt_st[3:0] = TAP5_IDLE;
            TAP5_SELECT_DR_SCAN:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_SELECT_IR_SCAN;
                else
                    tap5_nxt_st[3:0] = TAP5_CAPTURE_DR;
            TAP5_SELECT_IR_SCAN:
                if (!tms_i)
                    tap5_nxt_st[3:0] = TAP5_CAPTURE_IR;
                else
                    tap5_nxt_st[3:0] = TAP5_RESET;
            TAP5_CAPTURE_IR:
                if (!tms_i)
                    tap5_nxt_st[3:0] = TAP5_SHIFT_IR;
                else
                    tap5_nxt_st[3:0] = TAP5_EXIT1_IR;
            TAP5_SHIFT_IR: 
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_EXIT1_IR;
                else
                    tap5_nxt_st[3:0] = TAP5_SHIFT_IR;
            TAP5_EXIT1_IR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_UPDATE_IR;
                else
                    tap5_nxt_st[3:0] = TAP5_PAUSE_IR;
            TAP5_PAUSE_IR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_EXIT2_IR;
                else
                    tap5_nxt_st[3:0] = TAP5_PAUSE_IR;
            TAP5_EXIT2_IR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_UPDATE_IR;
                else
                    tap5_nxt_st[3:0] = TAP5_SHIFT_IR;
            TAP5_UPDATE_IR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_SELECT_DR_SCAN;
                else
                    tap5_nxt_st[3:0] = TAP5_IDLE;
            TAP5_CAPTURE_DR: 
                if (!tms_i)
                    tap5_nxt_st[3:0] = TAP5_SHIFT_DR;
                else
                    tap5_nxt_st[3:0] = TAP5_EXIT1_DR;
            TAP5_SHIFT_DR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_EXIT1_DR;
                else
                    tap5_nxt_st[3:0] = TAP5_SHIFT_DR;
            TAP5_EXIT1_DR:
                if (!tms_i)
                    tap5_nxt_st[3:0] = TAP5_PAUSE_DR;
                else
                    tap5_nxt_st[3:0] = TAP5_UPDATE_DR;
            TAP5_PAUSE_DR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_EXIT2_DR;
                else
                    tap5_nxt_st[3:0] = TAP5_PAUSE_DR;
            TAP5_EXIT2_DR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_UPDATE_DR;
                else
                    tap5_nxt_st[3:0] = TAP5_SHIFT_DR;
            TAP5_UPDATE_DR:
                if (tms_i)
                    tap5_nxt_st[3:0] = TAP5_SELECT_DR_SCAN;
                else
                    tap5_nxt_st[3:0] = TAP5_IDLE;
            default:
                tap5_nxt_st[3:0] = TAP5_RESET;
        endcase
    end
    
    //=============================================
    // TAP5 status
    //=============================================
    assign fsm5_shift_ir   = (tap5_cur_st[3:0] == TAP5_SHIFT_IR);
    assign fsm5_update_ir  = (tap5_cur_st[3:0] == TAP5_UPDATE_IR);
    assign fsm5_shift_dr   = (tap5_cur_st[3:0] == TAP5_SHIFT_DR);
    assign fsm5_update_dr  = (tap5_cur_st[3:0] == TAP5_UPDATE_DR);
    assign fsm5_capture_dr = (tap5_cur_st[3:0] == TAP5_CAPTURE_DR);
    assign fsm5_capture_ir = (tap5_cur_st[3:0] == TAP5_CAPTURE_IR);

    //=============================================
    // TDO output enable in JTAG_5 interafce
    //=============================================
    always @ (negedge tclk or negedge trst_b) begin
        if (!trst_b)
            tdo_en <= 1'b0;
        else if (dmihardreset)
            tdo_en <= 1'b0;
        else if (fsm5_shift_dr || fsm5_shift_ir)
            tdo_en <= 1'b1;
        else
            tdo_en <= 1'b0;
    end
    
    assign ctrl_io_tdo_en = tdo_en;
    
    //==============================================================================
    //                    TAP2 controller state machine
    //==============================================================================
    parameter TAP2_RESET  = 4'b0000;
    parameter TAP2_START  = 4'b0001;
    parameter TAP2_RW     = 4'b0010;
    parameter TAP2_RS     = 4'b0011;
    parameter TAP2_TRN1   = 4'b0100;
    parameter TAP2_DATA   = 4'b0101;
    parameter TAP2_SYNC   = 4'b0110; 
    parameter TAP2_PARITY = 4'b0111;
    parameter TAP2_TRN2   = 4'b1000;
    
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b)
            tap2_cur_st[3:0] <= TAP2_RESET;
        else if (dmihardreset)
            tap2_cur_st[3:0] <= TAP2_RESET;
        else if ((tap2_rst_vld && tms_i) || (!jtag2_sel))
            tap2_cur_st[3:0] <= TAP2_RESET;
        else
            tap2_cur_st[3:0] <= tap2_nxt_st[3:0];
    end
    
    //========================================
    // counter is counting dowwn when
    // TMS id high and TCLK is valid
    //========================================
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b)
            tap2_rst_cnt[6:0] <= DTM_FSM2_RSTCNT;
        else if (dmihardreset)
            tap2_rst_cnt[6:0] <= DTM_FSM2_RSTCNT;
        else if (!jtag2_sel)
            tap2_rst_cnt[6:0] <= DTM_FSM2_RSTCNT;
        else if (!tms_i)
            tap2_rst_cnt[6:0] <= DTM_FSM2_RSTCNT;
        else if (tap2_rst_cnt[6:0] > 7'd0)
            tap2_rst_cnt[6:0] <= tap2_rst_cnt[6:0] - 7'd1;
        else
            tap2_rst_cnt[6:0] <= DTM_FSM2_RSTCNT;
    end
    
    assign tap2_rst_vld = (tap2_rst_cnt[6:0] == 7'd00);
    
    always @ (tap2_cur_st[3:0] or
              io_ctrl_tap_en or
              tms_i or
              fsm2_rs_counter[1:0] or
              fsm2_read_vld or
              fsm2_data_counter[7:0]
              ) begin
        case (tap2_cur_st[3:0])
            TAP2_RESET : begin
                if (io_ctrl_tap_en && tms_i) 
                    tap2_nxt_st[3:0] = TAP2_START;
                else 
                    tap2_nxt_st[3:0] = TAP2_RESET;
            end
    
            TAP2_START : begin // wait for START bit (tms = 0)
                if (!tms_i) // sample START bit, logic 0
                    tap2_nxt_st[3:0] = TAP2_RW;
                else
                    tap2_nxt_st[3:0] = TAP2_START;
            end
    
            TAP2_RW : begin  // RnW bit, 1=Read Op, 0=Write Op
                tap2_nxt_st[3:0] = TAP2_RS;
            end
    
            TAP2_RS : begin // RS[1:0] - Register Group Select
                if (fsm2_rs_counter[1:0] == 2'd0)
                    tap2_nxt_st[3:0] = TAP2_TRN1;
                else
                    tap2_nxt_st[3:0] = TAP2_RS;
            end
    
            TAP2_TRN1 : begin // Turn Around 1
                if (fsm2_read_vld)  // Read operation need a sync cycle
                    tap2_nxt_st[3:0] = TAP2_SYNC;
                else               // write operation
                    tap2_nxt_st[3:0] = TAP2_DATA;
            end
    
            TAP2_SYNC : begin
                tap2_nxt_st[3:0] = TAP2_DATA;
            end
    
            TAP2_DATA : begin // IR or DR, Sample or Set
                if (fsm2_data_counter[7:0] == 8'd0)
                    tap2_nxt_st[3:0] = TAP2_PARITY;
                else
                    tap2_nxt_st[3:0] = TAP2_DATA;
            end
    
            TAP2_PARITY : begin
                tap2_nxt_st[3:0] = TAP2_TRN2;
            end
    
            TAP2_TRN2 : begin
                tap2_nxt_st[3:0] = TAP2_START;
            end
            default : begin
                tap2_nxt_st[3:0] = TAP2_RESET;
            end
        endcase
    end
    
    assign fsm2_start_vld  = (tap2_cur_st[3:0] == TAP2_RW);
    assign fsm2_load_rw    = (tap2_cur_st[3:0] == TAP2_RW);
    assign fsm2_load_rs    = (tap2_cur_st[3:0] == TAP2_RS);
    assign fsm2_trn1       = (tap2_cur_st[3:0] == TAP2_TRN1);
    assign fsm2_trn2       = (tap2_cur_st[3:0] == TAP2_TRN2);
    assign fsm2_shift_vld  = (tap2_cur_st[3:0] == TAP2_DATA);
    assign fsm2_update_vld = (tap2_cur_st[3:0] == TAP2_TRN2);
    assign fsm2_parity_vld = (tap2_cur_st[3:0] == TAP2_PARITY);
    assign fsm2_sync_vld   = (tap2_cur_st[3:0] == TAP2_SYNC);
    
    //=========================================
    // load the RW
    //=========================================
    always @ (posedge tclk) begin
        if (fsm2_load_rw)
            fsm2_read_vld <= tms_i;
    end
    
    //===========================================
    // load the RS[1:0]
    //===========================================
    always @ (posedge tclk) begin
        if (fsm2_start_vld)
            fsm2_rs_counter[1:0] <= 2'd1;
        else if (dmihardreset)
            fsm2_rs_counter[1:0] <= 2'd1;
        else if (fsm2_load_rs) 
            fsm2_rs_counter[1:0] <= fsm2_rs_counter[1:0] - 2'd1;
        else
            fsm2_rs_counter[1:0] <= fsm2_rs_counter[1:0];
    end
    
    always @ (posedge tclk) begin
        if (fsm2_load_rs)
            fsm2_rs[1:0] <= {tms_i, fsm2_rs[1]};
        else
            fsm2_rs[1:0] <= fsm2_rs[1:0];
    end
    
    assign fsm2_rs_had_ir_sel        = fsm2_rs[1:0] == 2'b00;   //IR
    assign fsm2_rs_had_dr_dmiacc_sel = fsm2_rs[1:0] == 2'b01;   //DMI_ACC
    assign fsm2_rs_had_dr_dmi_sel    = fsm2_rs[1:0] == 2'b11;   //DMI
    assign fsm2_rs_had_dr_ndmi_sel   = fsm2_rs[1:0] == 2'b10;   //OTHER DR
    assign fsm2_rs_had_dr_sel        = fsm2_rs_had_dr_dmiacc_sel || fsm2_rs_had_dr_dmi_sel || fsm2_rs_had_dr_ndmi_sel;
    //===========================================
    // intialize DATA shift length
    //===========================================
    always @ (posedge tclk) begin
        if (fsm2_trn1) begin
            if (fsm2_rs_had_dr_dmiacc_sel)
                fsm2_data_counter[7:0] <= 8'b0; //DTM_DMIACCREG_WIDTH - 1'b1
            else if (fsm2_rs_had_dr_dmi_sel) begin
                if (idr_dmi_mode)
                    fsm2_data_counter[7:0] <= DTM_DMIREG_ACC_WIDTH; //34 - 1, to fix lint
                else 
                    fsm2_data_counter[7:0] <= DTM_DMIREG_WIDTH; //50 - 1, to fix lint
            end else if (fsm2_rs_had_dr_ndmi_sel)
                fsm2_data_counter[7:0] <= DTM_NDMIREG_WIDTH;//32 - 1, to fix lint
            else
                fsm2_data_counter[7:0] <= DTM_IRREG_WIDTH;//5 - 1, to fix lint
        end
        else if (fsm2_shift_vld)
            fsm2_data_counter[7:0] <= fsm2_data_counter[7:0] - 8'd1;
    end
    
    //================================================
    // TMS output Enable
    //================================================
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b)
            tms_oe <= 1'b0; // default is input
        else if (dmihardreset)
            tms_oe <= 1'b0; // default is input
        else if (fsm2_trn1 && fsm2_read_vld)
            tms_oe <= 1'b1;
        else if (fsm2_trn2)
            tms_oe <= 1'b0;
        else
            tms_oe <= tms_oe;
    end
    
    assign ctrl_io_tms_oe = tms_oe;
    
    //================================================
    // Parity Check
    //================================================
    always @ (posedge tclk) begin
        if (fsm2_start_vld)
            fsm2_parity <= 1'b1;
        else if ((fsm2_rs_had_dr_sel || fsm2_rs_had_ir_sel) && fsm2_shift_vld)
            fsm2_parity <= fsm2_parity ^ tms_i; // calculate the parity bit
        else if (fsm2_parity_vld)
            fsm2_parity <= fsm2_parity ^ tms_i; // check received parity bit
        else
            fsm2_parity <= fsm2_parity;
    end
    
    assign fsm2_shift_ir   = fsm2_rs_had_ir_sel && fsm2_shift_vld;
    assign fsm2_shift_dr   = fsm2_rs_had_dr_sel && fsm2_shift_vld;
    assign fsm2_capture_dr = fsm2_rs_had_dr_sel && fsm2_read_vld && fsm2_trn1;
    assign fsm2_capture_ir = fsm2_rs_had_ir_sel && fsm2_read_vld && fsm2_trn1;
    assign fsm2_update_ir  = fsm2_update_vld && fsm2_rs_had_ir_sel && (!fsm2_parity);
    assign fsm2_update_dr  = fsm2_update_vld && fsm2_rs_had_dr_sel && (!fsm2_parity);
    
    assign ctrl_chain_shift_ir   = fsm5_shift_ir || fsm2_shift_ir;
    assign ctrl_chain_shift_dr   = fsm5_shift_dr || fsm2_shift_dr;
    assign ctrl_chain_capture_dr = fsm5_capture_dr || fsm2_capture_dr;
    assign ctrl_chain_capture_ir = fsm5_capture_ir || fsm2_capture_ir;
    assign ctrl_chain_shift_par  = fsm2_parity_vld;
    assign ctrl_chain_shift_sync = fsm2_sync_vld;
    assign ctrl_idr_update_ir    = fsm5_update_ir || fsm2_update_ir;
    assign ctrl_idr_update_dr    = fsm5_update_dr || fsm2_update_dr;
    assign ctrl_idr_capture_dr   = fsm5_capture_dr || fsm2_capture_dr;

endmodule






