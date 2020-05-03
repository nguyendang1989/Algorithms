import UIKit

/*Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that at least one duplicate number must exist. Assume that there is only one duplicate number, find the duplicate one.
 
 Example 1:
 
 Input: [1,3,4,2,2]
 Output: 2
 Example 2:
 
 Input: [3,1,3,4,2]
 Output: 3
 */

/*Instuition
 - Pigeonhole Principle : there is n + 1 pigeons put inside n cage, it must have a cage with 2 pigeons -> n + 1 number from 1...n put into an array with n slots, so it must have 2 number duplicated
 - If consider every value a[i] - 1 an pointer to next index, there is an circle inside the array at least
 - Using Floyd's Toitoise and Hare Algorithm
 */
func findDuplicatedNumber(_ arr: [Int]) -> Int {
    guard arr.count > 1 else {
        fatalError("Input is invalid")
    }
    
    var tortoise = arr[0]
    var hare = arr[0]
    
    repeat {
        tortoise = arr[tortoise]
        hare = arr[arr[hare]]
    } while tortoise != hare
}
