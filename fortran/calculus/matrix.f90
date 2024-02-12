program matrix_multiply
    implicit none
    integer, parameter :: N = 500
    real*8 :: a(N, N), b(N, N), result(N, N)
    integer :: i, j, k
    do i = 1, N
        do j = 1, N
            result(i, j) = 0.0d0
            do k = 1, N
                result(i, j) = result(i, j) + a(i, k) * b(k, j)
            end do
        end do
    end do
end program matrix_multiply