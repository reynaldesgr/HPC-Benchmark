program benchmark
    implicit none

    integer, parameter :: iterations = 100000000
    real(kind=4) :: f1, f2, result_f
    real(kind=8) :: d1, d2, result_d
    real(kind=8) :: start, finish, elapsed_time
    integer :: i, count_rate, count_max, start_count, end_count

    ! Get the clock rate
    call system_clock(count_rate=count_rate)

    ! Benchmarking float (32-bit) operations
    print *, "Benchmarking float (32-bit) operations:"
    f1 = 1.234567
    f2 = 7.890123

    call system_clock(start_count)
    do i = 1, iterations
        result_f = f1 * f2
    end do
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count) / real(count_rate)
    print *, "Float multiplication: Result = ", result_f, ", Time = ", elapsed_time, " seconds"

    call system_clock(start_count)
    do i = 1, iterations
        result_f = f1 + f2
    end do
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count) / real(count_rate)
    print *, "Float addition: Result = ", result_f, ", Time = ", elapsed_time, " seconds"

    call system_clock(start_count)
    do i = 1, iterations
        result_f = f1 / f2
    end do
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count) / real(count_rate)
    print *, "Float division: Result = ", result_f, ", Time = ", elapsed_time, " seconds"

    ! Benchmarking double (64-bit) operations
    print *, "Benchmarking double (64-bit) operations:"
    d1 = 1.234567890123456d0
    d2 = 7.890123456789012d0

    call system_clock(start_count)
    do i = 1, iterations
        result_d = d1 * d2
    end do
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count) / real(count_rate)
    print *, "Double multiplication: Result = ", result_d, ", Time = ", elapsed_time, " seconds"

    call system_clock(start_count)
    do i = 1, iterations
        result_d = d1 + d2
    end do
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count) / real(count_rate)
    print *, "Double addition: Result = ", result_d, ", Time = ", elapsed_time, " seconds"

    call system_clock(start_count)
    do i = 1, iterations
        result_d = d1 / d2
    end do
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count) / real(count_rate)
    print *, "Double division: Result = ", result_d, ", Time = ", elapsed_time, " seconds"
end program benchmark
