; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-apple-darwin -mattr=avx512f,avx512bw < %s | FileCheck %s --check-prefix=AVX512BW

define <32 x double> @test_load_32f64(<32 x double>* %ptrs, <32 x i1> %mask, <32 x double> %src0)  {
; AVX512BW-LABEL: test_load_32f64:
; AVX512BW:       ## %bb.0:
; AVX512BW-NEXT:    vpsllw $7, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovb2m %zmm0, %k1
; AVX512BW-NEXT:    vblendmpd (%rdi), %zmm1, %zmm0 {%k1}
; AVX512BW-NEXT:    kshiftrd $16, %k1, %k2
; AVX512BW-NEXT:    vblendmpd 128(%rdi), %zmm3, %zmm5 {%k2}
; AVX512BW-NEXT:    kshiftrw $8, %k1, %k1
; AVX512BW-NEXT:    vblendmpd 64(%rdi), %zmm2, %zmm1 {%k1}
; AVX512BW-NEXT:    kshiftrw $8, %k2, %k1
; AVX512BW-NEXT:    vblendmpd 192(%rdi), %zmm4, %zmm3 {%k1}
; AVX512BW-NEXT:    vmovapd %zmm5, %zmm2
; AVX512BW-NEXT:    retq
  %res = call <32 x double> @llvm.masked.load.v32f64.p0v32f64(<32 x double>* %ptrs, i32 4, <32 x i1> %mask, <32 x double> %src0)
  ret <32 x double> %res
}

define <32 x i64> @test_load_32i64(<32 x i64>* %ptrs, <32 x i1> %mask, <32 x i64> %src0)  {
; AVX512BW-LABEL: test_load_32i64:
; AVX512BW:       ## %bb.0:
; AVX512BW-NEXT:    vpsllw $7, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovb2m %zmm0, %k1
; AVX512BW-NEXT:    vpblendmq (%rdi), %zmm1, %zmm0 {%k1}
; AVX512BW-NEXT:    kshiftrd $16, %k1, %k2
; AVX512BW-NEXT:    vpblendmq 128(%rdi), %zmm3, %zmm5 {%k2}
; AVX512BW-NEXT:    kshiftrw $8, %k1, %k1
; AVX512BW-NEXT:    vpblendmq 64(%rdi), %zmm2, %zmm1 {%k1}
; AVX512BW-NEXT:    kshiftrw $8, %k2, %k1
; AVX512BW-NEXT:    vpblendmq 192(%rdi), %zmm4, %zmm3 {%k1}
; AVX512BW-NEXT:    vmovdqa64 %zmm5, %zmm2
; AVX512BW-NEXT:    retq
  %res = call <32 x i64> @llvm.masked.load.v32i64.p0v32i64(<32 x i64>* %ptrs, i32 4, <32 x i1> %mask, <32 x i64> %src0)
  ret <32 x i64> %res
}

declare <32 x i64> @llvm.masked.load.v32i64.p0v32i64(<32 x i64>* %ptrs, i32, <32 x i1> %mask, <32 x i64> %src0)
declare <32 x double> @llvm.masked.load.v32f64.p0v32f64(<32 x double>* %ptrs, i32, <32 x i1> %mask, <32 x double> %src0)