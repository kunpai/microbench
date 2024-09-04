; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @print_f32(float)
declare i64 @llvm.x86.rdtsc() 
declare void @print_i64(i64)

define float @float_add(float %0, float %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi float [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = fadd float %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret float %6
}

define float @float_sub(float %0, float %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi float [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = fsub float %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret float %6
}

define float @float_mul(float %0, float %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi float [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = fmul float %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret float %6
}

define float @float_div(float %0, float %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi float [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = fdiv float %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret float %6
}

define i32 @main() {
  %start_time_add = call i64 @llvm.x86.rdtsc()
  %1 = call float @float_add(float 10.0, float 20.0, i64 1000000)
  %end_time_add = call i64 @llvm.x86.rdtsc()
  %cycles_add = sub i64 %end_time_add, %start_time_add

  %start_time_sub = call i64 @llvm.x86.rdtsc()
  %2 = call float @float_sub(float 20.0, float 10.0, i64 1000000)
  %end_time_sub = call i64 @llvm.x86.rdtsc()
  %cycles_sub = sub i64 %end_time_sub, %start_time_sub

  %start_time_mul = call i64 @llvm.x86.rdtsc()
  %3 = call float @float_mul(float 10.0, float 20.0, i64 1000000)
  %end_time_mul = call i64 @llvm.x86.rdtsc()
  %cycles_mul = sub i64 %end_time_mul, %start_time_mul

  %start_time_div = call i64 @llvm.x86.rdtsc()
  %4 = call float @float_div(float 20.0, float 10.0, i64 1000000)
  %end_time_div = call i64 @llvm.x86.rdtsc()
  %cycles_div = sub i64 %end_time_div, %start_time_div

  call void @print_f32(float %1)
  call void @print_f32(float %2)
  call void @print_f32(float %3)
  call void @print_f32(float %4)
  
  call void @print_i64(i64 %cycles_add)
  call void @print_i64(i64 %cycles_sub)
  call void @print_i64(i64 %cycles_mul)
  call void @print_i64(i64 %cycles_div)

  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
