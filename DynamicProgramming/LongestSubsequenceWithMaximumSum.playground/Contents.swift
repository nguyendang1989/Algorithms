/*
 Longest Subsequence with Maximum Sum problem is to find the subsequence that subsequence
 sum as high as possible, and subsequence elements are sorted in increasing order, from lowest
 to highest. This subsequence is not necessarily contiguous or unique
 
 Example: [0,8,4,12,2,10,6,14,1,9,5,13,3,11]
 The maximum sum subsequence is : [8,12,14] which is total as 34
 
 Apply Longest Increasing Subsequence, instead of count 1 more when we include the number in
 result, we add the number in that sequence
 */

/*Recursive
 With element at index i
 - Include current element LSMS(i+1) + sequence[i] if sequence[i] > pre
 - Exclude current element LSMS(i+1)
 - A[i] = max(include, exclude)
 */


/*DP Bottom Up*/
func LSMS(_ input: [Int]) -> Int {
    guard input.count > 0 else {
        return 0
    }
    
    let m = input.count
    var dp = Array(repeating: 0, count: m)
    dp[0] = input[0]
    for i in 1..<m {
        for j in 0..<i {
            if input[j] < input[i], dp[j] > dp[i] {
                dp[i] = dp[j]
            }
        }
        
        dp[i] += input[i]
    }
    
    return dp.max() ?? 0
}

LSMS([0,8,4,12,2,10,6,14,1,9,5,13,3,11])
