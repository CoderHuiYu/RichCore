//
//  NumberExtension.swift
//  MMNotes
//
//  Created by yb on 2022/3/29.
//

import Foundation

extension Int {
    // 28KB
    var sizeDescription: String {
        if self < 1024 {
            return "\(self)B"
        } else if self < 1024*1024 {
            return String(format: "%.2fKB", Double(self) / 1024)
        } else if self < 1024*1024*1024 {
            return String(format: "%.2fMB", Double(self) / 1024 / 1024)
        } else if self < 1024*1024*1024*1024 {
            return String(format: "%.2fGB", Double(self) / 1024 / 1024 / 1024)
        } else {
            return String(format: "%.2fTB", Double(self) / 1024 / 1024 / 1024 / 1024)
        }
    }
    // 28 KB
    var sizeDescriptionWithSapce: String {
        if self < 1024 {
            return "\(self)B"
        } else if self < 1024*1024 {
            return String(format: "%.2f KB", Double(self) / 1024)
        } else if self < 1024*1024*1024 {
            return String(format: "%.2f MB", Double(self) / 1024 / 1024)
        } else if self < 1024*1024*1024*1024 {
            return String(format: "%.2f GB", Double(self) / 1024 / 1024 / 1024)
        } else {
            return String(format: "%.2f TB", Double(self) / 1024 / 1024 / 1024 / 1024)
        }
    }
}
