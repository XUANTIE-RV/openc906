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
module tdt_apb_master
#(
    parameter   PADDR_HIGH_WIDTH = 6,
    parameter   PADDR_LOW_WIDTH  = 12,
    parameter   DTM_ADDR_WIDTH   = PADDR_HIGH_WIDTH+PADDR_LOW_WIDTH,
    parameter   PADDR_WIDTH      = PADDR_HIGH_WIDTH+PADDR_LOW_WIDTH+2,
    parameter   SLAVE_NUM        = 1
)
( 
    input                           tck,
    input                           trst_b,
    input                           cmd_vld,
    input   [DTM_ADDR_WIDTH-1:0]    addr,
    input   [1:0]                   wr_flg,
    input   [31:0]                  wdata,
    input                           dmihardreset,
    output  [31:0]                  rdata,
    output                          apb_wr_ready,

    input                           pclk,
    input                           preset_b,
    output reg                      psel,
    output reg                      penable,
    output reg                      pwrite,
    output reg [PADDR_WIDTH-1:0]    paddr,
    output reg [31:0]               pwdata,
    input                           pready,
    input  [31:0]                   prdata,
    input                           pslverr,

    input                           dm_apb_clk_en,
    input                           pad_icg_scan_en
);
    //gated clock out
    wire    apb_pclk;

    //input sync
    wire    cmd_vld_sync; 
    wire    dmihardreset_sync;

    tdt_dmi_pulse_sync x_tdt_dmi_pulse_cmd_vld (
        .src_clk          (tck),
        .dst_clk          (pclk),
        .src_rst_b        (trst_b),
        .dst_rst_b        (preset_b),
        .src_pulse        (cmd_vld),
        .dst_pulse        (cmd_vld_sync)
    );

   tdt_dmi_pulse_sync x_tdt_dmi_pulse_dmihardreset (
        .src_clk          (tck),
        .dst_clk          (pclk),
        .src_rst_b        (trst_b),
        .dst_rst_b        (preset_b),
        .src_pulse        (dmihardreset),
        .dst_pulse        (dmihardreset_sync)
    );
    reg                     apb_wr_ready_pclk_d1;
    reg     [31:0]          prdata_smp;

    //input sample
    reg     [1:0]           wr_flg_smp;
    reg     [DTM_ADDR_WIDTH-1:0]     addr_smp;
    reg     [31:0]          wdata_smp;

    always @ (posedge apb_pclk or negedge preset_b)
    begin
        if(!preset_b)
        begin 
            wr_flg_smp[1:0] <= 2'b0;
            addr_smp[DTM_ADDR_WIDTH-1:0]   <= {DTM_ADDR_WIDTH{1'b0}};
            wdata_smp[31:0]  <= 32'b0;
        end
        else if(dmihardreset_sync)
        begin 
            wr_flg_smp[1:0] <= 2'b0;
            addr_smp[DTM_ADDR_WIDTH-1:0]   <= {DTM_ADDR_WIDTH{1'b0}};
            wdata_smp[31:0]  <= 32'b0;
        end
        else if(cmd_vld_sync)
        begin
            wr_flg_smp[1:0] <= wr_flg[1:0];
            addr_smp[DTM_ADDR_WIDTH-1:0]   <= addr[DTM_ADDR_WIDTH-1:0];
            wdata_smp[31:0]  <= wdata[31:0];
        end
    end

    //APB MASTER FSM
    localparam      IDLE    = 2'b00;
    localparam      APB_SETUP   = 2'b01;
    localparam      APB_ACCESS  = 2'b10;
    reg     [1:0]   p_state;
    reg     [1:0]   n_state;
    wire            addr_is_legal; 
    wire            trans_req;
    reg             cmd_vld_sync_dly;

    always @ (posedge apb_pclk or negedge preset_b)
    begin
        if(!preset_b)
            cmd_vld_sync_dly <= 1'b0;
        else if(dmihardreset_sync)
            cmd_vld_sync_dly <= 1'b0;
        else
            cmd_vld_sync_dly <= cmd_vld_sync;  
    end

    `ifdef TDT_DMI_SINGLE_SLAVE
        assign addr_is_legal = 1'b1;
    `else
        assign addr_is_legal = addr[DTM_ADDR_WIDTH-1:DTM_ADDR_WIDTH-PADDR_HIGH_WIDTH] < ($unsigned(SLAVE_NUM) & {PADDR_HIGH_WIDTH+1{1'b1}});
    `endif

    assign trans_req = cmd_vld_sync_dly & (wr_flg_smp[0] ^ wr_flg_smp[1]) & addr_is_legal;

    always @ (posedge apb_pclk or negedge preset_b)
    begin
        if(!preset_b)
            p_state[1:0] <= 2'b00;
        else if(dmihardreset_sync)
            p_state[1:0] <= 2'b00;
        else
            p_state[1:0] <= n_state[1:0];
    end

    always @ (p_state[1:0] or
              pready or
              trans_req)
    begin
        case(p_state[1:0])
            IDLE    : 
                if(trans_req)
                    n_state[1:0] = APB_SETUP;
                else
                    n_state[1:0] = IDLE;
            APB_SETUP   :   
                n_state[1:0] = APB_ACCESS;
            APB_ACCESS  : 
                if(pready && trans_req)
                    n_state[1:0] = APB_SETUP;
                else if(pready && !trans_req)
                    n_state[1:0] = IDLE;
                else 
                    n_state[1:0] = APB_ACCESS;
            default :   
                n_state[1:0] = IDLE;
        endcase
    end
    
    //psel reg out
    always @ (posedge apb_pclk or negedge preset_b)
    begin
        if(!preset_b)
            psel <= 1'b0;
        else if(dmihardreset_sync)
            psel <= 1'b0;
        else if(p_state[1:0] == IDLE && trans_req)
            psel <= 1'b1;
        else if(p_state[1:0] == APB_ACCESS && pready && !trans_req)//miss pready  at first
            psel <= 1'b0;
    end

    //penable reg out
    always @ (posedge apb_pclk or negedge preset_b)
    begin
        if(!preset_b)
            penable <= 1'b0;
        else if(dmihardreset_sync)
            penable <= 1'b0;
        else if(p_state[1:0] == APB_SETUP)
            penable <= 1'b1;
        else if(p_state[1:0] == APB_ACCESS && pready)
            penable <= 1'b0;
    end

    //pwrite, paddr, pwdata reg out
    always @ (posedge apb_pclk or negedge preset_b)
    begin
        if(!preset_b)
        begin
            pwrite <= 1'b0;
            paddr[PADDR_WIDTH-1:0]  <= {PADDR_WIDTH{1'b0}};
            pwdata[31:0] <= 32'b0;
        end
        else if(dmihardreset_sync)
        begin
            pwrite <= 1'b0;
            paddr[PADDR_WIDTH-1:0]  <= {PADDR_WIDTH{1'b0}};
            pwdata[31:0] <= 32'b0;
        end
        else if(trans_req)
        begin
            pwrite <= wr_flg_smp[1];
            paddr[PADDR_WIDTH-1:0]  <= {addr_smp[DTM_ADDR_WIDTH-1:0], 2'b0};
            pwdata[31:0] <= wdata_smp[31:0];
        end
    end

    //response modify
    wire    apb_wr_ready_pclk;

    assign apb_wr_ready_pclk = pready & penable;

    always @ (posedge apb_pclk or negedge preset_b) begin
        if(!preset_b)
            apb_wr_ready_pclk_d1 <= 1'b0;
        else if(dmihardreset_sync)
            apb_wr_ready_pclk_d1 <= 1'b0;
        else if (apb_wr_ready_pclk_d1)
            apb_wr_ready_pclk_d1 <= 1'b0;    
        else if (apb_wr_ready_pclk) 
            apb_wr_ready_pclk_d1 <= 1'b1;

    end

    always @ (posedge apb_pclk or negedge preset_b) begin
        if(!preset_b)
            prdata_smp[31:0] <= 32'b0;
        else if(dmihardreset_sync)
            prdata_smp[31:0] <= 32'b0;
        else if (apb_wr_ready_pclk)
            prdata_smp[31:0] <= prdata[31:0];

    end

    //output sync
    tdt_dmi_pulse_sync x_tdt_dmi_pulse_sync_1(
        .src_clk        (pclk),
        .dst_clk        (tck),
        .src_rst_b      (preset_b),
        .dst_rst_b      (trst_b),
        .src_pulse      (apb_wr_ready_pclk_d1),
        .dst_pulse      (apb_wr_ready)
    );
    
    //output rdata
    assign rdata[31:0] = prdata_smp[31:0];

    //clock gating enable
    wire    apb_master_clk_en;
    assign apb_master_clk_en = cmd_vld_sync | cmd_vld_sync_dly | psel | apb_wr_ready_pclk_d1 | dmihardreset_sync;
    
    tdt_gated_clk_cell x_tdt_gated_clk_cell(
        .clk_in             (pclk),
        .global_en          (1'b1),
        .module_en          (dm_apb_clk_en),
        .local_en           (apb_master_clk_en),
        .external_en        (1'b0),
        .pad_yy_icg_scan_en (pad_icg_scan_en),
        .clk_out            (apb_pclk)
    );

endmodule
