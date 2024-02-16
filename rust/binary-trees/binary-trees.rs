struct TreeNode {
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn make_tree(depth: i32) -> Option<Box<TreeNode>> {
        if depth > 0 {
            let left = TreeNode::make_tree(depth - 1);
            let right = TreeNode::make_tree(depth - 1);
            Some(Box::new(TreeNode { left, right }))
        } else {
            None
        }
    }

    fn check_tree(node: &Option<Box<TreeNode>>) -> i32 {
        match node {
            None => 0,
            Some(n) => 1 + TreeNode::check_tree(&n.left) + TreeNode::check_tree(&n.right),
        }
    }
}

fn main() {
    for _ in 0..25 {
        let depth = 25;
        let tree = TreeNode::make_tree(depth);
        let total_nodes = TreeNode::check_tree(&tree);
        println!("Tree of depth {} has {} nodes.", depth, total_nodes);
    }
}
