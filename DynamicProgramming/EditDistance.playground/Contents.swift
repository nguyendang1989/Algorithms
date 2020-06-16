/*
 Edit Distance is a way of quantifying how similar two strings are one another by
 counting the minimum number of operation require to transform one string to another
 
 Example:
 kitten -> sitting
 1. replace k by s
 2. replace e by i
 3. insert g in the end
 
 Intuition:
 There are 3 cases:
 1. If A = "" and B = "ABC" or A = "ABC", B = "" -> Just insert every character in B into A. There are n
 steps to insert equal with length of B
 2. If the character at index i of A equal with the character at index j of B. Ex: A = "ACC", B = "BAC"
 it would be the same as EditDistance("AC", "BC") + 1
 3. If the character at index i of A is different with the character at index j of B
 There is 3 ways to transform it:
 - Insert the last character of B into A: A = "ABB", B = "ACC" -> "ABBC" "ACC" == "ABB" "AC"
 - Delete the last character of A "ABB", "ACC" = "AB" "AC"
 - Replace the last character of A by the last character of B: "ABB" "ACC" == "ABC" "ACC" = "AB" "AC" + 1
 */

func editDistance(_ string1: String, _ string2: String) -> Int {
    let m = string1.count
    let n = string2.count
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    let string1 = Array(string1)
    let string2 = Array(string2)
    for i in 0...m {
        dp[i][0] = i
    }
    
    for j in 0...n {
        dp[0][j] = j
    }
    
    for i in 1...m {
        for j in 1...n {
            if string1[i-1] == string2[j-1] {
                dp[i][j] = dp[i-1][j-1]
            } else {
                dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1
            }
        }
    }
    
    return dp[m][n]
}

editDistance("XMJYAUZ", "XMJAATZ")
