/*LONGEST REPEATED SUBSEQUENCES:
 - Longest repeated subsequences is a problem to find out sequence that appear at least twice
 
 Example : ATACTCGGA there are 2 subsequences ATCG appear at least twice
 */

/*Recursive:
  if string1[i] == string2[j] && i != j increase result as 1
  else findout the result in [i-1][j] and [i][j-1]
 */

/*From the intuition above we can go straight up with bottom up solution */

func LRS(_ string: String) -> [[Int]] {
    guard string.count > 0 else {
        return [[]]
    }
    
    let string = Array(string)
    var dp = Array(repeating: Array(repeating: 0, count: string.count + 1), count: string.count + 1)
    
    for i in 1...string.count {
        for j in 1...string.count {
            if string[i-1] == string[j-1], i != j {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    return dp
}

func PrintLRS(_ string: String, _ dp:[[Int]], _ i: Int, _ j: Int) -> String {
    guard i > 0, j > 0 else {
        return ""
    }
    let arr = Array(string)
    if arr[i-1] == arr[j-1], i != j {
        return PrintLRS(string, dp, i-1, j-1) + String(arr[i-1])
    } else {
        if dp[i-1][j] > dp[i][j-1] {
            return PrintLRS(string, dp, i-1, j)
        } else {
            return PrintLRS(string, dp, i, j-1)
        }
    }
    
    return ""
}

let dp = LRS("aahaha")
PrintLRS("aahaha", dp, 6, 6)
