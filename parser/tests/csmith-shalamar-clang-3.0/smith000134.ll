; ModuleID = '/home/david/src/c-semantics/tests/csmith/smith000134.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g_2 = global i32 -1211172195, align 4
@.str = private unnamed_addr constant [19 x i8] c"checksum g_2 = %d\0A\00", align 1
@__undefined = common global i64 0, align 8

define i32 @func_1() nounwind uwtable {
  %l_3 = alloca i32*, align 8
  %l_4 = alloca i8, align 1
  store i32* @g_2, i32** %l_3, align 8
  store i8 0, i8* %l_4, align 1
  %1 = load volatile i32* @g_2, align 4
  %2 = load i32** %l_3, align 8
  store volatile i32 %1, i32* %2
  %3 = load i32** %l_3, align 8
  %4 = load volatile i32* %3
  %5 = sext i32 %4 to i64
  %6 = and i64 %5, 748470593
  %7 = trunc i64 %6 to i32
  store volatile i32 %7, i32* %3
  %8 = load i8* %l_4, align 1
  %9 = zext i8 %8 to i32
  ret i32 %9
}

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call i32 @func_1()
  %5 = load volatile i32* @g_2, align 4
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str, i32 0, i32 0), i32 %5)
  %7 = load i32* %1
  ret i32 %7
}

declare i32 @printf(i8*, ...)
