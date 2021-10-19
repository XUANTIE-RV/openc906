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
`define NOISA










`timescale 1ns/100ps
`define CLK_PERIOD          10
`define TCLK_PERIOD         40
`define MAX_RUN_TIME        700000000

`define SOC_TOP             tb.x_soc
`define RTL_MEM             tb.x_soc.x_axi_slave128.x_f_spsram_524288x128_L
`define RTL_MEM2            tb.x_soc.x_axi_slave128.x_f_spsram_524288x128_H



`define CPU_TOP             tb.x_soc.x_cpu_sub_system_axi.x_c906_wrapper.x_cpu_top
`define tb_retire0          `CPU_TOP.core0_pad_retire
`define retire0_pc          `CPU_TOP.core0_pad_retire_pc[39:0]
`define CPU_CLK             `CPU_TOP.pll_core_cpuclk
`define CPU_RST             `CPU_TOP.pad_cpu_rst_b



module tb();
reg clk;
reg jclk;
reg rst_b;
reg jrst_b;
reg jtap_en;
wire jtg_tms;
wire jtg_tdi;
wire jtg_tdo;
wire  pad_yy_gate_clk_en_b;

static integer FILE;

wire uart0_sin;
wire [7:0]b_pad_gpio_porta;

assign pad_yy_gate_clk_en_b = 1'b1;


initial
begin
  clk =0;
  forever begin
    #(`CLK_PERIOD/2) clk = ~clk;
  end
end

initial 
begin 
  jclk = 0;
  forever begin
    #(`TCLK_PERIOD/2) jclk = ~jclk;
  end
end


initial
begin
  rst_b = 1;
  #100;
  rst_b = 0;
  #100;
  rst_b = 1;
end

initial
begin
  jrst_b = 1;
  #400;
  jrst_b = 0;
  #400;
  jrst_b = 1;
end

integer i;
  bit [31:0] mem_inst_temp [65536];
  bit [31:0] mem_data_temp [65536];
  integer j;
  initial
  begin
    $display("\t********* Init Program *********");
    $display("\t********* Wipe memory to 0 *********");
    for(i=0; i < 32'h16384; i=i+1)
    begin
      `RTL_MEM.ram0.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram1.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram2.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram3.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram4.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram5.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram6.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram7.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram8.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram9.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram10.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram11.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram12.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram13.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram14.mem[i][7:0] = 8'h0;
      `RTL_MEM.ram15.mem[i][7:0] = 8'h0;
    end
  
    $display("\t********* Read program *********");
    $readmemh("inst.pat", mem_inst_temp);
    $readmemh("data.pat", mem_data_temp);
  
    $display("\t********* Load program to memory *********");
    i=0;
    for(j=0;i<32'h4000;i=j/4)
    begin
      `RTL_MEM.ram0.mem[i][7:0] = mem_inst_temp[j][31:24];
      `RTL_MEM.ram1.mem[i][7:0] = mem_inst_temp[j][23:16];
      `RTL_MEM.ram2.mem[i][7:0] = mem_inst_temp[j][15: 8];
      `RTL_MEM.ram3.mem[i][7:0] = mem_inst_temp[j][ 7: 0];
      j = j+1;
      `RTL_MEM.ram4.mem[i][7:0] = mem_inst_temp[j][31:24];
      `RTL_MEM.ram5.mem[i][7:0] = mem_inst_temp[j][23:16];
      `RTL_MEM.ram6.mem[i][7:0] = mem_inst_temp[j][15: 8];
      `RTL_MEM.ram7.mem[i][7:0] = mem_inst_temp[j][ 7: 0];
      j = j+1;
      `RTL_MEM.ram8.mem[i][7:0] = mem_inst_temp[j][31:24];
      `RTL_MEM.ram9.mem[i][7:0] = mem_inst_temp[j][23:16];
      `RTL_MEM.ram10.mem[i][7:0] = mem_inst_temp[j][15: 8];
      `RTL_MEM.ram11.mem[i][7:0] = mem_inst_temp[j][ 7: 0];
      j = j+1;
      `RTL_MEM.ram12.mem[i][7:0] = mem_inst_temp[j][31:24];
      `RTL_MEM.ram13.mem[i][7:0] = mem_inst_temp[j][23:16];
      `RTL_MEM.ram14.mem[i][7:0] = mem_inst_temp[j][15: 8];
      `RTL_MEM.ram15.mem[i][7:0] = mem_inst_temp[j][ 7: 0];
      j = j+1;
    end
    i=0;
    for(j=0;i<32'h4000;i=j/4)
    begin
      `RTL_MEM.ram0.mem[i+32'h4000][7:0]  = mem_data_temp[j][31:24];
      `RTL_MEM.ram1.mem[i+32'h4000][7:0]  = mem_data_temp[j][23:16];
      `RTL_MEM.ram2.mem[i+32'h4000][7:0]  = mem_data_temp[j][15: 8];
      `RTL_MEM.ram3.mem[i+32'h4000][7:0]  = mem_data_temp[j][ 7: 0];
      j = j+1;
      `RTL_MEM.ram4.mem[i+32'h4000][7:0]  = mem_data_temp[j][31:24];
      `RTL_MEM.ram5.mem[i+32'h4000][7:0]  = mem_data_temp[j][23:16];
      `RTL_MEM.ram6.mem[i+32'h4000][7:0]  = mem_data_temp[j][15: 8];
      `RTL_MEM.ram7.mem[i+32'h4000][7:0]  = mem_data_temp[j][ 7: 0];
      j = j+1;
      `RTL_MEM.ram8.mem[i+32'h4000][7:0]   = mem_data_temp[j][31:24];
      `RTL_MEM.ram9.mem[i+32'h4000][7:0]   = mem_data_temp[j][23:16];
      `RTL_MEM.ram10.mem[i+32'h4000][7:0]  = mem_data_temp[j][15: 8];
      `RTL_MEM.ram11.mem[i+32'h4000][7:0]  = mem_data_temp[j][ 7: 0];
      j = j+1;
      `RTL_MEM.ram12.mem[i+32'h4000][7:0]  = mem_data_temp[j][31:24];
      `RTL_MEM.ram13.mem[i+32'h4000][7:0]  = mem_data_temp[j][23:16];
      `RTL_MEM.ram14.mem[i+32'h4000][7:0]  = mem_data_temp[j][15: 8];
      `RTL_MEM.ram15.mem[i+32'h4000][7:0]  = mem_data_temp[j][ 7: 0];
      j = j+1;
    end
  end









initial
begin
#`MAX_RUN_TIME;
  $display("**********************************************");
  $display("*   meeting max simulation time, stop!       *");
  $display("**********************************************");
  FILE = $fopen("run_case.report","a");
  $fwrite(FILE,"TEST FAIL");   
$finish;
end

reg [31:0] retire_inst_in_period;
reg [31:0] cycle_count;

`define LAST_CYCLE 50000
always @(posedge clk or negedge rst_b)
begin
  if(!rst_b)
    cycle_count[31:0] <= 32'b1;
  else 
    cycle_count[31:0] <= cycle_count[31:0] + 1'b1;
end


always @(posedge clk or negedge rst_b)
begin
  if(!rst_b) //reset to zero
    retire_inst_in_period[31:0] <= 32'b0;
  else if( (cycle_count[31:0] % `LAST_CYCLE) == 0)//check and reset retire_inst_in_period every 50000 cycles
  begin
    if(retire_inst_in_period[31:0] == 0)begin
      $display("*************************************************************");
      $display("* Error: There is no instructions retired in the last %d cycles! *", `LAST_CYCLE);
      $display("*              Simulation Fail and Finished!                *");
      $display("*************************************************************");
      #10;
      FILE = $fopen("run_case.report","a");
      $fwrite(FILE,"TEST FAIL");   

      $finish;
    end
    retire_inst_in_period[31:0] <= 32'b0;
  end
  else if(`tb_retire0)
    retire_inst_in_period[31:0] <= retire_inst_in_period[31:0] + 1'b1;
end



reg [39:0] cpu_awaddr;
reg [3:0]  cpu_awlen;
reg [15:0] cpu_wstrb;
reg        cpu_wvalid;
reg [63:0] value0;
reg [63:0] value1;


always @(posedge clk)
begin
  cpu_awlen[3:0]   <= `SOC_TOP.biu_pad_awlen[3:0];
  cpu_awaddr[31:0] <= `SOC_TOP.biu_pad_awaddr[31:0];
  cpu_wvalid       <= `SOC_TOP.biu_pad_wvalid;
  cpu_wstrb        <= `SOC_TOP.biu_pad_wstrb;
  value0           <= `CPU_TOP.x_aq_top_0.x_aq_core.x_aq_rtu_top.x_aq_rtu_wb.wb_wb0_data[63:0];
  value1           <= `CPU_TOP.x_aq_top_0.x_aq_core.x_aq_rtu_top.x_aq_rtu_wb.wb_wb1_data[63:0];
end

always @(posedge clk)
begin
  if((value0 == 64'h444333222) || (value1 == 64'h444333222))
  begin
   $display("\n**********************************************");
   $display("*    simulation finished successfully        *");
   $display("**********************************************");
  #10;
   FILE = $fopen("run_case.report","a");
   $fwrite(FILE,"TEST PASS");   
   $fclose(FILE);

   $finish;
  end
  else if ((value0 == 64'h2382348720) || (value1 == 64'h2382348720))
  begin
   $display("**********************************************");
   $display("*    simulation finished with error          *");
   $display("**********************************************");
   #10;
   FILE = $fopen("run_case.report","a");
   $fwrite(FILE,"TEST FAIL");   
   $fclose(FILE);

   $finish;
  end

  else if((cpu_awlen[3:0] == 4'b0) &&
     (cpu_awaddr[31:0] == 32'h10015000) &&
      cpu_wvalid)
  begin
   FILE = $fopen("run_case.report","a");
    if(cpu_wstrb[15:0] == 16'hf) begin
      $write("%c", `SOC_TOP.biu_pad_wdata[7:0]);
      $fwrite(FILE,"%c",`SOC_TOP.biu_pad_wdata[7:0]);
      $fclose(FILE);
   end
   else if(cpu_wstrb[15:0] == 16'hf0) begin
      $write("%c", `SOC_TOP.biu_pad_wdata[39:32]);
      $fwrite(FILE,"%c",`SOC_TOP.biu_pad_wdata[39:32]);
      $fclose(FILE);
   end
   else if(cpu_wstrb[15:0] == 16'hf00) begin
      $write("%c", `SOC_TOP.biu_pad_wdata[71:64]);
      $fwrite(FILE,"%c",`SOC_TOP.biu_pad_wdata[71:64]);
      $fclose(FILE);
   end
   else if(cpu_wstrb[15:0] == 16'hf000) begin
      $write("%c", `SOC_TOP.biu_pad_wdata[103:96]);
      $fwrite(FILE,"%c",`SOC_TOP.biu_pad_wdata[103:96]);
      $fclose(FILE);
   end
  end

end

`ifndef NO_DUMP
initial
begin
`ifdef NC_SIM
  $dumpfile("test.vcd");
  $dumpvars;  
`else
   `ifdef IVERILOG_SIM
     $dumpfile("test.vcd");
     $dumpvars;  
   `else
     $display("######time:%d, Dump start######",$time);
     $fsdbDumpvars();
   `endif
`endif
end
`endif


assign jtg_tdi = 1'b0;
assign jtg_tms = 1'b0;

assign uart0_sin = 1'b1;


soc x_soc(
  .i_pad_clk           ( clk                  ),
  .b_pad_gpio_porta    ( b_pad_gpio_porta     ),
  .i_pad_jtg_trst_b    ( jrst_b               ),
  .i_pad_jtg_nrst_b    ( rst_b                ),
  .i_pad_jtg_tclk      ( jclk                 ),
  .i_pad_jtg_tdi       ( jtg_tdi              ),
  .i_pad_jtg_tms       ( jtg_tms              ),
  .i_pad_uart0_sin     ( uart0_sin            ),
  .o_pad_jtg_tdo       ( jtg_tdo              ),
  .o_pad_uart0_sout    ( uart0_sout           ),
  .i_pad_rst_b         ( rst_b                )
);




endmodule
