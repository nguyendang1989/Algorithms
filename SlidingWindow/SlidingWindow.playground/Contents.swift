import UIKit

func segment(_ x:Int, _ spaces: [Int]) -> Int {
    let n = spaces.count
    guard x * n != 0 else {
        return 0
    }
    
    var minLeft = Array(repeating: 0, count: n)
    var minRight = Array(repeating: 0, count: n)
    minLeft[0] = spaces[0]
    minRight[n-1] = spaces[n-1]
    
    for i in 1..<n {
        if i % x == 0 {
            minLeft[i] = spaces[i]
        } else {
            minLeft[i] = min(spaces[i], minLeft[i-1])
        }
        
        let j = n-1-i
        if (j+1) == 0 {
            minRight[j] = spaces[j]
        } else {
            minRight[j] = min(spaces[j], minRight[j+1])
        }
    }
    
    var result = Int.min
    for i in 0...(n-x) {
        let currentMin = min(minRight[i], minLeft[i+x-1])
        result = max(result, currentMin)
    }
    
    return result
}

segment(3, [1,3,-1,-3,5,3,6,7])
