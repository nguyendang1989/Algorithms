import UIKit

class Node {
    var val: Int
    var next: Node?
    var random: Node?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
        self.random = nil
    }
}

extension Node: Hashable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher:inout Hasher) {
        hasher.combine(val)
//        hasher.combine(next.hashValue)
//        hasher.combine(random.hashValue)
    }
}

var cache = [Node:Node]()
func cloneNode(_ node: Node?) -> Node? {
    guard let node = node else {
        return nil
    }
    
    if let newNode = cache[node] {
        return newNode
    }
    
    let newNode = Node(node.val)
    cache[node] = newNode
    newNode.next = cloneNode(node.next)
    newNode.random = cloneNode(node.random)
    
    return newNode
}

func copyRandomList(_ head: Node?) -> Node? {
    guard let head = head else {
        return nil
    }
    
    let dummyHead = cloneNode(head)
    
    return dummyHead
}

let node0 = Node(7)
let node1 = Node(13)
let node2 = Node(11)
let node3 = Node(10)
let node4 = Node(1)
node0.next = node1
node1.next = node2
node2.next = node3
node3.next = node4
node1.random = node0
node2.random = node4
node3.random = node2
node4.random = node0

let copy = copyRandomList(node0)
var iter: Node? = node0
var cloneIter: Node? = copy
while iter != nil, cloneIter != nil {
    print(iter == cloneIter)
    iter = iter!.next
    cloneIter = cloneIter!.next
}
