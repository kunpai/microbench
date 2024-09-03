module {
  // External print function declaration
  func.func private @print_i32(i32) -> ()

  // Function to perform integer addition and measure latency
  func.func @int_add(%arg0: i32, %arg1: i32, %iterations: index) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %result = scf.for %i = %c0 to %iterations step %c1 iter_args(%acc = %arg0) -> (i32) {
      %sum = arith.addi %acc, %arg1 : i32
      scf.yield %sum : i32
    }
    return %result : i32
  }

  // Function to perform integer subtraction and measure latency
  func.func @int_sub(%arg0: i32, %arg1: i32, %iterations: index) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %result = scf.for %i = %c0 to %iterations step %c1 iter_args(%acc = %arg0) -> (i32) {
      %diff = arith.subi %acc, %arg1 : i32
      scf.yield %diff : i32
    }
    return %result : i32
  }

  // Function to perform integer multiplication and measure latency
  func.func @int_mul(%arg0: i32, %arg1: i32, %iterations: index) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %result = scf.for %i = %c0 to %iterations step %c1 iter_args(%acc = %arg0) -> (i32) {
      %prod = arith.muli %acc, %arg1 : i32
      scf.yield %prod : i32
    }
    return %result : i32
  }

  // Function to perform integer division and measure latency
  func.func @int_div(%arg0: i32, %arg1: i32, %iterations: index) -> i32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %result = scf.for %i = %c0 to %iterations step %c1 iter_args(%acc = %arg0) -> (i32) {
      %quot = arith.divsi %acc, %arg1 : i32
      scf.yield %quot : i32
    }
    return %result : i32
  }

  // Main function to drive the tests and print results
  func.func @main() -> i32 {
    // Sample input values
    %c10 = arith.constant 10 : i32
    %c20 = arith.constant 20 : i32
    %iterations = arith.constant 1000000 : index  // Run each operation 1 million times

    // Call each arithmetic function and measure latency
    %add_result = call @int_add(%c10, %c20, %iterations) : (i32, i32, index) -> i32
    %sub_result = call @int_sub(%c20, %c10, %iterations) : (i32, i32, index) -> i32
    %mul_result = call @int_mul(%c10, %c20, %iterations) : (i32, i32, index) -> i32
    %div_result = call @int_div(%c20, %c10, %iterations) : (i32, i32, index) -> i32

    // Print each result
    call @print_i32(%add_result) : (i32) -> ()
    call @print_i32(%sub_result) : (i32) -> ()
    call @print_i32(%mul_result) : (i32) -> ()
    call @print_i32(%div_result) : (i32) -> ()

    return %add_result : i32
  }
}
