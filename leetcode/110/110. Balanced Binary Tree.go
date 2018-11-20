package main

import (
	"fmt"
)

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func myAbs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(x int, y int) int {
	if x < y {
		return y
	}
	return x
}

func height(root *TreeNode) int {
	if root == nil {
		return 0
	}

	l, r := height(root.Left), height(root.Right)
	if l == -1 || r == -1 || myAbs(l-r) > 1 {
		return -1
	}

	return max(l, r) + 1
}

func isBalanced(root *TreeNode) bool {
	if root == nil {
		return true
	}
	return height(root) != -1
}

func main() {
	unbalanced := &TreeNode{
		Right: &TreeNode{
			Val: 4,
			Right: &TreeNode{
				Val:   1,
				Right: nil,
				Left: &TreeNode{
					Val:   3,
					Right: nil,
					Left:  nil,
				},
			},
			Left: nil,
		},
		Left: nil,
	}
	fmt.Println(height(unbalanced.Right))

	balanced := &TreeNode{
		Val: 5,
		Right: &TreeNode{
			Val: 4,
			Right: &TreeNode{
				Val:   1,
				Right: nil,
				Left:  nil,
			},
			Left: nil,
		},

		Left: &TreeNode{
			Val: 4,
			Left: &TreeNode{
				Val:   1,
				Right: nil,
				Left:  nil,
			},
			Right: nil,
		},
	}

	fmt.Println(height(balanced))
}
