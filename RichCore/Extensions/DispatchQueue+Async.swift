//
//  DispatchQueue+Async.swift
//  MMNotes
//
//  Created by yb on 2022/2/10
//  
//
       

import Foundation

extension DispatchQueue {
    func asyncAsync<T>(_ work: @escaping () ->T) async -> T {
        return await withCheckedContinuation { ct in
            self.async {
                ct.resume(returning: work())
            }
        }
    }
}
