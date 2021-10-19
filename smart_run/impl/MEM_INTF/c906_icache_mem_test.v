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
// `define ICACHE_32K
module c906_icache_mem_test(icache_mem_test_pass);

output icache_mem_test_pass;
`ifdef ICACHE_8K
    parameter LOCAL_DATA_ADDR_WIDTH  = 9;
    parameter LOCAL_TAG_ADDR_WIDTH   = 6;
`elsif ICACHE_16K
    parameter LOCAL_DATA_ADDR_WIDTH  = 10
    parameter LOCAL_TAG_ADDR_WIDTH   = 7;
`elsif ICACHE_32K
    parameter LOCAL_DATA_ADDR_WIDTH  = 11;
    parameter LOCAL_TAG_ADDR_WIDTH   = 8;
`elsif ICACHE_64K
    parameter LOCAL_DATA_ADDR_WIDTH  = 12;
    parameter LOCAL_TAG_ADDR_WIDTH   = 9;
`endif
    
parameter LOCAL_DATA_DATA_WIDTH  = 32;
parameter LOCAL_DATA_WE_WIDTH    = 32;
parameter LOCAL_TAG_DATA_WIDTH   = 59;
parameter LOCAL_TAG_WE_WIDTH     = 59;

reg                               forever_clk;

reg  [LOCAL_DATA_ADDR_WIDTH-1:0]  icache_data_idx;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  icache_data_din;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  icache_data_dout;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  data_mask_ff;
reg  [LOCAL_DATA_DATA_WIDTH-1:0]  golden_data;
reg                               icache_data_gwen;
reg  [LOCAL_DATA_WE_WIDTH-1:0]    icache_data_wen;
reg                               icache_data_cen;
reg                               icache_data_clk;

reg  [LOCAL_TAG_ADDR_WIDTH-1:0]   icache_tag_idx;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   icache_tag_din;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   icache_tag_dout;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   tag_mask;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   tag_mask_ff;
reg  [LOCAL_TAG_DATA_WIDTH-1:0]   golden_tag;
reg                               icache_tag_gwen;
reg  [LOCAL_TAG_WE_WIDTH-1:0]     icache_tag_wen;
reg                               icache_tag_cen;
reg                               icache_tag_clk;

reg                               icache_mem_test_pass;


//icache data array
`ifdef ICACHE_8K
    aq_umc_spsram_512x32 x_data_array(
`endif
`ifdef ICACHE_16K
    aq_umc_spsram_1024x32 x_data_array(
`endif
`ifdef ICACHE_32K
    aq_umc_spsram_2048x32 x_data_array(
`endif
`ifdef ICACHE_64K
    aq_umc_spsram_4096x32 x_data_array(
`endif
        .A          (icache_data_idx[LOCAL_DATA_ADDR_WIDTH-1:0]  ),
        .CEN        (icache_data_cen                             ),
        .CLK        (icache_data_clk                             ),
        .D          (icache_data_din[LOCAL_DATA_DATA_WIDTH-1:0]  ),
        .GWEN       (icache_data_gwen                            ),
        .Q          (icache_data_dout[LOCAL_DATA_DATA_WIDTH-1:0] ),
        .WEN        (icache_data_wen[LOCAL_DATA_WE_WIDTH-1:0]    )
    );

`ifdef ICACHE_8K
    aq_umc_spsram_64x59 x_tag_array(
`endif
`ifdef ICACHE_16K
    aq_umc_spsram_128x59 x_tag_array(
`endif
`ifdef ICACHE_32K
    aq_umc_spsram_256x59 x_tag_array(
`endif
`ifdef ICACHE_64K
    aq_umc_spsram_512x59 x_tag_array(
`endif
        .A          (icache_tag_idx[LOCAL_TAG_ADDR_WIDTH-1:0]  ),
        .CEN        (icache_tag_cen                            ),
        .CLK        (icache_tag_clk                            ),
        .D          (icache_tag_din[LOCAL_TAG_DATA_WIDTH-1:0]  ),
        .GWEN       (icache_tag_gwen                           ),
        .Q          (icache_tag_dout[LOCAL_TAG_DATA_WIDTH-1:0] ),
        .WEN        (icache_tag_wen[LOCAL_TAG_WE_WIDTH-1:0]    )
    );
always
  #(`CLK_PERIOD/2) icache_data_clk = ~icache_data_clk;
always
  #(`CLK_PERIOD/2) icache_tag_clk = ~icache_tag_clk;
always
  #(`CLK_PERIOD/2) forever_clk    = ~forever_clk;

always@(posedge icache_data_clk)
begin
    data_mask <= icache_data_wen[LOCAL_DATA_WE_WIDTH-1:0];
end

always@(posedge icache_tag_clk)
begin
    tag_mask <= icache_tag_wen[LOCAL_TAG_WE_WIDTH-1:0];
end

integer i;

initial
begin
icache_data_clk = 0;
icache_tag_clk = 0;
forever_clk = 0;
icache_mem_test_pass = 0;
repeat(50)@(posedge icache_data_clk)
//cen = 0 test
icache_data_cen = 1;
icache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
icache_data_gwen = 1'b1;
icache_data_idx = 0;
icache_data_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge icache_data_clk)
    icache_data_cen <= 0;
    icache_data_gwen <= 1'b0;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    icache_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    icache_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge icache_data_clk)
    icache_data_gwen <= 1'b1;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= icache_data_din;
    @(posedge icache_data_clk)
    @(posedge icache_data_clk)
    if(icache_data_dout != golden_data)
    begin
        $display("data array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge icache_data_clk)
        $finish;
    end
end

//cen = 1 test
icache_data_cen = 1;
icache_data_gwen = 1'b1;
icache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
icache_data_idx = 0;
icache_data_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge icache_data_clk)
    icache_data_cen <= 1;
    icache_data_gwen <= 1'b0;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    icache_data_idx <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    icache_data_din <= {LOCAL_DATA_DATA_WIDTH{1'b0}} + i;
    @(posedge icache_data_clk)
    icache_data_gwen <= 1'b1;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= icache_data_din;
    @(posedge icache_data_clk)
    @(posedge icache_data_clk)
    if(icache_data_dout == golden_data)
    begin
        $display("data array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge icache_data_clk)
        $finish;
    end
end

//wen test
icache_data_cen = 1;
icache_data_gwen = 1'b1;
icache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
icache_data_idx = 0;
icache_data_din = 0;
for(i=0;i<LOCAL_DATA_WE_WIDTH;i=i+1)
begin
    @(posedge icache_data_clk)
    icache_data_idx  <= 20;
    icache_data_gwen <= 1'b0;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}} >> i;
    icache_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge icache_data_clk)
    icache_data_gwen <= 1'b1;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    golden_data      <= icache_data_din;
    data_mask_ff     <= data_mask;
    @(posedge icache_data_clk)
    @(posedge icache_data_clk)
    if(golden_data != icache_data_dout & (~data_mask_ff))
    begin
        $display("data array wen test fail when i is %d, golden_data is 0x%h, data out is 0x%h\n", i, golden_data, icache_data_dout);
        repeat(10)@(posedge icache_data_clk)
        $finish;
    end
end


//read and write test 
icache_data_cen = 1;
icache_data_gwen = 1'b1;
icache_data_wen = {LOCAL_DATA_WE_WIDTH{1'b1}};
icache_data_idx = 0;
icache_data_din = 0;
for(i=0;i<={LOCAL_DATA_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge icache_data_clk)
    icache_data_cen  <= 0;
    icache_data_gwen <= 1'b0;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b0}};
    icache_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i;
    icache_data_din  <= {LOCAL_DATA_DATA_WIDTH{1'b1}};
    @(posedge icache_data_clk)
    icache_data_gwen <=1'b1;
    icache_data_wen <= {LOCAL_DATA_WE_WIDTH{1'b1}};
    @(posedge icache_data_clk)
    @(posedge icache_data_clk)
    icache_data_idx  <= {LOCAL_DATA_ADDR_WIDTH{1'b0}} + i + 1;
    if(icache_data_dout != {LOCAL_DATA_DATA_WIDTH{1'b1}})
    begin
        $display("data array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge icache_data_clk)
        $finish;
    end
end





//tag array test
//cen = 0 test
repeat(50)@(posedge icache_tag_clk)
icache_tag_cen = 1;
icache_tag_gwen = 1'b1;
icache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
icache_tag_idx = 0;
icache_tag_din = 0;
for(i=0;i<10;i=i+1)
begin
    @(posedge icache_tag_clk)
    icache_tag_cen <= 0;
    icache_tag_gwen <= 1'b0;
    icache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    icache_tag_idx <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    icache_tag_din <= {LOCAL_TAG_DATA_WIDTH{1'b1}} - i;
    @(posedge icache_tag_clk)
    icache_tag_gwen <= 1'b1;
    icache_tag_wen  <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= icache_tag_din;
    @(posedge icache_tag_clk)
    @(posedge icache_tag_clk)
    if(icache_tag_dout != golden_tag)
    begin
        $display("tag array cen == 0 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge icache_tag_clk)
        $finish;
    end
end

//cen = 1 test
icache_tag_cen = 1;
icache_tag_gwen = 1'b1;
icache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
icache_tag_idx = 0;
icache_tag_din = 0;
for(i=10;i<20;i=i+1)
begin
    @(posedge icache_tag_clk)
    icache_tag_cen <= 1;
    icache_tag_gwen <= 1'b0;
    icache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    icache_tag_idx <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    icache_tag_din <= {LOCAL_TAG_DATA_WIDTH{1'b0}} + i;
    @(posedge icache_tag_clk)
    icache_tag_gwen <= 1'b1;
    icache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= icache_tag_din;
    @(posedge icache_tag_clk)
    @(posedge icache_tag_clk)
    if(icache_tag_dout == golden_tag)
    begin
        $display("tag array cen == 1 test fail when i is %d!!!\n", i);
        repeat(10)@(posedge icache_tag_clk)
        $finish;
    end
end

//wen test
icache_tag_cen = 1;
icache_tag_gwen = 1'b1;
icache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
icache_tag_idx = 0;
icache_tag_din = 0;
for(i=0;i<LOCAL_TAG_WE_WIDTH;i=i+1)
begin
    @(posedge icache_tag_clk)
    icache_tag_idx  <= 20;
    icache_tag_gwen <= 1'b0;
    icache_tag_wen  <= {LOCAL_TAG_WE_WIDTH{1'b1}} >> i;
    icache_tag_din  <= {LOCAL_TAG_DATA_WIDTH{1'b1}};
    @(posedge icache_tag_clk)
    icache_tag_gwen <= 1'b1;
    icache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    golden_tag      <= icache_tag_din;
    tag_mask_ff     <= tag_mask;
    @(posedge icache_tag_clk)
    @(posedge icache_tag_clk)
    if(golden_tag != icache_tag_dout & (~tag_mask_ff))
    begin
        $display("tag array wen test fail when i is %d, golden_data is 0x%h, data out is 0x%h\n", i, golden_tag, icache_tag_dout);
        repeat(10)@(posedge icache_tag_clk)
        $finish;
    end
end


//read and write test 
icache_tag_cen = 1;
icache_tag_gwen = 1'b1;
icache_tag_wen = {LOCAL_TAG_WE_WIDTH{1'b1}};
icache_tag_idx = 0;
icache_tag_din = 0;
for(i=0;i<={LOCAL_TAG_ADDR_WIDTH{1'b1}};i=i+1)
begin
    @(posedge icache_tag_clk)
    icache_tag_cen  <= 0;
    icache_tag_gwen <= 1'b0;
    icache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b0}};
    icache_tag_idx  <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i;
    icache_tag_din  <= {LOCAL_TAG_DATA_WIDTH{1'b1}};
    @(posedge icache_tag_clk)
    icache_tag_gwen <= 1'b1;
    icache_tag_wen <= {LOCAL_TAG_WE_WIDTH{1'b1}};
    @(posedge icache_tag_clk)
    @(posedge icache_tag_clk)
    icache_tag_idx  <= {LOCAL_TAG_ADDR_WIDTH{1'b0}} + i + 1;
    if(icache_tag_dout != {LOCAL_TAG_DATA_WIDTH{1'b1}})
    begin
        $display("tag array read/write test fail when addr is %d\n", i);
        repeat(10)@(posedge icache_tag_clk)
        $finish;
    end
        icache_mem_test_pass = 1;
end

end




endmodule
