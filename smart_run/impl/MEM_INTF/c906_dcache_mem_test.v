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
// `define DCACHE_32K
module c906_dcache_mem_test(dcache_mem_test_pass);

output dcache_mem_test_pass;

`ifdef DCACHE_8K
    parameter LOCAL_DATA_ADDR_WIDTH  = 8;
    parameter LOCAL_TAG_ADDR_WIDTH   = 5;
    parameter LOCAL_TAG_DATA_WIDTH   = 60;
    parameter LOCAL_TAG_WE_WIDTH     = 60;
    parameter LOCAL_DIRTY_ADDR_WIDTH = 5;
`elsif DCACHE_16K
    parameter LOCAL_DATA_ADDR_WIDTH  = 9;
    parameter LOCAL_TAG_ADDR_WIDTH   = 6;
    parameter LOCAL_TAG_DATA_WIDTH   = 58;
    parameter LOCAL_TAG_WE_WIDTH     = 58;
    parameter LOCAL_DIRTY_ADDR_WIDTH = 6;
`elsif DCACHE_32K
    parameter LOCAL_DATA_ADDR_WIDTH  = 10;
    parameter LOCAL_TAG_ADDR_WIDTH   = 6;
    parameter LOCAL_TAG_DATA_WIDTH   = 58;
    parameter LOCAL_TAG_WE_WIDTH     = 58;
    parameter LOCAL_DIRTY_ADDR_WIDTH = 7;
`elsif DCACHE_64K
    parameter LOCAL_DATA_ADDR_WIDTH  = 11;
    parameter LOCAL_TAG_ADDR_WIDTH   = 6;
    parameter LOCAL_TAG_DATA_WIDTH   = 58;
    parameter LOCAL_TAG_WE_WIDTH     = 58;
    parameter LOCAL_DIRTY_ADDR_WIDTH = 8;
`endif
    
parameter LOCAL_DATA_DATA_WIDTH = 64;
parameter LOCAL_DATA_WE_WIDTH   = 64;
parameter LOCAL_DIRTY_DATA_WIDTH = 8;
parameter LOCAL_DIRTY_WE_WIDTH  = 8;

reg                               forever_clk;

reg  [LOCAL_DATA_ADDR_WIDTH-1:0]  dcache_data_idx;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  dcache_data_din;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  dcache_data_dout;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask_ff;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  golden_data;
reg                               dcache_data_gwen;
reg  [LOCAL_DATA_WE_WIDTH-1:0]    dcache_data_wen;
reg                               dcache_data_cen;
reg                               dcache_data_clk;

reg  [LOCAL_TAG_ADDR_WIDTH-1:0]   dcache_tag_idx;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   dcache_tag_din;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   dcache_tag_dout;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   tag_mask;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   tag_mask_ff;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   golden_tag;
reg                               dcache_tag_gwen;
reg  [LOCAL_TAG_WE_WIDTH-1:0]     dcache_tag_wen;
reg                               dcache_tag_cen;
reg                               dcache_tag_clk;

reg  [LOCAL_DIRTY_ADDR_WIDTH-1:0] dcache_dirty_idx;
reg  [LOCAL_DIRTY_DATA_WIDTH-1:0] dcache_dirty_din;
reg  [LOCAL_DIRTY_DATA_WIDTH-1:0] dcache_dirty_dout;
reg  [LOCAL_DIRTY_DATA_WIDTH-1:0] dirty_mask;
reg  [LOCAL_DIRTY_DATA_WIDTH-1:0] dirty_mask_ff;
reg  [LOCAL_DIRTY_DATA_WIDTH-1:0] golden_dirty;
reg                               dcache_dirty_gwen;
reg  [LOCAL_DIRTY_WE_WIDTH-1:0]   dcache_dirty_wen;
reg                               dcache_dirty_cen;
reg                               dcache_dirty_clk;

reg                               dcache_mem_test_pass;

//dcache data array
`ifdef DCACHE_8K
    aq_umc_spsram_256x64 x_data_array(
`endif
`ifdef DCACHE_16K
    aq_umc_spsram_512x64 x_data_array(
`endif
`ifdef DCACHE_32K
    aq_umc_spsram_1024x64 x_data_array(
`endif
`ifdef DCACHE_64K
    aq_umc_spsram_2048x64 x_data_array(
`endif
        .A          (dcache_data_idx[LOCAL_DATA_ADDR_WIDTH-1:0]  ),
        .CEN        (dcache_data_cen                             ),
        .CLK        (dcache_data_clk                             ),
        .D          (dcache_data_din[LOCAL_DATA_DATA_WIDTH-1:0]  ),
        .GWEN       (dcache_data_gwen                            ),
        .Q          (dcache_data_dout[LOCAL_DATA_DATA_WIDTH-1:0] ),
        .WEN        (dcache_data_wen[LOCAL_DATA_WE_WIDTH-1:0]     )
    );

`ifdef DCACHE_8K
    aq_umc_spsram_32x60 x_tag_array(
`endif
`ifdef DCACHE_16K
    aq_umc_spsram_64x58 x_tag_array(
`endif
`ifdef DCACHE_32K
    aq_umc_spsram_64x58 x_tag_array(
`endif
`ifdef DCACHE_64K
    aq_umc_spsram_64x58 x_tag_array(
`endif
        .A          (dcache_tag_idx[LOCAL_TAG_ADDR_WIDTH-1:0]  ),
        .CEN        (dcache_tag_cen                            ),
        .CLK        (dcache_tag_clk                            ),
        .D          (dcache_tag_din[LOCAL_TAG_DATA_WIDTH-1:0]  ),
        .GWEN       (dcache_tag_gwen                           ),
        .Q          (dcache_tag_dout[LOCAL_TAG_DATA_WIDTH-1:0] ),
        .WEN        (dcache_tag_wen[LOCAL_TAG_WE_WIDTH-1:0]    )
    );


`ifdef DCACHE_8K
    aq_umc_spsram_32x8 x_dirty_array(
`endif
`ifdef DCACHE_16K
    aq_umc_spsram_64x8 x_dirty_array(
`endif
`ifdef DCACHE_32K
    aq_umc_spsram_128x8 x_dirty_array(
`endif
`ifdef DCACHE_64K
    aq_umc_spsram_256x8 x_dirty_array(
`endif
        .A          (dcache_dirty_idx[LOCAL_DIRTY_ADDR_WIDTH-1:0]  ),
        .CEN        (dcache_dirty_cen                            ),
        .CLK        (dcache_dirty_clk                            ),
        .D          (dcache_dirty_din[LOCAL_DIRTY_DATA_WIDTH-1:0]),
        .GWEN       (dcache_dirty_gwen                           ),
        .Q          (dcache_dirty_dout[LOCAL_DIRTY_DATA_WIDTH-1:0] ),
        .WEN        (dcache_dirty_wen[LOCAL_DIRTY_WE_WIDTH-1:0]    )
    );  

always
  #(`CLK_PERIOD/2) dcache_data_clk = ~dcache_data_clk;
always
  #(`CLK_PERIOD/2) dcache_tag_clk = ~dcache_tag_clk;
always
  #(`CLK_PERIOD/2) dcache_dirty_clk = ~dcache_dirty_clk;
always
  #(`CLK_PERIOD/2) forever_clk    = ~forever_clk;

always@(posedge dcache_data_clk)
begin
    data_mask <= dcache_data_wen[LOCAL_DATA_DATA_WIDTH-1:0];
end

always@(posedge dcache_tag_clk)
begin
    tag_mask <= dcache_tag_wen[LOCAL_TAG_DATA_WIDTH-1:0];
end

always@(posedge dcache_dirty_clk)
begin
    dirty_mask <= dcache_dirty_wen[LOCAL_DIRTY_DATA_WIDTH-1:0];
end

integer i;

initial
begin
dcache_data_clk = 0;
dcache_tag_clk = 0;
dcache_dirty_clk = 0;
dcache_mem_test_pass = 0;
forever_clk = 0;
repeat(50)@(posedge dcache_data_clk)
//cen = 0 test
dcache_data_cen = 1;
dcache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
dcache_data_gwen = 1'b1;
dcache_data_idx = 0;
dcache_data_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge dcache_data_clk)
    dcache_data_cen <= 0;
    dcache_data_gwen <= 1'b0;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    dcache_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    dcache_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge dcache_data_clk)
    dcache_data_gwen <= 1'b1;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= dcache_data_din;
    @(posedge dcache_data_clk)
    @(posedge dcache_data_clk)
    if(dcache_data_dout != golden_data)
    begin
        $display("data array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge dcache_data_clk)
        $finish;
    end
end

//cen = 1 test
dcache_data_cen = 1;
dcache_data_gwen = 1'b1;
dcache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
dcache_data_idx = 0;
dcache_data_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge dcache_data_clk)
    dcache_data_cen <= 1;
    dcache_data_gwen <= 1'b0;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    dcache_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    dcache_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge dcache_data_clk)
    dcache_data_gwen <= 1'b1;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= dcache_data_din;
    @(posedge dcache_data_clk)
    @(posedge dcache_data_clk)
    if(dcache_data_dout == golden_data)
    begin
        $display("data array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge dcache_data_clk)
        $finish;
    end
end

//wen test
dcache_data_cen = 1;
dcache_data_gwen = 1'b1;
dcache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
dcache_data_idx = 0;
dcache_data_din = 0;
for(i=0;i<LOCAL_DATA_WE_WIDTH;i=i+1)
begin
    @(posedge dcache_data_clk)
    dcache_data_idx  <= 20;
    dcache_data_gwen <= 1'b0;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}} >> i;
    dcache_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge dcache_data_clk)
    dcache_data_gwen <= 1'b1;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= dcache_data_din;
    data_mask_ff     <= data_mask;
    @(posedge dcache_data_clk)
    @(posedge dcache_data_clk)
    if(golden_data != dcache_data_dout & (~data_mask_ff))
    begin
        $display("data array wen test fail when i is %d, golden_data is 0x%h, data out is 0x%h\n", i, golden_data, dcache_data_dout);
        repeat(10)@(posedge dcache_data_clk)
        $finish;
    end
end


//read and write test 
dcache_data_cen = 1;
dcache_data_gwen = 1'b1;
dcache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
dcache_data_idx = 0;
dcache_data_din = 0;
for(i=0;i<={LOCAL_DATA_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge dcache_data_clk)
    dcache_data_cen  <= 0;
    dcache_data_gwen <= 1'b0;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    dcache_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    dcache_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge dcache_data_clk)
    dcache_data_gwen <=1'b1;
    dcache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    @(posedge dcache_data_clk)
    @(posedge dcache_data_clk)
    dcache_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i + 1;
    if(dcache_data_dout != {LOCAL_DATA_DATA_WIDTH{1'b1}})
    begin
        $display("data array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge dcache_data_clk)
        $finish;
    end
end





//tag array test
//cen = 0 test
repeat(50)@(posedge dcache_tag_clk)
dcache_tag_cen = 1;
dcache_tag_gwen = 1'b1;
dcache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
dcache_tag_idx = 0;
dcache_tag_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge dcache_tag_clk)
    dcache_tag_cen <= 0;
    dcache_tag_gwen <= 1'b0;
    dcache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    dcache_tag_idx <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    dcache_tag_din <= {LOCAL_TAG_DATA_WIDTH{1'b1}} - i;
    @(posedge dcache_tag_clk)
    dcache_tag_gwen <= 1'b1;
    dcache_tag_wen  <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= dcache_tag_din;
    @(posedge dcache_tag_clk)
    @(posedge dcache_tag_clk)
    if(dcache_tag_dout != golden_tag)
    begin
        $display("tag array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge dcache_tag_clk)
        $finish;
    end
end

//cen = 1 test
dcache_tag_cen = 1;
dcache_tag_gwen = 1'b1;
dcache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
dcache_tag_idx = 0;
dcache_tag_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge dcache_tag_clk)
    dcache_tag_cen <= 1;
    dcache_tag_gwen <= 1'b0;
    dcache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    dcache_tag_idx <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    dcache_tag_din <= {LOCAL_TAG_DATA_WIDTH{1'b0}} + i;
    @(posedge dcache_tag_clk)
    dcache_tag_gwen <= 1'b1;
    dcache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= dcache_tag_din;
    @(posedge dcache_tag_clk)
    @(posedge dcache_tag_clk)
    if(dcache_tag_dout == golden_tag)
    begin
        $display("tag array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge dcache_tag_clk)
        $finish;
    end
end

//wen test
dcache_tag_cen = 1;
dcache_tag_gwen = 1'b1;
dcache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
dcache_tag_idx = 0;
dcache_tag_din = 0;
for(i=0;i<LOCAL_TAG_WE_WIDTH;i=i+1)
begin
    @(posedge dcache_tag_clk)
    dcache_tag_idx  <= 20;
    dcache_tag_gwen <= 1'b0;
    dcache_tag_wen  <= {LOCAL_TAG_WE_WIDTH{1'b1}} >> i;
    dcache_tag_din  <= {LOCAL_TAG_DATA_WIDTH{1'b1}};
    @(posedge dcache_tag_clk)
    dcache_tag_gwen <= 1'b1;
    dcache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= dcache_tag_din;
    tag_mask_ff     <= tag_mask;
    @(posedge dcache_tag_clk)
    @(posedge dcache_tag_clk)
    if(golden_tag != dcache_tag_dout & (~tag_mask_ff))
    begin
        $display("tag array wen test fail when i is %d, golden_tag is 0x%h, data out is 0x%h\n", i, golden_tag, dcache_tag_dout);
        repeat(10)@(posedge dcache_tag_clk)
        $finish;
    end
end


//read and write test 
dcache_tag_cen = 1;
dcache_tag_gwen = 1'b1;
dcache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
dcache_tag_idx = 0;
dcache_tag_din = 0;
for(i=0;i<={LOCAL_TAG_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge dcache_tag_clk)
    dcache_tag_cen  <= 0;
    dcache_tag_gwen <= 1'b0;
    dcache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    dcache_tag_idx  <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    dcache_tag_din  <= {LOCAL_TAG_DATA_WIDTH{1'b1}};
    @(posedge dcache_tag_clk)
    dcache_tag_gwen <= 1'b1;
    dcache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    @(posedge dcache_tag_clk)
    @(posedge dcache_tag_clk)
    dcache_tag_idx  <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i + 1;
    if(dcache_tag_dout != {LOCAL_TAG_DATA_WIDTH{1'b1}})
    begin
        $display("tag array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge dcache_tag_clk)
        $finish;
    end
end



//dirty array test
//cen = 0 test
repeat(50)@(posedge dcache_dirty_clk)
dcache_dirty_cen = 1;
dcache_dirty_gwen = 1'b1;
dcache_dirty_wen = {LOCAL_DIRTY_WE_WIDTH{1'b1}};
dcache_dirty_idx = 0;
dcache_dirty_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge dcache_dirty_clk)
    dcache_dirty_cen <= 0;
    dcache_dirty_gwen <= 1'b0;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b0}};
    dcache_dirty_idx <= {LOCAL_DIRTY_ADDR_WIDTH{1'b0}} + i;
    dcache_dirty_din <= {LOCAL_DIRTY_DATA_WIDTH{1'b1}} - i;
    @(posedge dcache_dirty_clk)
    dcache_dirty_gwen <= 1'b1;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b1}};
    golden_dirty      <= dcache_dirty_din;
    @(posedge dcache_dirty_clk)
    @(posedge dcache_dirty_clk)
    if(dcache_dirty_dout != golden_dirty)
    begin
        $display("dirty array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge dcache_dirty_clk)
        $finish;
    end
end

//cen = 1 test
dcache_dirty_cen = 1;
dcache_dirty_gwen = 1'b1;
dcache_dirty_wen = {LOCAL_DIRTY_WE_WIDTH{1'b1}};
dcache_dirty_idx = 0;
dcache_dirty_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge dcache_dirty_clk)
    dcache_dirty_cen <= 1;
    dcache_dirty_gwen <= 1'b0;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b0}};
    dcache_dirty_idx <= {LOCAL_DIRTY_ADDR_WIDTH{1'b0}} + i;
    dcache_dirty_din <= {LOCAL_DIRTY_DATA_WIDTH{1'b0}} + i;
    @(posedge dcache_dirty_clk)
    dcache_dirty_gwen <= 1'b1;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b1}};
    golden_dirty      <= dcache_dirty_din;
    @(posedge dcache_dirty_clk)
    @(posedge dcache_dirty_clk)
    if(dcache_dirty_dout == golden_dirty)
    begin
        $display("dirty array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge dcache_dirty_clk)
        $finish;
    end
end

//wen test
dcache_dirty_cen = 1;
dcache_dirty_gwen = 1'b1;
dcache_dirty_wen = {LOCAL_DIRTY_WE_WIDTH{1'b1}};
dcache_dirty_idx = 0;
dcache_dirty_din = 0;
for(i=0;i<LOCAL_DIRTY_WE_WIDTH;i=i+1)
begin
    @(posedge dcache_dirty_clk)
    dcache_dirty_idx  <= 20;
    dcache_dirty_gwen <= 1'b0;
    dcache_dirty_wen  <= {LOCAL_DIRTY_WE_WIDTH{1'b1}} >> i;
    dcache_dirty_din  <= {LOCAL_DIRTY_DATA_WIDTH{1'b1}};
    @(posedge dcache_dirty_clk)
    dcache_dirty_gwen <= 1'b1;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b1}};
    golden_dirty      <= dcache_dirty_din;
    dirty_mask_ff     <= dirty_mask;
    @(posedge dcache_dirty_clk)
    @(posedge dcache_dirty_clk)
    if(golden_dirty != dcache_dirty_dout & (~dirty_mask_ff))
    begin
        $display("dirty array wen test fail when i is %d, golden_dirty is 0x%h, data out is 0x%h\n", i, golden_dirty, dcache_dirty_dout);
        repeat(10)@(posedge dcache_dirty_clk)
        $finish;
    end
end


//read and write test 
dcache_dirty_cen = 1;
dcache_dirty_gwen = 1'b1;
dcache_dirty_wen = {LOCAL_DIRTY_WE_WIDTH{1'b1}};
dcache_dirty_idx = 0;
dcache_dirty_din = 0;
for(i=0;i<={LOCAL_DIRTY_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge dcache_dirty_clk)
    dcache_dirty_cen  <= 0;
    dcache_dirty_gwen <= 1'b0;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b0}};
    dcache_dirty_idx  <= {LOCAL_DIRTY_ADDR_WIDTH{1'b0}} + i;
    dcache_dirty_din  <= {LOCAL_DIRTY_DATA_WIDTH{1'b1}};
    @(posedge dcache_dirty_clk)
    dcache_dirty_gwen <= 1'b1;
    dcache_dirty_wen <= {LOCAL_DIRTY_WE_WIDTH{1'b1}};
    @(posedge dcache_dirty_clk)
    @(posedge dcache_dirty_clk)
    dcache_dirty_idx  <= {LOCAL_DIRTY_ADDR_WIDTH{1'b0}} + i + 1;
    if(dcache_dirty_dout != {LOCAL_DIRTY_DATA_WIDTH{1'b1}})
    begin
        $display("dirty array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge dcache_dirty_clk)
        $finish;
    end
        dcache_mem_test_pass = 1;
end

end




endmodule
