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
// `define JTLB_ENTRY_256
module c906_mmu_mem_test(mmu_mem_test_pass);

output mmu_mem_test_pass;
`ifdef JTLB_ENTRY_128
    parameter LOCAL_DATA_ADDR_WIDTH  = 6;
    parameter LOCAL_TAG_ADDR_WIDTH   = 6;
`elsif JTLB_ENTRY_256
    parameter LOCAL_DATA_ADDR_WIDTH  = 7;
    parameter LOCAL_TAG_ADDR_WIDTH   = 7;
`elsif JTLB_ENTRY_512
    parameter LOCAL_DATA_ADDR_WIDTH  = 8;
    parameter LOCAL_TAG_ADDR_WIDTH   = 8;
`endif
    
parameter LOCAL_DATA_DATA_WIDTH = 88;
parameter LOCAL_DATA_WE_WIDTH   = 88;
parameter LOCAL_TAG_DATA_WIDTH  = 98;
parameter LOCAL_TAG_WE_WIDTH    = 98;

reg                               forever_clk;

reg  [LOCAL_DATA_ADDR_WIDTH-1:0]  mmu_data_idx;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  mmu_data_din;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  mmu_data_dout;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask_ff;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  golden_data;
reg                               mmu_data_gwen;
reg  [LOCAL_DATA_WE_WIDTH-1:0]    mmu_data_wen;
reg                               mmu_data_cen;
reg                               mmu_data_clk;

reg  [LOCAL_TAG_ADDR_WIDTH-1:0]   mmu_tag_idx;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   mmu_tag_din;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   mmu_tag_dout;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   tag_mask;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   tag_mask_ff;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   golden_tag;
reg                               mmu_tag_gwen;
reg  [LOCAL_TAG_WE_WIDTH-1:0]     mmu_tag_wen;
reg                               mmu_tag_cen;
reg                               mmu_tag_clk;

reg                               mmu_mem_test_pass;

//mmu data array
`ifdef JTLB_ENTRY_128
    aq_umc_spsram_64x88  x_data_array(
`endif
`ifdef JTLB_ENTRY_256
    aq_umc_spsram_128x88 x_data_array(
`endif
`ifdef JTLB_ENTRY_512
    aq_umc_spsram_256x88 x_data_array(
`endif
        .A          (mmu_data_idx[LOCAL_DATA_ADDR_WIDTH-1:0]  ),
        .CEN        (mmu_data_cen                             ),
        .CLK        (mmu_data_clk                             ),
        .D          (mmu_data_din[LOCAL_DATA_DATA_WIDTH-1:0]  ),
        .GWEN       (mmu_data_gwen                            ),
        .Q          (mmu_data_dout[LOCAL_DATA_DATA_WIDTH-1:0] ),
        .WEN        (mmu_data_wen[LOCAL_DATA_WE_WIDTH-1:0]    )
    );

`ifdef JTLB_ENTRY_128
    aq_umc_spsram_64x98 x_tag_array(
`endif
`ifdef JTLB_ENTRY_256
    aq_umc_spsram_128x98 x_tag_array(
`endif
`ifdef JTLB_ENTRY_512
    aq_umc_spsram_256x98 x_tag_array(
`endif
        .A          (mmu_tag_idx[LOCAL_TAG_ADDR_WIDTH-1:0]  ),
        .CEN        (mmu_tag_cen                            ),
        .CLK        (mmu_tag_clk                            ),
        .D          (mmu_tag_din[LOCAL_TAG_DATA_WIDTH-1:0]  ),
        .GWEN       (mmu_tag_gwen                           ),
        .Q          (mmu_tag_dout[LOCAL_TAG_DATA_WIDTH-1:0] ),
        .WEN        (mmu_tag_wen[LOCAL_TAG_WE_WIDTH-1:0]    )
    );
always
  #(`CLK_PERIOD/2) mmu_data_clk = ~mmu_data_clk;
always
  #(`CLK_PERIOD/2) mmu_tag_clk = ~mmu_tag_clk;
always
  #(`CLK_PERIOD/2) forever_clk    = ~forever_clk;

always@(posedge mmu_data_clk)
begin
    data_mask <= mmu_data_wen[LOCAL_DATA_WE_WIDTH-1:0];
end

always@(posedge mmu_tag_clk)
begin
    tag_mask <= mmu_tag_wen[LOCAL_TAG_WE_WIDTH-1:0];
end

integer i;

initial
begin
mmu_data_clk = 0;
mmu_tag_clk = 0;
forever_clk = 0;
mmu_mem_test_pass = 0;
repeat(50)@(posedge mmu_data_clk)
//cen = 0 test
mmu_data_cen = 1;
mmu_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
mmu_data_gwen = 1'b1;
mmu_data_idx = 0;
mmu_data_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge mmu_data_clk)
    mmu_data_cen <= 0;
    mmu_data_gwen <= 1'b0;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    mmu_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    mmu_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge mmu_data_clk)
    mmu_data_gwen <= 1'b1;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= mmu_data_din;
    @(posedge mmu_data_clk)
    @(posedge mmu_data_clk)
    if(mmu_data_dout != golden_data)
    begin
        $display("data array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge mmu_data_clk)
        $finish;
    end
end

//cen = 1 test
mmu_data_cen = 1;
mmu_data_gwen = 1'b1;
mmu_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
mmu_data_idx = 0;
mmu_data_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge mmu_data_clk)
    mmu_data_cen <= 1;
    mmu_data_gwen <= 1'b0;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    mmu_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    mmu_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge mmu_data_clk)
    mmu_data_gwen <= 1'b1;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= mmu_data_din;
    @(posedge mmu_data_clk)
    @(posedge mmu_data_clk)
    if(mmu_data_dout == golden_data)
    begin
        $display("data array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge mmu_data_clk)
        $finish;
    end
end

//wen test
mmu_data_cen = 1;
mmu_data_gwen = 1'b1;
mmu_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
mmu_data_idx = 0;
mmu_data_din = 0;
for(i=0;i<LOCAL_DATA_WE_WIDTH;i=i+1)
begin
    @(posedge mmu_data_clk)
    mmu_data_idx  <= 20;
    mmu_data_gwen <= 1'b0;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}} >> i;
    mmu_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge mmu_data_clk)
    mmu_data_gwen <= 1'b1;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= mmu_data_din;
    data_mask_ff     <= data_mask;
    @(posedge mmu_data_clk)
    @(posedge mmu_data_clk)
    if(golden_data != mmu_data_dout & (~data_mask_ff))
    begin
        $display("data array wen test fail when i is %d, golden_data is 0x%h, data out is 0x%h\n", i, golden_data, mmu_data_dout);
        repeat(10)@(posedge mmu_data_clk)
        $finish;
    end
end


//read and write test 
mmu_data_cen = 1;
mmu_data_gwen = 1'b1;
mmu_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
mmu_data_idx = 0;
mmu_data_din = 0;
for(i=0;i<={LOCAL_DATA_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge mmu_data_clk)
    mmu_data_cen  <= 0;
    mmu_data_gwen <= 1'b0;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    mmu_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    mmu_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge mmu_data_clk)
    mmu_data_gwen <=1'b1;
    mmu_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    @(posedge mmu_data_clk)
    @(posedge mmu_data_clk)
    mmu_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i + 1;
    if(mmu_data_dout != {LOCAL_DATA_DATA_WIDTH{1'b1}})
    begin
        $display("data array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge mmu_data_clk)
        $finish;
    end
end





//tag array test
//cen = 0 test
repeat(50)@(posedge mmu_tag_clk)
mmu_tag_cen = 1;
mmu_tag_gwen = 1'b1;
mmu_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
mmu_tag_idx = 0;
mmu_tag_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge mmu_tag_clk)
    mmu_tag_cen <= 0;
    mmu_tag_gwen <= 1'b0;
    mmu_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    mmu_tag_idx <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    mmu_tag_din <= {LOCAL_TAG_DATA_WIDTH{1'b1}} - i;
    @(posedge mmu_tag_clk)
    mmu_tag_gwen <= 1'b1;
    mmu_tag_wen  <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= mmu_tag_din;
    @(posedge mmu_tag_clk)
    @(posedge mmu_tag_clk)
    if(mmu_tag_dout != golden_tag)
    begin
        $display("tag array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge mmu_tag_clk)
        $finish;
    end
end

//cen = 1 test
mmu_tag_cen = 1;
mmu_tag_gwen = 1'b1;
mmu_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
mmu_tag_idx = 0;
mmu_tag_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge mmu_tag_clk)
    mmu_tag_cen <= 1;
    mmu_tag_gwen <= 1'b0;
    mmu_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    mmu_tag_idx <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    mmu_tag_din <= {LOCAL_TAG_DATA_WIDTH{1'b0}} + i;
    @(posedge mmu_tag_clk)
    mmu_tag_gwen <= 1'b1;
    mmu_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= mmu_tag_din;
    @(posedge mmu_tag_clk)
    @(posedge mmu_tag_clk)
    if(mmu_tag_dout == golden_tag)
    begin
        $display("tag array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge mmu_tag_clk)
        $finish;
    end
end

//wen test
mmu_tag_cen = 1;
mmu_tag_gwen = 1'b1;
mmu_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
mmu_tag_idx = 0;
mmu_tag_din = 0;
for(i=0;i<LOCAL_TAG_WE_WIDTH;i=i+1)
begin
    @(posedge mmu_tag_clk)
    mmu_tag_idx  <= 20;
    mmu_tag_gwen <= 1'b0;
    mmu_tag_wen  <= {LOCAL_TAG_WE_WIDTH{1'b1}} >> i;
    mmu_tag_din  <= {LOCAL_TAG_DATA_WIDTH{1'b1}};
    @(posedge mmu_tag_clk)
    mmu_tag_gwen <= 1'b1;
    mmu_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= mmu_tag_din;
    tag_mask_ff     <= tag_mask;
    @(posedge mmu_tag_clk)
    @(posedge mmu_tag_clk)
    if(golden_tag != mmu_tag_dout & (~tag_mask_ff))
    begin
        $display("tag array wen test fail when i is %d, golden_data is 0x%h, data out is 0x%h\n", i, golden_tag, mmu_tag_dout);
        repeat(10)@(posedge mmu_tag_clk)
        $finish;
    end
end


//read and write test 
mmu_tag_cen = 1;
mmu_tag_gwen = 1'b1;
mmu_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
mmu_tag_idx = 0;
mmu_tag_din = 0;
for(i=0;i<={LOCAL_TAG_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge mmu_tag_clk)
    mmu_tag_cen  <= 0;
    mmu_tag_gwen <= 1'b0;
    mmu_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    mmu_tag_idx  <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    mmu_tag_din  <= {LOCAL_TAG_DATA_WIDTH{1'b1}};
    @(posedge mmu_tag_clk)
    mmu_tag_gwen <= 1'b1;
    mmu_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    @(posedge mmu_tag_clk)
    @(posedge mmu_tag_clk)
    mmu_tag_idx  <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i + 1;
    if(mmu_tag_dout != {LOCAL_TAG_DATA_WIDTH{1'b1}})
    begin
        $display("tag array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge mmu_tag_clk)
        $finish;
    end
        mmu_mem_test_pass = 1;
end

end




endmodule
