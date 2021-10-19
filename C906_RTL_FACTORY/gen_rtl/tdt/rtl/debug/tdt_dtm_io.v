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
module tdt_dtm_io(      
    input          pad_dtm_jtag2_sel,         
    input          pad_dtm_tap_en,        
    input          pad_dtm_tdi,           
    input          pad_dtm_tms_i,  
    output         dtm_pad_tdo,           
    output         dtm_pad_tdo_en,        
    output         dtm_pad_tms_o,         
    output         dtm_pad_tms_oe,        
    input          chain_io_tdo,             
    input          ctrl_io_tdo_en,              
    input          ctrl_io_tms_oe,                          
    output         io_chain_tdi,             
    output         io_ctrl_tap_en
);

    assign io_ctrl_tap_en = pad_dtm_tap_en;
    assign io_chain_tdi   = pad_dtm_jtag2_sel ? pad_dtm_tms_i : pad_dtm_tdi;
    assign dtm_pad_tdo    = chain_io_tdo;
    assign dtm_pad_tms_o  = chain_io_tdo;
    assign dtm_pad_tdo_en = ctrl_io_tdo_en;
    assign dtm_pad_tms_oe = ctrl_io_tms_oe;

endmodule



