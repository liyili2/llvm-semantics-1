; ModuleID = './large-array.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@test.XX = internal constant [1000 x i32] zeroinitializer, align 16
@test.S = internal constant [1000 x i8] c"foo\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16
@test.array = internal constant [300 x i32] [i32 17, i32 53, i32 523, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49], align 16
@.str = private unnamed_addr constant [7 x i8] c"error\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"error2\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @test(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds [300 x i32], [300 x i32]* @test.array, i32 0, i64 %3
  %5 = load i32, i32* %4, align 4
  ret i32 %5
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @test(i32 1)
  %3 = icmp ne i32 %2, 53
  br i1 %3, label %4, label %6

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  br label %6

; <label>:6                                       ; preds = %4, %0
  %7 = call i32 @test(i32 2)
  %8 = icmp ne i32 %7, 523
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %6
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i32 0, i32 0))
  br label %11

; <label>:11                                      ; preds = %9, %6
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.7.1-svn253571-1~exp1 (branches/release_37) (based on LLVM 3.7.1)"}
