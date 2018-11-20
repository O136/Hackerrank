package leetcode

import (
	"bytes"
)

var M = []string{"", "M", "MM", "MMM"}                                       //thousands
var C = []string{"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"} //hundreds
var X = []string{"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"} //tens
var I = []string{"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"} //ones

//num is guaranteed to be in range 1...3999
func intToRoman(num int) string {
	var roman bytes.Buffer
	roman.WriteString(M[num/1000])
	roman.WriteString(C[(num%1000)/100])
	roman.WriteString(X[(num%100)/10])
	roman.WriteString(I[(num % 10)])

	return roman.String()
}
