program benchmark
    implicit none
    
    integer, parameter :: iterations = 100000000
    real(kind=4) :: f1, f2, result_f
    real(kind=8) :: d1, d2, result_d
    real(kind=8) :: start, finish
    integer :: i

    ! Benchmarking float (32-bit) operations
    print *, "Benchmarking float (32-bit) operations:"
    f1 = 1.234567
    f2 = 7.890123
    start = real(clock(), kind=8) / real(clock_rate())
    do i = 1, iterations
        result_f = f1 * f2
    end do
    finish = real(clock(), kind=8) / real(clock_rate())
    print *, "Float multiplication: Result = ", result_f, ", Time = ", finish - start, " seconds"

    start = real(clock(), kind=8) / real(clock_rate())
    do i = 1, iterations
        result_f = f1 + f2
    end do
    finish = real(clock(), kind=8) / real(clock_rate())
    print *, "Float addition: Result = ", result_f, ", Time = ", finish - start, " seconds"

    start = real(clock(), kind=8) / real(clock_rate())
    do i = 1, iterations
        result_f = f1 / f2
    end do
    finish = real(clock(), kind=8) / real(clock_rate())
    print *, "Float division: Result = ", result_f, ", Time = ", finish - start, " seconds"

    ! Benchmarking double (64-bit) operations
    print *, "Benchmarking double (64-bit) operations:"
    d1 = 1.234567890123456d0
    d2 = 7.890123456789012d0
    start = real(clock(), kind=8) / real(clock_rate())
    do i = 1, iterations
        result_d = d1 * d2
    end do
    finish = real(clock(), kind=8) / real(clock_rate())
    print *, "Double multiplication: Result = ", result_d, ", Time = ", finish - start, " seconds"

    start = real(clock(), kind=8) / real(clock_rate())
    do i = 1, iterations
        result_d = d1 + d2
    end do
    finish = real(clock(), kind=8) / real(clock_rate())
    print *, "Double addition: Result = ", result_d, ", Time = ", finish - start, " seconds"

    start = real(clock(), kind=8) / real(clock_rate())
    do i = 1, iterations
        result_d = d1 / d2
    end do
    finish = real(clock(), kind=8) / real(clock_rate())
    print *, "Double division: Result = ", result_d, ", Time = ", finish - start, " seconds"
end program benchmark