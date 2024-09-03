; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @print_i32(i32)
declare i64 @llvm.x86.rdtsc() 
declare void @print_i64(i64)

define i32 @int_add(i32 %0, i32 %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi i32 [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = add i32 %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret i32 %6
}

define i32 @int_sub(i32 %0, i32 %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi i32 [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = sub i32 %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret i32 %6
}

define i32 @int_mul(i32 %0, i32 %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi i32 [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = mul i32 %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret i32 %6
}

define i32 @int_div(i32 %0, i32 %1, i64 %2) {
  br label %4

4:                                                ; preds = %8, %3
  %5 = phi i64 [ %10, %8 ], [ 0, %3 ]
  %6 = phi i32 [ %9, %8 ], [ %0, %3 ]
  %7 = icmp slt i64 %5, %2
  br i1 %7, label %8, label %11

8:                                                ; preds = %4
  %9 = sdiv i32 %6, %1
  %10 = add i64 %5, 1
  br label %4

11:                                               ; preds = %4
  ret i32 %6
}

define i32 @main() {
  %start_time_add = call i64 @llvm.x86.rdtsc()
  %1 = call i32 @int_add(i32 10, i32 20, i64 1000000)
  %end_time_add = call i64 @llvm.x86.rdtsc()
  %cycles_add = sub i64 %end_time_add, %start_time_add

  %start_time_sub = call i64 @llvm.x86.rdtsc()
  %2 = call i32 @int_sub(i32 20, i32 10, i64 1000000)
  %end_time_sub = call i64 @llvm.x86.rdtsc()
  %cycles_sub = sub i64 %end_time_sub, %start_time_sub

  %start_time_mul = call i64 @llvm.x86.rdtsc()
  %3 = call i32 @int_mul(i32 10, i32 20, i64 1000000)
  %end_time_mul = call i64 @llvm.x86.rdtsc()
  %cycles_mul = sub i64 %end_time_mul, %start_time_mul

  %start_time_div = call i64 @llvm.x86.rdtsc()
  %4 = call i32 @int_div(i32 20, i32 10, i64 1000000)
  %end_time_div = call i64 @llvm.x86.rdtsc()
  %cycles_div = sub i64 %end_time_div, %start_time_div

  call void @print_i32(i32 %1)
  call void @print_i32(i32 %2)
  call void @print_i32(i32 %3)
  call void @print_i32(i32 %4)
  
  call void @print_i64(i64 %cycles_add)
  call void @print_i64(i64 %cycles_sub)
  call void @print_i64(i64 %cycles_mul)
  call void @print_i64(i64 %cycles_div)

  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
