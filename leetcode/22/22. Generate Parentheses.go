package leetcode

//просто шикарно...
func choose(left int, right int, cur string, acc *[]string) {
	if right == 0 {
		*acc = append(*acc, cur)
	} else if left == 0 {
		choose(left, right-1, cur+")", acc)
	} else if left == right {
		choose(left-1, right, cur+"(", acc)
	} else { //left > 0 and right > left
		choose(left-1, right, cur+"(", acc)
		choose(left, right-1, cur+")", acc)
	}

}

func generateParenthesis(n int) []string {
	res := make([]string, 0, n*n*n)
	choose(n, n, "", &res)
	return res
}
