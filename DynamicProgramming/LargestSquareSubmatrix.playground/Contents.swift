/*
 Find the largest squared sub-matrix of 1's present in given binary matrix
 
 Example:
 0 0 1 0 1 1
 0 1 1 1 0 0
 0 0 1 1 1 1
 1 1 0 1 1 1
 1 1 1 1 1 1
 1 1 0 1 1 1
 1 0 1 1 1 1
 1 1 1 0 1 1
 */

/*Intuition
 let consider 2-sized squared
 1 1
 1 1
 The size at index i = min_size_of(top-squared, left-squared, top-left-squared)
 */

func largestSquared(_ matrix: [[Int]]) -> Int {
    guard matrix.count > 0 else {
        return 0
    }
    let m = matrix.count
    let n = matrix[0].count
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    var res = 0
    for i in 0..<m {
        for j in 0..<n {
            if matrix[i][j] == 1 {
                if i > 0, j > 0 {
                    dp[i][j] = min(dp[i][j-1], dp[i-1][j-1], dp[i-1][j]) + 1
                } else {
                    dp[i][j] = 1
                }
            }
            
            if res < dp[i][j] {
                res = dp[i][j]
            }
        }
    }
    
    return res
}

let matrix = [[0, 0, 1, 0, 1, 1], [0, 1, 1, 1, 0, 0], [0, 0, 1, 1, 1, 1], [1, 1, 0, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 0, 1, 1, 1], [1, 0, 1, 1, 1, 1], [1, 1, 1, 0, 1, 1]]
largestSquared(matrix)
