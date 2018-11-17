package leetcode

import (
	"fmt"
	"sort"
)

type ListNode struct {
	Val  int
	Next *ListNode
}

func collectVals(head *ListNode) []int {
	c := make([]int, 0, 32)
	tmp := head
	for tmp != nil {
		c = append(c, tmp.Val)
		tmp = tmp.Next
	}
	return c
}

func mergeKLists(lists []*ListNode) *ListNode {
	tmp := &ListNode{ //temporary node
		Val:  -1,
		Next: nil,
	}
	head := tmp

	//collect all values into a container
	//will speed up building of heap, but will consume O(n) memory
	c := make([]int, 0, 8000)
	for _, l := range lists {
		c = append(c, collectVals(l)...)
	}

	sort.Ints(c)

	for _, el := range c {
		tmp = insert(tmp, el)
	}

	return head.Next
}

func insert(tail *ListNode, toInsert int) *ListNode {

	if tail.Next != nil {
		panic("assert tail.Next == nil failed")
	}

	tail.Next = &ListNode{
		Val:  toInsert,
		Next: nil,
	}
	return tail.Next
}

func printList(h *ListNode) {
	tmp := h
	for tmp != nil {
		fmt.Print(tmp.Val, "-->")
		tmp = tmp.Next
	}
	fmt.Println("nil")
}

func main() {
	lists := []*ListNode{
		&ListNode{
			Val: 1,
			Next: &ListNode{
				Val:  4,
				Next: nil,
			},
		},
		&ListNode{
			Val: 1,
			Next: &ListNode{
				Val: 7,
				Next: &ListNode{
					Val:  -3,
					Next: nil,
				},
			},
		},
		&ListNode{
			Val:  0,
			Next: nil,
		},
	}

	printList(mergeKLists(lists))
}
