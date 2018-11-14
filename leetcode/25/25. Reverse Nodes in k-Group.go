package main

import (
	"fmt"
)

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func reverseKGroup(head *ListNode, k int) *ListNode {
	cur := head
	i := 0

	// reach for the k+1th node
	//in order to break the list into 2 parts
	for ; cur != nil && i != k; i++ {
		cur = cur.Next
	}

	//if k + 1 node is found
	if i == k {
		cur = reverseKGroup(cur, k)

		for ; i > 0; i-- {
			tmp := head.Next
			head.Next = cur
			cur = head
			head = tmp
		}
		head = cur
	}

	return head
}

func printList(n *ListNode) {
	for n != nil {
		fmt.Print(n.Val, "->")
		n = n.Next
	}
	fmt.Println("NIL")
}

func main() {
	l := &ListNode{
		Val: 1,
		Next: &ListNode{
			Val: 2,
			Next: &ListNode{
				Val:  3,
				Next: nil,
			},
		},
	}
	printList(reverseKGroup(l, 3))
}
