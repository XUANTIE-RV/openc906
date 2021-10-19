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
module tdt_dtm_idr #(
    parameter                           DTM_IRREG_WIDTH   = 5,
    parameter                           DTM_ABITS         = 16,    
    parameter                           DTM_NDMIREG_WIDTH = 32,
    parameter                           CHAIN_DW          = DTM_ABITS + 32 + 2

)(
    input                               tclk,                 
    input                               trst_b, 
    output     [CHAIN_DW-1:0]           idr_chain_dr, 
    output     [DTM_IRREG_WIDTH-1:0]    idr_chain_ir, 
    input      [CHAIN_DW-1:0]           chain_idr_data,
    output                              idr_dmi_mode,     
    input                               ctrl_idr_update_ir,       
    input                               ctrl_idr_update_dr,
    input                               ctrl_idr_capture_dr,
    output reg                          dmihardreset,

    output                              dtm_apbm_wr_vld,
    output     [DTM_ABITS-1:0]          dtm_apbm_wr_addr,
    output     [1:0]                    dtm_apbm_wr_flg,
    output     [31:0]                   dtm_apbm_wdata,
    input      [31:0]                   apbm_dtm_rdata,
    input                               apbm_dtm_wr_ready
);

    localparam  [DTM_IRREG_WIDTH-1:0]   IDCODE               = 5'h01;
    localparam  [DTM_IRREG_WIDTH-1:0]   DMI_ACC              = 5'h02;
    localparam  [DTM_IRREG_WIDTH-1:0]   DTMCS                = 5'h10;
    localparam  [DTM_IRREG_WIDTH-1:0]   DMI                  = 5'h11;
    localparam  [DTM_NDMIREG_WIDTH-1:0] IDCODE_REG_DEFINE    = {4'h1, 16'h0, 12'b1011_011_0111_1};
    localparam  [3:0]                   DTM_VERSION          = 4'h1;
    localparam  [2:0]                   IDLE_CYCLE           = `TDT_DMI_IDLE_CYCLE;
    
    reg  [DTM_IRREG_WIDTH-1:0]   dtm_ir;
    wire [DTM_NDMIREG_WIDTH-1:0] dtm_idcode;
    //reg                          dmihardreset;
    reg                          dmireset;
    wire [2:0]                   idle;
    wire [1:0]                   dmistat;
    wire [5:0]                   abits;
    wire [3:0]                   version;
    reg  [DTM_ABITS-1:0]         address;
    reg  [31:0]                  data;
    reg  [1:0]                   op;
    reg                          mode;
    reg  [1:0]                   op_stat;
    reg                          wr_vld;
    reg                          dmi_req_running;
    reg  [CHAIN_DW-1:0]          data_out;
   
    wire                         capture_dmi_in_running;
    wire [CHAIN_DW-1:0]          dmi_total;

    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            dtm_ir[DTM_IRREG_WIDTH-1:0] <= IDCODE;
        else if (dmihardreset)
            dtm_ir[DTM_IRREG_WIDTH-1:0] <= IDCODE;
        else if (ctrl_idr_update_ir) 
            dtm_ir[DTM_IRREG_WIDTH-1:0] <= chain_idr_data[DTM_IRREG_WIDTH-1:0];
     
    end
    
    assign dtm_idcode[DTM_NDMIREG_WIDTH-1:0] = IDCODE_REG_DEFINE;
    
    assign idle[2:0]         = IDLE_CYCLE;
    assign dmistat[1:0]      = op_stat[1:0];
    assign abits[5:0]        = DTM_ABITS;
    assign version[3:0]      = DTM_VERSION;
   
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            dmihardreset <= 1'b0;
        else if (dmihardreset)
            dmihardreset <= 1'b0;
        else if (ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DTMCS) 
            dmihardreset <= chain_idr_data[17];
    end

    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            dmireset <= 1'b0;
        else if (dmihardreset)
            dmireset <= 1'b0;
        else if (dmireset)
            dmireset <= 1'b0;
        else if (ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DTMCS) 
            dmireset <= chain_idr_data[16];
    end
 
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            mode <= 1'b0;
        else if (dmihardreset)
            mode <= 1'b0;
        else if (ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI_ACC) 
            mode <= chain_idr_data[0];
    end
    
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            address[DTM_ABITS-1:0] <= {DTM_ABITS{1'b0}};
        else if (dmihardreset)
            address[DTM_ABITS-1:0] <= {DTM_ABITS{1'b0}};
        else if (ctrl_idr_update_dr && !mode && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI && !dmi_req_running)
            address[DTM_ABITS-1:0] <= chain_idr_data[34 +: DTM_ABITS];
    end
    
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            data[31:0] <= 32'h0;
        else if (dmihardreset)
            data[31:0] <= 32'h0;
        else if (ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI && !dmi_req_running) 
            data[31:0] <= chain_idr_data[33:2];
        else if (apbm_dtm_wr_ready && op[1:0] == 2'b01)
        //else if (apbm_dtm_wr_ready)
            data[31:0] <= apbm_dtm_rdata[31:0];
    end
    
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            op[1:0] <= 2'b0;
        else if (dmihardreset)
            op[1:0] <= 2'b0;
        else if (ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI && !dmi_req_running) 
            op[1:0] <= chain_idr_data[1:0];
    end
    
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            wr_vld <= 1'b0;
        else if (dmihardreset)
            wr_vld <= 1'b0;
        else if (wr_vld)
            wr_vld <= 1'b0;
        else if (ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI && (^chain_idr_data[1:0])
                 && op_stat[1:0] == 2'b0 && !dmi_req_running) 
            wr_vld <= 1'b1;
    end
   
    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            dmi_req_running <= 1'b0;
        else if (dmihardreset)
            dmi_req_running <= 1'b0;
        else if (apbm_dtm_wr_ready)
            dmi_req_running <= 1'b0;
        else if (wr_vld) 
            dmi_req_running <= 1'b1;
    end

    assign capture_dmi_in_running = dmi_req_running && ctrl_idr_capture_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI;

    always @ (posedge tclk or negedge trst_b) begin
        if (!trst_b) 
            op_stat[1:0] <= 2'b0;
        else if (dmihardreset)
            op_stat[1:0] <= 2'b0;
        else if (dmireset)
            op_stat[1:0] <= 2'b0;
        else if (dmi_req_running && ctrl_idr_update_dr && dtm_ir[DTM_IRREG_WIDTH-1:0] ==  DMI && (^chain_idr_data[1:0]) ||
                 capture_dmi_in_running) 
            op_stat[1:0] <= 2'b11;
    end

    assign dmi_total[CHAIN_DW-1:0] = capture_dmi_in_running ? {address[DTM_ABITS-1:0], data[31:0], 2'b11} : {address[DTM_ABITS-1:0], data[31:0], op_stat[1:0]};
    
    //generate 
    //    if ((CHAIN_DW-DTM_ABITS-34) == 0) begin : gen_full_dmi
    //        assign dmi_total = {address, data, op_stat};
    //    end else begin : gen_pad_dmi
    //        assign dmi_total = {{CHAIN_DW-DTM_ABITS-34{1'b0}}, address, data, op_stat};
    //    end
    //endgenerate

    always @ (dtm_ir[DTM_IRREG_WIDTH-1:0] or
              dtm_idcode[DTM_NDMIREG_WIDTH-1:0] or
              mode or
              idle[2:0] or
              dmistat[1:0] or
              abits[5:0] or
              version[3:0] or
              dmi_total[CHAIN_DW-1:0]
              ) begin
        case (dtm_ir[DTM_IRREG_WIDTH-1:0])
            IDCODE  : data_out[CHAIN_DW-1:0] = {{CHAIN_DW-DTM_NDMIREG_WIDTH{1'b0}}, dtm_idcode[DTM_NDMIREG_WIDTH-1:0]};
            DMI_ACC : data_out[CHAIN_DW-1:0] = {{CHAIN_DW-1{1'b0}}, mode};
            DTMCS   : data_out[CHAIN_DW-1:0] = {{CHAIN_DW-15{1'b0}}, idle[2:0], dmistat[1:0], abits[5:0], version[3:0]};
            DMI     : data_out[CHAIN_DW-1:0] = dmi_total[CHAIN_DW-1:0];
            default : data_out[CHAIN_DW-1:0] = {CHAIN_DW{1'b0}};
        endcase
    end
   
    assign idr_dmi_mode                      = mode; 
    assign idr_chain_dr[CHAIN_DW-1:0]        = data_out[CHAIN_DW-1:0];
    assign idr_chain_ir[DTM_IRREG_WIDTH-1:0] = dtm_ir[DTM_IRREG_WIDTH-1:0];
    assign dtm_apbm_wr_vld                   = wr_vld;
    assign dtm_apbm_wr_flg[1:0]              = op[1:0];
    assign dtm_apbm_wr_addr[DTM_ABITS-1:0]   = address[DTM_ABITS-1:0];
    assign dtm_apbm_wdata[31:0]              = data[31:0];

    `ifdef ASSERTION
     property update_dr_in_dmi_running_cannot_change_dmi_address;
      @(posedge tclk) (dmi_req_running && !dmihardreset) |-> $stable(address[DTM_ABITS-1:0]);
    endproperty
    assert property(update_dr_in_dmi_running_cannot_change_dmi_address);   

    property update_dr_in_dmi_running_cannot_change_dmi_op;
      @(posedge tclk) (dmi_req_running && !dmihardreset) |-> $stable(op[1:0]);
    endproperty
    assert property(update_dr_in_dmi_running_cannot_change_dmi_op);

    property update_dr_in_dmi_running_cannot_change_dmi_data;
      @(posedge tclk) (dmi_req_running && !dmihardreset && !apbm_dtm_wr_ready) |-> $stable(data[31:0]);
    endproperty
    assert property(update_dr_in_dmi_running_cannot_change_dmi_data);

    property update_dr_in_dmi_running_cannot_start_a_new_operation;
      @(posedge tclk) (dmi_req_running && !dmihardreset) |=> $stable(wr_vld);
    endproperty
    assert property(update_dr_in_dmi_running_cannot_start_a_new_operation);

    property set_op_when_capture_dr_in_dmi_running;
      @(posedge tclk) (dmi_req_running && ctrl_idr_capture_dr && dtm_ir ==  DMI) |-> (dmi_total[1:0] == 2'b11);
    endproperty
    assert property(set_op_when_capture_dr_in_dmi_running);
    `endif

endmodule
