; ModuleID = '/home/david/src/c-semantics/tests/csmith/smith000517.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g_3 = global [1 x i32] zeroinitializer, align 4
@g_2 = global [2 x i32*] [i32* getelementptr inbounds ([1 x i32]* @g_3, i32 0, i32 0), i32* getelementptr inbounds ([1 x i32]* @g_3, i32 0, i32 0)], align 16
@.str = private unnamed_addr constant [22 x i8] c"checksum g_3[0] = %d\0A\00", align 1
@__undefined = common global i64 0, align 8

define i64 @func_1() nounwind uwtable {
  %l_4 = alloca i32**, align 8
  store i32** getelementptr inbounds ([2 x i32*]* @g_2, i32 0, i64 1), i32*** %l_4, align 8
  %1 = load volatile i32** getelementptr inbounds ([2 x i32*]* @g_2, i32 0, i64 1), align 8
  %2 = load i32*** %l_4, align 8
  store volatile i32* %1, i32** %2
  %3 = load i32*** %l_4, align 8
  %4 = load volatile i32** %3
  %5 = load volatile i32* %4
  %6 = sext i32 %5 to i64
  ret i64 %6
}

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call i64 @func_1()
  %5 = load volatile i32* getelementptr inbounds ([1 x i32]* @g_3, i32 0, i64 0), align 4
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %5)
  %7 = load volatile i32* getelementptr inbounds ([1 x i32]* @g_3, i32 0, i64 0), align 4
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %7)
  %9 = load i32* %1
  ret i32 %9
}

declare i32 @printf(i8*, ...)
