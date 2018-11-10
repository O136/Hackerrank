package main

import (
	"math/rand"
)

/*
Needed:
	(int -> (int-> [pos_in_array]) map
	int slice

amortized O(1)
On Insert method we compute the pos_in_array = len(array) + 1 and

O(1)
On GetRandom we generate a n = randomInt(0, len(slice) + 1), because it's non inclusive
and return slice[n]

amortized O(1)
On Deletion we delete the key with ANY position in the array
if pos of the deleted key is the last one we're done
otherwise we use the pos_in_array to get to the value and
swap it with the last one in the slice, then decrease the length of the slice
and we have to update the position of the swapped key

*/

type RandomizedCollection struct {
	//a map from int keys to a set which represents
	//the positions in the copiedKeys slice
	container  map[int]map[int]bool
	copiedKeys []int
}

// /** Initialize your data structure here. */
func Constructor() RandomizedCollection {
	return RandomizedCollection{container: make(map[int]map[int]bool, 512), copiedKeys: make([]int, 0)}
}

/** Inserts a value to the collection. Returns true if the collection did not already contain the specified element. */
func (c *RandomizedCollection) Insert(key int) bool {
	//for the key add its position in array
	val, ok := c.container[key]
	if !ok {
		val = make(map[int]bool)
	}
	val[len(c.copiedKeys)] = true
	c.container[key] = val

	//update array of keys
	c.copiedKeys = append(c.copiedKeys, key)
	return !ok
}

/** Removes a value from the collection. Returns true if the collection contained the specified element. */
func (c *RandomizedCollection) Remove(key int) bool {
	val, ok := c.container[key]
	if ok {
		// take pos where to delete in copiedKeys
		pos := 0
		for any := range val { //get any key, could use a struct instead with lastElemAccessed
			pos = any
			break
		}

		last := len(c.copiedKeys) - 1
		delete(c.container[key], pos)

		if last != pos {
			//aka swap last with pos
			c.copiedKeys[pos] = c.copiedKeys[last]
			c.container[c.copiedKeys[last]][pos] = true
			delete(c.container[c.copiedKeys[last]], len(c.copiedKeys)-1)
		}

		//decrease size
		c.copiedKeys = c.copiedKeys[:last]

		if len(c.container[key]) == 0 {
			delete(c.container, key)
		}
	}

	return ok
}

/* GetRandom element from the collection.*/
func (c *RandomizedCollection) GetRandom() int {
	l := len(c.copiedKeys)
	if l > 0 {
		return c.copiedKeys[rand.Intn(l)]
	}
	return 0
}
