#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    struct TreeNode* left;
    struct TreeNode* right;
} TreeNode;

TreeNode* make_tree(int depth) {
    if (depth > 0) {
        depth--;
        TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
        node->left = make_tree(depth);
        node->right = make_tree(depth);
        return node;
    }
    return NULL;
}

int check_tree(TreeNode* node) {
    if (node == NULL) {
        return 0;
    }
    return 1 + check_tree(node->left) + check_tree(node->right);
}

void free_tree(TreeNode* node) {
    if (node != NULL) {
        free_tree(node->left);
        free_tree(node->right);
        free(node);
    }
}

int main() {
    for (int i = 0; i < 21; i++) {
        int depth = 22;
        TreeNode* tree = make_tree(depth);
        int total_nodes = check_tree(tree);
        //printf("Tree of depth %d has %d nodes.\n", depth, total_nodes);
        free_tree(tree);
    }
    return 0;
}
