package leetcode

import (
	"math/rand"
)

type Solution struct {
	m   map[int][]int //key -> key.PositionInArray
	arr []int
}

func Constructor(nums []int) Solution {
	return Solution{m: make(map[int][]int), arr: nums}
}

func (s *Solution) Pick(target int) int {

	for idx, elem := range s.arr {
		if elem == target {
			s.m[elem] = append(s.m[elem], idx)
		}
	}
	//problem statement assures us not to worry about the existance of target
	val, _ := s.m[target]

	return val[rand.Intn(len(val))]
}
