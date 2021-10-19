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
module tdt_dm_sync_dff #(
    parameter    SYNC_NUM = 2
)(
    input        dst_clk,
    input        dst_rst_b,
    input        src_in,
    output       dst_out
);

reg  [SYNC_NUM-1:0] sync_ff;

always @ (posedge dst_clk or negedge dst_rst_b) begin
    if (!dst_rst_b)
        sync_ff[SYNC_NUM-1:0] <= {SYNC_NUM{1'b0}};
    else 
        sync_ff[SYNC_NUM-1:0] <= {sync_ff[SYNC_NUM-2:0], src_in};
end

assign dst_out = sync_ff[SYNC_NUM-1];

endmodule
