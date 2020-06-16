/*
 Based on this article : https://www.techiedelight.com/matrix-chain-multiplication/
 Time Complexity: O(N^3)
 Space Complexicty: O(N^2)
 */

func matrixChain(_ matrices: [Int]) -> Int {
    guard matrices.count > 2 else {
        return 0
    }
    let n = matrices.count
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
    
    for len in 2...n {
        for i in 1...(n-len+1) {
            let j = i + len - 1
            var k = i
            dp[i][j] = Int.max
            while j < n, k < j {
                let cost = dp[i][k] + dp[k+1][j] + matrices[i-1] * matrices[k] * matrices[j]
                if cost < dp[i][j] {
                    dp[i][j] = cost
                }
                
                k += 1
            }
        }
    }
    
    return dp[1][n-1]
}

matrixChain([10,30,5,60])
