package leetcode

func min(a int, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a int, b int) int {
	if a > b {
		return a
	}
	return b
}

func trap(blockHeights []int) int {
	wArea := 0                                 //water area
	stack := make([]int, 0, len(blockHeights)) //len=0, cap=len(blockHeights)

	for pos := 0; pos < len(blockHeights); pos++ {

		for len(stack) != 0 && blockHeights[pos] > blockHeights[stack[len(stack)-1]] {
			topPos := stack[len(stack)-1]
			stack = stack[:len(stack)-1] //pop the top
			if len(stack) == 0 {
				break
			}

			distance := pos - stack[len(stack)-1] - 1 //extra -1 because we start counting at 0

			height := min(blockHeights[stack[len(stack)-1]], blockHeights[pos]) - blockHeights[topPos]
			wArea += height * distance
		}

		stack = append(stack, pos) //push current pos
	}

	return wArea
}

func trapBrute(height []int) int {
	wArea := 0
	size := len(height)
	for i := 1; i < size-1; i++ {
		maxLeft, maxRight := 0, 0

		for j := i; j >= 0; j-- { //Search the left part for max bar size
			maxLeft = max(maxLeft, height[j])
		}
		for j := i; j < size; j++ { //Search the right part for max bar size
			maxRight = max(maxRight, height[j])
		}
		wArea += min(maxLeft, maxRight) - height[i]
	}
	return wArea
}

func trapDP(height []int) int {
	if len(height) == 0 {
		return 0
	}

	wArea := 0
	size := len(height)
	leftMax, rightMax := make([]int, size), make([]int, size)
	leftMax[0] = height[0]

	for i := 1; i < size; i++ {
		leftMax[i] = max(height[i], leftMax[i-1])
	}

	rightMax[size-1] = height[size-1]

	for i := size - 2; i >= 0; i-- {
		rightMax[i] = max(height[i], rightMax[i+1])
	}
	for i := 1; i < size-1; i++ {
		wArea += min(leftMax[i], rightMax[i]) - height[i]
	}

	return wArea
}
