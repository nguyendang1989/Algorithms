struct Heap<Element> {
    var elements: [Element]
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var priorityFunction: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool){
        elements = [Element]()
        self.priorityFunction = sort
    }
    
    func isRoot(_ index: Int) -> Bool {
        return index == 0
    }
    
    func leftChildIndex(_ index: Int) -> Int {
        return 2*index + 1
    }
    
    func rightChildIndex(_ index: Int) -> Int {
        return 2 * index + 2
    }
    
    func parentIndex(_ index: Int) -> Int {
        return (index - 1)/2
    }
    
    func isHigherPriority(_ leftIndex: Int, _ rightIndex: Int) -> Bool {
        return priorityFunction(elements[leftIndex], elements[rightIndex])
    }
    
    func higherPriority(_ parentIndex: Int, _ childIndex: Int) -> Int {
        guard childIndex < count, isHigherPriority(childIndex, parentIndex) else {
            return parentIndex
        }
        return childIndex
    }
    
    func highestPriority(_ parentIndex: Int) -> Int {
        return higherPriority(higherPriority(parentIndex, leftChildIndex(parentIndex)), higherPriority(parentIndex, rightChildIndex(parentIndex)))
    }
    
    mutating func heapUp(_ index: Int) {
        let parent = parentIndex(index)
        guard !isRoot(index), isHigherPriority(index, parent) else {
            return
        }
        elements.swapAt(index, parent)
        heapUp(parent)
    }
    
    mutating func heapDown(_ index: Int) {
        let childIndex = highestPriority(index)
        guard childIndex != index else {
            return
        }
        elements.swapAt(childIndex, index)
        heapDown(childIndex)
    }
    
    func peek() -> Element? {
        return elements.first
    }
    
    mutating func poll() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count-1)
        let element = elements.removeLast()
        if !isEmpty {
            heapDown(0)
        }
        
        return element
    }
    
    mutating func add(_ element: Element) {
        elements.append(element)
        heapUp(count-1)
    }
}


let stones = [2,7,4,1,8,1]
var heap = Heap<Int>(sort: <)
for stone in stones {
    heap.add(stone)
}
print(heap.elements)
while heap.count > 1 {
    let first = heap.poll()!
    let second = heap.poll()!
    if first != second {
        // print("first: \(first) second: \(second)")
        heap.add(first - second)
    }
}

let result = heap.isEmpty ? 0 : heap.elements[0]

let a = (nil ?? 0) + 1
