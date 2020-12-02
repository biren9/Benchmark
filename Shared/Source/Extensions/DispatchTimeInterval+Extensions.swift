//
//  DispatchTimeINterval+Extensions.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 02.12.20.
//

import Foundation

extension DispatchTimeInterval {
    var seconds: Int {
        switch self {
        case .seconds(let s): return s
        case .milliseconds(let ms): return ms / 1_000
        case .microseconds(let us): return us / 1_000_000
        case .nanoseconds(let ns): return ns / 1_000_000_000
        case .never: return .max
        @unknown default:
            fatalError("@unknown default DispatchTimeInterval")
        }
    }
}
