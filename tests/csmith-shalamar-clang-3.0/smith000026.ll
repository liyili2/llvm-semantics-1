; ModuleID = '/home/david/src/c-semantics/tests/csmith/smith000026.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S1 = type { i16, i32 }

@func_1.l_2 = private unnamed_addr constant %struct.S1 { i16 -5, i32 782903745 }, align 4
@__undefined = common global i64 0, align 8

define i64 @func_1() nounwind uwtable {
  %1 = alloca %struct.S1, align 4
  %l_2 = alloca %struct.S1, align 4
  %2 = bitcast %struct.S1* %l_2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* bitcast (%struct.S1* @func_1.l_2 to i8*), i64 8, i32 4, i1 false)
  %3 = bitcast %struct.S1* %1 to i8*
  %4 = bitcast %struct.S1* %l_2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 8, i32 4, i1 false)
  %5 = bitcast %struct.S1* %1 to i64*
  %6 = load i64* %5, align 1
  ret i64 %6
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) nounwind

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %4 = alloca %struct.S1, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %5 = call i64 @func_1()
  %6 = bitcast %struct.S1* %4 to i64*
  store i64 %5, i64* %6
  %7 = load i32* %1
  ret i32 %7
}