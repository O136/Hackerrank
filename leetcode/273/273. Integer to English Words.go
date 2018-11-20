package main

import "fmt"

// TODO:Convert a non-negative integer to its english words representation.
// Given input is guaranteed to be less than 2^(31) - 1.
func numberToWords(num int) string {
	return ""
}

func main() {
	//"One"
	fmt.Println(numberToWords(1))

	//"One Hundred Twenty Three"
	fmt.Println(numberToWords(123))

	//"Twelve Thousand Three Hundred Forty Five"
	fmt.Println(numberToWords(12345))

	//"One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
	fmt.Println(numberToWords(1234567))

	//"One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One"
	fmt.Println(numberToWords(1234567891))
}
