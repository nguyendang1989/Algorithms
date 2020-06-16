/*
 Give an array, let find out that array can be divided into 2 subset that have same total
 
 Example : [3,1,1,2,2,1] has 2 partition : {3,2} {2,1,1,1}
 
 Intuition: This problem is a special case of Subset Sum. Subset sum is a special case of
 Knapsack Problem
 
 So for sum s at item i dp[s][i]
 - We select the item in the result and look for the remains : dp[s][i] = dp[s-arr[i]][i-1]
 - We dont select the current item dp[s][i] = dp[s][i-1]
 */

func partitionProblem(_ A: [Int]) -> Bool {
    guard A.count > 0 else {
        return false
    }
    let sum = A.reduce(0, +)
    if sum % 2 == 1 {
        return false
    }
    let target = sum/2
    let n = A.count
    var dp = Array(repeating: Array(repeating: false, count: n+1), count: target+1)
    for i in 0...n {
        dp[0][i] = true
    }
    
    for i in 1...target {
        for j in 1...n {
            if i < A[j-1] {
                dp[i][j] = false
            } else {
                dp[i][j] = dp[i-A[j-1]][j-1] || dp[i][j-1]
            }
        }
    }
    
    return dp[target][n]
}

partitionProblem([3,1,1,2,2,1])
