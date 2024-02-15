class TreeNode {
    TreeNode left;
    TreeNode right;
}

public class BinaryTree {

    public static TreeNode makeTree(int depth) {
        if (depth > 0) {
            depth--;
            TreeNode node = new TreeNode();
            node.left = makeTree(depth);
            node.right = makeTree(depth);
            return node;
        }
        return null;
    }

    public static int checkTree(TreeNode node) {
        if (node == null) {
            return 0;
        }
        return 1 + checkTree(node.left) + checkTree(node.right);
    }

    public static void main(String[] args) {
        for (int i = 0; i < 45; i++) {
            int depth = 45;
            TreeNode tree = makeTree(depth);
            int totalNodes = checkTree(tree);
            System.out.println("Tree of depth " + depth + " has " + totalNodes + " nodes.");
        }
    }
}
