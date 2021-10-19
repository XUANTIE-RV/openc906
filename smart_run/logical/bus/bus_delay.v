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























module bus_delay(
  paddr,
  pclk,
  penable,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  bus_delay_counter
);


input   [15:0]  paddr;                 
input           pclk;                  
input           penable;               
input           presetn;               
input           psel;                  
input   [31:0]  pwdata;
input           pwrite;
output  [31:0]  prdata;                
output  [31:0]  bus_delay_counter;


reg     [31:0]  prdata;                
reg     [31:0]  bus_delay_counter;


wire    [15:0]  paddr;                 
wire            pclk;                  
wire            presetn;               
wire            psel;                  
wire    [31:0]  pwdata;                
wire            pwrite;  












always @(posedge pclk or negedge presetn)
begin
  if(!presetn)
  begin
    bus_delay_counter <= 32'b0;
  end
  else if(psel && pwrite && penable && (~|paddr[7:2])) begin
    bus_delay_counter <= pwdata;
  end
end
    



always @(posedge pclk)
begin
  if(psel && !pwrite && !penable && (~|paddr[7:0])) begin
    prdata <= bus_delay_counter;
  end
  else begin
	prdata <= 32'b0;
  end
end

endmodule


