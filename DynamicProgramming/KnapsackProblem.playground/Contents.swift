/* KNAPSACK PROBLEM:
 - We are given a set of items, each with a weight and a value we need to determine
 the number of each item to include a collection so that the total weight is less than
 or equal a given limit and the total value is large as possible
 
 Examples:
 Input:
 value: [20,5,10,40,15,25]
 weight = [1,2,3,8,7,4]
 limit: 10
 
 Output:
 value = 20 + 40 = 60
 weight = 1 + 8 = 9
 */

/* APPROACH 1: RECURSIVE
 For each item with value and weight we have 2 choices
 - Include that item into the result, continue looking for the remains item with weight W - w[i]
 - Exclude that item, call recursive with the remain item
 */

func knapsackRecursive(_ value: [Int], _ w: [Int], _ limit: Int, _ i: Int) -> Int {
    guard limit >= 0 else {
        return Int.min
    }
    
    if limit == 0 || i < 0 {
        return 0
    }
    
    let include = value[i] + knapsackRecursive(value, w, limit - w[i], i-1)
    let exclude = knapsackRecursive(value, w, limit, i-1)
    return max(include, exclude)
}
let value = [20,5,10,40,15,25]
let weight = [1,2,3,8,7,4]
let limit = 10

print(knapsackRecursive(value, weight, limit, value.count-1))

/*APPROACH 2: DYNAMIC PROGRAMMING TOP DOWN
 - cache if with every index/weight we went through
 */
var cache = [String: Int]()
func knapsackTopDownDP(_ value: [Int], _ w: [Int], _ limit: Int, _ i: Int) -> Int {
    guard limit >= 0 else {
        return Int.min
    }
    
    if limit == 0 || i < 0 {
        return 0
    }
    
    let key = String(i) + "|" + String(limit)
    
    if let computed = cache[key] {
        return computed
    }
    
    let include = value[i] + knapsackRecursive(value, w, limit - w[i], i-1)
    let exclude = knapsackRecursive(value, w, limit, i-1)
    let result = max(include, exclude)
    cache[key] = result
    return result
}

print(knapsackTopDownDP(value, weight, limit, value.count-1))

/*APPROACH 3: DYNAMIC PROGRAMMING BOTTOM UP*/

func knapsackBottomUpDP(_ v: [Int], _ w: [Int], _ limit: Int) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: w.count + 1), count: limit + 1)
    
    for i in 1...limit {
        for j in 1...w.count {
            if i - w[j-1] < 0 {
                dp[i][j] = dp[i][j-1] // dp[i][j-1] means select with n-1 items left with same limit
            } else {
                dp[i][j] = max(v[j-1] + dp[i-w[j-1]][j-1], dp[i][j-1])
            }
        }
    }
    
    return dp[limit][w.count]
}

print(knapsackBottomUpDP(value, weight, limit))
