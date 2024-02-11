#include <iostream>
#include <memory>

struct TreeNode {
    std::unique_ptr<TreeNode> left;
    std::unique_ptr<TreeNode> right;
};

std::unique_ptr<TreeNode> make_tree(int depth) {
    if (depth > 0) {
        depth--;
        auto node = std::make_unique<TreeNode>();
        node->left = make_tree(depth);
        node->right = make_tree(depth);
        return node;
    }
    return nullptr;
}

int check_tree(const std::unique_ptr<TreeNode>& node) {
    if (!node) {
        return 0;
    }
    return 1 + check_tree(node->left) + check_tree(node->right);
}

int main() {
    for (int i = 0; i < 21; i++) {
        int depth = 22;
        auto tree = make_tree(depth);
        int total_nodes = check_tree(tree);
        std::cout << "Tree of depth " << depth << " has " << total_nodes << " nodes." << std::endl;
    }
    return 0;
}
