//
//  BenchmarkServiceProtocol.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation

enum CpuCoreRunType {
    case singleCore
    case multiCore
}

protocol BenchmarkServiceProtocol {
    var cpuCoreRunType: CpuCoreRunType { get }
    var description: String { get }
    var duration: TimeInterval { get }
    
    func calculate()
    func generateScore(numberOfCalculations: Int) -> Int
}
