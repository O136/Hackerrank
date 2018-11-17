package leetcode

import (
	"container/heap"
)

/*
type ListNode struct {
	Val  int
	Next *ListNode
}
*/

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}
func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
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
	c := make(IntHeap, 0, 8000)
	for _, l := range lists {
		c = append(c, collectVals(l)...)
	}

	hp := &c
	heap.Init(hp) //heap is built

	for hp.Len() > 0 {
		tmp = insert(tmp, heap.Pop(hp).(int))
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
	} //toInsert.Next = nil
	return tail.Next
}
