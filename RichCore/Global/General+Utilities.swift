//
//  General+Utilities.swift
//  SFNotes
//
//  Created by JefferyYu on 7.2.22.
//

// Common Closures
public typealias SortingClosure<T> = (T, T) -> Bool
public typealias ActionClosure = () -> Void
public typealias ObjectClosure<Value> = (Value) -> Void
public typealias AsyncActionClosure = () -> Operation<Void>
public typealias FetchClosure<Value> = () -> Operation<Value>
public typealias ValueChangedHandler<Value> = (Value) -> Void
public typealias FormatterClosure<Value> = (Value) -> String
public typealias PredicateClosure<Value> = (Value) -> Bool
public typealias FilterClosure<Value> = PredicateClosure<Value>
public typealias SelectionHandler<Value> = (Value) -> Void
public typealias ObjCCompletionHandler<Value> = (Value?, Error?) -> Void

public protocol AnyOptional {
    static var any_none: Any { get }
}

public var 🔥: Never { preconditionFailure() }

/// Returns `f(x)` if `x` is non-`nil`; otherwise returns `nil`.
@discardableResult public func given<T, U>(_ x: T?, _ f: (T) throws -> U?) rethrows -> U? {
    guard let x = x else { return nil }
    return try f(x)
}

/// Returns `f(x!, y!)` if `x != nil && y != nil`; otherwise returns `nil`.
@discardableResult public func given<T, U, V>(_ x: T?, _ y: U?, _ f: (T, U) throws -> V?) rethrows -> V? {
    guard let x = x, let y = y else { return nil }
    return try f(x, y)
}

public func lazy<T>(_ variable: inout T?, construction: () throws -> T) rethrows -> T {
    if let value = variable {
        return value
    } else {
        let value = try construction()
        variable = value
        return value
    }
}


/// A generic informationless error.
public struct GenericError : Error {
    public init() {}
}

public struct CancelledError : Error {
    public init() {}
}

extension Collection {
    /// Returns `self[index]` if `index` is a valid index, or `nil` otherwise.
    public subscript(ifValid index: Index) -> Iterator.Element? {
        return (index >= startIndex && index < endIndex) ? self[index] : nil
    }

    /// Given the collection contains only exactly one element, returns it; otherwise returns `nil`.
    public var onlyElement: Element? { return count == 1 ? first : nil }

    public var nilIfEmpty: Self? { return isEmpty ? nil : self }
}
