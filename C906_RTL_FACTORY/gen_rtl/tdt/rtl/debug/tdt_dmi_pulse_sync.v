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
module tdt_dmi_pulse_sync #(
    parameter   SYNC_NUM = 2
)(
    input       src_clk,
    input       dst_clk,
    input       src_rst_b,
    input       dst_rst_b,
    input       src_pulse,
    output      dst_pulse
);
    reg         src_pulse_2_lvl;
    wire        dst_lvl; 
    reg         dst_lvl_d;
    wire        dst_lvl_src;
    reg         dst_lvl_src_d;
    wire        dst_pulse_2_src;

    always @ (posedge src_clk or negedge src_rst_b) begin
        if(!src_rst_b)
            dst_lvl_src_d <= 1'b0;
        else 
            dst_lvl_src_d <= dst_lvl_src;        
    end

    assign dst_pulse_2_src = dst_lvl_src & ~dst_lvl_src_d;


    always @ (posedge src_clk or negedge src_rst_b) begin
        if(!src_rst_b)
            src_pulse_2_lvl <= 1'b0;
        else if (dst_pulse_2_src)
            src_pulse_2_lvl <= 1'b0;    
        else if (src_pulse)
            src_pulse_2_lvl <= 1'b1;

            //src_pulse_2_lvl <= ~src_pulse_2_lvl;
    end

    tdt_dmi_sync_dff #(
        .SYNC_NUM    (SYNC_NUM)
    ) x_tdt_dmi_sync_dff (
        .dst_clk     (dst_clk),
        .dst_rst_b   (dst_rst_b),
        .src_in      (src_pulse_2_lvl),
        .dst_out     (dst_lvl)
    );

    tdt_dmi_sync_dff #(
        .SYNC_NUM    (SYNC_NUM)
    ) x_tdt_dmi_sync_dff_back (
        .dst_clk     (src_clk),
        .dst_rst_b   (src_rst_b),
        .src_in      (dst_lvl),
        .dst_out     (dst_lvl_src)
    );

    always @ (posedge dst_clk or negedge dst_rst_b) begin
        if(!dst_rst_b)
            dst_lvl_d <= 1'b0;
        else
            dst_lvl_d <= dst_lvl;
    end

    assign dst_pulse = dst_lvl & ~dst_lvl_d;

endmodule

