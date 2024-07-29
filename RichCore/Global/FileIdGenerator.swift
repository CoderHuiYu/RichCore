//
//  FileIdGenerator.swift
//  SFNotes
//
//  Created by yb on 2022/6/15.
//

import Foundation

private var idRoundIndex = Int64(0)

/// According timeInterval , get an id
/// - Parameter timeInterval: if  want get an history id, the timeInterver is a negative value, sush as TimeInterval(-1*5*60) ; Otherwise, if  want to  get a future id , giva a positive timeInterval
/// - Returns: get an unique id
func GenerateId(timeInterval: TimeInterval = TimeInterval(0)) -> Int {
    let round = OSAtomicAdd64(1, &idRoundIndex)
    let date = Date(timeInterval: timeInterval, since: Date())
    let id = Int(date.timeIntervalSince1970*100000)*10 + Int(round % 10)
    return id
}
