import UIKit

/*
 This based on LC question : https://leetcode.com/problems/longest-common-subsequence/
 Given two strings text1 and text2, return the length of their longest common subsequence.
 
 A subsequence of a string is a new string generated from the original string with some characters(can be none) deleted without changing the relative order of the remaining characters. (eg, "ace" is a subsequence of "abcde" while "aec" is not). A common subsequence of two strings is a subsequence that is common to both strings.
 
 
 
 If there is no common subsequence, return 0.
 
 Example 1:
 
 Input: text1 = "abcde", text2 = "ace"
 Output: 3
 Explanation: The longest common subsequence is "ace" and its length is 3.
 Example 2:
 
 Input: text1 = "abc", text2 = "abc"
 Output: 3
 Explanation: The longest common subsequence is "abc" and its length is 3.
 Example 3:
 
 Input: text1 = "abc", text2 = "def"
 Output: 0
 Explanation: There is no such common subsequence, so the result is 0.
 
 */

/*
 APPROACH 1: RECURSIVE
 Intuition : Give 2 text
 text1  *****a
 text2  *****b
 
 If text just have 1 character text1[0] == text2[0] ? 1 : 0
 If last character of text1 is different with last character of text2 -> max(longestCommonSubsequence(text1.removeLast(), text2), longestCommonSubsequence(text1, text2.removeLast()))
 
 if last character of text1 == last character of text2
 longestCommonSubsequence(text1.removeLast(), text2.removeLast()) + 1
 */
func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
    return longestCommonSubsequence(Array(text1), Array(text2), text1.count-1, text2.count-1)
}

func longestCommonSubsequence(_ text1: [Character], _ text2: [Character], _ index1: Int, _ index2: Int) -> Int {
    guard index1 >= 0, index2 >= 0 else {
        return 0
    }
    
    if text1[index1] == text2[index2] {
        return longestCommonSubsequence(text1, text2, index1-1, index2-1) + 1
    }
    
    return max(longestCommonSubsequence(text1, text2, index1-1, index2), longestCommonSubsequence(text1, text2, index1, index2-1))
}

longestCommonSubsequence("abcde", "ace")

/*
 APPROACH 2: Dynamic Programming Top-Down solution
 From the recursive approach we see if we can memorize the result at range [i,j] where i is index1
 and j is index2. we will not need to reprocess it again
 */

func LCS(_ text1: String, _ text2: String) -> Int {
    var memorizer:[[Int?]] = Array(repeating: Array(repeating: nil, count: text2.count+1), count: text1.count+1)
    memorizer[0][0] = 0
    
    return lcsHelper(Array(text1), Array(text2), text1.count, text2.count, &memorizer)
}

func lcsHelper(_ text1: [Character], _ text2: [Character], _ i: Int, _ j: Int, _ dp:inout [[Int?]]) -> Int {
    guard i > 0, j > 0 else {
        if i >= 0, j >= 0 {
            dp[i][j] = 0
        }
        return 0
    }
    
    if let result = dp[i][j] {
        return result
    }
    
    if text1[i-1] == text2[j-1] {
        dp[i][j] = lcsHelper(text1, text2, i-1, j-1, &dp) + 1
    } else {
        dp[i][j] = max(lcsHelper(text1, text2, i-1, j, &dp), lcsHelper(text1, text2, i, j-1, &dp))
    }
    
    return dp[i][j]!
}

LCS("abcde", "ace")

/*
 APPROACH 3: Dynamic Programming Bottom Up
 */

func LCSBottomUp(_ text1: String,_ text2: String) -> Int {
    guard text1.count > 0, text2.count > 0 else {
        return 0
    }
    let text1 = Array(text1)
    let text2 = Array(text2)
    var dp = Array(repeating: Array(repeating: 0,count: text2.count+1), count: text1.count+1)
    
    for i in 1...text1.count {
        for j in 1...text2.count {
            if text1[i-1] == text2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    
    return dp[text1.count][text2.count]
}

LCSBottomUp("abcde", "ace")

/*APPROACH 4: Bottom Up with space optimization
 As we have seen in approach 3: we just need all collumns of previous row to compute the next row
 So we can save a lot of space with this optimization :
 */

func LCSOptimization(_ string1: String, _ string2: String) -> Int {
    guard string1.count > 0, string2.count > 0 else {
        return 0
    }
    let string1 = Array(string1)
    let string2 = Array(string2)
    let m = string1.count
    let n = string2.count
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: 2)
    var bi = 0
    
    for i in 0...m {
        bi = i & 1
        for j in 0...n {
            if i == 0 || j == 0 {
                dp[bi][j] = 0
            } else if string1[i-1] == string2[j-1] {
                dp[bi][j] = dp[1-bi][j-1] + 1
            } else {
                dp[bi][j] = max(dp[bi][j-1], dp[1-bi][j])
            }
        }
    }
    
    return dp[bi][n]
}

LCSOptimization("ABCBDAB", "BDCABA")
