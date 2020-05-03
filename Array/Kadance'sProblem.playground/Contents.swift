import UIKit
/*Given an array arr of N integers. Find the contiguous sub-array with maximum sum.
 
 Input:
 The first line of input contains an integer T denoting the number of test cases. The description of T test cases follows. The first line of each test case contains a single integer N denoting the size of array. The second line contains N space-separated integers A1, A2, ..., AN denoting the elements of the array.
 
 Output:
 Print the maximum sum of the contiguous sub-array in a separate line for each test case.
 
 Constraints:
 1 ≤ T ≤ 110
 1 ≤ N ≤ 106
 -107 ≤ A[i] <= 107
 
 Example:
 Input
 2
 5
 1 2 3 -2 5
 4
 -1 -2 -3 -4
 
 2 3 5 -3 -4 -7 9 -2
 Output
 9
 -1
 
 Explanation:
 Testcase 1: Max subarray sum is 9 of elements (1, 2, 3, -2, 5) which is a contiguous subarray.*/

func kadanceProblem(_ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    var maxGlobal = nums[0]
    var maxLocal = nums[0]
    
    for i in 1..<nums.count {
        maxLocal = max(nums[i], maxLocal + nums[i])
        maxGlobal = max(maxGlobal, maxLocal)
    }
    
    return maxGlobal
}

kadanceProblem([-13, -3, -25, -20, -3, -16, -23, -12, -5, -22, -15, -4, -7])
kadanceProblem([-1,-2,-3,-4])
kadanceProblem([1,2,3,-2,5])
kadanceProblem([2,-3,-5, -3, -4, -7, -9, -2])
