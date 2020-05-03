import UIKit

/*Given an array of distinct integers. The task is to count all the triplets such that sum of two elements equals the third element.
 
 Input:
 The first line of input contains an integer T denoting the number of test cases. Then T test cases follow. Each test case consists of two lines. First line of each test case contains an Integer N denoting size of array and the second line contains N space separated elements.
 
 Output:
 For each test case, print the count of all triplets, in new line. If no such triplets can form, print "-1".
 
 Constraints:
 1 <= T <= 100
 3 <= N <= 105
 1 <= A[i] <= 106
 
 Example:
 Input:
 2
 4
 1 5 3 2
 3
 3 2 7
 Output:
 2
 -1
 
 Explanation:
 Testcase 1: There are 2 triplets: 1 + 2 = 3 and 3 +2 = 5*/

func findTheTriplet(_ nums: [Int]) -> Int {
    guard nums.count > 2 else {
        fatalError("Array Input is invalid")
    }
    
    var result = 0
    var nums = nums.sorted()
    for i in 2..<nums.count {
        let target = nums[i]
        var hash = Set<Int>()
        for j in 0..<i {
            let desireNumber = target - nums[j]
            if hash.contains(desireNumber) {
                result += 1
            } else {
                hash.insert(nums[j])
            }
        }
    }
    
    return result == 0 ? -1 : result
}

findTheTriplet([1, 5, 3, 2])
findTheTriplet([1, 5, 2])
findTheTriplet([-1,0,1,-2,-1,-3])
