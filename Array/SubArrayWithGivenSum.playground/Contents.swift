import UIKit

/*Given an unsorted array A of size N of non-negative integers, find a continuous sub-array which adds to a given number S.
 
 Input:
 The first line of input contains an integer T denoting the number of test cases. Then T test cases follow. Each test case consists of two lines. The first line of each test case is N and S, where N is the size of array and S is the sum. The second line of each test case contains N space separated integers denoting the array elements.
 
 Output:
 For each testcase, in a new line, print the starting and ending positions(1 indexing) of first such occuring subarray from the left if sum equals to subarray, else print -1.
 
 Constraints:
 1 <= T <= 100
 1 <= N <= 107
 1 <= Ai <= 1010
 
 Example:
 Input:
 2
 5 12
 1 2 3 7 5
 10 15
 1 2 3 4 5 6 7 8 9 10
 Output:
 2 4
 1 5
 
 Explanation :
 Testcase1: sum of elements from 2nd position to 4th position is 12
 Testcase2: sum of elements from 1st position to 5th position is 15*/

func subArrayWithGivenSum(_ nums: [Int], _ sum: Int) -> [Int] {
    guard nums.count > 0 else {
        return []
    }
    
    var hashmap = [Int:Int]()
    var total = 0
    for i in 0..<nums.count {
        total += nums[i]
        if total == sum {
            return [1 ,i + 1]
        }
        
        if let cache = hashmap[total - sum] {
            return [cache + 1, i + 1]
        } else {
            hashmap[total] = i + 1
        }
    }
    
    return []
}

subArrayWithGivenSum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10)

/*Follow Up: Find all of them*/

func findAllSubArrayWithGivenSum(_ nums: [Int], _ sum: Int) -> [[Int]] {
    return []
}
