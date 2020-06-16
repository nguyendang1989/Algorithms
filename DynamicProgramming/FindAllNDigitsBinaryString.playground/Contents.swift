/*
 Find All N-digits binary strings without consicutive 1's
 Example :
 N = 5
 00000 00001 00010 00100 00101 ... = total 13 strings
 
 For every i-th digit we have 2 choices
 - Set ith digit as 1 the i-1 'th digit must be 0, count[i] == count[i-2]
 - Unset i-th digit as 0, the count of the string = count[i-1]
 
 count[i] = count[i-1] + count[i-2]. It's just another type of Fibbonaci array
 */

func countString(_ N: Int) -> Int {
    if N == 0 {
        return 1
    }
    if N == 1 {
        return 2
    }
    var select = 1, notSelect = 2
    var result = 0
    for _ in 2...N {
        result = select + notSelect
        select = notSelect
        notSelect = result
    }
    return result
}

countString(5)
2 & 1
