; ModuleID = './20001017-2.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @fn_4parms(i8 zeroext %a, i64* %b, i64* %c, i32* %d) #0 {
  %1 = alloca i8, align 1
  %2 = alloca i64*, align 8
  %3 = alloca i64*, align 8
  %4 = alloca i32*, align 8
  store i8 %a, i8* %1, align 1
  store i64* %b, i64** %2, align 8
  store i64* %c, i64** %3, align 8
  store i32* %d, i32** %4, align 8
  %5 = load i64*, i64** %2, align 8
  %6 = load i64, i64* %5, align 8
  %7 = icmp ne i64 %6, 1
  br i1 %7, label %16, label %8

; <label>:8                                       ; preds = %0
  %9 = load i64*, i64** %3, align 8
  %10 = load i64, i64* %9, align 8
  %11 = icmp ne i64 %10, 2
  br i1 %11, label %16, label %12

; <label>:12                                      ; preds = %8
  %13 = load i32*, i32** %4, align 8
  %14 = load i32, i32* %13, align 4
  %15 = icmp ne i32 %14, 3
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %12, %8, %0
  call void @abort() #2
  unreachable

; <label>:17                                      ; preds = %12
  ret void
}

; Function Attrs: noreturn nounwind
declare void @abort() #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %a = alloca i8, align 1
  %b = alloca i64, align 8
  %c = alloca i64, align 8
  %d = alloca i32, align 4
  store i32 0, i32* %1
  store i8 0, i8* %a, align 1
  store i64 1, i64* %b, align 8
  store i64 2, i64* %c, align 8
  store i32 3, i32* %d, align 4
  %2 = load i8, i8* %a, align 1
  call void @fn_4parms(i8 zeroext %2, i64* %b, i64* %c, i32* %d)
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.7.1-svn253571-1~exp1 (branches/release_37) (based on LLVM 3.7.1)"}
