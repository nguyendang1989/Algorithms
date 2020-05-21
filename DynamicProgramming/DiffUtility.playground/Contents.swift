/*
 The diff utility is a data comparison tool that calculates and displays the differences
 between 2 text. It tries to determine the smallest set of deletions and insertions to
 create text from one to another. Diff is line oriented rather than character oriented,
 unlike Edit Distance
 
 Example :
 string1: XMJYAUZ
 string2: XMJAATZ
 
 result: X M J -Y A -U +A +T Z
 Explains: transfom string1 to string 2 need to delete Y, U and insert A, T
 
 We can solve this problem using Longest Common Subsequence, loop over the look-up table
 and find the deletions and insertion
 */

func LCS(_ string1: String, _ string2: String) -> [[Int]] {
    let m = string1.count
    let n = string2.count
    var lookup = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    var string1 = Array(string1)
    var string2 = Array(string2)
    for i in 1...m {
        for j in 1...n {
            if string1[i-1] == string2[j-1] {
                lookup[i][j] = lookup[i-1][j-1] + 1
            } else {
                lookup[i][j] = max(lookup[i-1][j], lookup[i][j-1])
            }
        }
    }
    
    return lookup
}

var result = ""
func diffUtility(_ string1: [Character], _ string2: [Character], _ lookup: [[Int]], _ i: Int, _ j: Int) {
    
    if i > 0, j > 0, string1[i-1] == string2[j-1] {
        diffUtility(string1, string2, lookup, i-1, j-1)
        result += " " + String(string1[i-1])
    }
    
    //available in string1 but not available in string2
    else if i > 0, (j == 0 || lookup[i-1][j] > lookup[i][j-1]) {
        diffUtility(string1, string2, lookup, i-1, j)
        result += " -" + String(string1[i-1])
    }
    //available in string2 but not available in string1
    else if j > 0, (i == 0 || lookup[i-1][j] <= lookup[i][j-1]) {
        diffUtility(string1, string2, lookup, i, j-1)
        result += " +" + String(string2[j-1])
    }
}

let string1 = "horse"
let string2 = "rose"
let lookup = LCS(string1, string2)
diffUtility(Array(string1), Array(string2), lookup, string1.count, string2.count)
print(result)
