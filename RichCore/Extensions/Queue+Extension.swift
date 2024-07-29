//
//  Queue+Extension.swift
//  MMNotes
//
//  Created by JefferyYu on 5.5.22.
//

import Foundation

public struct Queue<T: Codable & Equatable> : Codable {
  
    // 设置队列的存储空间
    private var _capacity: Int?
    public var capacity: Int? {
        didSet {
           _capacity = capacity
        }
    }
    
    public var count: Int { return data.count }
    
    fileprivate var data = [T]()
    
    // 构造方法，用于构建一个空的队列
    public init() {}
    public init(with capacity: Int) {
        self.capacity = capacity
        self._capacity = capacity
    }
    
    // 构造方法，用于从序列中创建队列
    public init<S: Sequence>(_ elements: S) where
        S.Iterator.Element == T {
            data.append(contentsOf: elements)
    }
    
    // 将类型为T的数据元素添加到队列的末尾
    public mutating func enqueue(element: T) {
        guard let capacity = _capacity else { data.append(element); return  }
        if capacity > data.count {
            data.append(element)
        } else {
            dequeue()
            data.append(element)
        }
    }
    
    // 移除并返回队列中第一个元素
    @discardableResult public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    // 返回队列中的第一个元素，但是这个元素不会从队列中删除
    public func peek() -> T? {
        return data.first
    }
    
    public mutating func clear() {
        data.removeAll()
    }
    
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
    
    public func contains(element: T) -> Bool {
        return data.contains { $0 == element }
    }    
}
