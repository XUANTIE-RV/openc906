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
module tdt_sba_axi
#(  
    parameter   AXI_ADDR_WIDTH = 16,
    parameter   ADD_ALIAN_BITS = `TDT_DM_SBA_BW
)
(

    input                           mclk,
    input                           mreset_b,
    input                           pad_icg_scan_en,
    input                           axim_clk_en,
    //CMD interface
    input   [`TDT_DM_SBA_DW-1:0]    wr_data,
    input                           wr_flg, //1:write, 0:read
    input   [AXI_ADDR_WIDTH-1:0]    wr_addr,
    input                           wr_vld,
    input   [2:0]                   wr_size,
    output reg [`TDT_DM_SBA_DW-1:0] rd_data,
    output reg                      axi_wr_ready,
    output reg                      sba_error,

    //write address channel
    output     [3:0]                awid,
    output reg [AXI_ADDR_WIDTH-1:0] awaddr,
    output     [3:0]                awlen,
    output reg [2:0]                awsize,
    output reg                      awvalid,
    input                           awready,
    //write data channel
    output  reg [`TDT_DM_SBA_DW-1:0]    wdata,
    output  reg [ADD_ALIAN_BITS-1:0]    wstrb,
    output                          wlast,
    output reg                      wvalid,
    input                           wready,
    //write response channel
    input   [3:0]                   bid,
    input   [1:0]                   bresp,
    input                           bvalid,
    output                          bready,
    //read address channel
    output  [3:0]                   arid,
    output reg [AXI_ADDR_WIDTH-1:0] araddr,
    output     [3:0]                arlen,
    output reg [2:0]                arsize,
    output reg                      arvalid,
    input                           arready,
    //read data channel
    input   [3:0]                   rid,
    input   [`TDT_DM_SBA_DW-1:0]    rdata,
    input                           rlast,
    input   [1:0]                   rresp,
    input                           rvalid,
    output                          rready
);
    localparam    ADD_ALIAN_W = $clog2(ADD_ALIAN_BITS);


    reg   [`TDT_DM_SBA_DW-1:0]    s_wr_data;
    reg                           s_wr_flg; //1:write; 0:read
    reg   [AXI_ADDR_WIDTH-1:0]    s_wr_addr;
    reg                           s_wr_vld;
    reg   [2:0]                   s_wr_size;
    reg                           axi_wr_ready_pre;
    reg   [`TDT_DM_SBA_DW-1:0]    rd_data_pre;

    wire                          g_mclk;
    //--------------------------async smp---------------------------
    always @ (posedge g_mclk or negedge mreset_b) begin
        if (!mreset_b)
            s_wr_data[`TDT_DM_SBA_DW-1:0] <= {`TDT_DM_SBA_DW{1'b0}};
        else if (wr_vld & axim_clk_en)
            s_wr_data[`TDT_DM_SBA_DW-1:0] <= wr_data[`TDT_DM_SBA_DW-1:0];    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (!mreset_b)
            s_wr_flg <= 1'b0;
        else if (wr_vld & axim_clk_en)
            s_wr_flg <= wr_flg;    
    end


    always @ (posedge g_mclk or negedge mreset_b) begin
        if (!mreset_b)
            s_wr_addr[AXI_ADDR_WIDTH-1:0] <= {AXI_ADDR_WIDTH{1'b0}};
        else if (wr_vld & axim_clk_en)
            s_wr_addr[AXI_ADDR_WIDTH-1:0] <= wr_addr[AXI_ADDR_WIDTH-1:0];    
    end


    always @ (posedge g_mclk or negedge mreset_b) begin
        if (!mreset_b)
            s_wr_size[2:0] <= 3'b0;
        else if (wr_vld & axim_clk_en)
            s_wr_size[2:0] <= wr_size[2:0];    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (!mreset_b)
            s_wr_vld <= 1'b0;
        else if(axim_clk_en) 
            s_wr_vld <= wr_vld;    
    end
    //--------------------------async smp---------------------------


    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            awvalid <= 1'b0;
        else if (awvalid & awready & axim_clk_en)
            awvalid <= 1'b0;
        else if (s_wr_vld & s_wr_flg & axim_clk_en) 
            awvalid <= 1'b1;    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            wvalid <= 1'b0;
        else if (wvalid & wready & axim_clk_en)
            wvalid <= 1'b0;
        else if (s_wr_vld & s_wr_flg & axim_clk_en) 
            wvalid <= 1'b1;    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            awaddr[AXI_ADDR_WIDTH-1:0] <= {AXI_ADDR_WIDTH{1'b0}};
        else if (s_wr_vld & s_wr_flg & axim_clk_en) 
            awaddr[AXI_ADDR_WIDTH-1:0] <= s_wr_addr[AXI_ADDR_WIDTH-1:0];    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            awsize[2:0] <= 3'b0;
        else if (s_wr_vld & s_wr_flg & axim_clk_en) 
            awsize[2:0] <= s_wr_size[2:0];    
    end

    reg [`TDT_DM_SBA_DW-1:0]     wdata_pre;
    wire [ADD_ALIAN_W-1:0]       addr_alian;
    wire [ADD_ALIAN_BITS-1:0]       wstrb_pre;
    reg  [ADD_ALIAN_BITS-1:0]       wstrb_pre1;

`ifdef TDT_DM_SBA_DW_128
    assign wstrb_pre[ADD_ALIAN_BITS-1:0] = (s_wr_size[2:0] == 3'h4) ? 16'hffff :
                       (s_wr_size[2:0] == 3'h3) ? 16'h00ff : 16'h000f;
`else
  `ifdef TDT_DM_SBA_DW_64
      assign wstrb_pre[ADD_ALIAN_BITS-1:0] = (s_wr_size[2:0] == 3'h3) ? 8'hff : 8'h0f;
  `else
      assign wstrb_pre[ADD_ALIAN_BITS-1:0] = 4'hf;
  `endif
`endif

    assign addr_alian[ADD_ALIAN_W-1:0] = s_wr_addr[ADD_ALIAN_W-1:0];

`ifdef TDT_DM_SBA_DW_128
    always @ (*) begin
        case (addr_alian[ADD_ALIAN_W-1:2])
            2'b00: wdata_pre[`TDT_DM_SBA_DW-1:0] = s_wr_data[`TDT_DM_SBA_DW-1:0];
            2'b01: wdata_pre[`TDT_DM_SBA_DW-1:0] = {s_wr_data[95:0], 32'b0};
            2'b10: wdata_pre[`TDT_DM_SBA_DW-1:0] = {s_wr_data[63:0], 64'b0};
            2'b11: wdata_pre[`TDT_DM_SBA_DW-1:0] = {s_wr_data[31:0], 96'b0};
        endcase
    end

    always @ (*) begin
        case (addr_alian[ADD_ALIAN_W-1:2])
            2'b00: wstrb_pre1[ADD_ALIAN_BITS-1:0] = wstrb_pre[ADD_ALIAN_BITS-1:0];
            2'b01: wstrb_pre1[ADD_ALIAN_BITS-1:0] = {wstrb_pre[11:0], 4'h0};
            2'b10: wstrb_pre1[ADD_ALIAN_BITS-1:0] = {wstrb_pre[7:0],  8'h0};
            2'b11: wstrb_pre1[ADD_ALIAN_BITS-1:0] = {wstrb_pre[3:0],  12'h0};
        endcase
    end

`else
  `ifdef TDT_DM_SBA_DW_64
      always @ (*) begin
        case (addr_alian[ADD_ALIAN_W-1:2])
            1'b0: wdata_pre[`TDT_DM_SBA_DW-1:0] = s_wr_data[`TDT_DM_SBA_DW-1:0];
            1'b1: wdata_pre[`TDT_DM_SBA_DW-1:0] = {s_wr_data[31:0], 32'b0};
        endcase
      end

    always @ (*) begin
        case (addr_alian[ADD_ALIAN_W-1:2])
            1'b0: wstrb_pre1[ADD_ALIAN_BITS-1:0] = wstrb_pre[ADD_ALIAN_BITS-1:0];
            1'b1: wstrb_pre1[ADD_ALIAN_BITS-1:0] = {wstrb_pre[3:0],  4'h0};
        endcase
    end

  `else
    always @ (*) begin  
       wdata_pre[`TDT_DM_SBA_DW-1:0] = s_wr_data[`TDT_DM_SBA_DW-1:0];
    end 

     always @ (*) begin  
       wstrb_pre1[ADD_ALIAN_BITS-1:0] = wstrb_pre[ADD_ALIAN_BITS-1:0];
    end 

  `endif
`endif

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            wdata[`TDT_DM_SBA_DW-1:0] <= {`TDT_DM_SBA_DW{1'b0}};
        else if (s_wr_vld & s_wr_flg & axim_clk_en) 
            wdata[`TDT_DM_SBA_DW-1:0] <= wdata_pre[`TDT_DM_SBA_DW-1:0];    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            wstrb[ADD_ALIAN_BITS-1:0] <= {ADD_ALIAN_BITS{1'b0}};
        else if (s_wr_vld & s_wr_flg & axim_clk_en) 
            wstrb[ADD_ALIAN_BITS-1:0] <= wstrb_pre1[ADD_ALIAN_BITS-1:0];    
    end

    assign bready = 1'b1;

    assign wlast = 1'b1;
    assign awlen[3:0] = 4'h0;
    assign arlen[3:0] = 4'h0;

    assign rready = 1'b1;

    //awid,arid no use
    assign awid[3:0] = 4'b0;
    assign arid[3:0] = 4'b0;


    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            arvalid <= 1'b0;
        else if (arvalid & arready & axim_clk_en)
            arvalid <= 1'b0;
        else if (s_wr_vld & !s_wr_flg & axim_clk_en) 
            arvalid <= 1'b1;    
    end
 
    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            araddr[AXI_ADDR_WIDTH-1:0] <= {AXI_ADDR_WIDTH{1'b0}};
        else if (s_wr_vld & !s_wr_flg & axim_clk_en) 
            araddr[AXI_ADDR_WIDTH-1:0] <= s_wr_addr[AXI_ADDR_WIDTH-1:0];    
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            arsize[2:0] <= 3'b0;
        else if (s_wr_vld & !s_wr_flg & axim_clk_en) 
            arsize[2:0] <= s_wr_size[2:0];    
    end

    reg [`TDT_DM_SBA_DW-1:0] rdata_smp;
    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            rdata_smp[`TDT_DM_SBA_DW-1:0] <= {`TDT_DM_SBA_DW{1'b0}};
        else if (rready & rvalid & axim_clk_en) 
            rdata_smp[`TDT_DM_SBA_DW-1:0] <= rdata[`TDT_DM_SBA_DW-1:0];    
    end                  

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            axi_wr_ready_pre <= 1'b0;
        else if (axi_wr_ready_pre & axim_clk_en)
            axi_wr_ready_pre <= 1'b0;    
        else if (((s_wr_flg && bready & bvalid) | (!s_wr_flg && rready & rvalid)) & axim_clk_en) 
            axi_wr_ready_pre <= 1'b1;

    end

`ifdef TDT_DM_SBA_DW_128
    always @ (*) begin
        case (addr_alian[ADD_ALIAN_W-1:2])
            2'b00 : rd_data_pre[`TDT_DM_SBA_DW-1:0] = rdata_smp[`TDT_DM_SBA_DW-1:0];
            2'b01 : rd_data_pre[`TDT_DM_SBA_DW-1:0] = {32'h0, rdata_smp[127:32]};
            2'b10 : rd_data_pre[`TDT_DM_SBA_DW-1:0] = {64'h0, rdata_smp[127:64]};
            2'b11 : rd_data_pre[`TDT_DM_SBA_DW-1:0] = {96'h0, rdata_smp[127:96]};
        endcase
    end
`else
  `ifdef TDT_DM_SBA_DW_64
     always @ (*) begin
        case (addr_alian[ADD_ALIAN_W-1:2])
            1'b0 : rd_data_pre[`TDT_DM_SBA_DW-1:0] = rdata_smp[`TDT_DM_SBA_DW-1:0];
            1'b1 : rd_data_pre[`TDT_DM_SBA_DW-1:0] = {32'h0, rdata_smp[63:32]};
        endcase
    end
  `else
     always @ (*) begin
         rd_data_pre[`TDT_DM_SBA_DW-1:0] = rdata_smp[`TDT_DM_SBA_DW-1:0];
     end
  `endif     
`endif

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            axi_wr_ready <= 1'b0;
        else if (axi_wr_ready_pre & axim_clk_en)
            axi_wr_ready <= 1'b1;    
        else if (axi_wr_ready & axim_clk_en) 
            axi_wr_ready <= 1'b0;

    end
    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            rd_data[`TDT_DM_SBA_DW-1:0] <= {`TDT_DM_SBA_DW{1'b0}};
        else if (axi_wr_ready_pre & axim_clk_en)
            rd_data[`TDT_DM_SBA_DW-1:0] <= rd_data_pre[`TDT_DM_SBA_DW-1:0];    

    end

    reg sba_error_pre;
    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            sba_error_pre <= 1'b0;
        else if (bready & bvalid & axim_clk_en)
            sba_error_pre <= bresp[1];
        else if (rready & rvalid & axim_clk_en)
            sba_error_pre <= rresp[1];
    end

    always @ (posedge g_mclk or negedge mreset_b) begin
        if (~mreset_b) 
            sba_error <= 1'b0;
        else if (axi_wr_ready_pre & axim_clk_en)
            sba_error <= sba_error_pre;
    end

    reg  axi_work;
    always @ (posedge mclk or negedge mreset_b) begin
        if (~mreset_b) 
            axi_work <= 1'b0;
        else if (axi_wr_ready & axim_clk_en)
            axi_work <= 1'b0;
        else if (wr_vld & axim_clk_en)
            axi_work <= 1'b1;    
    end

    wire  axi_gated_en;
    assign  axi_gated_en = wr_vld | axi_work;

    gated_clk_cell x_gated_clk_cell(
        .clk_in                     (mclk),
        .global_en                  (1'b1),
        .module_en                  (1'b0),
        .local_en                   (axi_gated_en),
        .external_en                (1'b0),
        .pad_yy_icg_scan_en         (pad_icg_scan_en),
        .clk_out                    (g_mclk)
    );

endmodule
