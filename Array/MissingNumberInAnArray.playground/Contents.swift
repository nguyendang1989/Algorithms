import UIKit
/*Given an array C of size N-1 and given that there are numbers from 1 to N with one element missing, the missing number is to be found.
 
 Input:
 The first line of input contains an integer T denoting the number of test cases. For each test case first line contains N(size of array). The subsequent line contains N-1 array elements.
 
 Output:
 Print the missing number in array.
 
 Constraints:
 1 ≤ T ≤ 200
 1 ≤ N ≤ 107
 1 ≤ C[i] ≤ 107
 
 Example:
 Input:
 2
 5
 1 2 3 5
 10
 1 2 3 4 5 6 7 8 10
 
 Output:
 4
 9
 
 Explanation:
 Testcase 1: Given array : 1 2 3 5. Missing element is 4.*/

/* Conclusion:
 - There is ONE missing number -> N-1 numbers are distinct 1...N
 - All the number will be from 1 -> N which can be used as indexes
 - So we can use the conclusion that total(1...N) = N(N+1)/2
 - Missing Number is total(1...N) - sum(array)
 */
func missingNumber(_ arr:[Int]) -> Int {
    let n = arr.count + 1
    return n*(n+1)/2 - arr.reduce(0, +)
}

missingNumber([1,2,3,5])
missingNumber([1,2,3,4,5,6,7,8,10])

//Using OR bitwise

func missingNumber2(_ arr: [Int]) -> Int {
    let n = arr.count
    var X1 = 0, X2 = 0
    
    for num in arr {
        X1 ^= num
    }
    
    for i in 1...(n+1) {
        X2 ^= i
    }
    
    return X1 ^ X2
}

missingNumber2([1,2,3,5])
missingNumber2([1,2,3,4,5,6,7,8,10])
