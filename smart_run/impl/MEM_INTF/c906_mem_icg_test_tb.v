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
module c906_mem_icg_test_tb();

reg  icache_mem_test_pass;
reg  dcache_mem_test_pass;
reg  bht_mem_test_pass;
reg  mmu_mem_test_pass;
reg  icg_test_pass;



initial
begin
  #100000;
  if(bht_mem_test_pass)
  begin
    $display("*************************************************\n");
    $display("*************BHT MEMORY TEST PASS!!!*************\n");
    $display("*************************************************\n");
  end
  else begin
    $display("*************************************************\n");
    $display("*************BHT MEMORY TEST FAIL!!!*************\n");
    $display("*************************************************\n");
    $display("*************************************************\n");
    $display("**********SORRY!!! MEMORY TEST FAIL!!!***********\n");
    $display("*************************************************\n");
    $finish;
  end

  #100000;
  if(icache_mem_test_pass)
  begin
    $display("*************************************************\n");
    $display("***********ICACHE MEMORY TEST PASS!!!************\n");
    $display("*************************************************\n");
  end
  else begin
    $display("*************************************************\n");
    $display("***********ICACHE MEMORY TEST FAIL!!!************\n");
    $display("*************************************************\n");
    $display("*************************************************\n");
    $display("**********SORRY!!! MEMORY TEST FAIL!!!***********\n");
    $display("*************************************************\n");
    $finish;
  end

  #100000;
  if(dcache_mem_test_pass)
  begin
    $display("*************************************************\n");
    $display("***********DCACHE MEMORY TEST PASS!!!************\n");
    $display("*************************************************\n");
  end
  else begin
    $display("*************************************************\n");
    $display("***********DCACHE MEMORY TEST FAIL!!!************\n");
    $display("*************************************************\n");
    $display("*************************************************\n");
    $display("**********SORRY!!! MEMORY TEST FAIL!!!***********\n");
    $display("*************************************************\n");
    $finish;
  end


  #100000;
  if(mmu_mem_test_pass)
  begin
    $display("*************************************************\n");
    $display("*************MMU MEMORY TEST PASS!!!*************\n");
    $display("*************************************************\n");

    $display("*************************************************\n");
    $display("*****CONGRATULATIONS!!! MEMORY TEST PASS!!!******\n");
    $display("*************************************************\n");
  end
  else begin
    $display("*************************************************\n");
    $display("*************MMU MEMORY TEST FAIL!!!*************\n");
    $display("*************************************************\n");
    $display("*************************************************\n");
    $display("**********SORRY!!! MEMORY TEST FAIL!!!***********\n");
    $display("*************************************************\n");
    $finish;
  end

  #100000;
  if(icg_test_pass)
  begin
    $display("*************************************************\n");
    $display("**************ICG CELL TEST PASS!!!**************\n");
    $display("*************************************************\n");
    $finish;
  end
  else begin
    $display("*************************************************\n");
    $display("*********SORRY!!! ICG CELL TEST FAIL!!!**********\n");
    $display("*************************************************\n");
    $finish;
  end

end

c906_bht_mem_test    x_bht_mem_test   (.bht_mem_test_pass(bht_mem_test_pass));
c906_icache_mem_test x_icache_mem_test(.icache_mem_test_pass(icache_mem_test_pass));
c906_dcache_mem_test x_dcache_mem_test(.dcache_mem_test_pass(dcache_mem_test_pass));
c906_mmu_mem_test    x_mmu_mem_test   (.mmu_mem_test_pass(mmu_mem_test_pass));
c906_icg_test_tb     x_icg_test       (.icg_test_pass (icg_test_pass));

initial
begin
  $dumpfile("test.vcd");
  $dumpvars;
end

endmodule
