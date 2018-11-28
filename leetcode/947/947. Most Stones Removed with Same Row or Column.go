package leetcode

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

	if q.sz[root1] < q.sz[root2] {
		q.id[root1] = root2
		q.sz[root2] += q.sz[root1]
	} else {
		q.id[root2] = root1
		q.sz[root1] += q.sz[root2]
	}
}

func (q *QuickUnion) treeCount() int {
	treeCount := 0
	for i := 0; i < len(q.id); i++ {
		if q.id[i] == i {
			treeCount++
		}
	}

	return treeCount
}

func removeStones(stones [][]int) int {
	size := len(stones)
	q := makeQuickUnion(size)

	for i := 0; i < size; i++ {
		//no point to iterate from 0 again, because the
		//previous i points were already covered
		for j := i + 1; j < size; j++ {
			if stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1] {
				q.unite(i, j)
			}
		}
	}
	//count #trees aka connected components
	return size - q.treeCount()
}
