/*Give 2 String as an input. Print all longest subsequences that exist in 2 strings*/

func LCSTable(_ string1: String, _ string2: String) -> [[Int]] {
    let arr1 = Array(string1)
    let arr2 = Array(string2)
    let m = arr1.count
    let n = arr2.count
    var result = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    for i in 1...m {
        for j in 1...n {
            if arr1[i-1] == arr2[j-1] {
                result[i][j] = result[i-1][j-1] + 1
            } else {
                result[i][j] = max(result[i-1][j], result[i][j-1])
            }
        }
    }
    return result
}

/*
 Algorithm: Greedy
 Time complexity : O(m+n)
 Space complexity: O(m+n) if we count the variable space, if we dont space complexity is O(k*n)
 with k is number of result
 */
func findSubsequences(_ arr1: [Character], _ arr2: [Character], _ table: [[Int]], _ i: Int, _ j: Int, _ result: inout [String], _ candidate: String) {
    guard i > 0, j > 0 else {
        result.append(candidate)
        return
    }
    
    if arr1[i-1] == arr2[j-1] {
        let temp = String(arr1[i-1]) + candidate
        findSubsequences(arr1, arr2, table, i-1, j-1, &result, temp)
    } else {
        if table[i-1][j] > table[i][j-1] {
            findSubsequences(arr1, arr2, table, i-1, j, &result, candidate)
        } else if table[i][j-1] > table[i-1][j] {
            findSubsequences(arr1, arr2, table, i, j-1, &result, candidate)
        } else {
            findSubsequences(arr1, arr2, table, i-1, j, &result, candidate)
            findSubsequences(arr1, arr2, table, i, j-1, &result, candidate)
        }
    }
}

func LCSAllSubsequences(_ string1: String, _ string2: String) -> [String] {
    guard string1.count > 0, string2.count > 0 else {
        return []
    }
    let board = LCSTable(string1, string2)
    var result = [String]()
    findSubsequences(Array(string1), Array(string2), board, string1.count, string2.count, &result, "")
    return result
}

print(LCSAllSubsequences("BDCABA", "ABCBDAB"))
