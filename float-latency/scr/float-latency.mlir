module {
  func @print_f32(f32)
  func @llvm.x86.rdtsc() -> i64
  func @print_i64(i64)

  func @float_add(%0: f32, %1: f32, %2: i64) -> f32 {
    %3 = scf.while(%c0_i64 = 0: i64, %c1_f32 = %0) : (i64, f32) -> (i64, f32) {
      %4 = llvm.icmp "slt" (%c0_i64, %2) : i64
      scf.condition(%4) %c0_i64, %c1_f32 : i64, f32
    } do {
      %5 = llvm.fadd %c1_f32, %1 : f32
      %6 = llvm.add %c0_i64, 1 : i64
      scf.yield %6, %5 : i64, f32
    }
    return %3#1 : f32
  }

  func @float_sub(%0: f32, %1: f32, %2: i64) -> f32 {
    %3 = scf.while(%c0_i64 = 0: i64, %c1_f32 = %0) : (i64, f32) -> (i64, f32) {
      %4 = llvm.icmp "slt" (%c0_i64, %2) : i64
      scf.condition(%4) %c0_i64, %c1_f32 : i64, f32
    } do {
      %5 = llvm.fsub %c1_f32, %1 : f32
      %6 = llvm.add %c0_i64, 1 : i64
      scf.yield %6, %5 : i64, f32
    }
    return %3#1 : f32
  }

  func @float_mul(%0: f32, %1: f32, %2: i64) -> f32 {
    %3 = scf.while(%c0_i64 = 0: i64, %c1_f32 = %0) : (i64, f32) -> (i64, f32) {
      %4 = llvm.icmp "slt" (%c0_i64, %2) : i64
      scf.condition(%4) %c0_i64, %c1_f32 : i64, f32
    } do {
      %5 = llvm.fmul %c1_f32, %1 : f32
      %6 = llvm.add %c0_i64, 1 : i64
      scf.yield %6, %5 : i64, f32
    }
    return %3#1 : f32
  }

  func @float_div(%0: f32, %1: f32, %2: i64) -> f32 {
    %3 = scf.while(%c0_i64 = 0: i64, %c1_f32 = %0) : (i64, f32) -> (i64, f32) {
      %4 = llvm.icmp "slt" (%c0_i64, %2) : i64
      scf.condition(%4) %c0_i64, %c1_f32 : i64, f32
    } do {
      %5 = llvm.fdiv %c1_f32, %1 : f32
      %6 = llvm.add %c0_i64, 1 : i64
      scf.yield %6, %5 : i64, f32
    }
    return %3#1 : f32
  }

  func @main() -> i32 {
    %start_time_add = call @llvm.x86.rdtsc() : () -> i64
    %1 = call @float_add(%10.0 : f32, %20.0 : f32, %1000000 : i64) : (f32, f32, i64) -> f32
    %end_time_add = call @llvm.x86.rdtsc() : () -> i64
    %cycles_add = llvm.sub %end_time_add, %start_time_add : i64

    %start_time_sub = call @llvm.x86.rdtsc() : () -> i64
    %2 = call @float_sub(%20.0 : f32, %10.0 : f32, %1000000 : i64) : (f32, f32, i64) -> f32
    %end_time_sub = call @llvm.x86.rdtsc() : () -> i64
    %cycles_sub = llvm.sub %end_time_sub, %start_time_sub : i64

    %start_time_mul = call @llvm.x86.rdtsc() : () -> i64
    %3 = call @float_mul(%10.0 : f32, %20.0 : f32, %1000000 : i64) : (f32, f32, i64) -> f32
    %end_time_mul = call @llvm.x86.rdtsc() : () -> i64
    %cycles_mul = llvm.sub %end_time_mul, %start_time_mul : i64

    %start_time_div = call @llvm.x86.rdtsc() : () -> i64
    %4 = call @float_div(%20.0 : f32, %10.0 : f32, %1000000 : i64) : (f32, f32, i64) -> f32
    %end_time_div = call @llvm.x86.rdtsc() : () -> i64
    %cycles_div = llvm.sub %end_time_div, %start_time_div : i64

    call @print_f32(%1) : (f32) -> ()
    call @print_f32(%2) : (f32) -> ()
    call @print_f32(%3) : (f32) -> ()
    call @print_f32(%4) : (f32) -> ()

    call @print_i64(%cycles_add) : (i64) -> ()
    call @print_i64(%cycles_sub) : (i64) -> ()
    call @print_i64(%cycles_mul) : (i64) -> ()
    call @print_i64(%cycles_div) : (i64) -> ()

    return 0 : i32
  }
}
