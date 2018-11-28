package leetcode

//NOTE: to make it in linear time we
//must unite smartly, namely the indices!!!

type QuickUnion struct {
	id []int
	sz []int //counts number of elements in the tree rooted at i.
}

func makeQuickUnion(size int) *QuickUnion {
	id := make([]int, size, size)
	sz := make([]int, size, size)

	for index := 0; index < size; index++ {
		id[index] = index
		sz[index] = 1
	}

	return &QuickUnion{id: id, sz: sz}
}

func (q *QuickUnion) root(i int) int {
	for i != q.id[i] {
		q.id[i] = q.id[q.id[i]] //for path compression
		i = q.id[i]
	}

	return i
}

func (q *QuickUnion) find(node1 int, node2 int) bool {
	return q.root(node1) == q.root(node2)
}

func (q *QuickUnion) unite(node1 int, node2 int) {
	root1 := q.root(node1)
	root2 := q.root(node2)

	if root1 != root2 {
		if q.sz[root1] < q.sz[root2] {
			q.id[root1] = root2
			q.sz[root2] += q.sz[root1]
		} else {
			q.id[root2] = root1
			q.sz[root1] += q.sz[root2]
		}
	}
}

func removeStones(stones [][]int) int {
	offset := 10000
	q := makeQuickUnion(2 * offset)

	for i := 0; i < len(stones); i++ {
		q.unite(stones[i][0], stones[i][1]+offset)
	}
	//count #trees aka connected components
	m := make(map[int]struct{})

	for i := 0; i < len(stones); i++ {
		m[q.root(stones[i][0])] = struct{}{} //or stones[i][1]+offset
	}

	return len(stones) - len(m)
}

// func main() {
// 	//stones can be empty
// 	fmt.Println(removeStones([][]int{{0, 0}}))                                         //0
// 	fmt.Println(removeStones([][]int{{0, 0}, {0, 2}, {1, 1}, {2, 0}, {2, 2}}))         //3
// 	fmt.Println(removeStones([][]int{{0, 0}, {0, 1}, {1, 0}, {1, 2}, {2, 1}, {2, 2}})) //5

// 	fmt.Println(removeStones([][]int{{0, 1}, {1, 0}, {1, 1}})) //2

// }
