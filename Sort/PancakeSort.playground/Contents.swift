import Foundation

func flip(_ arr: [Int], _ k: Int) -> [Int] {
    guard arr.count > 1 else {
        return arr
    }
    var arr = arr
    var left = 0
    var right = k-1
    
    while left < right {
        let temp = arr[right]
        arr[right] = arr[left]
        arr[left] = temp
        left += 1
        right -= 1
    }
    
    return arr
}

func pancakeSort(arr: [Int]) -> [Int] {
    guard arr.count > 1 else {
        return arr
    }
    
    let minNumber = arr.min()!
    let index = arr.firstIndex(of: minNumber)!
    var subArray : [Int]
    var result = [Int]()
    if index == 0 {
        subArray = Array(arr[1..<arr.count])
    } else {
        let array = flip(arr, index+1)
        subArray = Array(array[1..<arr.count])
    }
    
    result = [minNumber] + pancakeSort(arr: subArray)
    
    return result
}
pancakeSort(arr: [5,4,1,3,2])

print("a" < "b")
