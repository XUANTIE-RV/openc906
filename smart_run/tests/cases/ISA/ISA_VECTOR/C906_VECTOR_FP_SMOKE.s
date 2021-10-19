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
###############################################################
.text
.align 2
.global main

.macro FPUVCHECK_ZERO FDESVREG, EXPNUM IMM_REG0, IMM_REG1 
  vext.x.v \IMM_REG0, \FDESVREG, x0 
  li   \IMM_REG1, \EXPNUM
.endm
.macro FPUEXCHK EXPNUM32, IMM_REG0, IMM_REG1
  #//to see if fccee is enabled
  li   \IMM_REG0, 0x7f
  csrrs \IMM_REG1,fxcr,x0
  csrrc x0,fxcr, \IMM_REG0  #//clear flag bits
  and  \IMM_REG0, \IMM_REG0,\IMM_REG1
  li   \IMM_REG1, \EXPNUM32
.endm
.macro FPUMOVD FDESREG,IMME64,IMM_REG
  li \IMM_REG, \IMME64
  fmv.d.x \FDESREG, \IMM_REG
.endm
.macro FPUMOVH FDESREG, IMME16, IMM_REG
  li \IMM_REG, \IMME16
  li x3, 0xffff0000
  or \IMM_REG,\IMM_REG,x3
  fmv.w.x \FDESREG, \IMM_REG  
.endm
.macro FPUMOVS FDESREG, IMME32, IMM_REG
  li \IMM_REG, \IMME32
  fmv.w.x \FDESREG, \IMM_REG  
.endm
.macro FPUBP16SET IMME2, IMM_REG0
   addi \IMM_REG0,x0,0x1
   slli \IMM_REG0,\IMM_REG0, 31
   csrrc x0, fxcr,\IMM_REG0
   li \IMM_REG0, \IMME2
   slli \IMM_REG0,\IMM_REG0, 31
   csrrs x0, fxcr,\IMM_REG0
.endm
#//============================================================
#// half precision 
#//============================================================
.set HpsNaN,    0x7c01
.set HnsNaN,    0xfc01
.set HpqNaN,    0x7e00
.set HnqNaN,    0xfe00
.set HpInf,     0x7c00
.set HnInf,     0xfc00
.set HpNorm,    0x3800    #//0.5
.set HnNorm,    0xb800    #//-0.5
.set HpDeNorm,  0x0001
.set HnDeNorm,  0x8001
.set HpZero,    0x0000
.set HnZero,    0x8000
.set HpLFN,     0x7bff
.set HnLFN,     0xfbff
.set HpMIN,     0x0400
.set HnMIN,     0x8400
.set HpSPECIAL_1,  0x0002    # // denorm+denrom
.set HnSPECIAL_1,  0x8002    # // -denorm + -denorm
.set HpOne,  0x3c00
.set HnOne,  0xbc00
.set HpONE,  0x3c00
.set HnONE,  0xbc00
.set Hp1p1,  0x3e00
.set Hn1p1,  0xbe00
.set HpDeNormMost, 0x03ff    
.set HnDeNormMost, 0x83ff


#//==========================================================
#// single format
#//==========================================================
.set SpsNaN,   0x7f800001 #//0_111'1111'1_000'0000'0000'0000'0000'0001
.set SnsNaN,   0xff800001 #//1_111'1111'1_000'0000'0000'0000'0000'0001
.set SpqNaN,   0x7fc00000 #//0_111'1111'1_100'0000'0000'0000'0000'0000
.set SnqNaN,   0xffc00000 #//1_111'1111'1_100'0000'0000'0000'0000'0000
.set SpInf,    0x7f800000 #//0_111'1111'1_000'0000'0000'0000'0000'0000
.set SnInf,    0xff800000 #//1_111'1111'1_000'0000'0000'0000'0000'0000
.set SpNorm,   0x3f000000 #//0_011'1111'0_000'0000'0000'0000'0000'0000 (+0.5)
.set SnNorm,   0xbf000000 #//1_011'1111'0_000'0000'0000'0000'0000'0000 (-0.5)
.set SpDeNorm, 0x00000001 #//0_000'0000'0_000'0000'0000'0000'0000'0001
.set SnDeNorm, 0x80000001 #//1_000'0000'0_000'0000'0000'0000'0000'0001
.set SpZero,   0x00000000 #//0_000'0000'0_000'0000'0000'0000'0000'0000
.set SnZero,   0x80000000 #//1_000'0000'0_000'0000'0000'0000'0000'0000
.set SpLFN,    0x7f7fffff #//0_111'1111'0_111'1111'1111'1111'1111'1111
.set SnLFN,    0xff7fffff #//1_111'1111'0_111'1111'1111'1111'1111'1111
.set SpMIN,    0x00800000 #//0_000'0000'1_000'0000'0000'0000'0000'0000 
.set SnMIN,    0x80800000 #//1_000'0000'1_000'0000'0000'0000'0000'0000 

.set SpSPECIAL_1,  0x00000002
.set SnSPECIAL_1,  0x80000002
.set SpOne,  0x3f800000
.set SnOne,  0xbf800000
.set SpONE,  0x3f800000
.set SnONE,  0xbf800000
.set Sp1p1,  0x3fc00000
.set Sn1p1,  0xbfc00000

.set SpDeNormMost,   0x007fffff    #//0_000'0000'0111'_ffff...ffff
.set SnDeNormMost,   0x807fffff    #//1_000'0000'0111'_ffff...ffff


#//==========================================================
#// double format
#//==========================================================
.set DpsNaN,    0x7ff0000000000001 #//0_111'1111'1111'_0000'0...0'0001
.set DpsNaNH,   0x7ff00000
.set DpsNaNL,   0x00000001
.set DnsNaN,    0xfff0000000000001 #//1_111'1111'1111'_0000'0...0'0001
.set DnsNaNH,   0xfff00000
.set DnsNaNL,   0x00000001
.set DpqNaN,    0x7ff8000000000000 #//0_111'1111'1111'_1000'0...0'0000
.set DpqNaNH,   0x7ff80000
.set DpqNaNL,   0x00000000
.set DnqNaN,    0xfff8000000000000 #//1_111'1111'1111'_1000'0...0'0000
.set DnqNaNH,   0xfff80000
.set DnqNaNL,   0x00000000
.set DpInf,     0x7ff0000000000000 #//0_111'1111'1111'_0000'0...0'0000
.set DpInfH,    0x7ff00000
.set DpInfL,    0x00000000
.set DnInf,     0xfff0000000000000 #//1_111'1111'1111'_0000'0...0'0000
.set DnInfH,    0xfff00000
.set DnInfL,    0x00000000
.set DpNorm,    0x3fe0000000000000 #//0_011'1111'1110'_0000'0...0'0000 (+0.5)
.set DpNormH,   0x3fe00000
.set DpNormL,   0x00000000
.set DnNorm,    0xbfe0000000000000 #//1_011'1111'1110'_0000'0...0'0000 (-0.5)
.set DnNormH,   0xbfe00000
.set DnNormL,   0x00000000
.set DpDeNorm,  0x0000000000000001 #//0_000'0000'0000'_0000'0...0'0001
.set DpDeNormH, 0x00000000
.set DpDeNormL, 0x00000001
.set DnDeNorm,  0x8000000000000001 #//1_000'0000'0000'_0000'0...0'0001
.set DnDeNormH, 0x80000000
.set DnDeNormL, 0x00000001
.set DpZero,    0x0000000000000000 #//0_000'0000'0000'_0000'0...0'0000
.set DpZeroH,   0x00000000
.set DpZeroL,   0x00000000
.set DnZero,    0x8000000000000000 #//1_000'0000'0000'_0000'0...0'0000
.set DnZeroH,   0x80000000
.set DnZeroL,   0x00000000
.set DpLFN,     0x7fefffffffffffff #//0_111'1111'1110'_1111'1...1'1111
.set DpLFNH,    0x7fefffff
.set DpLFNL,    0xffffffff 
.set DnLFN,     0xffefffffffffffff #//1_111'1111'1110'_1111'1...1'1111
.set DnLFNH,    0xffefffff 
.set DnLFNL,    0xffffffff
.set DpMIN,     0x0010000000000000 #//0_000'0000'0001'_0000'0...0'0000
.set DpMINH,    0x00100000
.set DpMINL,    0x00000000
.set DnMIN,     0x8010000000000000
.set DnMINH,    0x80100000
.set DnMINL,    0x00000000

.set DpSPECIAL_1,  0x0000000000000002
.set DnSPECIAL_1,  0x8000000000000002
.set DpOne,  0x3ff0000000000000
.set DnOne,  0xbff0000000000000
.set DpONE,  0x3ff0000000000000
.set DnONE,  0xbff0000000000000
.set Dp1p1,  0x3ff8000000000000
.set Dn1p1,  0xbff8000000000000


#SNaN,QNaN
.set DpqNaN2,   0x7ff800000000000f    #//0_111'1111'1111'_1000'0000...0'1111
.set DpqNaN3,   0x7ff80000000000f0    #//0_111'1111'1111'_1000'0000...'1111'0000
.set DnqNaN2,   0xfff8000000000f00    #//1_111'1111'1111'_1000'0000...0'1111'0000'0000
.set DnqNaN3,   0xfff800000000f000    #//1_111'1111'1111'_1000'0000...'1111'0000'0000'0000
.set DpsNaN2,   0x7ff00000000f0000    #//0_111'1111'1111'_0000'0...0'0001'0000'0000'0000'0000
.set DpsNaN3,   0x7ff0000000f00000    #//0_111'1111'1111'_0000'0...0'0001'0000'0000'0000'0000'0000
.set DnsNaN2,   0x7ff000000f000000    #//0_111'1111'1111'_0000'0...0'0001'0000'0000'0000'0000'0000'0000
.set DnsNaN3,   0x7ff00000f000000    #//0_111'1111'1111'_0000'0...0'0001'0000'0000'0000'0000'0000'0000'0000
.set DpDeNormMost,   0x000fffffffffffff    #//0_000'0000'0000'_ffff...ffff
.set DnDeNormMost,   0x800fffffffffffff    #//1_000'0000'0000'_ffff...ffff


#//==========================================================
#//    deformal
#//==========================================================
#// Single
.set SpNmMAX,  0x7f7fffff #//0_111'1111'0_111'1111'1111'1111'1111'1111
.set SpNmMIN,  0x00800000 #//0_000'0000'1_000'0000'0000'0000'0000'0000
.set SnNmMAX,  0xff7fffff #//1_111'1111'0_111'1111'1111'1111'1111'1111
.set SnNmMIN,  0x80800000 #//1_000'0000'1_000'0000'0000'0000'0000'0000
.set SpDmMAX,  0x007fffff #//0_000'0000'0_111'1111'1111'1111'1111'1111
.set SpDmMIN,  0x00000001 #//0_000'0000'0_000'0000'0000'0000'0000'0001
.set SnDmMAX,  0x807fffff #//1_000'0000'0_111'1111'1111'1111'1111'1111
.set SnDmMIN,  0x80000001 #//0_000'0000'0_000'0000'0000'0000'0000'0001
.set SpOne,    0x3f800000
.set SnOne,    0xbf800000
.set SpqNaN1,  0x7fc00001 #//0_111'1111'1_100'0000'0000'0000'0000'0000
.set SnqNaN1,  0xffc00001 #//1_111'1111'1_100'0000'0000'0000'0000'0000
.set SpOne,    0x3f800000
.set SnOne,    0xbf800000
#// Double
.set DpNmMAX,   0x7fefffffffffffff #//0_111'1111'1110'_1111'1...1'1111
.set DpNmMIN,   0x0010000000000000 #//0_000'0000'0001'_0000'0...0'0000
.set DnNmMAX,   0xffefffffffffffff #//1_111'1111'1110'_1111'1...1'1111
.set DnNmMIN,   0x8010000000000000
.set DpDmMAX,   0x000fffffffffffff #//0_000'0000'0000'_1111'1...1'1111
.set DpDmMIN,   0x0000000000000001 #//0_000'0000'0000'_0000'0...0'0001
.set DnDmMAX,   0x800fffffffffffff #//1_000'0000'0000'_1111'1...1'1111
.set DnDmMIN,   0x8000000000000001 #//1_000'0000'0000'_0000'0...0'0001
.set DpOne,     0x3ff0000000000000
.set DnOne,     0xbff0000000000000
.set DpqNaN1,   0x7ff8000000000001 #//0_111'1111'1111'_1000'0...0'0000
.set DnqNaN1,    0xfff8000000000001 #//1_111'1111'1111'_1000'0...0'0000
.set DpOne,     0x3ff0000000000000
.set DnOne,     0xbff0000000000000

main:
    vsetvli         x0 , x0 , e8 
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
    li              x10, 0x1
    vmv.s.x         v28, x10
.global SEW8_WIDEN_CVT_INST0
SEW8_WIDEN_CVT_INST0:
    vfwcvt.f.xu.v   v30, v28, v0.t
    vsetvli         x0 , x0 , e16
    FPUVCHECK_ZERO  v30, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e8 
    li              x10, 0xff
    vmv.s.x         v28, x10
.global SEW8_WIDEN_CVT_INST1
SEW8_WIDEN_CVT_INST1:
    vfwcvt.f.xu.v   v30, v28, v0.t
    vsetvli         x0 , x0 , e16
    FPUVCHECK_ZERO  v30, 0x5bf8, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e8 
    li              x10, 0x1
    vmv.s.x         v28, x10
.global SEW8_WIDEN_CVT_INST2
SEW8_WIDEN_CVT_INST2:
    vfwcvt.f.x.v    v30, v28, v0.t
    vsetvli         x0 , x0 , e16
    FPUVCHECK_ZERO  v30, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e8 
    li              x10, 0xff
    vmv.s.x         v28, x10
.global SEW8_WIDEN_CVT_INST3
SEW8_WIDEN_CVT_INST3:
    vfwcvt.f.x.v    v30, v28, v0.t
    vsetvli         x0 , x0 , e16
    FPUVCHECK_ZERO  v30, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
    FPUMOVD         f0 , DpZero, x1 
    FPUMOVH         f4 , HpsNaN, x1 
    FPUMOVH         f5 , HnsNaN, x1 
    FPUMOVH         f6 , HpqNaN, x1 
    FPUMOVH         f7 , HnqNaN, x1 
    FPUMOVH         f8 , HpInf, x1 
    FPUMOVH         f9 , HnInf, x1 
    FPUMOVH         f10, HpNorm, x1 
    FPUMOVH         f11, HnNorm, x1 
    FPUMOVH         f12, HpDeNorm, x1 
    FPUMOVH         f13, HnDeNorm, x1 
    FPUMOVH         f14, HpZero, x1 
    FPUMOVH         f15, HnZero, x1 
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
    vfmv.s.f        v4 , f4 
    vfmv.s.f        v5 , f5 
    vfmv.s.f        v6 , f6 
    vfmv.s.f        v7 , f7 
    vfmv.s.f        v8 , f8 
    vfmv.s.f        v9 , f9 
    vfmv.s.f        v10, f10
    vfmv.s.f        v11, f11
    vfmv.s.f        v12, f12
    vfmv.s.f        v13, f13
    vfmv.s.f        v14, f14
    vfmv.s.f        v15, f15
.global HALF_ADD_INST0
HALF_ADD_INST0:
    vfadd.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_ADD_INST3
HALF_ADD_INST3:
    vfadd.vv        v30, v10, v12, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_ADD_INST4
HALF_ADD_INST4:
    vfadd.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_ADD_INST7
HALF_ADD_INST7:
    vfadd.vf        v30, v10, f12, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SUB_INST0
HALF_SUB_INST0:
    vfsub.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SUB_INST3
HALF_SUB_INST3:
    vfsub.vv        v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SUB_INST4
HALF_SUB_INST4:
    vfsub.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SUB_INST7
HALF_SUB_INST7:
    vfsub.vf        v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SUB_INST8
HALF_SUB_INST8:
    vfrsub.vf       v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SUB_INST11
HALF_SUB_INST11:
    vfrsub.vf       v30, v13, f10, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_DIV_INST0
HALF_DIV_INST0:
    vfdiv.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_DIV_INST6
HALF_DIV_INST6:
    vfdiv.vv        v30, v12, v13, v0.t
    FPUVCHECK_ZERO  v30, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_DIV_INST7
HALF_DIV_INST7:
    vfdiv.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_DIV_INST13
HALF_DIV_INST13:
    vfdiv.vf        v30, v12, f13, v0.t
    FPUVCHECK_ZERO  v30, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_DIV_INST14
HALF_DIV_INST14:
    vfrdiv.vf       v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_DIV_INST20
HALF_DIV_INST20:
    vfrdiv.vf       v30, v12, f13, v0.t
    FPUVCHECK_ZERO  v30, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SQRT_INST0
HALF_SQRT_INST0:
    vfsqrt.v        v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_SQRT_INST4
HALF_SQRT_INST4:
    vfsqrt.v        v30, v12, v0.t
    FPUVCHECK_ZERO  v30, 0x0c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MIN_INST0
HALF_MIN_INST0:
    vfmin.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MIN_INST2
HALF_MIN_INST2:
    vfmin.vv        v30, v10, v12, v0.t
    FPUVCHECK_ZERO  v30, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MIN_INST4
HALF_MIN_INST4:
    vfmin.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MIN_INST6
HALF_MIN_INST6:
    vfmin.vf        v30, v10, f12, v0.t
    FPUVCHECK_ZERO  v30, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MAX_INST0
HALF_MAX_INST0:
    vfmax.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MAX_INST2
HALF_MAX_INST2:
    vfmax.vv        v30, v10, v12, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MAX_INST4
HALF_MAX_INST4:
    vfmax.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_MAX_INST6
HALF_MAX_INST6:
    vfmax.vf        v30, v10, f12, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJ_INST0
HALF_VFSGNJ_INST0:
    vfsgnj.vv       v30, v4 , v5 , v0.t
    FPUVCHECK_ZERO  v30, HnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJ_INST2
HALF_VFSGNJ_INST2:
    vfsgnj.vv       v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, HnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJ_INST3
HALF_VFSGNJ_INST3:
    vfsgnj.vf       v30, v4 , f5 , v0.t
    FPUVCHECK_ZERO  v30, HnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJ_INST5
HALF_VFSGNJ_INST5:
    vfsgnj.vf       v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, HnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJN_INST0
HALF_VFSGNJN_INST0:
    vfsgnjn.vv      v30, v4 , v5 , v0.t
    FPUVCHECK_ZERO  v30, HpsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJN_INST2
HALF_VFSGNJN_INST2:
    vfsgnjn.vv      v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJN_INST3
HALF_VFSGNJN_INST3:
    vfsgnjn.vf      v30, v4 , f5 , v0.t
    FPUVCHECK_ZERO  v30, HpsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJN_INST5
HALF_VFSGNJN_INST5:
    vfsgnjn.vf      v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJX_INST0
HALF_VFSGNJX_INST0:
    vfsgnjx.vv      v30, v4 , v5 , v0.t
    FPUVCHECK_ZERO  v30, HnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJX_INST2
HALF_VFSGNJX_INST2:
    vfsgnjx.vv      v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, HnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJX_INST3
HALF_VFSGNJX_INST3:
    vfsgnjx.vf      v30, v4 , f5 , v0.t
    FPUVCHECK_ZERO  v30, HnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFSGNJX_INST5
HALF_VFSGNJX_INST5:
    vfsgnjx.vf      v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, HnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMEQ_INST0
HALF_VFMEQ_INST0:
    vmfeq.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMEQ_INST1
HALF_VFMEQ_INST1:
    vmfeq.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMEQ_INST2
HALF_VFMEQ_INST2:
    vmfeq.vv        v0 , v10, v10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMEQ_INST3
HALF_VFMEQ_INST3:
    vmfeq.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMEQ_INST4
HALF_VFMEQ_INST4:
    vmfeq.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMEQ_INST5
HALF_VFMEQ_INST5:
    vmfeq.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFNE_INST0
HALF_VMFNE_INST0:
    vmfne.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFNE_INST1
HALF_VMFNE_INST1:
    vmfne.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFNE_INST2
HALF_VMFNE_INST2:
    vmfne.vv        v0 , v10, v11, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFNE_INST3
HALF_VMFNE_INST3:
    vmfne.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFNE_INST4
HALF_VMFNE_INST4:
    vmfne.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFNE_INST5
HALF_VMFNE_INST5:
    vmfne.vf        v0 , v10, f11, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST0
HALF_VMFLT_INST0:
    vmflt.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST1
HALF_VMFLT_INST1:
    vmflt.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST2
HALF_VMFLT_INST2:
    vmflt.vv        v0 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST3
HALF_VMFLT_INST3:
    vmflt.vv        v0 , v10, v10, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST4
HALF_VMFLT_INST4:
    vmflt.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST5
HALF_VMFLT_INST5:
    vmflt.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST6
HALF_VMFLT_INST6:
    vmflt.vf        v0 , v10, f8 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLT_INST7
HALF_VMFLT_INST7:
    vmflt.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST0
HALF_VMFLE_INST0:
    vmfle.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST1
HALF_VMFLE_INST1:
    vmfle.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST2
HALF_VMFLE_INST2:
    vmfle.vv        v0 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST3
HALF_VMFLE_INST3:
    vmfle.vv        v0 , v10, v10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST4
HALF_VMFLE_INST4:
    vmfle.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST5
HALF_VMFLE_INST5:
    vmfle.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST6
HALF_VMFLE_INST6:
    vmfle.vf        v0 , v10, f8 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFLE_INST7
HALF_VMFLE_INST7:
    vmfle.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGT_INST0
HALF_VMFGT_INST0:
    vmfgt.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGT_INST1
HALF_VMFGT_INST1:
    vmfgt.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGT_INST2
HALF_VMFGT_INST2:
    vmfgt.vf        v0 , v8 , f10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGT_INST3
HALF_VMFGT_INST3:
    vmfgt.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGE_INST0
HALF_VMFGE_INST0:
    vmfge.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGE_INST1
HALF_VMFGE_INST1:
    vmfge.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGE_INST2
HALF_VMFGE_INST2:
    vmfge.vf        v0 , v8 , f10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFGE_INST3
HALF_VMFGE_INST3:
    vmfge.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST0
HALF_VMFPRD_INST0:
    vmford.vv       v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST1
HALF_VMFPRD_INST1:
    vmford.vv       v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST2
HALF_VMFPRD_INST2:
    vmford.vv       v0 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST3
HALF_VMFPRD_INST3:
    vmford.vv       v0 , v10, v12, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST4
HALF_VMFPRD_INST4:
    vmford.vf       v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST5
HALF_VMFPRD_INST5:
    vmford.vf       v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST6
HALF_VMFPRD_INST6:
    vmford.vf       v0 , v10, f8 , v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VMFPRD_INST7
HALF_VMFPRD_INST7:
    vmford.vf       v0 , v10, f12, v0.t
    FPUVCHECK_ZERO  v0 , HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VCLASS_INST0
HALF_VCLASS_INST0:
    vfclass.v       v30, v9 , v0.t
    FPUVCHECK_ZERO  v30, 0x1, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VCLASS_INST9
HALF_VCLASS_INST9:
    vfclass.v       v30, v5 , v0.t
    FPUVCHECK_ZERO  v30, 0x100, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vmv.s.x         v0 , x0 
.global HALF_VFMERGE_INST0
HALF_VFMERGE_INST0:
    vfmerge.vfm     v30, v4 , f8 , v0 
    FPUVCHECK_ZERO  v30, HpsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFMERGE_INST1
HALF_VFMERGE_INST1:
    vfmv.v.f        v30, f8 
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_VFMERGE_INST2
HALF_VFMERGE_INST2:
    vfmerge.vfm     v30, v4 , f8 , v0 
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_VFMERGE_INST3
HALF_VFMERGE_INST3:
    vfmv.v.f        v30, f9 
    FPUVCHECK_ZERO  v30, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vmv.s.x         v0 , x1 
.global HALF_CONVERT_INST0
HALF_CONVERT_INST0:
    vfcvt.xu.f.v    v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0xffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_CONVERT_INST1
HALF_CONVERT_INST1:
    vfcvt.xu.f.v    v30, v6 , v0.t
    FPUVCHECK_ZERO  v30, 0xffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_CONVERT_INST2
HALF_CONVERT_INST2:
    vfcvt.xu.f.v    v30, v10, v0.t
    FPUVCHECK_ZERO  v30, HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_CONVERT_INST3
HALF_CONVERT_INST3:
    vfcvt.x.f.v     v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0x7fff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_CONVERT_INST4
HALF_CONVERT_INST4:
    vfcvt.x.f.v     v30, v6 , v0.t
    FPUVCHECK_ZERO  v30, 0x7fff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_CONVERT_INST5
HALF_CONVERT_INST5:
    vfcvt.x.f.v     v30, v10, v0.t
    FPUVCHECK_ZERO  v30, HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0x1
    vmv.s.x         v28, x10
.global HALF_CONVERT_INST6
HALF_CONVERT_INST6:
    vfcvt.f.xu.v    v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0xffff
    vmv.s.x         v28, x10
.global HALF_CONVERT_INST7
HALF_CONVERT_INST7:
    vfcvt.f.xu.v    v30, v28, v0.t
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x25, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0xffff
    vmv.s.x         v28, x10
.global HALF_CONVERT_INST8
HALF_CONVERT_INST8:
    vfcvt.f.x.v     v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0x7fff
    vmv.s.x         v28, x10
.global HALF_CONVERT_INST9
HALF_CONVERT_INST9:
    vfcvt.f.x.v     v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0x7800, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e32
    vmv.v.x         v0 , x0 
    li              x1 , 0x1
    vslide1up.vx    v1 , v0 , x1 
    li              x1 , 0x00010001
    vslide1up.vx    v0 , v1 , x1 
    vsetvli         x0 , x0 , e16
    vfmv.v.f        v28, f10
.global HALF_REDUCT_INST0
HALF_REDUCT_INST0:
    vfredosum.vs    v30, v28, v11, v0.t
    FPUVCHECK_ZERO  v30, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.v.f        v28, f7 
.global HALF_REDUCT_INST1
HALF_REDUCT_INST1:
    vfredosum.vs    v30, v28, v6 , v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.v.f        v28, f8 
.global HALF_REDUCT_INST2
HALF_REDUCT_INST2:
    vfredsum.vs     v30, v28, v14, v0.t
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.v.f        v28, f8 
.global HALF_REDUCT_INST3
HALF_REDUCT_INST3:
    vfredsum.vs     v30, v28, v4 , v0.t
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
.global HALF_REDUCT_INST4
HALF_REDUCT_INST4:
    vfredmax.vs     v30, v28, v13, v0.t
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_REDUCT_INST5
HALF_REDUCT_INST5:
    vfredmax.vs     v30, v28, v6 , v0.t
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_REDUCT_INST6
HALF_REDUCT_INST6:
    vfredmin.vs     v30, v28, v13, v0.t
    FPUVCHECK_ZERO  v30, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_REDUCT_INST7
HALF_REDUCT_INST7:
    vfredmin.vs     v30, v28, v6 , v0.t
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global HALF_NARROW_CVT_INST0
HALF_NARROW_CVT_INST0:
    vsetvli         x0 , x0 , e8 
    vfncvt.xu.f.v   v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0xff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e8 
.global HALF_NARROW_CVT_INST1
HALF_NARROW_CVT_INST1:
    vfncvt.xu.f.v   v30, v10, v0.t
    FPUVCHECK_ZERO  v30, 0x0, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e8 
.global HALF_NARROW_CVT_INST2
HALF_NARROW_CVT_INST2:
    vfncvt.x.f.v    v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0x7f, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e8 
.global HALF_NARROW_CVT_INST3
HALF_NARROW_CVT_INST3:
    vfncvt.x.f.v    v30, v10, v0.t
    FPUVCHECK_ZERO  v30, 0x0, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST0
HALF_WIDEN_CVT_INST0:
    vfwcvt.xu.f.v   v30, v4 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0xffffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST1
HALF_WIDEN_CVT_INST1:
    vfwcvt.xu.f.v   v30, v6 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0xffffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST2
HALF_WIDEN_CVT_INST2:
    vfwcvt.xu.f.v   v30, v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x0, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST3
HALF_WIDEN_CVT_INST3:
    vfwcvt.x.f.v    v30, v4 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x7fffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST4
HALF_WIDEN_CVT_INST4:
    vfwcvt.x.f.v    v30, v6 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x7fffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST5
HALF_WIDEN_CVT_INST5:
    vfwcvt.x.f.v    v30, v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x0, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
    li              x10, 0x1
    vmv.s.x         v28, x10
.global HALF_WIDEN_CVT_INST6
HALF_WIDEN_CVT_INST6:
    vfwcvt.f.xu.v   v30, v28, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
    li              x10, 0xffff
    vmv.s.x         v28, x10
.global HALF_WIDEN_CVT_INST7
HALF_WIDEN_CVT_INST7:
    vfwcvt.f.xu.v   v30, v28, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x477fff00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
    li              x10, 0x1
    vmv.s.x         v28, x10
.global HALF_WIDEN_CVT_INST8
HALF_WIDEN_CVT_INST8:
    vfwcvt.f.x.v    v30, v28, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
    li              x10, 0xffff
    vmv.s.x         v28, x10
.global HALF_WIDEN_CVT_INST9
HALF_WIDEN_CVT_INST9:
    vfwcvt.f.x.v    v30, v28, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0xbf800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST10
HALF_WIDEN_CVT_INST10:
    vfwcvt.f.f.v    v30, v4 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_WIDEN_CVT_INST11
HALF_WIDEN_CVT_INST11:
    vfwcvt.f.f.v    v30, v12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x33800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST0
HALF_DST_WIDEN_VFADD_INST0:
    vfwadd.vv       v30, v4 , v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST1
HALF_DST_WIDEN_VFADD_INST1:
    vfwadd.vv       v30, v6 , v12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST2
HALF_DST_WIDEN_VFADD_INST2:
    vfwadd.vv       v30, v8 , v9 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST3
HALF_DST_WIDEN_VFADD_INST3:
    vfwadd.vv       v30, v10, v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST4
HALF_DST_WIDEN_VFADD_INST4:
    vfwadd.vf       v30, v4 , f10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST5
HALF_DST_WIDEN_VFADD_INST5:
    vfwadd.vf       v30, v6 , f12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST6
HALF_DST_WIDEN_VFADD_INST6:
    vfwadd.vf       v30, v8 , f9 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFADD_INST7
HALF_DST_WIDEN_VFADD_INST7:
    vfwadd.vf       v30, v10, f10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST0
HALF_DST_WIDEN_VFSUB_INST0:
    vfwsub.vv       v30, v4 , v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST1
HALF_DST_WIDEN_VFSUB_INST1:
    vfwsub.vv       v30, v6 , v12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST2
HALF_DST_WIDEN_VFSUB_INST2:
    vfwsub.vv       v30, v8 , v8 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST3
HALF_DST_WIDEN_VFSUB_INST3:
    vfwsub.vv       v30, v10, v11, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST4
HALF_DST_WIDEN_VFSUB_INST4:
    vfwsub.vf       v30, v4 , f10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST5
HALF_DST_WIDEN_VFSUB_INST5:
    vfwsub.vf       v30, v6 , f12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST6
HALF_DST_WIDEN_VFSUB_INST6:
    vfwsub.vf       v30, v8 , f8 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DST_WIDEN_VFSUB_INST7
HALF_DST_WIDEN_VFSUB_INST7:
    vfwsub.vf       v30, v10, f11, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    FPUMOVS         f16, SpsNaN, x1 
    FPUMOVS         f17, SnsNaN, x1 
    FPUMOVS         f18, SpqNaN, x1 
    FPUMOVS         f19, SnqNaN, x1 
    FPUMOVS         f20, SpInf, x1 
    FPUMOVS         f21, SnInf, x1 
    FPUMOVS         f22, SpNorm, x1 
    FPUMOVS         f23, SnNorm, x1 
    FPUMOVS         f24, SpDeNorm, x1 
    FPUMOVS         f25, SnDeNorm, x1 
    FPUMOVS         f26, SpZero, x1 
    FPUMOVS         f27, SnZero, x1 
    vfmv.s.f        v16, f16
    vfmv.s.f        v17, f17
    vfmv.s.f        v18, f18
    vfmv.s.f        v19, f19
    vfmv.s.f        v20, f20
    vfmv.s.f        v21, f21
    vfmv.s.f        v22, f22
    vfmv.s.f        v23, f23
    vfmv.s.f        v24, f24
    vfmv.s.f        v25, f25
    vfmv.s.f        v26, f26
    vfmv.s.f        v27, f27
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST0
HALF_DSTSRC_WIDEN_VFADD_INST0:
    vfwadd.wv       v30, v16, v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST1
HALF_DSTSRC_WIDEN_VFADD_INST1:
    vfwadd.wv       v30, v18, v12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST2
HALF_DSTSRC_WIDEN_VFADD_INST2:
    vfwadd.wv       v30, v20, v9 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST3
HALF_DSTSRC_WIDEN_VFADD_INST3:
    vfwadd.wv       v30, v22, v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST4
HALF_DSTSRC_WIDEN_VFADD_INST4:
    vfwadd.wf       v30, v16, f10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST5
HALF_DSTSRC_WIDEN_VFADD_INST5:
    vfwadd.wf       v30, v18, f12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST6
HALF_DSTSRC_WIDEN_VFADD_INST6:
    vfwadd.wf       v30, v20, f9 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFADD_INST7
HALF_DSTSRC_WIDEN_VFADD_INST7:
    vfwadd.wf       v30, v22, f10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST0
HALF_DSTSRC_WIDEN_VFSUB_INST0:
    vfwsub.wv       v30, v16, v10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST1
HALF_DSTSRC_WIDEN_VFSUB_INST1:
    vfwsub.wv       v30, v18, v12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST2
HALF_DSTSRC_WIDEN_VFSUB_INST2:
    vfwsub.wv       v30, v20, v8 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST3
HALF_DSTSRC_WIDEN_VFSUB_INST3:
    vfwsub.wv       v30, v22, v11, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST4
HALF_DSTSRC_WIDEN_VFSUB_INST4:
    vfwsub.wf       v30, v16, f10, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST5
HALF_DSTSRC_WIDEN_VFSUB_INST5:
    vfwsub.wf       v30, v18, f12, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST6
HALF_DSTSRC_WIDEN_VFSUB_INST6:
    vfwsub.wf       v30, v20, f8 , v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
.global HALF_DSTSRC_WIDEN_VFSUB_INST7
HALF_DSTSRC_WIDEN_VFSUB_INST7:
    vfwsub.wf       v30, v22, f11, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vmv.s.x         v0 , x1 
    vsetvli         x0 , x0 , e32
    vmv.v.x         v0 , x0 
    li              x1 , 0x1
    vslide1up.vx    v1 , v0 , x1 
    vslide1up.vx    v0 , v1 , x1 
    vsetvli         x0 , x0 , e16
    vfmv.v.f        v28, f12
.global HALF_WIDEN_REDUCT_INST0
HALF_WIDEN_REDUCT_INST0:
    vfwredosum.vs   v30, v28, v24, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0x34000000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_WIDEN_REDUCT_INST1
HALF_WIDEN_REDUCT_INST1:
    vsetvli         x0 , x0 , e16
    vfwredosum.vs   v30, v28, v16, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16
    vfmv.v.f        v28, f13
.global HALF_WIDEN_REDUCT_INST2
HALF_WIDEN_REDUCT_INST2:
    vfwredsum.vs    v30, v28, v26, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, 0xb4000000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_WIDEN_REDUCT_INST3
HALF_WIDEN_REDUCT_INST3:
    vsetvli         x0 , x0 , e16
    vfwredsum.vs    v30, v28, v16, v0.t
    vsetvli         x0 , x0 , e32
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
    vsetvli         x0 , x0 , e32
    FPUMOVD         f0 , DpZero, x1 
    FPUMOVS         f4 , SpsNaN, x1 
    FPUMOVS         f5 , SnsNaN, x1 
    FPUMOVS         f6 , SpqNaN, x1 
    FPUMOVS         f7 , SnqNaN, x1 
    FPUMOVS         f8 , SpInf, x1 
    FPUMOVS         f9 , SnInf, x1 
    FPUMOVS         f10, SpNorm, x1 
    FPUMOVS         f11, SnNorm, x1 
    FPUMOVS         f12, SpDeNorm, x1 
    FPUMOVS         f13, SnDeNorm, x1 
    FPUMOVS         f14, SpZero, x1 
    FPUMOVS         f15, SnZero, x1 
    vfmv.s.f        v4 , f4 
    vfmv.s.f        v5 , f5 
    vfmv.s.f        v6 , f6 
    vfmv.s.f        v7 , f7 
    vfmv.s.f        v8 , f8 
    vfmv.s.f        v9 , f9 
    vfmv.s.f        v10, f10
    vfmv.s.f        v11, f11
    vfmv.s.f        v12, f12
    vfmv.s.f        v13, f13
    vfmv.s.f        v14, f14
    vfmv.s.f        v15, f15
.global SINGLE_ADD_INST0
SINGLE_ADD_INST0:
    vfadd.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_ADD_INST3
SINGLE_ADD_INST3:
    vfadd.vv        v30, v10, v12, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_ADD_INST4
SINGLE_ADD_INST4:
    vfadd.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_ADD_INST7
SINGLE_ADD_INST7:
    vfadd.vf        v30, v10, f12, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SUB_INST0
SINGLE_SUB_INST0:
    vfsub.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SUB_INST3
SINGLE_SUB_INST3:
    vfsub.vv        v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SUB_INST4
SINGLE_SUB_INST4:
    vfsub.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SUB_INST7
SINGLE_SUB_INST7:
    vfsub.vf        v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SUB_INST8
SINGLE_SUB_INST8:
    vfrsub.vf       v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SUB_INST11
SINGLE_SUB_INST11:
    vfrsub.vf       v30, v13, f10, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_DIV_INST0
SINGLE_DIV_INST0:
    vfdiv.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_DIV_INST6
SINGLE_DIV_INST6:
    vfdiv.vv        v30, v12, v13, v0.t
    FPUVCHECK_ZERO  v30, 0xbf800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_DIV_INST7
SINGLE_DIV_INST7:
    vfdiv.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_DIV_INST13
SINGLE_DIV_INST13:
    vfdiv.vf        v30, v12, f13, v0.t
    FPUVCHECK_ZERO  v30, 0xbf800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_DIV_INST14
SINGLE_DIV_INST14:
    vfrdiv.vf       v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_DIV_INST20
SINGLE_DIV_INST20:
    vfrdiv.vf       v30, v12, f13, v0.t
    FPUVCHECK_ZERO  v30, 0xbf800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SQRT_INST0
SINGLE_SQRT_INST0:
    vfsqrt.v        v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_SQRT_INST3
SINGLE_SQRT_INST3:
    vfsqrt.v        v30, v15, v0.t
    FPUVCHECK_ZERO  v30, SnZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MIN_INST0
SINGLE_MIN_INST0:
    vfmin.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MIN_INST3
SINGLE_MIN_INST3:
    vfmin.vv        v30, v14, v15, v0.t
    FPUVCHECK_ZERO  v30, SnZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MIN_INST4
SINGLE_MIN_INST4:
    vfmin.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MIN_INST7
SINGLE_MIN_INST7:
    vfmin.vf        v30, v14, f15, v0.t
    FPUVCHECK_ZERO  v30, SnZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MAX_INST0
SINGLE_MAX_INST0:
    vfmax.vv        v30, v4 , v12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MAX_INST3
SINGLE_MAX_INST3:
    vfmax.vv        v30, v14, v15, v0.t
    FPUVCHECK_ZERO  v30, SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MAX_INST4
SINGLE_MAX_INST4:
    vfmax.vf        v30, v4 , f12, v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_MAX_INST7
SINGLE_MAX_INST7:
    vfmax.vf        v30, v14, f15, v0.t
    FPUVCHECK_ZERO  v30, SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJ_INST0
SINGLE_VFSGNJ_INST0:
    vfsgnj.vv       v30, v4 , v5 , v0.t
    FPUVCHECK_ZERO  v30, SnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJ_INST2
SINGLE_VFSGNJ_INST2:
    vfsgnj.vv       v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, SnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJ_INST3
SINGLE_VFSGNJ_INST3:
    vfsgnj.vf       v30, v4 , f5 , v0.t
    FPUVCHECK_ZERO  v30, SnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJ_INST5
SINGLE_VFSGNJ_INST5:
    vfsgnj.vf       v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, SnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJN_INST0
SINGLE_VFSGNJN_INST0:
    vfsgnjn.vv      v30, v4 , v5 , v0.t
    FPUVCHECK_ZERO  v30, SpsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJN_INST2
SINGLE_VFSGNJN_INST2:
    vfsgnjn.vv      v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJN_INST3
SINGLE_VFSGNJN_INST3:
    vfsgnjn.vf      v30, v4 , f5 , v0.t
    FPUVCHECK_ZERO  v30, SpsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJN_INST5
SINGLE_VFSGNJN_INST5:
    vfsgnjn.vf      v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJX_INST0
SINGLE_VFSGNJX_INST0:
    vfsgnjx.vv      v30, v4 , v5 , v0.t
    FPUVCHECK_ZERO  v30, SnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJX_INST2
SINGLE_VFSGNJX_INST2:
    vfsgnjx.vv      v30, v10, v13, v0.t
    FPUVCHECK_ZERO  v30, SnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJX_INST3
SINGLE_VFSGNJX_INST3:
    vfsgnjx.vf      v30, v4 , f5 , v0.t
    FPUVCHECK_ZERO  v30, SnsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFSGNJX_INST5
SINGLE_VFSGNJX_INST5:
    vfsgnjx.vf      v30, v10, f13, v0.t
    FPUVCHECK_ZERO  v30, SnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMEQ_INST0
SINGLE_VFMEQ_INST0:
    vmfeq.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMEQ_INST1
SINGLE_VFMEQ_INST1:
    vmfeq.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMEQ_INST2
SINGLE_VFMEQ_INST2:
    vmfeq.vv        v0 , v10, v10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMEQ_INST3
SINGLE_VFMEQ_INST3:
    vmfeq.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMEQ_INST4
SINGLE_VFMEQ_INST4:
    vmfeq.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMEQ_INST5
SINGLE_VFMEQ_INST5:
    vmfeq.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFNE_INST0
SINGLE_VMFNE_INST0:
    vmfne.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFNE_INST1
SINGLE_VMFNE_INST1:
    vmfne.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFNE_INST2
SINGLE_VMFNE_INST2:
    vmfne.vv        v0 , v10, v11, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFNE_INST3
SINGLE_VMFNE_INST3:
    vmfne.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFNE_INST4
SINGLE_VMFNE_INST4:
    vmfne.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFNE_INST5
SINGLE_VMFNE_INST5:
    vmfne.vf        v0 , v10, f11, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST0
SINGLE_VMFLT_INST0:
    vmflt.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST1
SINGLE_VMFLT_INST1:
    vmflt.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST2
SINGLE_VMFLT_INST2:
    vmflt.vv        v0 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST3
SINGLE_VMFLT_INST3:
    vmflt.vv        v0 , v10, v10, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST4
SINGLE_VMFLT_INST4:
    vmflt.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST5
SINGLE_VMFLT_INST5:
    vmflt.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST6
SINGLE_VMFLT_INST6:
    vmflt.vf        v0 , v10, f8 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLT_INST7
SINGLE_VMFLT_INST7:
    vmflt.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST0
SINGLE_VMFLE_INST0:
    vmfle.vv        v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST1
SINGLE_VMFLE_INST1:
    vmfle.vv        v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST2
SINGLE_VMFLE_INST2:
    vmfle.vv        v0 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST3
SINGLE_VMFLE_INST3:
    vmfle.vv        v0 , v10, v10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST4
SINGLE_VMFLE_INST4:
    vmfle.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST5
SINGLE_VMFLE_INST5:
    vmfle.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST6
SINGLE_VMFLE_INST6:
    vmfle.vf        v0 , v10, f8 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFLE_INST7
SINGLE_VMFLE_INST7:
    vmfle.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGT_INST0
SINGLE_VMFGT_INST0:
    vmfgt.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGT_INST1
SINGLE_VMFGT_INST1:
    vmfgt.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGT_INST2
SINGLE_VMFGT_INST2:
    vmfgt.vf        v0 , v8 , f10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGT_INST3
SINGLE_VMFGT_INST3:
    vmfgt.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGE_INST0
SINGLE_VMFGE_INST0:
    vmfge.vf        v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGE_INST1
SINGLE_VMFGE_INST1:
    vmfge.vf        v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGE_INST2
SINGLE_VMFGE_INST2:
    vmfge.vf        v0 , v8 , f10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFGE_INST3
SINGLE_VMFGE_INST3:
    vmfge.vf        v0 , v10, f10, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST0
SINGLE_VMFPRD_INST0:
    vmford.vv       v0 , v4 , v6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST1
SINGLE_VMFPRD_INST1:
    vmford.vv       v0 , v6 , v15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST2
SINGLE_VMFPRD_INST2:
    vmford.vv       v0 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST3
SINGLE_VMFPRD_INST3:
    vmford.vv       v0 , v10, v12, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST4
SINGLE_VMFPRD_INST4:
    vmford.vf       v0 , v4 , f6 , v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST5
SINGLE_VMFPRD_INST5:
    vmford.vf       v0 , v6 , f15, v0.t
    FPUVCHECK_ZERO  v0 , SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST6
SINGLE_VMFPRD_INST6:
    vmford.vf       v0 , v10, f8 , v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.v.f        v0 , f14
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VMFPRD_INST7
SINGLE_VMFPRD_INST7:
    vmford.vf       v0 , v10, f12, v0.t
    FPUVCHECK_ZERO  v0 , SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VCLASS_INST0
SINGLE_VCLASS_INST0:
    vfclass.v       v30, v9 , v0.t
    FPUVCHECK_ZERO  v30, 0x1, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VCLASS_INST9
SINGLE_VCLASS_INST9:
    vfclass.v       v30, v5 , v0.t
    FPUVCHECK_ZERO  v30, 0x100, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vmv.s.x         v0 , x0 
.global SINGLE_VFMERGE_INST0
SINGLE_VFMERGE_INST0:
    vfmerge.vfm     v30, v4 , f8 , v0 
    FPUVCHECK_ZERO  v30, SpsNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFMERGE_INST1
SINGLE_VFMERGE_INST1:
    vfmv.v.f        v30, f8 
    FPUVCHECK_ZERO  v30, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
.global SINGLE_VFMERGE_INST2
SINGLE_VFMERGE_INST2:
    vfmerge.vfm     v30, v4 , f8 , v0 
    FPUVCHECK_ZERO  v30, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_VFMERGE_INST3
SINGLE_VFMERGE_INST3:
    vfmv.v.f        v30, f9 
    FPUVCHECK_ZERO  v30, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vmv.s.x         v0 , x1 
.global SINGLE_CONVERT_INST0
SINGLE_CONVERT_INST0:
    vfcvt.xu.f.v    v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0xffffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_CONVERT_INST1
SINGLE_CONVERT_INST1:
    vfcvt.xu.f.v    v30, v6 , v0.t
    FPUVCHECK_ZERO  v30, 0xffffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_CONVERT_INST2
SINGLE_CONVERT_INST2:
    vfcvt.xu.f.v    v30, v10, v0.t
    FPUVCHECK_ZERO  v30, SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_CONVERT_INST3
SINGLE_CONVERT_INST3:
    vfcvt.x.f.v     v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0x7fffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_CONVERT_INST4
SINGLE_CONVERT_INST4:
    vfcvt.x.f.v     v30, v6 , v0.t
    FPUVCHECK_ZERO  v30, 0x7fffffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_CONVERT_INST5
SINGLE_CONVERT_INST5:
    vfcvt.x.f.v     v30, v10, v0.t
    FPUVCHECK_ZERO  v30, SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0x1
    vmv.s.x         v28, x10
.global SINGLE_CONVERT_INST6
SINGLE_CONVERT_INST6:
    vfcvt.f.xu.v    v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0xffffffff
    vmv.s.x         v28, x10
.global SINGLE_CONVERT_INST7
SINGLE_CONVERT_INST7:
    vfcvt.f.xu.v    v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0x4f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0xffffffff
    vmv.s.x         v28, x10
.global SINGLE_CONVERT_INST8
SINGLE_CONVERT_INST8:
    vfcvt.f.x.v     v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0xbf800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x10, 0x7fffffff
    vmv.s.x         v28, x10
.global SINGLE_CONVERT_INST9
SINGLE_CONVERT_INST9:
    vfcvt.f.x.v     v30, v28, v0.t
    FPUVCHECK_ZERO  v30, 0x4f000000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e32
    vmv.v.x         v0 , x0 
    li              x1 , 0x1
    vslide1up.vx    v1 , v0 , x1 
    vslide1up.vx    v0 , v1 , x1 
    vfmv.v.f        v28, f12
.global SINGLE_REDUCT_INST0
SINGLE_REDUCT_INST0:
    vfredosum.vs    v30, v28, v13, v0.t
    FPUVCHECK_ZERO  v30, 0x1, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_REDUCT_INST1
SINGLE_REDUCT_INST1:
    vfredosum.vs    v30, v28, v4 , v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.v.f        v28, f10
.global SINGLE_REDUCT_INST2
SINGLE_REDUCT_INST2:
    vfredsum.vs     v30, v28, v13, v0.t
    FPUVCHECK_ZERO  v30, 0x3f800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_REDUCT_INST3
SINGLE_REDUCT_INST3:
    vfredsum.vs     v30, v28, v4 , v0.t
    FPUVCHECK_ZERO  v30, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.v.f        v28, f8 
.global SINGLE_REDUCT_INST4
SINGLE_REDUCT_INST4:
    vfredmax.vs     v30, v28, v13, v0.t
    FPUVCHECK_ZERO  v30, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_REDUCT_INST5
SINGLE_REDUCT_INST5:
    vfredmax.vs     v30, v28, v6 , v0.t
    FPUVCHECK_ZERO  v30, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_REDUCT_INST6
SINGLE_REDUCT_INST6:
    vfredmin.vs     v30, v28, v13, v0.t
    FPUVCHECK_ZERO  v30, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_REDUCT_INST7
SINGLE_REDUCT_INST7:
    vfredmin.vs     v30, v28, v6 , v0.t
    FPUVCHECK_ZERO  v30, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    li              x1 , 0x1
    vmv.s.x         v0 , x1 
    vsetvli         x0 , x0 , e16
.global SINGLE_NARROW_CVT_INST0
SINGLE_NARROW_CVT_INST0:
    vfncvt.xu.f.v   v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0xffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST1
SINGLE_NARROW_CVT_INST1:
    vfncvt.xu.f.v   v30, v10, v0.t
    FPUVCHECK_ZERO  v30, 0x0, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST2
SINGLE_NARROW_CVT_INST2:
    vfncvt.x.f.v    v30, v4 , v0.t
    FPUVCHECK_ZERO  v30, 0x7fff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST3
SINGLE_NARROW_CVT_INST3:
    vfncvt.x.f.v    v30, v10, v0.t
    FPUVCHECK_ZERO  v30, 0x0, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x21, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST4
SINGLE_NARROW_CVT_INST4:
    vfncvt.f.f.v    v30, v4 , v0.t
    vsetvli         x0 , x0 , e16
    FPUVCHECK_ZERO  v30, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x30, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST5
SINGLE_NARROW_CVT_INST5:
    vfncvt.f.f.v    v30, v8 , v0.t
    FPUVCHECK_ZERO  v30, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST6
SINGLE_NARROW_CVT_INST6:
    vfncvt.f.f.v    v30, v10, v0.t
    FPUVCHECK_ZERO  v30, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x0, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_NARROW_CVT_INST7
SINGLE_NARROW_CVT_INST7:
    vfncvt.f.f.v    v30, v12, v0.t
    vsetvli         x0 , x0 , e16
    FPUVCHECK_ZERO  v30, HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vmv.v.x         v30, x0 
    FPUEXCHK        0x23, x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e32, m1 
    fmv.s.x         f0 , x0 
    FPUMOVS         f4 , SpsNaN, x1 
    FPUMOVS         f5 , SnsNaN, x1 
    FPUMOVS         f6 , SpqNaN, x1 
    FPUMOVS         f7 , SnqNaN, x1 
    FPUMOVS         f8 , SpInf, x1 
    FPUMOVS         f9 , SnInf, x1 
    FPUMOVS         f10, SpNorm, x1 
    FPUMOVS         f11, SnNorm, x1 
    FPUMOVS         f12, SpDeNorm, x1 
    FPUMOVS         f13, SnDeNorm, x1 
    FPUMOVS         f14, SpZero, x1 
    FPUMOVS         f15, SnZero, x1 
    FPUMOVS         f16, SpMIN, x1 
    FPUMOVS         f17, SpOne, x1 
    FPUMOVS         f18, SpLFN, x1 
    FPUMOVS         f19, SnLFN, x1 
    FPUMOVS         f20, SpLFN, x1 
    FPUMOVS         f21, SpDeNorm, x1 
    FPUMOVS         f22, SpInf, x1 
    FPUMOVS         f23, SpMIN, x1 
    vfmv.s.f        v4 , f4 
    vfmv.s.f        v5 , f5 
    vfmv.s.f        v6 , f6 
    vfmv.s.f        v7 , f7 
    vfmv.s.f        v8 , f8 
    vfmv.s.f        v9 , f9 
    vfmv.s.f        v10, f10
    vfmv.s.f        v11, f11
    vfmv.s.f        v12, f12
    vfmv.s.f        v13, f13
    vfmv.s.f        v14, f14
    vfmv.s.f        v15, f15
    vfmv.s.f        v16, f16
    vfmv.s.f        v17, f17
    vfmv.s.f        v18, f18
    vfmv.s.f        v19, f19
    vfmv.s.f        v20, f20
    vfmv.s.f        v21, f21
    vfmv.s.f        v22, f22
    vfmv.s.f        v23, f23
.global SINGLE_INST0
SINGLE_INST0:
    vfmul.vv        v29, v4 , v4 , v0.t
    FPUVCHECK_ZERO  v29, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v29, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v29, v4 , f4 , v0.t
    FPUVCHECK_ZERO  v29, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v29, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v28, v8 , v14, v0.t
    FPUVCHECK_ZERO  v28, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v28, v8 , f14, v0.t
    FPUVCHECK_ZERO  v28, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v27, v10, v16, v0.t
    FPUVCHECK_ZERO  v27, 0x400000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v27, v14, f0 , v0.t
    vfmul.vf        v27, v10, f16, v0.t
    FPUVCHECK_ZERO  v27, 0x400000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v27, v14, f0 , v0.t
    vfmul.vv        v26, v18, v18, v0.t
    FPUVCHECK_ZERO  v26, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v27, v14, f0 , v0.t
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v26, v18, f18, v0.t
    FPUVCHECK_ZERO  v26, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v26, v12, v12, v0.t
    FPUVCHECK_ZERO  v26, SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v26, v12, f12, v0.t
    FPUVCHECK_ZERO  v26, SpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global SINGLE_INST1
SINGLE_INST1:
    vfmacc.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmacc.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmacc.vv       v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmacc.vf       v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmacc.vv       v17, v10, v16, v0.t
    FPUVCHECK_ZERO  v17, SpOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v17, f17
    vfmacc.vf       v17, f10, v16, v0.t
    FPUVCHECK_ZERO  v17, SpOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v17, f17
    vfmacc.vv       v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmacc.vf       v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmacc.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmacc.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST2
SINGLE_INST2:
    vfnmacc.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmacc.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmacc.vv      v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmacc.vf      v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmacc.vv      v17, v10, v16, v0.t
    FPUVCHECK_ZERO  v17, SnOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v17, f17
    vfnmacc.vf      v17, f10, v16, v0.t
    FPUVCHECK_ZERO  v17, SnOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v17, f17
    vfnmacc.vv      v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmacc.vf      v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmacc.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmacc.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST3
SINGLE_INST3:
    vfmsac.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsac.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsac.vv       v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsac.vf       v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsac.vv       v16, v10, v16, v0.t
    FPUVCHECK_ZERO  v16, 0x80400000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfmsac.vf       v16, f10, v16, v0.t
    FPUVCHECK_ZERO  v16, 0x80400000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfmsac.vv       v12, v18, v18, v0.t
    FPUVCHECK_ZERO  v12, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vf       v12, f18, v18, v0.t
    FPUVCHECK_ZERO  v12, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vv       v12, v18, v18, v0.t
    FPUVCHECK_ZERO  v12, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vf       v12, f18, v18, v0.t
    FPUVCHECK_ZERO  v12, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST4
SINGLE_INST4:
    vfnmsac.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsac.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsac.vv      v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsac.vf      v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x0 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsac.vv      v16, v10, v16, v0.t
    FPUVCHECK_ZERO  v16, 0x00400000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfnmsac.vf      v16, f10, v16, v0.t
    FPUVCHECK_ZERO  v16, 0x00400000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfnmsac.vv      v12, v18, v18, v0.t
    FPUVCHECK_ZERO  v12, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsac.vf      v12, f18, v18, v0.t
    FPUVCHECK_ZERO  v12, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsac.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsac.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST5
SINGLE_INST5:
    vfmadd.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmadd.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmadd.vv       v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmadd.vf       v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmadd.vv       v16, v10, v17, v0.t
    FPUVCHECK_ZERO  v16, SpOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfmadd.vf       v16, f10, v17, v0.t
    FPUVCHECK_ZERO  v16, SpOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfmadd.vv       v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmadd.vf       v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmadd.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmadd.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST6
SINGLE_INST6:
    vfnmadd.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmadd.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmadd.vv      v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmadd.vf      v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmadd.vv      v16, v10, v17, v0.t
    FPUVCHECK_ZERO  v16, SnOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfnmadd.vf      v16, f10, v17, v0.t
    FPUVCHECK_ZERO  v16, SnOne, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfnmadd.vv      v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmadd.vf      v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmadd.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmadd.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST7
SINGLE_INST7:
    vfmsub.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsub.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsub.vv       v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsub.vf       v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsub.vv       v16, v10, v10, v0.t
    FPUVCHECK_ZERO  v16, SnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v16, f16
    vfmsub.vf       v16, f10, v10, v0.t
    FPUVCHECK_ZERO  v16, SnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v16, f16
    vfmsub.vv       v18, v18, v12, v0.t
    FPUVCHECK_ZERO  v18, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmsub.vf       v18, f18, v12, v0.t
    FPUVCHECK_ZERO  v18, SpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmsub.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsub.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global SINGLE_INST8
SINGLE_INST8:
    vfnmsub.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsub.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsub.vv      v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsub.vf      v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsub.vv      v16, v10, v10, v0.t
    FPUVCHECK_ZERO  v16, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v16, f16
    vfnmsub.vf      v16, f10, v10, v0.t
    FPUVCHECK_ZERO  v16, SpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v16, f16
    vfnmsub.vv      v18, v18, v12, v0.t
    FPUVCHECK_ZERO  v18, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmsub.vf      v18, f18, v12, v0.t
    FPUVCHECK_ZERO  v18, SnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmsub.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsub.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, SpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vsetvli         x0 , x0 , e16, m1 
    fmv.d.x         f0 , x0 
    FPUMOVH         f4 , HpsNaN, x1 
    FPUMOVH         f5 , HnsNaN, x1 
    FPUMOVH         f6 , HpqNaN, x1 
    FPUMOVH         f7 , HnqNaN, x1 
    FPUMOVH         f8 , HpInf, x1 
    FPUMOVH         f9 , HnInf, x1 
    FPUMOVH         f10, HpNorm, x1 
    FPUMOVH         f11, HnNorm, x1 
    FPUMOVH         f12, HpDeNorm, x1 
    FPUMOVH         f13, HnDeNorm, x1 
    FPUMOVH         f14, HpZero, x1 
    FPUMOVH         f15, HnZero, x1 
    FPUMOVH         f16, HpMIN, x1 
    FPUMOVH         f17, HpOne, x1 
    FPUMOVH         f18, HpLFN, x1 
    FPUMOVH         f19, HnLFN, x1 
    FPUMOVH         f20, HpLFN, x1 
    FPUMOVH         f21, HpDeNorm, x1 
    FPUMOVH         f22, HpInf, x1 
    vfmv.s.f        v4 , f4 
    vfmv.s.f        v5 , f5 
    vfmv.s.f        v6 , f6 
    vfmv.s.f        v7 , f7 
    vfmv.s.f        v8 , f8 
    vfmv.s.f        v9 , f9 
    vfmv.s.f        v10, f10
    vfmv.s.f        v11, f11
    vfmv.s.f        v12, f12
    vfmv.s.f        v13, f13
    vfmv.s.f        v14, f14
    vfmv.s.f        v15, f15
    vfmv.s.f        v16, f16
    vfmv.s.f        v17, f17
    vfmv.s.f        v18, f18
    vfmv.s.f        v19, f19
    vfmv.s.f        v20, f20
    vfmv.s.f        v21, f21
    vfmv.s.f        v22, f22
.global HALF_INST0
HALF_INST0:
    vfmul.vv        v29, v4 , v4 , v0.t
    FPUVCHECK_ZERO  v29, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v29, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v29, v4 , f4 , v0.t
    FPUVCHECK_ZERO  v29, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v29, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v28, v8 , v14, v0.t
    FPUVCHECK_ZERO  v28, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v28, v8 , f14, v0.t
    FPUVCHECK_ZERO  v28, HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v27, v10, v16, v0.t
    FPUVCHECK_ZERO  v27, 0x0200, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v27, v14, f0 , v0.t
    FPUEXCHK        0x00 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v27, v10, f16, v0.t
    FPUVCHECK_ZERO  v27, 0x0200, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v27, v14, f0 , v0.t
    FPUEXCHK        0x00 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v26, v18, v18, v0.t
    FPUVCHECK_ZERO  v26, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v26, v18, f18, v0.t
    FPUVCHECK_ZERO  v26, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vv        v26, v12, v12, v0.t
    FPUVCHECK_ZERO  v26, HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmul.vf        v26, v12, f12, v0.t
    FPUVCHECK_ZERO  v26, HpZero, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfadd.vf        v26, v14, f0 , v0.t
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
.global HALF_INST1
HALF_INST1:
    vfmacc.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmacc.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmacc.vv       v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmacc.vf       v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmacc.vv       v17, v10, v16, v0.t
    FPUVCHECK_ZERO  v17, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v17, f17
    vfmacc.vf       v17, f10, v16, v0.t
    FPUVCHECK_ZERO  v17, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v17, f17
    vfmacc.vv       v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmacc.vf       v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmacc.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmacc.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST2
HALF_INST2:
    vfnmacc.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmacc.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmacc.vv      v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmacc.vf      v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmacc.vv      v17, v10, v16, v0.t
    FPUVCHECK_ZERO  v17, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v17, f17
    vfnmacc.vf      v17, f10, v16, v0.t
    FPUVCHECK_ZERO  v17, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v17, f17
    vfnmacc.vv      v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmacc.vf      v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmacc.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmacc.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST3
HALF_INST3:
    vfmsac.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsac.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsac.vv       v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsac.vf       v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsac.vv       v16, v10, v10, v0.t
    FPUVCHECK_ZERO  v16, 0x3400, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfmsac.vf       v16, f10, v10, v0.t
    FPUVCHECK_ZERO  v16, 0x3400, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfmsac.vv       v12, v18, v18, v0.t
    FPUVCHECK_ZERO  v12, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vf       v12, f18, v18, v0.t
    FPUVCHECK_ZERO  v12, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsac.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST4
HALF_INST4:
    vfnmsac.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsac.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsac.vv      v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsac.vf      v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsac.vv      v16, v10, v10, v0.t
    FPUVCHECK_ZERO  v16, 0xb400, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfnmsac.vf      v16, f10, v10, v0.t
    FPUVCHECK_ZERO  v16, 0xb400, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    vfnmsac.vv      v12, v18, v18, v0.t
    FPUVCHECK_ZERO  v12, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsac.vf      v12, f18, v18, v0.t
    FPUVCHECK_ZERO  v12, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsac.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsac.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST5
HALF_INST5:
    vfmadd.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmadd.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmadd.vv       v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmadd.vf       v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmadd.vv       v16, v10, v17, v0.t
    FPUVCHECK_ZERO  v16, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmadd.vf       v16, f10, v17, v0.t
    FPUVCHECK_ZERO  v16, 0x3c00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmadd.vv       v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmadd.vf       v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmadd.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmadd.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST6
HALF_INST6:
    vfnmadd.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmadd.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmadd.vv      v8 , v11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmadd.vf      v8 , f11, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmadd.vv      v16, v10, v17, v0.t
    FPUVCHECK_ZERO  v16, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfnmadd.vf      v16, f10, v17, v0.t
    FPUVCHECK_ZERO  v16, 0xbc00, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfnmadd.vv      v18, v18, v18, v0.t
    FPUVCHECK_ZERO  v18, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmadd.vf      v18, f18, v18, v0.t
    FPUVCHECK_ZERO  v18, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmadd.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmadd.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST7
HALF_INST7:
    vfmsub.vv       v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsub.vf       v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfmsub.vv       v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsub.vf       v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsub.vv       v16, v10, v10, v0.t
    FPUVCHECK_ZERO  v16, HnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsub.vf       v16, f10, v10, v0.t
    FPUVCHECK_ZERO  v16, HnNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfmsub.vv       v18, v18, v12, v0.t
    FPUVCHECK_ZERO  v18, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmsub.vf       v18, f18, v12, v0.t
    FPUVCHECK_ZERO  v18, HpInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfmsub.vv       v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfmsub.vf       v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HnDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global HALF_INST8
HALF_INST8:
    vfnmsub.vv      v4 , v10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsub.vf      v4 , f10, v10, v0.t
    FPUVCHECK_ZERO  v4 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v4 , f4 
    vfnmsub.vv      v8 , v10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsub.vf      v8 , f10, v8 , v0.t
    FPUVCHECK_ZERO  v8 , HpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v8 , f8 
    vfnmsub.vv      v16, v10, v10, v0.t
    FPUVCHECK_ZERO  v16, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v16, f16
    vfnmsub.vf      v16, f10, v10, v0.t
    FPUVCHECK_ZERO  v16, HpNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vfmv.s.f        v16, f16
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfnmsub.vv      v18, v18, v12, v0.t
    FPUVCHECK_ZERO  v18, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmsub.vf      v18, f18, v12, v0.t
    FPUVCHECK_ZERO  v18, HnInf, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x25 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v18, f18
    vfnmsub.vv      v12, v12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
    vfnmsub.vf      v12, f12, v12, v0.t
    FPUVCHECK_ZERO  v12, HpDeNorm, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x23 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfmv.s.f        v12, f12
.global WIDEN_16BIT_INST0
WIDEN_16BIT_INST0:
    vfwmul.vv       v28, v4 , v4 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfwmul.vf       v28, v4 , f4 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfwmul.vv       v28, v8 , v14, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfwmul.vf       v28, v8 , f14, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfadd.vf        v28, v14, f0 , v0.t
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vfwmul.vv       v28, v10, v16, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x38000000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfadd.vf        v28, v14, f0 , v0.t
    vfwmul.vf       v28, v10, f16, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x38000000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfadd.vf        v28, v14, f0 , v0.t
    vfwmul.vv       v20, v18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v20, 0x4f7fc004, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x00 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v20, f20
    vsetvli         x0 , x0 , e16, m1 
    vfwmul.vf       v20, v18, f18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v20, 0x4f7fc004, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x00 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v20, f20
    vsetvli         x0 , x0 , e16, m1 
    vfwmul.vv       v28, v12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x27800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x00 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmul.vf       v28, v12, f12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x27800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x00 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
.global WIDEN_16BIT_INST1
WIDEN_16BIT_INST1:
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vv      v4 , v10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vf      v4 , f10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vv      v22, v11, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vf      v22, f11, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpOne, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vv      v28, v10, v16, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x3f800100, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpOne, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vf      v28, f10, v16, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x3f800100, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpLFN, x1 
    vfmv.s.f        v20, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vv      v20, v18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v20, 0x7f7fffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v20, f20
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpLFN, x1 
    vfmv.s.f        v20, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vf      v20, f18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v20, 0x7f7fffff, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v20, f20
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vv      v28, v12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x27800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmacc.vf      v28, f12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x27800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
.global WIDEN_16BIT_INST2
WIDEN_16BIT_INST2:
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vv     v4 , v10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vf     v4 , f10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vv     v22, v11, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vf     v22, f11, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpOne, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vv     v28, v10, v16, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0xbf800100, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpOne, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vf     v28, f10, v16, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0xbf800100, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpLFN, x1 
    vfmv.s.f        v20, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vv     v20, v18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v20, SnLFN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v20, f20
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpLFN, x1 
    vfmv.s.f        v20, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vf     v20, f18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v20, SnLFN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v20, f20
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vv     v28, v12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0xa7800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmacc.vf     v28, f12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0xa7800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
.global WIDEN_16BIT_INST3
WIDEN_16BIT_INST3:
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vv      v4 , v10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vf      v4 , f10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vv      v22, v10, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vf      v22, f10, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpMIN, x1 
    vfmv.s.f        v16, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vv      v16, v10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v16, 0x3e800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v16, f16
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpMIN, x1 
    vfmv.s.f        v16, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vf      v16, f10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v16, 0x3e800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v16, f16
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnLFN, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vv      v28, v18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SpLFN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnLFN, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vf      v28, f18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SpLFN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vv      v28, v12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x27800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwmsac.vf      v28, f12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0x27800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
.global WIDEN_16BIT_INST4
WIDEN_16BIT_INST4:
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vv     v4 , v10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpsNaN, x1 
    vfmv.s.f        v4 , f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vf     v4 , f10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v4 , SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v4 , f4 
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vv     v22, v10, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpInf, x1 
    vfmv.s.f        v22, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vf     v22, f10, v8 , v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v22, SpqNaN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x30 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v22, f22
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpMIN, x1 
    vfmv.s.f        v16, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vv     v16, v10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v16, 0xbe800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v16, f16
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SpMIN, x1 
    vfmv.s.f        v16, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vf     v16, f10, v10, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v16, 0xbe800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v16, f16
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnLFN, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vv     v28, v18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SnLFN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnLFN, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vf     v28, f18, v18, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, SnLFN, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vv     v28, v12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0xa7800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e32, m1 
    FPUMOVS         f28, SnDeNorm, x1 
    vfmv.s.f        v28, f28
    vsetvli         x0 , x0 , e16, m1 
    vfwnmsac.vf     v28, f12, v12, v0.t
    vsetvli         x0 , x0 , e32, m1 
    FPUVCHECK_ZERO  v28, 0xa7800000, x3 , x4 
    bne             x3 , x4 , RESULTFAIL
    FPUEXCHK        0x21 x3 , x4 
    bne             x3 , x4 , EXCEPTION_FAIL
    vsetvli         x0 , x0 , e16, m1 
    vfmv.s.f        v28, f28
.global EXIT
EXIT:
    j __exit           
.global RESULT_CHECK
RESULT_CHECK:
    vext.x.v        x3 , v24, x20
    bne             x3 , x4 , RESULT_FAIL
    addi            x20, x20, 0x1
    bne             x20, x16, RESULT_CHECK
    li              x20, 0x0
    ret            
.global WIDEN_RESULT_CHECK
WIDEN_RESULT_CHECK:
    vsetvli         x0 , x0 , e32
    bge             x20, x17, HIGH_CHECK
    vext.x.v        x3 , v24, x20
    bne             x3 , x4 , RESULT_FAIL
    addi            x20, x20, 0x1
    j               WIDEN_RESULT_CHECK
.global HIGH_CHECK
HIGH_CHECK:
    vext.x.v        x3 , v25, x21
    bne             x3 , x4 , RESULT_FAIL
    addi            x21, x21, 0x1
    bne             x21, x17, HIGH_CHECK
    vsetvli         x0 , x0 , e16
    li              x20, 0x0
    li              x21, 0x0
    ret            
.global SEW8_WIDEN_RESULT_CHECK
SEW8_WIDEN_RESULT_CHECK:
    vsetvli         x0 , x0 , e16
    bge             x20, x18, SEW8_HIGH_CHECK
    vext.x.v        x3 , v24, x20
    bne             x3 , x4 , RESULT_FAIL
    addi            x20, x20, 0x1
    j               SEW8_WIDEN_RESULT_CHECK
.global SEW8_HIGH_CHECK
SEW8_HIGH_CHECK:
    vext.x.v        x3 , v25, x21
    bne             x3 , x4 , RESULT_FAIL
    addi            x21, x21, 0x1
    bne             x21, x18, SEW8_HIGH_CHECK
    vsetvli         x0 , x0 , e8 
    li              x20, 0x0
    li              x21, 0x0
    ret            
.global SEW8_NARROW_RESULT_CHECK
SEW8_NARROW_RESULT_CHECK:
    vext.x.v        x3 , v24, x20
    bne             x3 , x4 , RESULT_FAIL
    addi            x20, x20, 0x1
    bne             x20, x19, SEW8_NARROW_RESULT_CHECK
    li              x20, 0x0
    ret            
.global FAIL
FAIL:
    j __fail           
.global RESULT_FAIL
RESULT_FAIL:
    j __fail           
.global RESULTFAIL
RESULTFAIL:
    j __fail           
.global EXPTFAIL
EXPTFAIL:
    j __fail           
.global EXCEPTION_FAIL
EXCEPTION_FAIL:
    j __fail           
