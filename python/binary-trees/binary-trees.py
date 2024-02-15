import random
import sys
#import multiprocessing as mp

def make_tree(depth):
    """
    Recursively generates a binary tree of specified depth.
    Each node is a tuple (left_child, right_child).
    A leaf node is represented as (None, None).
    """
    if depth > 0:
        depth -= 1
        return (make_tree(depth), make_tree(depth))
    return (None, None)

def check_tree(node):
    """
    Recursively calculates and returns the total number of nodes in the tree,
    including the current node, by traversing the tree.
    """
    (left, right) = node
    if left is None:  # Leaf node
        return 1
    else:
        return 1 + check_tree(left) + check_tree(right)

def main():
    """
    Main function to drive the tree creation and checking for 21 trees.
    """
    for _ in range(45):
        depth = 45
        tree = make_tree(depth)
        total_nodes = check_tree(tree)
        print(f'Tree of depth {depth} has {total_nodes} nodes.')

if __name__ == '__main__':
    main()