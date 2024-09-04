; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @print_i64(i64)
declare i64 @llvm.x86.rdtsc()

@large_array = global [16777216 x i32] zeroinitializer  ; 64MB array

define i32 @memory_latency(i64 %array_size, i64 %stride, i64 %num_accesses) {
entry:
  %ptr = getelementptr [16777216 x i32], [16777216 x i32]* @large_array, i64 0, i64 0
  %end_ptr = getelementptr i32, i32* %ptr, i64 %array_size

  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %i_next, %loop ]
  %current_ptr = getelementptr i32, i32* %ptr, i64 %i
  %val = load i32, i32* %current_ptr

  %i_next = add i64 %i, %stride
  %cond = icmp ult i64 %i_next, %array_size
  br i1 %cond, label %loop, label %exit

exit:                                             ; preds = %loop
  ret i32 0
}

define i32 @main() {
  ; Measure latency for various sizes
  %start_time_4KB = call i64 @llvm.x86.rdtsc()
  %result_4KB = call i32 @memory_latency(i64 1024, i64 1, i64 1000000)  ; 4KB test
  %end_time_4KB = call i64 @llvm.x86.rdtsc()
  %cycles_4KB = sub i64 %end_time_4KB, %start_time_4KB
  call void @print_i64(i64 %cycles_4KB)

  %start_time_8KB = call i64 @llvm.x86.rdtsc()
  %result_8KB = call i32 @memory_latency(i64 2048, i64 1, i64 1000000)  ; 8KB test
  %end_time_8KB = call i64 @llvm.x86.rdtsc()
  %cycles_8KB = sub i64 %end_time_8KB, %start_time_8KB
  call void @print_i64(i64 %cycles_8KB)

  %start_time_16KB = call i64 @llvm.x86.rdtsc()
  %result_16KB = call i32 @memory_latency(i64 16384, i64 1, i64 1000000)  ; 16KB test
  %end_time_16KB = call i64 @llvm.x86.rdtsc()
  %cycles_16KB = sub i64 %end_time_16KB, %start_time_16KB
  call void @print_i64(i64 %cycles_16KB)

  %start_time_32KB = call i64 @llvm.x86.rdtsc()
  %result_32KB = call i32 @memory_latency(i64 32768, i64 1, i64 1000000)  ; 32KB test
  %end_time_32KB = call i64 @llvm.x86.rdtsc()
  %cycles_32KB = sub i64 %end_time_32KB, %start_time_32KB
  call void @print_i64(i64 %cycles_32KB)

  %start_time_64KB = call i64 @llvm.x86.rdtsc()
  %result_64KB = call i32 @memory_latency(i64 65536, i64 1, i64 1000000)  ; 64KB test
  %end_time_64KB = call i64 @llvm.x86.rdtsc()
  %cycles_64KB = sub i64 %end_time_64KB, %start_time_64KB
  call void @print_i64(i64 %cycles_64KB)

  %start_time_128KB = call i64 @llvm.x86.rdtsc()
  %result_128KB = call i32 @memory_latency(i64 131072, i64 1, i64 1000000)  ; 128KB test
  %end_time_128KB = call i64 @llvm.x86.rdtsc()
  %cycles_128KB = sub i64 %end_time_128KB, %start_time_128KB
  call void @print_i64(i64 %cycles_128KB)

  %start_time_256KB = call i64 @llvm.x86.rdtsc()
  %result_256KB = call i32 @memory_latency(i64 262144, i64 1, i64 1000000)  ; 256KB test
  %end_time_256KB = call i64 @llvm.x86.rdtsc()
  %cycles_256KB = sub i64 %end_time_256KB, %start_time_256KB
  call void @print_i64(i64 %cycles_256KB)

  %start_time_512KB = call i64 @llvm.x86.rdtsc()
  %result_512KB = call i32 @memory_latency(i64 524288, i64 1, i64 1000000)  ; 512KB test
  %end_time_512KB = call i64 @llvm.x86.rdtsc()
  %cycles_512KB = sub i64 %end_time_512KB, %start_time_512KB
  call void @print_i64(i64 %cycles_512KB)

  %start_time_1MB = call i64 @llvm.x86.rdtsc()
  %result_1MB = call i32 @memory_latency(i64 1048576, i64 1, i64 1000000)  ; 1MB test
  %end_time_1MB = call i64 @llvm.x86.rdtsc()
  %cycles_1MB = sub i64 %end_time_1MB, %start_time_1MB
  call void @print_i64(i64 %cycles_1MB)

  %start_time_2MB = call i64 @llvm.x86.rdtsc()
  %result_2MB = call i32 @memory_latency(i64 2097152, i64 1, i64 1000000)  ; 2MB test
  %end_time_2MB = call i64 @llvm.x86.rdtsc()
  %cycles_2MB = sub i64 %end_time_2MB, %start_time_2MB
  call void @print_i64(i64 %cycles_2MB)

  %start_time_4MB = call i64 @llvm.x86.rdtsc()
  %result_4MB = call i32 @memory_latency(i64 4194304, i64 1, i64 1000000)  ; 4MB test
  %end_time_4MB = call i64 @llvm.x86.rdtsc()
  %cycles_4MB = sub i64 %end_time_4MB, %start_time_4MB
  call void @print_i64(i64 %cycles_4MB)

  %start_time_8MB = call i64 @llvm.x86.rdtsc()
  %result_8MB = call i32 @memory_latency(i64 8388608, i64 1, i64 1000000)  ; 8MB test
  %end_time_8MB = call i64 @llvm.x86.rdtsc()
  %cycles_8MB = sub i64 %end_time_8MB, %start_time_8MB
  call void @print_i64(i64 %cycles_8MB)

  %start_time_16MB = call i64 @llvm.x86.rdtsc()
  %result_16MB = call i32 @memory_latency(i64 16777216, i64 1, i64 1000000)  ; 16MB test
  %end_time_16MB = call i64 @llvm.x86.rdtsc()
  %cycles_16MB = sub i64 %end_time_16MB, %start_time_16MB
  call void @print_i64(i64 %cycles_16MB)

  %start_time_32MB = call i64 @llvm.x86.rdtsc()
  %result_32MB = call i32 @memory_latency(i64 33554432, i64 1, i64 1000000)  ; 32MB test
  %end_time_32MB = call i64 @llvm.x86.rdtsc()
  %cycles_32MB = sub i64 %end_time_32MB, %start_time_32MB
  call void @print_i64(i64 %cycles_32MB)

  %start_time_64MB = call i64 @llvm.x86.rdtsc()
  %result_64MB = call i32 @memory_latency(i64 67108864, i64 1, i64 1000000)  ; 64MB test
  %end_time_64MB = call i64 @llvm.x86.rdtsc()
  %cycles_64MB = sub i64 %end_time_64MB, %start_time_64MB
  call void @print_i64(i64 %cycles_64MB)

  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
