class Solution:
    def pairwise(self, l1, l2): # [[concat(i,j)] ∀i ∊ l1 and ∀j ∊ l2]
        return [''.join([e1,e2]) for e1 in l1 for e2 in l2]

    def letterCombinations(self, digits):
        """
        :type digits: str
        :rtype: List[str]
        """
        if len(digits) == 0:
            return []
        #converting from ascii to integer
        dRange = list(map(lambda d : ord(d) - ord('2'), digits))

        d = [['a', 'b', 'c'], ['d', 'e','f'], ['g','h','i'], ['j','k','l'],
             ['m','n','o'], ['p','q','r','s'], ['t','u','v'], ['w','x','y','z']]

        #putting the letters for the 1st index
        acc = d[dRange.pop(0)]
        
        for seq in dRange:
            #for more readability would use the function pairwise
            acc = [''.join([e1,e2]) for e1 in d[seq] for e2 in acc] 
            
        return list(acc)
		