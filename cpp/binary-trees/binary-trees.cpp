#include <iostream>

struct TreeNode {
    TreeNode* left;
    TreeNode* right;

    TreeNode() : left(nullptr), right(nullptr) {}
    ~TreeNode() {
        delete left;
        delete right;
    }
};

TreeNode* make_tree(int depth) {
    if (depth > 0) {
        depth--;
        TreeNode* node = new TreeNode();
        node->left = make_tree(depth);
        node->right = make_tree(depth);
        return node;
    }
    return nullptr;
}

int check_tree(TreeNode* node) {
    if (node == nullptr) {
        return 0;
    }
    return 1 + check_tree(node->left) + check_tree(node->right);
}

int main() {
    for (int i = 0; i < 45; i++) {
        int depth = 45;
        TreeNode* tree = make_tree(depth);
        int total_nodes = check_tree(tree);
        std::cout << "Tree of depth " << depth << " has " << total_nodes << " nodes." << std::endl;
        delete tree;
    }
    return 0;
}

