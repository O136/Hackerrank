package leetcode

func generateParenthesis(n int) []string {
	ans := []string{}
	build(&ans, "", 0, 0, n)
	return ans
}

func build(ans *[]string, str string, openP int, closedP int, maxP int) {
	//at most we can have maxP'(' and maxP')' parens
	if len(str) == 2*maxP {
		*ans = append(*ans, str)
		return
	}

	if openP < maxP {
		build(ans, str+"(", openP+1, closedP, maxP)
		// fmt.Println(*ans)
	}

	if closedP < openP {
		build(ans, str+")", openP, closedP+1, maxP)
		// fmt.Println(*ans)
	}
}
