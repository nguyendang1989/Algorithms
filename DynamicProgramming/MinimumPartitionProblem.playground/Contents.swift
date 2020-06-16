/*
 Mininmum Partition Problem:
 Given a set of positive integer S, partition the set into 2 sets such that the
 different between 2 set is minimum
 
 Example:
 [10,20,15,5,25] -> 5
 [10,20] -> 10
 
 Intuition:
 
 This is a subproblem of Subset Sum problem.
 - We include the current item in S1
 - We include the current item in S2
 - compare the minimum problem
 */

func minimumPartition(_ arr: [Int], _ i: Int, _ s1: Int, _ s2: Int, _ cache:inout [String: Int]) -> Int {
    if i < 0 {
        return abs(s1 - s2)
    }
    
    let key = String(i) + "|" + String(s1)
    if let res = cache[key] {
        return res
    }
    
    let sum1 = minimumPartition(arr, i-1, s1 + arr[i], s2, &cache)
    let sum2 = minimumPartition(arr, i-1, s1, s2 + arr[i], &cache)
    let minimum = min(sum1,sum2)
    cache[key] = minimum
    return minimum
}

var cache = [String: Int]()
let input = [10,20,15,5,25]
minimumPartition(input, input.count - 1, 0, 0, &cache)
