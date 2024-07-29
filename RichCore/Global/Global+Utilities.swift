// Copyright © 2022 SFCore. All rights reserved.
import UIKit

public func SFWarn(_ message: String) {
    #if !RELEASE
        print(" WARNING: \(message)")
    #endif
}

/// Prints the given message if the application is in debug mode.
public func SFLog(_ format: String, _ arguments: CVarArg...) {
    #if !RELEASE
        print(String(format: format, arguments: arguments))
    #endif
}

/// Prints the given message if the application is in debug mode.
public func SFLog(_ object: Any) {
    SFLog("%@", String(describing: object))
}

/// Prints `object` if the application is in debug mode.
public func SFDump(_ object: Any?) {
    #if !RELEASE
        print(object ?? "nil")
    #endif
}

func printXY(_ any:Any,obj:Any,line:Int) {
    let date = Date()
     let timeFormatter = DateFormatter()
     //日期显示格式，可按自己需求显示
     timeFormatter.dateFormat = "HH:mm:ss.SSS"
     let strNowTime = timeFormatter.string(from: date) as String
     print("\(strNowTime) \(type(of: obj)) \(line)： \(any)")
}

func measure(f: ()->()) {
    let start = CACurrentMediaTime()
    f()
    let end = CACurrentMediaTime()
    print("测量时间：\(end - start)")
}

struct SFViewHierarchy {
    public static func logSubView(by superView: UIView, in level: Int) {
        let subviews = superView.subviews
        if subviews.isEmpty { return }
        
        for subView in subviews {
            var blank = ""
            for _ in 1..<level {
                blank += " "
            }
            logSubView(by: subView, in: level + 1)
        }
    }
}

public func PGWarn(_ message: String) {
    #if !RELEASE
        print(" WARNING: \(message)")
    #endif
}

/// Prints the given message if the application is in debug mode.
public func PGLog(_ format: String, _ arguments: CVarArg...) {
    #if !RELEASE
        print(String(format: format, arguments: arguments))
    #endif
}

/// Prints the given message if the application is in debug mode.
public func PGLog(_ object: Any) {
    PGLog("%@", String(describing: object))
}

/// Prints `object` if the application is in debug mode.
public func PGDump(_ object: Any?) {
    #if !RELEASE
        print(object ?? "nil")
    #endif
}


public enum HorizontalDirection { case left, right }
public enum VerticalDirection { case up, down }
public enum DepthDirection { case forward, backward }

@objc public enum VerticalSide : Int { case top, bottom }


// TODO: Move
public class Global : NSObject {
    @objc public static func unqualifiedClassName(_ type: AnyClass) -> String {
        return String(describing: type) // Not the same as NSStringFromClass(…), which returns the fully-qualified name.
    }
}
