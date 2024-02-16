program binary_trees
    implicit none

    type :: TreeNode
        type(TreeNode), pointer :: left => null()
        type(TreeNode), pointer :: right => null()
    end type TreeNode

    type(TreeNode), pointer :: tree
    integer :: i, total_nodes, depth

    depth = 25
    do i = 0, 25
        tree => make_tree(depth)
        total_nodes = check_tree(tree)
        print *, "Tree of depth ", depth, " has ", total_nodes, " nodes."
        call free_tree(tree)
    end do

contains

    recursive function make_tree(depth) result(node)
        integer, intent(in) :: depth
        type(TreeNode), pointer :: node
        if (depth > 0) then
            allocate(node)
            node%left => make_tree(depth - 1)
            node%right => make_tree(depth - 1)
        else
            nullify(node)
        end if
    end function make_tree

    recursive function check_tree(node) result(count)
        type(TreeNode), pointer :: node
        integer :: count
        if (.not. associated(node)) then
            count = 0
        else
            count = 1 + check_tree(node%left) + check_tree(node%right)
        end if
    end function check_tree

    recursive subroutine free_tree(node)
        type(TreeNode), pointer :: node
        if (associated(node)) then
            call free_tree(node%left)
            call free_tree(node%right)
            deallocate(node)
        end if
    end subroutine free_tree

end program binary_trees
