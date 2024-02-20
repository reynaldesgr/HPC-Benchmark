// Cadeau. Codé par Thomas TAMAGNAUD pour Antoine VITON et Reynalde SEGERIE 
const DEPTH : u32 = 26;
const REPETITION : u32 = 30;

pub mod pool;
use std::ops::{Index, IndexMut};

pub use pool::*;

struct TreeNodeManager
{
    // Des block de 2^18 TreeNode
    // Soit 262144 * mem::sizeof::<TreeNode>::() = 2^18 * 16 octets
    // = 4 Mio (mébioctet : 4 * 1024 * 1024 octets) par Block (environ, juste pour le tableau contigu des TreeNode)
    nodes : Pool<TreeNode, 262144>
}
impl Index<PoolId<TreeNode>> for TreeNodeManager
{
    type Output=TreeNode;
    #[inline(always)]
    fn index(&self, index: PoolId<TreeNode>) -> &Self::Output { &self.nodes[index] }
}
impl IndexMut<PoolId<TreeNode>> for TreeNodeManager 
{ 
    #[inline(always)]
    fn index_mut(&mut self, index: PoolId<TreeNode>) -> &mut Self::Output { &mut self.nodes[index] }
}

struct TreeNode 
{
    left: Option<PoolId<TreeNode>>,
    right: Option<PoolId<TreeNode>>,
}

impl TreeNodeManager 
{
    fn make_tree(&mut self, depth: u32) -> Option<PoolId<TreeNode>> {
        if depth > 0 {
            let left = self.make_tree(depth - 1);
            let right = self.make_tree(depth - 1);
            Some(self.nodes.alloc(TreeNode { left, right }))
        } else {
            None
        }
    }

    fn count_node(&self, node: Option<PoolId<TreeNode>>) -> usize {
        match node {
            None => 0,
            Some(node_id) => 
            {
                let node = &self.nodes[node_id];
                1 + self.count_node(node.left) + self.count_node(node.right)
            },
        }
    }

    fn free(&mut self, node: Option<PoolId<TreeNode>>)
    {
        match node
        {
            Some(node_id) => 
            { 
                let node = self.nodes.remove_from_pool(node_id);
                self.free(node.left);
                self.free(node.right);
            },
            None => {},
        }
    }
}


fn main() 
{
    for _ in 0..REPETITION
    {
        let mut node_manager = TreeNodeManager{ nodes: Pool::new() };

        let tree = node_manager.make_tree(DEPTH);

        // Possibilité de changer la ligne
        let total_nodes = node_manager.count_node(tree);
        //let total_nodes = node_manager.nodes.nb_alloc_active;

        node_manager.nodes.no_more_allocation();
        node_manager.free(tree); // possibilité de mettre cette ligne en commentaire, car un noeud n'a pas de pointeur externe (autre que ceux dans la même Pool)

        println!("Tree of depth {} has {} nodes.", DEPTH, total_nodes);
    }
}

/*

struct TreeNode {
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn make_tree(depth: u32) -> Option<Box<TreeNode>> {
        if depth > 0 {
            let left = TreeNode::make_tree(depth - 1);
            let right = TreeNode::make_tree(depth - 1);
            Some(Box::new(TreeNode { left, right }))
        } else {
            None
        }
    }

    fn count_node(node: &Option<Box<TreeNode>>) -> usize {
        match node {
            None => 0,
            Some(n) => 1 + TreeNode::count_node(&n.left) + TreeNode::count_node(&n.right),
        }
    }
}

fn main() {
    println!();
    for _ in 0..REPETITION {
        let tree = TreeNode::make_tree(DEPTH);
        let total_nodes = TreeNode::count_node(&tree);
        println!("Tree of depth {} has {} nodes.", DEPTH, total_nodes);
    }
}
*/

/*
Commande de compilation :
cargo build --release
time ./target/release/binary_tree
*/