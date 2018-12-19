class Graph:
    def __init__(self):
        self.adj = {}

    def bfs(self, src):
        q = [src]
        visited = set()

        while len(q) > 0:
            v = q.pop()

            for adj in self.adj[v]:
                if adj not in visited:
                    q.append(adj)

            visited.update([v])

        return visited

    def cc(self):
        visited = set([])
        cc = []

        # iterate through every node
        for v in self.adj:
            if v not in visited:
                s = self.bfs(v)
                visited.update(s)
                cc.append(s)

        return cc

    # method to add an undirected edge
    def add_edge(self, v, w):
        if v not in self.adj:
            self.adj[v] = set()
        if w not in self.adj:
            self.adj[w] = set()

        self.adj[v].update([w])
        self.adj[w].update([v])


class Solution:
    def numIslands2(self, grid):
        if not grid:
            return 0

        count = 0
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == '1':
                    self.dfs(grid, i, j)
                    count += 1
        return count

    def dfs(self, grid, i, j):
        if i < 0 or j < 0 or i >= len(grid) or j >= len(grid[0]) or grid[i][j] != '1':
            return
            
        grid[i][j] = '#'
        self.dfs(grid, i+1, j)
        self.dfs(grid, i-1, j)
        self.dfs(grid, i, j+1)
        self.dfs(grid, i, j-1)

    def numIslands(self, grid):
        """
        :type grid: List[List[str]]
        :rtype: int
        """
        if len(grid) == 0:
            return 0
        rows, cols = len(grid), len(grid[0])
        g = Graph()

        for row in range(0, rows):
            for col in range(0, cols):
                vertex_id = cols * row + col
                if grid[row][col] == '1':

                    # check if below neighbor is '1'
                    if row + 1 < rows and grid[row + 1][col] == '1':
                        neighbor_id = cols * (row + 1) + col
                        g.add_edge(vertex_id, neighbor_id)

                    # check if right neighbor is '1'
                    if col + 1 < cols and grid[row][col + 1] == '1':
                        neighbor_id = cols * row + (col + 1)
                        g.add_edge(vertex_id, neighbor_id)

                    # check if it's a lonely island :(
                    if vertex_id not in g.adj:
                        g.add_edge(vertex_id, vertex_id)

        return len(g.cc())


if __name__ == '__main__':
    g = Graph()
    g.add_edge(1, 0)
    g.add_edge(2, 3)
    g.add_edge(3, 4)
    print(g.adj)
    print(g.bfs(3))

    print('cc with bfs:', g.cc())
    # print('cc with dfs:', g.connectedComponents())

    # 1
    m1 = [['1', '1', '1', '1', '0'],
          ['1', '1', '0', '1', '0'],
          ['1', '1', '0', '0', '0'],
          ['0', '0', '0', '0', '0']]

    # 3
    m2 = [['1', '1', '0', '0', '0'],
          ['1', '1', '0', '0', '0'],
          ['0', '0', '1', '0', '0'],
          ['0', '0', '0', '1', '1']]

    # 4
    m3 = [['1', '0', '0', '0', '0'],
          ['0', '0', '0', '0', '0'],
          ['0', '0', '1', '0', '0'],
          ['0', '0', '0', '0', '1'],
          ['1', '1', '0', '1', '1']]

    # 3
    m4 = [['1', '0', '1', '0', '1'],
          ['1', '0', '1', '0', '1'],
          ['1', '0', '1', '0', '1'],
          ['1', '0', '1', '0', '1']]

    # 2
    m5 = [['0', '1', '1', '1', '1'],
          ['1', '0', '0', '0', '1'],
          ['1', '0', '0', '0', '1'],
          ['1', '1', '1', '1', '0']]

    # 6
    m6 = [['0', '1', '0'],
          ['1', '0', '1'],
          ['0', '1', '0'],
          ['1', '0', '1']]

    all_ones = [['1' for _ in range(0, 10)] for _ in range(0, 10)]
    single_zero = [['0']]
    single_one = [['1']]
    null = [[]]

    s = Solution()
    print('solutions:')
    print(s.numIslands(m1))
    print(s.numIslands(m2))
    print(s.numIslands(m3))
    print(s.numIslands(m4))
    print(s.numIslands(m5))
    print(s.numIslands(m6))

    print('base cases')
    print(s.numIslands(all_ones))
    print(s.numIslands(single_zero))
    print(s.numIslands(single_one))
    print(s.numIslands(null))
    print(s.numIslands2(m6))
