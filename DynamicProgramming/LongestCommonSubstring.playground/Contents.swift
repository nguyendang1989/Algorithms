func LCSubstring(_ string1: String, _ string2: String) -> Int{
    let arr1 = Array(string1)
    let arr2 = Array(string2)
    return LCSubstring(arr1, arr2, 0, arr1.count-1, arr2.count-1)
}

func LCSubstring(_ arr1: [Character], _ arr2: [Character], _ n: Int, _ i: Int, _ j: Int) -> Int {
    guard i >= 0, j >= 0 else {
        return n
    }
    
    if arr1[i] != arr2[j] {
        let res1 = LCSubstring(arr1, arr2, 0, i-1, j)
        let res2 = LCSubstring(arr1, arr2, 0, i, j-1)
        return max(n, res1, res2)
    }
    
    return LCSubstring(arr1, arr2, n+1, i-1, j-1)
}

print(LCSubstring("ABABC", "BABCA"))

func LCSDP(_ string1: String, _ string2: String) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: string2.count + 1), count: string1.count + 1)
    let arr1 = Array(string1)
    let arr2 = Array(string2)
    
    for i in 1...arr1.count {
        for j in 1...arr2.count {
            if arr1[i-1] == arr2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    
    return dp[string1.count][string2.count]
}

print(LCSDP("ABAB", "BABA"))
