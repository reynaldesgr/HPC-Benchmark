program multiply
    implicit none
    integer, parameter :: N = 500
    real*8 ::  result(N, N)
    

    integer :: i, j, k
    do i = 1, N
        do j = 1, N
            result(i, j) = 0.0d0
            do k = 1, N
                result(i, j) = result(i, j) + matrix(i, k) * matrix(k, j)
            end do
        end do
    end do
end program multiply