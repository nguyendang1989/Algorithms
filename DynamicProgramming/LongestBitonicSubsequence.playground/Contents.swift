/*Longest Bitonic Subsequence problem is to find a subsequence of a given sequence
 in which the subsequence's elements are sorted in increasing order, then in decreasing
 order, and the subsequence is long as possible
 For Example:
 [4,2,5,9,7,6,10,3,1] has longest bitonic subsequence is :
 4,5,9,7,6,3,1 OR 2, 5, 9, 7, 6, 3, 1
 for sequences are already sorted
 [1,2,3,4,5] -> [1,2,3,4,5]
 [5,4,3,2,1] -> [5,4,3,2,1]
 */

/*
 Base on the definition. We can use the Longest Increasing Subproblem to find out
 at position i:
 A[i] -> length of longest increasing sequence in 0...i
 B[i+1] -> length of longest decreasing sequence in i+1..<n
 then loop over the array and find out max of A[i] + B[i+1]
 */

func LBS(_ sequence: [Int]) -> Int {
    guard sequence.count > 0 else {
        return 0
    }
    let m = sequence.count
    var A = Array(repeating: 0, count: m)
    var B = Array(repeating: 0, count: m)
    
    A[0] = 1
    B[m-1] = 1
    
    for i in 1..<m {
        for j in 0..<i {
            if sequence[i] > sequence[j], A[j] > A[i] {
                A[i] = A[j]
            }
        }
        A[i] += 1
    }
    
    for i in (0..<m-1).reversed() {
        for j in (i+1...m-1).reversed() {
            if sequence[j] < sequence[i], B[j] > B[i] {
                B[i] = B[j]
            }
        }
        B[i] += 1
    }
    
    var result = 0
    for i in 0..<m {
        result = max(result, A[i] + B[i] - 1)
    }
    
    return result
}
let input1 = [4,2,5,9,7,6,10,3,1]
let input2 = [1,2,3,4,5]
let input3 = [5,4,3,2,1]

LBS(input1)
LBS(input2)
LBS(input3)

