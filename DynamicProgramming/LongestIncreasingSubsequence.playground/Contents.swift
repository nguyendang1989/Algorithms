/* LONGEST INCREASING SUBSEQUENCE:
 LIS problem is to find a subsequence of a given sequence in which the subsequence's
 elements are in sorted order, lowest to highest, and in which subsequence is long as
 possible. This subsequence is not necessarily contiguous, or unique
 
 Example: 0,8,4,12,2,10,6,14,1,9,5,13,11,7,15
 
 -> Longest subsequence is : 0, 2, 6, 9, 11, 15
 */

/*APPROACH 1: RECURSIVE*/

func LISRecursive(_ sequence: [Int], _ i: Int, _ prev: Int) -> Int {
    guard i >= 0 else {
        return 0
    }
    
    var include = 0
    if sequence[i] < prev {
        include = LISRecursive(sequence, i-1, sequence[i]) + 1
    }
    let exclude = LISRecursive(sequence, i-1, prev)
    
    return max(include, exclude)
}

let input = [0,8,4,12,2,10,6,14,1,9,5,13,11]
LISRecursive(input, input.count-1, Int.max)

/*APPROACH 2: TOP DOWN
 */

func LISTopDown(_ sequence: [Int], _ i: Int, _ prev: Int, _ cache: inout [Int: Int]) -> Int {
    guard i < sequence.count else {
        return 0
    }
    
    if let maxLen = cache[i] {
        return maxLen
    }
    
    var include = 0
    if sequence[i] > prev {
        include = LISTopDown(sequence, i+1, sequence[i], &cache) + 1
    }
    let exclude = LISTopDown(sequence, i+1, prev, &cache)
    let result = max(include, exclude)
    cache[i] = result
    return result
}
var cache = [Int: Int]()
LISTopDown(input, 0, Int.min, &cache)

/*APPROACH 3: BOTTOM UP*/

func LISBottomUp(_ sequence: [Int]) -> Int {
    var dp = Array(repeating: 0, count: sequence.count)
    dp[0] = 1
    
    for i in 1..<sequence.count {
        for j in 0..<i {
            if sequence[j] < sequence[i], dp[j] > dp[i] {
                dp[i] = dp[j]
            }
        }
        
        dp[i] += 1
    }
    
    return dp.max() ?? 0
}

LISBottomUp(input)
