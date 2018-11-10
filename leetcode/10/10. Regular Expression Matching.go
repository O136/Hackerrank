package leetcode

func isMatch(text string, p string) bool {
	dp := make([][]bool, len(text)+1)
	for i := range dp {
		dp[i] = make([]bool, len(p)+1)
	}
	dp[len(text)][len(p)] = true

	for i := len(text); i >= 0; i-- {
		for j := len(p) - 1; j >= 0; j-- {
			firstMatch := (i < len(text) && (p[j] == text[i] || p[j] == '.'))

			if j+1 < len(p) && p[j+1] == '*' {
				dp[i][j] = dp[i][j+2] || firstMatch && dp[i+1][j]
			} else {
				dp[i][j] = firstMatch && dp[i+1][j+1]
			}
		}
	}

	return dp[0][0]
}
