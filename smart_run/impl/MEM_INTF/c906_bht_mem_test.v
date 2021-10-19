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
`define CLK_PERIOD          10
//`include "../../../cpu/cpu_cfig.h"
// `define BHT_8K
module c906_bht_mem_test(bht_mem_test_pass);

output bht_mem_test_pass;
`ifdef BHT_2K
    parameter LOCAL_DATA_ADDR_WIDTH  = 7;
`elsif BHT_4K
    parameter LOCAL_DATA_ADDR_WIDTH  = 8;
`elsif BHT_8K
    parameter LOCAL_DATA_ADDR_WIDTH  = 9;
`elsif BHT_16K
    parameter LOCAL_DATA_ADDR_WIDTH  = 10;
`endif
    
parameter LOCAL_DATA_DATA_WIDTH = 16;
parameter LOCAL_DATA_WE_WIDTH   = 16;

reg                               forever_clk;

reg  [LOCAL_DATA_ADDR_WIDTH-1:0]  bht_data_idx;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  bht_data_din;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  bht_data_dout;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask_ff;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  golden_data;
reg                               bht_data_gwen;
reg  [LOCAL_DATA_WE_WIDTH-1:0]    bht_data_wen;
reg                               bht_data_cen;
reg                               bht_data_clk;

reg                               bht_mem_test_pass;
//bht data array
`ifdef BHT_2K
    aq_umc_spsram_128x16 x_bht_array(
`elsif BHT_4K
    aq_umc_spsram_256x16 x_bht_array(
`elsif BHT_8K
    aq_umc_spsram_512x16 x_bht_array(
`elsif BHT_16K
    aq_umc_spsram_1024x16 x_bht_array(
`endif
        .A          (bht_data_idx[LOCAL_DATA_ADDR_WIDTH-1:0]  ),
        .CEN        (bht_data_cen                             ),
        .CLK        (bht_data_clk                             ),
        .D          (bht_data_din[LOCAL_DATA_DATA_WIDTH-1:0]  ),
        .GWEN       (bht_data_gwen                            ),
        .Q          (bht_data_dout[LOCAL_DATA_DATA_WIDTH-1:0] ),
        .WEN        (bht_data_wen[LOCAL_DATA_WE_WIDTH-1:0]    )
    );


always
  #(`CLK_PERIOD/2) bht_data_clk = ~bht_data_clk;
always
  #(`CLK_PERIOD/2) forever_clk    = ~forever_clk;

always@(posedge bht_data_clk)
begin
    data_mask <= bht_data_wen[LOCAL_DATA_WE_WIDTH-1:0];
end

integer i;

initial
begin
bht_data_clk = 0;
forever_clk = 0;
bht_mem_test_pass = 0;
repeat(50)@(posedge bht_data_clk)
//cen = 0 test
bht_data_cen = 1;
bht_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
bht_data_gwen = 1'b1;
bht_data_idx = 0;
bht_data_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge bht_data_clk)
    bht_data_cen <= 0;
    bht_data_gwen <= 1'b0;
    bht_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    bht_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    bht_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge bht_data_clk)
    bht_data_gwen <= 1'b1;
    bht_data_wen  <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data   <= bht_data_din;
    @(posedge bht_data_clk)
    @(posedge bht_data_clk)
    if(bht_data_dout != golden_data)
    begin
        $display("bht array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge bht_data_clk)
        $finish;
    end
end

//cen = 1 test
bht_data_cen = 1;
bht_data_gwen = 1'b1;
bht_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
bht_data_idx = 0;
bht_data_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge bht_data_clk)
    bht_data_cen <= 1;
    bht_data_gwen <= 1'b0;
    bht_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    bht_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    bht_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge bht_data_clk)
    bht_data_gwen <= 1'b1;
    bht_data_wen  <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data   <= bht_data_din;
    @(posedge bht_data_clk)
    @(posedge bht_data_clk)
    if(bht_data_dout == golden_data)
    begin
        $display("bht array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge bht_data_clk)
        $finish;
    end
end

//wen test
bht_data_cen = 1;
bht_data_gwen = 1'b1;
bht_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
bht_data_idx = 0;
bht_data_din = 0;
for(i=0;i<LOCAL_DATA_WE_WIDTH;i=i+1)
begin
    @(posedge bht_data_clk)
    bht_data_idx  <= 20;
    bht_data_gwen <= 1'b0;
    bht_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}} >> i;
    bht_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge bht_data_clk)
    bht_data_gwen <= 1'b1;
    bht_data_wen  <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data   <= bht_data_din;
    data_mask_ff  <= data_mask;
    @(posedge bht_data_clk)
    @(posedge bht_data_clk)
    if(golden_data != bht_data_dout & (~data_mask_ff))
    begin
        $display("bht array wen test fail when i is %d, golden_data is 0x%h, data out is 0x%h\n", i, golden_data, bht_data_dout);
        repeat(10)@(posedge bht_data_clk)
        $finish;
    end
end


//read and write test 
bht_data_cen = 1;
bht_data_gwen = 1'b1;
bht_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
bht_data_idx = 0;
bht_data_din = 0;
for(i=0;i<={LOCAL_DATA_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge bht_data_clk)
    bht_data_cen  <= 0;
    bht_data_gwen <= 1'b0;
    bht_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    bht_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    bht_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge bht_data_clk)
    bht_data_gwen <=1'b1;
    bht_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    @(posedge bht_data_clk)
    @(posedge bht_data_clk)
    bht_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i + 1;
    if(bht_data_dout != {LOCAL_DATA_DATA_WIDTH{1'b1}})
    begin
        $display("bht array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge bht_data_clk)
        $finish;
    end
end
        bht_mem_test_pass = 1;
end





endmodule
