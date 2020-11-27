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

protocol BenchmarkServiceProtocol: class {
    init()
    
    func cancel()
    func calculate()
    func generateScore() -> Int
}

protocol BenchmarkServiceConfigurationProtocol {
    var cpuCoreRunType: CpuCoreRunType { get }
    var description: String { get }
    var duration: TimeInterval { get }
    var serviceType: BenchmarkServiceProtocol.Type { get }
}
