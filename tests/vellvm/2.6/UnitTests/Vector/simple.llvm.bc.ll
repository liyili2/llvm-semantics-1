; ModuleID = 'simple.llvm.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-pc-linux-gnu"

@.str = private constant [13 x i8] c"%f %f %f %f\0A\00", align 1 ; <[13 x i8]*> [#uses=1]
@.str1 = private constant [7 x i8] c"%g %g\0A\00", align 1 ; <[7 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %Argv) nounwind {
entry:
  %0 = icmp eq i32 %argc, 1123                    ; <i1> [#uses=1]
  %X.0 = select i1 %0, float 0x40030E9A20000000, float 0x3FF3BE76C0000000 ; <float> [#uses=4]
  %1 = icmp eq i32 %argc, 1432                    ; <i1> [#uses=1]
  %Y.0 = select i1 %1, float 0x401EE0B780000000, float 0x4023C08320000000 ; <float> [#uses=4]
  %2 = icmp eq i32 %argc, 2123                    ; <i1> [#uses=1]
  %U.0 = select i1 %2, double 3.282190e+01, double 8.731834e+02 ; <double> [#uses=2]
  %3 = icmp eq i32 %argc, 5123                    ; <i1> [#uses=1]
  %V.0 = select i1 %3, double 7.779980e+01, double 0x409CCB9C779A6B51 ; <double> [#uses=1]
  %4 = insertelement <4 x float> undef, float %X.0, i32 0 ; <<4 x float>> [#uses=1]
  %5 = insertelement <4 x float> %4, float %X.0, i32 1 ; <<4 x float>> [#uses=3]
  %6 = insertelement <4 x float> %5, float %X.0, i32 2 ; <<4 x float>> [#uses=1]
  %7 = insertelement <4 x float> %6, float %X.0, i32 3 ; <<4 x float>> [#uses=2]
  %8 = insertelement <4 x float> %5, float 0.000000e+00, i32 2 ; <<4 x float>> [#uses=1]
  %9 = insertelement <4 x float> %8, float 0.000000e+00, i32 3 ; <<4 x float>> [#uses=2]
  %10 = insertelement <4 x float> %5, float %Y.0, i32 2 ; <<4 x float>> [#uses=1]
  %11 = insertelement <4 x float> %10, float %Y.0, i32 3 ; <<4 x float>> [#uses=2]
  %12 = insertelement <4 x float> undef, float %Y.0, i32 0 ; <<4 x float>> [#uses=1]
  %13 = insertelement <4 x float> %12, float %Y.0, i32 1 ; <<4 x float>> [#uses=1]
  %14 = insertelement <4 x float> %13, float 0x3FF1C6A7E0000000, i32 2 ; <<4 x float>> [#uses=1]
  %15 = insertelement <4 x float> %14, float 0x3FF1C6A7E0000000, i32 3 ; <<4 x float>> [#uses=2]
  %16 = insertelement <2 x double> undef, double %U.0, i32 0 ; <<2 x double>> [#uses=2]
  %17 = insertelement <2 x double> %16, double %U.0, i32 1 ; <<2 x double>> [#uses=2]
  %18 = insertelement <2 x double> %16, double %V.0, i32 1 ; <<2 x double>> [#uses=2]
  %19 = fmul <4 x float> %7, %7                   ; <<4 x float>> [#uses=4]
  %20 = fadd <4 x float> %9, %9                   ; <<4 x float>> [#uses=4]
  %21 = fadd <4 x float> %11, %11                 ; <<4 x float>> [#uses=4]
  %22 = fadd <4 x float> %15, %15                 ; <<4 x float>> [#uses=4]
  %23 = fadd <2 x double> %17, %17                ; <<2 x double>> [#uses=2]
  %24 = fadd <2 x double> %18, %18                ; <<2 x double>> [#uses=2]
  %tmp7 = extractelement <4 x float> %19, i32 3   ; <float> [#uses=1]
  %25 = fpext float %tmp7 to double               ; <double> [#uses=1]
  %tmp5 = extractelement <4 x float> %19, i32 2   ; <float> [#uses=1]
  %26 = fpext float %tmp5 to double               ; <double> [#uses=1]
  %tmp3 = extractelement <4 x float> %19, i32 1   ; <float> [#uses=1]
  %27 = fpext float %tmp3 to double               ; <double> [#uses=1]
  %tmp1 = extractelement <4 x float> %19, i32 0   ; <float> [#uses=1]
  %28 = fpext float %tmp1 to double               ; <double> [#uses=1]
  %29 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0), double %28, double %27, double %26, double %25) nounwind ; <i32> [#uses=0]
  %tmp15 = extractelement <4 x float> %20, i32 3  ; <float> [#uses=1]
  %30 = fpext float %tmp15 to double              ; <double> [#uses=1]
  %tmp13 = extractelement <4 x float> %20, i32 2  ; <float> [#uses=1]
  %31 = fpext float %tmp13 to double              ; <double> [#uses=1]
  %tmp11 = extractelement <4 x float> %20, i32 1  ; <float> [#uses=1]
  %32 = fpext float %tmp11 to double              ; <double> [#uses=1]
  %tmp9 = extractelement <4 x float> %20, i32 0   ; <float> [#uses=1]
  %33 = fpext float %tmp9 to double               ; <double> [#uses=1]
  %34 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0), double %33, double %32, double %31, double %30) nounwind ; <i32> [#uses=0]
  %tmp24 = extractelement <4 x float> %21, i32 3  ; <float> [#uses=1]
  %35 = fpext float %tmp24 to double              ; <double> [#uses=1]
  %tmp22 = extractelement <4 x float> %21, i32 2  ; <float> [#uses=1]
  %36 = fpext float %tmp22 to double              ; <double> [#uses=1]
  %tmp20 = extractelement <4 x float> %21, i32 1  ; <float> [#uses=1]
  %37 = fpext float %tmp20 to double              ; <double> [#uses=1]
  %tmp18 = extractelement <4 x float> %21, i32 0  ; <float> [#uses=1]
  %38 = fpext float %tmp18 to double              ; <double> [#uses=1]
  %39 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0), double %38, double %37, double %36, double %35) nounwind ; <i32> [#uses=0]
  %tmp33 = extractelement <4 x float> %22, i32 3  ; <float> [#uses=1]
  %40 = fpext float %tmp33 to double              ; <double> [#uses=1]
  %tmp31 = extractelement <4 x float> %22, i32 2  ; <float> [#uses=1]
  %41 = fpext float %tmp31 to double              ; <double> [#uses=1]
  %tmp29 = extractelement <4 x float> %22, i32 1  ; <float> [#uses=1]
  %42 = fpext float %tmp29 to double              ; <double> [#uses=1]
  %tmp27 = extractelement <4 x float> %22, i32 0  ; <float> [#uses=1]
  %43 = fpext float %tmp27 to double              ; <double> [#uses=1]
  %44 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0), double %43, double %42, double %41, double %40) nounwind ; <i32> [#uses=0]
  %tmp38 = extractelement <2 x double> %23, i32 1 ; <double> [#uses=1]
  %tmp36 = extractelement <2 x double> %23, i32 0 ; <double> [#uses=1]
  %45 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([7 x i8]* @.str1, i32 0, i32 0), double %tmp36, double %tmp38) nounwind ; <i32> [#uses=0]
  %tmp43 = extractelement <2 x double> %24, i32 1 ; <double> [#uses=1]
  %tmp41 = extractelement <2 x double> %24, i32 0 ; <double> [#uses=1]
  %46 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([7 x i8]* @.str1, i32 0, i32 0), double %tmp41, double %tmp43) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind