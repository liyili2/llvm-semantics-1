; ModuleID = './20000717-3.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@c = global i32 -1, align 4

; Function Attrs: nounwind uwtable
define i32 @foo(i32* %p) #0 {
  %1 = alloca i32*, align 8
  %x = alloca i32, align 4
  %a = alloca i32, align 4
  store i32* %p, i32** %1, align 8
  %2 = load i32*, i32** %1, align 8
  %3 = getelementptr inbounds i32, i32* %2, i64 0
  %4 = load i32, i32* %3, align 4
  store i32 %4, i32* %a, align 4
  %5 = load i32, i32* %a, align 4
  %6 = add nsw i32 %5, 5
  store i32 %6, i32* %x, align 4
  %7 = load i32, i32* @c, align 4
  store i32 %7, i32* %a, align 4
  %8 = load i32, i32* %x, align 4
  %9 = sub nsw i32 %8, 15
  %10 = load i32*, i32** %1, align 8
  %11 = getelementptr inbounds i32, i32* %10, i64 0
  store i32 %9, i32* %11, align 4
  %12 = load i32, i32* %a, align 4
  ret i32 %12
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %b = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %1
  store i32 1, i32* %b, align 4
  %2 = call i32 @foo(i32* %b)
  store i32 %2, i32* %a, align 4
  %3 = load i32, i32* %a, align 4
  %4 = icmp ne i32 %3, -1
  br i1 %4, label %8, label %5

; <label>:5                                       ; preds = %0
  %6 = load i32, i32* %b, align 4
  %7 = icmp ne i32 %6, -9
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %5, %0
  call void @abort() #2
  unreachable

; <label>:9                                       ; preds = %5
  call void @exit(i32 0) #2
  unreachable
                                                  ; No predecessors!
  %11 = load i32, i32* %1
  ret i32 %11
}

; Function Attrs: noreturn nounwind
declare void @abort() #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.7.1-svn253571-1~exp1 (branches/release_37) (based on LLVM 3.7.1)"}
