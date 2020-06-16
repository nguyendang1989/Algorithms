/*
 Give an array. Let find maximum value of A[s] - A[r] + A[p] - A[q] where s > r > q > q
 
 Example: [3,9,10,1,30,40]
 
 The result is 46 which 4 numbers : 40 - 1 + 10 - 3
 
 The solution could be solved by 4 loop with O(N^4) time complexity. But we can computed
 with 4 arrays and get time complexity O(n)
 L1: Maximum of A[s]
 L2: Maximum of A[s] - A[r]
 L3: Maximum of A[s] - A[r] + A[p]
 L4: Maximum of A[s] - A[r] + A[p] - A[q]
 */

func findMaximumOf(_ arr: [Int]) -> Int {
    let n = arr.count
    var L1 = Array(repeating: Int.min, count: n + 1)
    var L2 = Array(repeating: Int.min, count: n)
    var L3 = Array(repeating: Int.min, count: n - 1)
    var L4 = Array(repeating: Int.min, count: n - 2)
    
    for i in (0..<n).reversed() {
        L1[i] = max(arr[i], L1[i+1])
    }
    
    // A[s] - A[r]
    for i in (0..<n-1).reversed() {
        L2[i] = max(L1[i+1] - arr[i], L2[i+1])
    }
    
    // A[s] - A[r] + A[p]
    for i in (0..<n-2).reversed() {
        L3[i] = max(L2[i+1] + arr[i], L3[i+1])
    }
    
    // A[s] - A[r] + A[p] - A[q]
    for i in (0..<n-3).reversed() {
        L4[i] = max(L3[i+1] - arr[i], L4[i+1])
    }
    
    return L4[0]
}

findMaximumOf([3,9,10,1,30,40])
