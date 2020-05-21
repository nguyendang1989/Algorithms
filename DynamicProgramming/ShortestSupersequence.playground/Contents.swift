/*Shortest Common Supersequence:
 Give 2 strings, find a shortest string that has string1 and string2 as its subsequences
 
 Example :
 String1 : ABCBDAB
 String2 : BDCABA
 
 Supersequences: ABCBDCABA, ABDCABDAB, ABDCBDABA
 
 if i > 0, j > 0 string1[i-1] == string2[j-1]
    dp[i][j] = dp[i-1][j-1] + 1
 if i > 0 && j == 0 //write down string1[i-1]
    dp[i][j] = dp[i-1][j] + 1
 if j > 0 && i == 0 //write down string2[j-1]
    dp[i][j] = dp[i][j-1] + 1
 if i > 0, j > 0 // pick what ever substring form a shorter string
    dp[i][j] = min(dp[i][j-1], dp[i-1][j]) + 1
 */

func SCS(_ string1: String, _ string2: String) -> Int {
    let m = string1.count
    let n = string2.count
    if m == 0 {
        return n
    }
    if n == 0 {
        return m
    }
    
    let string1 = Array(string1)
    let string2 = Array(string2)
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    for i in 1...m {
        dp[i][0] = dp[i-1][0] + 1
    }
    
    for j in 1...n {
        dp[0][j] = dp[0][j-1] + 1
    }
    
    for i in 1...m {
        for j in 1...n {
            if string1[i-1] == string2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + 1
            }
        }
    }
    
    return dp[m][n]
}

func SCSTable(_ string1: String, _ string2: String) -> [[Int]] {
    let m = string1.count
    let n = string2.count
    
    let string1 = Array(string1)
    let string2 = Array(string2)
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    for i in 1...m {
        dp[i][0] = dp[i-1][0] + 1
    }
    
    for j in 1...n {
        dp[0][j] = dp[0][j-1] + 1
    }
    
    for i in 1...m {
        for j in 1...n {
            if string1[i-1] == string2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + 1
            }
        }
    }
    
    return dp
}

print(SCS("ABCBDAB", "BDCABA"))

var result = [String]()
func printSCS(_ string1: [Character], _ string2: [Character], _ dp: [[Int]], _ i: Int, _ j: Int, _ candidate: String) {
    if i == 0, j == 0 {
        result.append(candidate)
        return
    }
    if i == 0 {
        printSCS(string1, string2, dp, i, j-1, String(string2[j-1]) + candidate)
        return
    }
    if j == 0 {
        printSCS(string1, string2, dp, i-1, j, String(string1[i-1]) + candidate)
        return
    }
    
    if string1[i-1] == string2[j-1] {
        printSCS(string1, string2, dp, i-1, j-1, String(string1[i-1]) + candidate)
    } else {
        if dp[i][j-1] == dp[i-1][j] {
            printSCS(string1, string2, dp, i, j-1, String(string2[j-1]) + candidate)
            printSCS(string1, string2, dp, i-1, j, String(string1[i-1]) + candidate)
        } else if dp[i][j-1] < dp[i-1][j] {
            printSCS(string1, string2, dp, i, j-1, String(string2[j-1]) + candidate)
        } else {
            printSCS(string1, string2, dp, i-1, j, String(string1[i-1]) + candidate)
        }
    }
}

let string1 = "ABCBDAB"
let string2 = "BDCABA"
let lookupTable = SCSTable(string1, string2)
printSCS(Array(string1), Array(string2), lookupTable, string1.count, string2.count, "")
print(result)
