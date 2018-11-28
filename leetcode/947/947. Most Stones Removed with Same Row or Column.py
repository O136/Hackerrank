class DSU:
    def __init__(self, N):
        self.p = [n for n in range(N)]

    def find(self, x):
        if self.p[x] != x:
            self.p[x] = self.find(self.p[x])
        return self.p[x]

    def union(self, x, y):
        xr = self.find(x)
        yr = self.find(y)
        self.p[xr] = yr

class Solution(object):
    def removeStones(self, stones):
        N = len(stones)
        dsu = DSU(20000)

        for x, y in stones:
            dsu.union(x, y + 10000)
            print('union(',x,',',y+10000,')')
        
        l = set(dsu.find(x) for x, _ in stones)
        print(l)
        return N - len(l)

s = Solution()
print(s.removeStones([[0, 0], [0, 2], [1, 1], [2, 0], [2, 2]]))