; ModuleID = '/home/grosu/celliso2/c-semantics/tests/csmith/smith000614.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@g_4 = global [10 x i32] [i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327, i32 -1955398327], align 16
@g_3 = global i32* bitcast (i8* getelementptr (i8* bitcast ([10 x i32]* @g_4 to i8*), i64 16) to i32*), align 8
@.str = private unnamed_addr constant [22 x i8] c"checksum g_4[0] = %d\0A\00", align 1
@.str1 = private unnamed_addr constant [22 x i8] c"checksum g_4[1] = %d\0A\00", align 1
@.str2 = private unnamed_addr constant [22 x i8] c"checksum g_4[2] = %d\0A\00", align 1
@.str3 = private unnamed_addr constant [22 x i8] c"checksum g_4[3] = %d\0A\00", align 1
@.str4 = private unnamed_addr constant [22 x i8] c"checksum g_4[4] = %d\0A\00", align 1
@.str5 = private unnamed_addr constant [22 x i8] c"checksum g_4[5] = %d\0A\00", align 1
@.str6 = private unnamed_addr constant [22 x i8] c"checksum g_4[6] = %d\0A\00", align 1
@.str7 = private unnamed_addr constant [22 x i8] c"checksum g_4[7] = %d\0A\00", align 1
@.str8 = private unnamed_addr constant [22 x i8] c"checksum g_4[8] = %d\0A\00", align 1
@.str9 = private unnamed_addr constant [22 x i8] c"checksum g_4[9] = %d\0A\00", align 1
@__undefined = common global i64 0, align 8

define i32 @func_1() nounwind uwtable {
entry:
  %l_2 = alloca i8, align 1
  store i8 2, i8* %l_2, align 1
  %tmp = load i8* %l_2, align 1
  %conv = sext i8 %tmp to i32
  %tmp1 = volatile load i32** @g_3, align 8
  %tmp2 = load i32* %tmp1
  %or = or i32 %tmp2, %conv
  store i32 %or, i32* %tmp1
  %tmp3 = load i8* %l_2, align 1
  %conv4 = sext i8 %tmp3 to i32
  ret i32 %conv4
}

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i32 @func_1()
  %tmp = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 0), align 4
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %tmp)
  %tmp2 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 1), align 4
  %call3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str1, i32 0, i32 0), i32 %tmp2)
  %tmp4 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 2), align 4
  %call5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str2, i32 0, i32 0), i32 %tmp4)
  %tmp6 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 3), align 4
  %call7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0), i32 %tmp6)
  %tmp8 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 4), align 4
  %call9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str4, i32 0, i32 0), i32 %tmp8)
  %tmp10 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 5), align 4
  %call11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str5, i32 0, i32 0), i32 %tmp10)
  %tmp12 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 6), align 4
  %call13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str6, i32 0, i32 0), i32 %tmp12)
  %tmp14 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 7), align 4
  %call15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %tmp14)
  %tmp16 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 8), align 4
  %call17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str8, i32 0, i32 0), i32 %tmp16)
  %tmp18 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 9), align 4
  %call19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %tmp18)
  %tmp20 = load i32* getelementptr inbounds ([10 x i32]* @g_4, i32 0, i64 4), align 4
  %call21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str4, i32 0, i32 0), i32 %tmp20)
  %0 = load i32* %retval
  ret i32 %0
}

declare i32 @printf(i8*, ...)