package main

import (
	"fmt"
)

const (
	//ANY represents chars from the range'a'-'z'
	ANY rune = '.'
	//STAR can be coupled to a 'a'-'z' char
	//or directly with ANY e.g. ".*" which means
	//that the chars from 'a'-'z' can be repeated 0 or many times
	STAR rune = '*'
)

type Pair struct {
	char  rune
	state int
}

type Automaton struct {
	initState   int            //id of state is represented with int
	finalState  int            //will be only a single accept state
	transitions map[int][]Pair //k=fromState, v=(char, toState)
}

func (a *Automaton) consume(currentState int, input rune) []int {
	val, _ := a.transitions[currentState]
	validTranistions := []int{}

	for _, pair := range val {
		if pair.char == input || pair.char == ANY {
			validTranistions = append(validTranistions, pair.state)
		}
	}

	return validTranistions // if empty then we reached the NULL/inexistent state
}

func (a *Automaton) accept(s string) bool {
	currentStates := []int{a.initState}

	for _, elem := range s {
		currentStates = a.consume(currentStates[0], elem)
		// if len(currentStates) == 0 {
		// 	return false //we ended up in the NULL state, already handled below
		// }

	}

	fmt.Println("final=", a.finalState, ",current=", currentStates)
	for _, state := range currentStates {
		if state == a.finalState { //only 1 accept is enough
			return true
		}
	}
	return false
}

func buildNFAFromReg(p string) Automaton { //maybe return pointer to Automaton ? with an error
	transitions := make(map[int][]Pair)
	currentState := 0

	for idx := 0; idx < len(p); idx++ {
		c := rune(p[idx])
		pairs, _ := transitions[currentState]

		if idx+1 < len(p) {
			if rune(p[idx+1]) == STAR {
				pairs = append(pairs, Pair{char: c, state: currentState})
				transitions[currentState] = pairs
				idx++ //skip the STAR
				continue
			}
		}

		//update the stateId only if input char is not STAR
		pairs = append(pairs, Pair{char: c, state: currentState + 1})
		transitions[currentState] = pairs
		currentState++
	}

	return Automaton{initState: 0, finalState: currentState, transitions: transitions}
}

func isMatch(s string, p string) bool {
	a := buildNFAFromReg(p)
	fmt.Println(a)
	return a.accept(s)
}

func main() {
	// fmt.Println(isMatch("mississippi", "mis*is*p*."))
	// fmt.Println(isMatch("aab", "c*a*b"))
	// fmt.Println(isMatch("ab", ".*"))
	// fmt.Println(isMatch("aa", "a*"))
	// fmt.Println(isMatch("aa", "a"))
	fmt.Println(isMatch("aaa", "a*a")) //the case why we need an NFA
}
