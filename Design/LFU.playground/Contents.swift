class Node {
    var key: Int
    var val: Int
    var fre: Int
    var prev: Node?
    var next: Node?
    
    init(_ key: Int, _ value: Int) {
        self.key = key
        self.val = value
        self.fre = 1
        self.prev = nil
        self.next = nil
    }
}

class DoubleLinkedList {
    let head: Node
    let tail: Node
    var count: Int
    let frequency: Int
    init(_ frequency: Int) {
        head = Node(0,0)
        tail = Node(0,0)
        head.next = tail
        tail.prev = head
        count = 0
        self.frequency = frequency
    }
    
    func addNode(_ node: Node) {
        node.next = head.next
        head.next?.prev = node
        node.prev = head
        head.next = node
        count += 1
    }
    
    func removeNode(_ node: Node) -> Node? {
        guard count > 0, node.fre == self.frequency else {
            return nil
        }
        
        let nextNode = node.next!
        let prevNode = node.prev!
        nextNode.prev = prevNode
        prevNode.next = nextNode
        node.next = nil
        node.prev = nil
        count -= 1
        
        return node
    }
    
    func removeLast() -> Node? {
        return removeNode(tail.prev!)
    }
}

class LFUCache {
    var cache: [Int: Node]
    var frequency: [Int: DoubleLinkedList]
    var size: Int
    var minimum: Int
    let capacity: Int
    init(_ capacity: Int) {
        self.capacity = capacity
        minimum = 1
        size = 0
        cache = [Int: Node]()
        frequency = [Int: DoubleLinkedList]()
    }
    
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            return -1
        }
        
        updateNode(node, false)
        return node.val
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            // update value and fre
            node.val = value
            updateNode(node, false)
        } else {
            let newNode = Node(key, value)
            if size == capacity {
                removeLFU()
            }
            updateNode(newNode, true)
        }
    }
    
    func updateNode(_ node: Node, _ isNewNode: Bool) {
        // update cache and frequency, minimum
        if isNewNode {
            frequency[1] = frequency[1, default: DoubleLinkedList(1)]
            cache[node.key] = node
            frequency[1]!.addNode(node)
            minimum = 1
            size += 1
        } else {
            let freq = node.fre
            if let _ = frequency[freq]!.removeNode(node) {
                frequency[freq+1] = frequency[freq+1, default: DoubleLinkedList(freq+1)]
                frequency[freq+1]!.addNode(node)
                node.fre += 1
                if frequency[freq]!.count == 0 {
                    minimum += 1
                }
            }
        }
    }
    
    func removeLFU() {
        if let freqList = frequency[minimum] {
            if let node = freqList.removeLast() {
                print("remove \(node.key) at freq \(minimum)")
                size -= 1
                cache[node.key] = nil
                if freqList.count == 0 {
                    minimum += 1
                }
            }
        }
    }
}

let lfu = LFUCache(2)
lfu.put(1,1)
lfu.put(2,2)
lfu.get(1)
lfu.put(3,3)
lfu.get(2)
lfu.get(3)
lfu.put(4,4)
lfu.get(1)
lfu.get(3)
lfu.get(4)
