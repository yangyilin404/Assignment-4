; ModuleID = 'Assignment-4-Andersen/Test-Cases/struct-twoflds.bc'
source_filename = "struct-twoflds.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.IntChar = type { i32, i8 }
%struct.CharInt = type { i8, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca %struct.IntChar, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca %struct.CharInt, align 4
  store i32 0, ptr %1, align 4
  store ptr %4, ptr %2, align 8
  store ptr %4, ptr %3, align 8
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %struct.IntChar, ptr %8, i32 0, i32 0
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.IntChar, ptr %10, i32 0, i32 0
  call void @MUSTALIAS(ptr noundef %9, ptr noundef %11)
  %12 = load ptr, ptr %2, align 8
  %13 = getelementptr inbounds %struct.IntChar, ptr %12, i32 0, i32 1
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.IntChar, ptr %14, i32 0, i32 1
  call void @MUSTALIAS(ptr noundef %13, ptr noundef %15)
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.IntChar, ptr %16, i32 0, i32 0
  %18 = load ptr, ptr %3, align 8
  %19 = getelementptr inbounds %struct.IntChar, ptr %18, i32 0, i32 1
  call void @NOALIAS(ptr noundef %17, ptr noundef %19)
  store ptr %7, ptr %5, align 8
  store ptr %7, ptr %6, align 8
  %20 = load ptr, ptr %5, align 8
  %21 = getelementptr inbounds %struct.CharInt, ptr %20, i32 0, i32 0
  %22 = load ptr, ptr %6, align 8
  %23 = getelementptr inbounds %struct.CharInt, ptr %22, i32 0, i32 0
  call void @MUSTALIAS(ptr noundef %21, ptr noundef %23)
  %24 = load ptr, ptr %5, align 8
  %25 = getelementptr inbounds %struct.CharInt, ptr %24, i32 0, i32 1
  %26 = load ptr, ptr %6, align 8
  %27 = getelementptr inbounds %struct.CharInt, ptr %26, i32 0, i32 1
  call void @MUSTALIAS(ptr noundef %25, ptr noundef %27)
  %28 = load ptr, ptr %5, align 8
  %29 = getelementptr inbounds %struct.CharInt, ptr %28, i32 0, i32 0
  %30 = load ptr, ptr %6, align 8
  %31 = getelementptr inbounds %struct.CharInt, ptr %30, i32 0, i32 1
  call void @NOALIAS(ptr noundef %29, ptr noundef %31)
  ret i32 0
}

declare void @MUSTALIAS(ptr noundef, ptr noundef) #1

declare void @NOALIAS(ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 16.0.4 (https://github.com/bjjwwang/LLVM-compile 2259018fffaba36b5e50dce52fb5aa97b417ce4f)"}
