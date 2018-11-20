package leetcode

//for simplicity we assume it is a byte
//but it should be of type rune in order to support unicode chars (if needed)
var numerals = map[byte]int{
	'I': 1,
	'V': 5,
	'X': 10,
	'L': 50,
	'C': 100,
	'D': 500,
	'M': 1000,
}

//we're assured that s containts only capitalized letters
func romanToInt(s string) int {
	if len(s) == 0 {
		return 0
	}

	res := 0
	for i := range s[:len(s)-1] {
		if numerals[s[i]] < numerals[s[i+1]] {
			res -= numerals[s[i]]
		} else {
			res += numerals[s[i]]
		}
	}

	//last one is always added
	res += numerals[s[len(s)-1]]

	return res
}
