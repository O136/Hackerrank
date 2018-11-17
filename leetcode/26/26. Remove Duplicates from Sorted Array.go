package main

import (
	"fmt"
)

func removeDuplicates(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	idx := 0
	for j := 1; j < len(nums); j++ {
		if nums[j] != nums[idx] {
			idx++
			nums[idx] = nums[j]
		}
	}

	return idx + 1
}

func main() {

	// fmt.Println("count", removeDuplicates([]int{0, 1, 1, 1, 1, 2, 3, 4, 4, 4, 5}))
	// fmt.Println("count", removeDuplicates([]int{0}))
	// fmt.Println("count", removeDuplicates([]int{1, 1}))
	// fmt.Println("count", removeDuplicates([]int{1, 2, 3, 3}))
	// fmt.Println("count", removeDuplicates([]int{1, 1, 3, 3}))
	// fmt.Println("count", removeDuplicates([]int{0, 1, 2}))
	// fmt.Println("count", removeDuplicates([]int{0, 1, 1, 7, 8, 9, 9, 9}))
	fmt.Println("count", removeDuplicates([]int{0, 1, 2, 3, 4, 4, 5, 5, 5, 5}))
	fmt.Println("count", removeDuplicates([]int{0, 0, 0, 0, 1, 2, 3, 4, 4, 5, 5, 5, 5}))
}
