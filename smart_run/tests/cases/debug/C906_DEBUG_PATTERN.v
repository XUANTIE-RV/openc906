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

`define TDT_DM_CORE_RV64

`define TDT_DM_PB_SIZE 4

`define FPU

`define TDT_DM_SBA
`define TDT_DM_SBA_DW_128


module C906_DEBUG_PATTERN();
 reg[31:0] had_data_out;
ext_debug dh;
longint  rd_value;
longint  wr_value;
bit      error;

bit[1:0] dmi_op;
bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
int dmi_value, dmi_expected_value;
bit error;
int pb_size;



process process1;
bit[31:0] data_high, data_low, data_temp;
bit[2:0] cmderr;
int halt_poll_num;

int retire_num, retire_total_num;
bit[39:0] retire_pc;
int step_num;
bit[2:0] aarsize;
bit[31:0] itr_opcodes[$];
bit[63:0] data_back;

initial begin
    //debug host class init
    $display("debug test begin..");
    dh = new("dh");
    dh.initDTM();
    `ifdef TDT_DM_CORE_RV64
        aarsize=3;
    `else
        aarsize=2;
    `endif
    $display("RV aarsize = %0d", aarsize);
    //start reading DTM registers

    wait_mstatus();
    $display("core enter handshake");

//**********************************************************
//dtm reg rd/wr
//**********************************************************
    //1.check BYPASS value
    dh.part_start("DTM.BYPASS");
    wr_value = 64'd0;
    rd_value = 64'd0;
    dh.rwDTMReg(`DTM_BYPASS, rd_value, wr_value, error);
    //TODO: add check logic
    $display("dtm.bypass = %0h", rd_value);

    //2.check IDCODE value
    dh.part_start("DTM.IDCODE");
    wr_value = 64'd0;
    rd_value = 64'd0;
    dh.rwDTMReg(`DTM_IDCODE, rd_value, wr_value, error);
    //TODO: add check logic
    $display("dtm.idcode = %0h", rd_value);

//**********************************************************
//dm reg rd/wr
//**********************************************************
    //enable debug module
    dmi_op = `DMI_WRITE;
    dmi_address = `DM_DMCONTROL;
    dmi_value = 32'd1; //enable dactive
    dh.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);

    //1.check dmstatus value
    dh.part_start("DM.dmstatus default value check:");
    dmi_op = `DMI_READ;
    dmi_address = `DM_DMSTATUS;
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    // check DMSTATUS.version=2
    if (dmi_value[3:0] != 4'd2) begin
        dh.tb_fatal($sformatf("Error:DM.dmstatus.version should be 2, but now %0h", dmi_value[3:0]));
    end
    $display("dmi_status default value: %h", dmi_value);

    dh.part_start("DM.dmcontrol default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DMCONTROL, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    if (dmi_value[19]!=1'b0 ||
        dmi_value[26]!=1'b0 ||
        dmi_value[25:16]!=10'd0 ||
        dmi_value[15:6]!=10'd0 ||
        dmi_value[1]!=1'b0
    ) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end

    dh.part_start("DM.hartinfo default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_HARTINFO, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    //if (dmi_value[23:20]!= `TDT_DM_CORE_NSCRATCH ||
    if (dmi_value[23:20]!= 4'h2 ||
        dmi_value[16]!=1'b0 ||  //dataaccess
        dmi_value[15:12]!=10'd0 || //datasize
        dmi_value[11:0]!=10'd0 //dataaddr
    ) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end

    dh.part_start("DM.hawindowsel default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_HAWINDOWSEL, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    if (dmi_value!= 32'd0
    ) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end

    dh.part_start("DM.abstractcs default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_ABSTRACTCS, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
`ifdef TDT_DM_PB_SIZE
    pb_size = `TDT_DM_PB_SIZE;
`else
    pb_size = 0;
`endif
    if (dmi_value[28:24]!= pb_size
    //if (dmi_value[28:24]!= 5'h1  //ZHAOKUAN TODO
        || dmi_value[12]!=1'b0 //busy
        || dmi_value[10:8]!=3'b0 //cmderr
        || dmi_value[3:0]!=64/32 //datacount
        //|| dmi_value[3:0]!=`TDT_DM_CORE_MAX_XLEN/32 //datacount
    ) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end


    dh.part_start("DM.COMMAND default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_COMMAND, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    if (dmi_value!= 32'd0
    ) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end


    dh.part_start("DM.abstractauto default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_ABSTRACTAUTO, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    if (dmi_value!= 32'd0
    ) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end

`ifdef TDT_DM_SBA
    dh.part_start("DM.sbcs default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_SBCS, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    dmi_expected_value = 32'b0;
    dmi_expected_value[31:29] = 3'd1;//sbversion
    dmi_expected_value[19:17] = 3'd2; //sbaccess
    `ifdef TDT_DM_SBA_DW_128
    dmi_expected_value[11:5] = 7'd40; //sbasize
    `else
    dmi_expected_value[11:5] = 7'd32; //sbasize
    `endif
    `ifdef TDT_DM_SBA_DW_128
    dmi_expected_value[4] = 1'b1; //sbaccess128
    dmi_expected_value[3] = 1'b1; //sbaccess64
    `endif 
    `ifdef TDT_DM_SBA_DW_64
    dmi_expected_value[3] = 1'b1; //sbaccess64
    `endif 
    dmi_expected_value[2] = 1'b1; //sbaccess32
    if (dmi_value[31:0]!= dmi_expected_value) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end
`else
    dh.part_start("DM.sbcs default value check:");
    dmi_value = 32'd0;
    dh.rwMemorybyDMIwithCheck(`DMI_READ, `DM_SBCS, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("dmi read error");
    end
    dmi_expected_value = 32'b0;
    if (dmi_value[31:0]!= dmi_expected_value) begin
        dh.tb_fatal($sformatf("reset value[%0h] error.", dmi_value));
    end
`endif
//**********************************************************
//dm itr
//**********************************************************


    //0.prepare
    //enabel dm and select hart0
    dmi_op = `DMI_WRITE;
    dmi_address = `DM_DMCONTROL;
    dmi_value = 32'd1; //enable dactive
    dh.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);

    //enter halt mode
    dh.hart0_sync_halt_req();

    //------------------
    //part1: test mepc write with program buffer:
    //       - write mepc with program buffer, then read back with abscmd, cmp the result
    //       - pb instructions: csrw mepc, s0; ebreak
    dh.part_start("test mepc read/write with itr");
    //abscmd write s0=5a5a5a5a
    dmi_value = 32'h5a5a5a5a;
    dh.access_abscmd_data(1'b1, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 write error");
    end
`ifdef TDT_DM_CORE_RV64
    dh.access_register_by_abscmd(3'd3, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1008, cmderr);
`else
    dh.access_register_by_abscmd(3'd2, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1008, cmderr);
`endif
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd execute error");
    end
    //execute itr csrw mepc, so
    dmi_value = `CSRW_MEPC_X8;
    dh.execute_itr(dmi_value, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("itr execute error");
    end
    //-read mepc(0x341) with abscmd
`ifdef TDT_DM_CORE_RV64
    dh.access_register_by_abscmd(3'd3, 1'b0, 1'b0, 1'b1, 1'b0, 16'h0341, cmderr);
`else
    dh.access_register_by_abscmd(3'd2, 1'b0, 1'b0, 1'b1, 1'b0, 16'h0341, cmderr);
`endif
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd read mepc execute error");
    end
    dmi_value = 32'h0;
    dh.access_abscmd_data(1'b0, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 read error");
    end
    if (dmi_value != 32'h5a5a5a5a) begin
        dh.tb_error($sformatf("mepc pb write failed, with real mepc value[%0h]", dmi_value));
    end

    //write mepc with abscmd, and read mepc with pb
    //-write mepc(0x341) with abscmd; csrr s0, mepc; ebreak
    dmi_value = 32'ha5a5a5a5;
    dh.access_abscmd_data(1'b1, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 read error");
    end
`ifdef TDT_DM_CORE_RV64
    dh.access_register_by_abscmd(3'd3, 1'b0, 1'b0, 1'b1, 1'b1, 16'h0341, cmderr);
`else
    dh.access_register_by_abscmd(3'd2, 1'b0, 1'b0, 1'b1, 1'b1, 16'h0341, cmderr);
`endif
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd write mepc execute error");
    end
    //-read mepc(0x341) with pb
    //-write epc with itr
    dmi_value = `CSRR_X8_MEPC;
    dh.execute_itr(dmi_value, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("itr csrr_x8_mepc execute error");
    end
    //--read back s0 to data0 by abscmd
    dh.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1008, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd read mepc execute error");
    end
    dmi_value = 32'h0;
    dh.access_abscmd_data(1'b0, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 read error");
    end
    if (dmi_value != 32'ha5a5a5a4) begin
        dh.tb_error($sformatf("mepc pb read failed, with real mepc value[%0h]", dmi_value));
    end

    //------------------
    //part2: test f1 read:
    //       - write s0 with abscmd to 0xffff0000
    //       - write f1 with program buffer, fmv.w.x f1, s0, fmv.x.w s1, f1
    //       -  then read back s1 with abscmd
`ifdef FPU
    dh.part_start("test f1 read with program buffer");
    //write s0=ffff0000
    dmi_value = 32'hffff0000;
    dh.access_abscmd_data(1'b1, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 write error");
    end
    dh.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1008, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd write s0 execute error");
    end
    //-write pb
    dmi_value = `FMV_X_W_F1_X8;
    dh.execute_itr(dmi_value, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("itr fmv.x.w f1, x8 execute error");
    end
    dmi_value = `FMV_W_X_X9_F1;
    dh.execute_itr(dmi_value, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("itr fmv.w.x x9, f1 execute error");
    end

    //--read back s1 to data0 by abscmd
    dh.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1009, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd read s1 execute error");
    end
    dmi_value = 32'h0;
    dh.access_abscmd_data(1'b0, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 read error");
    end
    if (dmi_value != 32'hffff0000) begin
        dh.tb_error($sformatf("f1 read failed, with real f1 value[%0h] != 0xffff0000", dmi_value));
    end
`endif


    //itr execution
    //fff0011b          	addiw	x2,x0,-1
    //03f11113          	slli	x2,x2,0x3f
    //fff00293          	li	x5,-1
    //02514333          	div	x6,x2,x5
    //li              x7 , 0xffffffff80000000
    //bne             x6 , x7 , TEST_FAIL

`ifdef TDT_DM_CORE_RV64
    dh.part_start("itr div execution");
    itr_opcodes.push_back(32'hfff0011b);          //	addiw	x2,x0,-1
    itr_opcodes.push_back(32'h03f11113);          //	slli	x2,x2,0x3f
    itr_opcodes.push_back(32'hfff00293);          //	li	x5,-1
    itr_opcodes.push_back(32'h02514333);          //	div	x6,x2,x5
    foreach(itr_opcodes[i]) begin
        dmi_value = itr_opcodes[i];
        dh.execute_itr(dmi_value, cmderr);
        if (cmderr != 3'b0) begin
            dh.tb_fatal("itr execute error");
        end
    end

    //--read back x6 to data0/1 by abscmd
    dh.access_register_by_abscmd(3'd3, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1006, cmderr);
    if (cmderr != 3'b0) begin
        dh.tb_fatal("abscmd read s1 execute error");
    end
    dh.access_abscmd_data(1'b0, 32'd0, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 read error");
    end
    data_back[31:0] = dmi_value;
    dh.access_abscmd_data(1'b0, 32'd1, dmi_value, error);
    if (error == 1'b1) begin
        dh.tb_fatal("data0 read error");
    end
    data_back[63:32] = dmi_value;
    if (data_back != 64'h8000000000000000) begin
        dh.tb_error($sformatf("x6[%0h] != 0xf8000000000000000", data_back));
    end
`endif

//**********************************************************
// Memory Read / Write 
//**********************************************************
    $display(" Read Write Memory: begin");
    dmi_value = 32'h12345678;
    dh.write_word_by_pb(64'h000000001f005000, dmi_value);
    dmi_value = 32'h0;
    dh.read_word_by_pb(64'h000000001f005000, dmi_value);
    $display(" Memory value = %0h", dmi_value);
    $display(" Read Write Memory: end");

    dh.hart0_resume();
    //test pass finish
    dh.trigger_tb_pass_finish();
end
 endmodule
 
