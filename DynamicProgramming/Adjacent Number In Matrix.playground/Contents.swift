/*
 Find longest sequence formed by adjacent number in matrix. Give NxN matrix where
 each cell has distinct value in the 1 to N*N. Find the longest sequence formed by
 adjacent number in matrix such that for each number, the number on the adjacent
 neighbor is +1 its value
 
 This problem could not solve by bottom up because we dont have a clear base case
 
 Another approach that we can solve it using DFS because all elements will be distinct
 so the path will not cross over
 */
func isValid(_ i: Int, _ j: Int, _ m: Int, _ n: Int) -> Bool {
    return i >= 0 && i < m && j >= 0 && j < n
}

var cache = [String : String]()
func findLongestPath(_ A: [[Int]], _ i: Int, _ j: Int) -> String {
    guard A.count > 0 else {
        return ""
    }
    
    let m = A.count
    let n = A[0].count
    if !isValid(i,j,m,n) {
        return ""
    }
    
    let key = String(i) + "|" + String(j)
    if let computedValue = cache[key] {
        return computedValue
    }
    var path = ""
    if i > 0 && A[i-1][j] - A[i][j] == 1 {
        path = findLongestPath(A, i-1, j)
    }
    
    if j > 0 && A[i][j-1] - A[i][j] == 1 {
        path = findLongestPath(A, i, j-1)
    }
    
    if i < m-1 && A[i+1][j] - A[i][j] == 1 {
        path = findLongestPath(A, i+1, j)
    }
    
    if j < n-1 && A[i][j+1] - A[i][j] == 1 {
        path = findLongestPath(A, i, j+1)
    }
    
    if path != "" {
        cache[key] = String(A[i][j]) + "-" + path
    } else {
        cache[key] = String(A[i][j])
    }
    
    return cache[key]!
}

let A = [[10, 13, 14, 21, 23], [11,  9, 22,  2,  3], [12,  8,  1,  5,  4], [15, 24,  7,  6, 20], [16, 17, 18, 19, 25]]
var res = ""
for i in 0..<A.count {
    for j in 0..<A[0].count {
        let path = findLongestPath(A, i, j)
        if path.split(separator: "-").count > res.split(separator: "-").count {
            res = path
        }
    }
}
print(res)
