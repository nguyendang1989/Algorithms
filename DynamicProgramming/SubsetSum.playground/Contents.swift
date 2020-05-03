import UIKit

// MARK: SubsetSum with O(m*n) space complexity
/*Given an array of non-negative integers and a value sum, determine if there is a subset of the given set with sum equal to given sum.
 Input : arr[] = {4, 1, 10, 12, 5, 2},
 sum = 9
 Output : TRUE
 {4, 5} is a subset with sum 9.
 
 Input : arr[] = {1, 8, 2, 5},
 sum = 4
 Output : FALSE
 There exists no subset with sum 4.
 */

/*
 if arr[i] > sum {
 return subsetSum(arr[0..<i], sum)
 } else {
    return subsetSum(arr[0..<i], sum - arr[i]) || subsetSum(arr[0..<i], sum)
 
 }
 */
func subsetSum(_ input: [Int], _ sum: Int) -> Bool {
    guard input.count > 0 else {
        if sum == 0 {
            return true
        }
        
        return false
    }
    var dp = Array(repeating: Array(repeating: false, count: sum + 1), count: input.count + 1)
    for i in 0...input.count {
        dp[i][0] = true
    }
    
    for row in 1...input.count {
        for s in 1...sum {
            if s < input[row-1] {
                dp[row][s] = dp[row-1][s]
            } else {
                dp[row][s] = dp[row-1][s] || dp[row-1][s-input[row-1]]
            }
        }
    }
    return dp[input.count][sum]
}

print(subsetSum([1, 8, 2, 5], 4))


//Problem 2: Subset Sum with O(m) space
// Get modulo bi = row & 1
// dp[bi][s] = dp[1-bi][s] || dp[1-bi][s-input[row]]]

func subsetSumOptimalSpace(_ input: [Int], _ sum: Int) -> Bool {
    guard input.count > 0 else {
        if sum == 0 {
            return true
        }
        
        return false
    }
    
    var dp = Array(repeating: Array(repeating: false, count: sum + 1), count: 2)
    dp[0][0] = true
    dp[1][0] = true
    var index = 0
    
    for i in 1...input.count {
        index &= 1
        for j in 1...sum {
            if input[i-1] > sum {
                dp[1-index][j] = dp[index][j]
            } else {
                dp[1-index][j] = dp[index][j-input[i-1]] || dp[index][j]
            }
        }
    }
    return dp[index][sum]
}

print(subsetSum([1, 8, 2, 5], 4))

//Print All Subset with Sum

func listSubsetSum(_ input: [Int], _ sum: Int) -> [[Int]] {
    guard input.count > 0 else {
        return []
    }
    
    var dp = Array(repeating: Array(repeating: false, count: sum + 1), count: input.count + 1)
    for i in 0...input.count {
        dp[i][0] = true
    }
    
    for row in 1...input.count {
        for s in 1...sum {
            if s < input[row-1] {
                dp[row][s] = dp[row-1][s]
            } else {
                dp[row][s] = dp[row-1][s] || dp[row-1][s-input[row-1]]
            }
        }
    }
    
    if dp[input.count][sum] == false {
        return []
    }
    var result = [[Int]]()
    for row in 1...input.count {
        for s in 1...sum {
            if dp[row][s] {
                if s > input[row - 1] {
//                    result.append()
                }
            }
        }
    }
}
