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

module tdt_dmi_rst_top(
  sys_apb_clk,
  sys_apb_rst_b,
  pad_yy_scan_mode,
  pad_yy_scan_rst_b,
  sync_sys_apb_rst_b
                    );

  input sys_apb_clk;
  input sys_apb_rst_b;
  input pad_yy_scan_mode;
  input pad_yy_scan_rst_b;
  output sync_sys_apb_rst_b;

  wire sync_sys_apb_rst_b;
  wire async_apb_rst_b;
  reg sys_apb_rst_ff_1st;

assign async_apb_rst_b = sys_apb_rst_b;

always @(posedge sys_apb_clk or negedge async_apb_rst_b)
begin
  if (!async_apb_rst_b)
    sys_apb_rst_ff_1st <= 1'b0;
  else
    sys_apb_rst_ff_1st <= 1'b1;
end

assign sync_sys_apb_rst_b = pad_yy_scan_mode ? pad_yy_scan_rst_b : sys_apb_rst_ff_1st;

endmodule
