; ModuleID = './testBreakFor.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %1
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %i, align 4
  br label %2

; <label>:2                                       ; preds = %12, %0
  %3 = load i32, i32* %i, align 4
  %4 = icmp slt i32 %3, 10
  br i1 %4, label %5, label %15

; <label>:5                                       ; preds = %2
  %6 = load i32, i32* %retval, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, i32* %retval, align 4
  %8 = load i32, i32* %i, align 4
  %9 = icmp eq i32 %8, 4
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %5
  br label %15

; <label>:11                                      ; preds = %5
  br label %12

; <label>:12                                      ; preds = %11
  %13 = load i32, i32* %i, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %i, align 4
  br label %2

; <label>:15                                      ; preds = %10, %2
  %16 = load i32, i32* %retval, align 4
  ret i32 %16
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.7.1-svn253571-1~exp1 (branches/release_37) (based on LLVM 3.7.1)"}
