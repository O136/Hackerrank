package leetcode

func minSubArrayLen(s int, nums []int) int {
	curSum, totalSum := 0, 0
	min := len(nums)
	lWB := 0 //left window bound

	for i := 0; i < len(nums); {
		curSum += nums[i]
		totalSum += nums[i]
		i++
		if curSum >= s {
			//shift window bound
			for ; curSum-nums[lWB] >= s && lWB < i; lWB++ {
				curSum -= nums[lWB]
			}
			if i-lWB < min { //i-lWB = size of the current window
				min = i - lWB
			}
		}
	}
	if totalSum < s {
		return 0
	}
	return min
}
