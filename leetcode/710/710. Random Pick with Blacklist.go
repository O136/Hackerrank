package leetcode

import (
	"math/rand"
)

type Solution struct {
	N             int
	upperBound    int
	needRemapping []int
	remapped      map[int]int
}

func Constructor(N int, blacklist []int) Solution {
	needRemapping := make([]int, 0, len(blacklist)/2)
	upperBound := N - len(blacklist)

	for i := range blacklist {
		if blacklist[i] < upperBound {
			needRemapping = append(needRemapping, blacklist[i])
		}
	}

	blackListed := make(map[int]bool, len(blacklist))
	for _, b := range blacklist {
		blackListed[b] = true
	}

	remapped := make(map[int]int, len(needRemapping))
	pos := 0
	for i := upperBound; i < N; i++ {
		_, ok := blackListed[i]
		if !ok {
			remapped[needRemapping[pos]] = i
			pos++
		}
	}

	return Solution{N: N, upperBound: upperBound, remapped: remapped, needRemapping: needRemapping}
}

func (s *Solution) Pick() int {
	r := rand.Intn(s.upperBound)
	val, ok := s.remapped[r]
	if ok {
		return val
	}

	return r
}
