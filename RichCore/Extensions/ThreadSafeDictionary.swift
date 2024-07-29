//
//  ThreadSafeDictionary.swift
//  MMNotes
//
//  Created by JefferyYu on 9.3.22.
//

import Foundation

class TheadSafeDictionary<K: Hashable,V>: Collection {
    
    private var dictionary: [K: V]
    private let lock = NSLock()
    
    init(dict: [K: V] = [K: V]()) {
        self.dictionary = dict
    }
    
    subscript(key: K) -> V? {
        get {
            lock.lock()
            defer { lock.unlock() }
            return dictionary[key]
        }
        
        set {
            lock.lock()
            defer { lock.unlock() }
            dictionary[key] = newValue
        }
    }
    
    // Collection
    func index(after i: Dictionary<K, V>.Index) -> Dictionary<K, V>.Index {
        lock.unlock()
        defer { lock.unlock() }
        return dictionary.index(after: i)
    }
    
    var startIndex: Dictionary<K, V>.Index {
        lock.lock()
        defer { lock.unlock() }
        return dictionary.startIndex
    }
    
    var endIndex: Dictionary<K, V>.Index {
        lock.lock()
        defer { lock.unlock() }
        return dictionary.endIndex
    }
    
    @discardableResult
    func removeValue(forKey key: K) -> V? {
        lock.lock()
        defer { lock.unlock() }
        return dictionary.removeValue(forKey: key)
    }
    
    subscript(index: Dictionary<K, V>.Index) -> Dictionary<K, V>.Element {
        lock.lock()
        defer { lock.unlock() }
        return dictionary[index]
    }
    
    func allKeys() -> Dictionary<K, V>.Keys {
        lock.lock()
        defer { lock.unlock() }
        return dictionary.keys
    }
    
    func allValues() -> Dictionary<K, V>.Values {
        lock.lock()
        defer { lock.unlock() }
        return dictionary.values
    }
    
    func removeAll() {
        lock.lock()
        defer { lock.unlock() }
        return dictionary.removeAll()
    }
}
