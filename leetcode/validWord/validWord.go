package leetcode

//State represetns the states of a DFA
type State int

// Transition represents the input chars
type Transition byte

func (s State) next(t Transition) State {

	switch s {
	case 0:
		switch {
		case t == ' ':
			return 0
		case t == '-':
			fallthrough
		case t == '+':
			return 2
		case t == '.':
			return 3
		case '0' <= t && t <= '9':
			return 1
		default:
			return -1
		}

	case 1:
		switch {
		case '0' <= t && t <= '9':
			return 1
		case t == ' ':
			return 8
		case t == 'e':
			return 5
		case t == '.':
			return 4
		default:
			return -1
		}

	case 2:
		switch {
		case '0' <= t && t <= '9':
			return 1
		case t == '.':
			return 3
		default:
			return -1
		}

	case 3:
		switch {
		case '0' <= t && t <= '9':
			return 4
		default:
			return -1
		}

	case 4:
		switch {
		case '0' <= t && t <= '9':
			return 4
		case t == 'e':
			return 5
		case t == ' ':
			return 8
		default:
			return -1
		}

	case 5:
		switch {
		case '0' <= t && t <= '9':
			return 6
		case t == '-':
			fallthrough
		case t == '+':
			return 7
		default:
			return -1
		}

	case 6:
		switch {
		case '0' <= t && t <= '9':
			return 6
		case t == ' ':
			return 8
		default:
			return -1
		}

	case 7:
		switch {
		case '0' <= t && t <= '9':
			return 6
		default:
			return -1
		}

	case 8:
		switch t {
		case ' ':
			return 8
		default:
			return -1
		}

	default:
		return -1
	}
}

func isNumber(s string) bool {
	state := State(0)
	for i := 0; i < len(s); i++ {
		state = state.next(Transition(s[i]))
		if state == -1 {
			return false
		}
	}

	switch state { //check if last state is in accept states
	case 1:
		fallthrough
	case 4:
		fallthrough
	case 6:
		fallthrough
	case 8:
		return true
	default:
		return false
	}
}
