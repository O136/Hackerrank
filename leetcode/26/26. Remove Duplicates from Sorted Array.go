package leetcode

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
