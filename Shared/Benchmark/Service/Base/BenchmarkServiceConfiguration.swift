//
//  BenchmarkServiceConfiguration.swift
//  Benchmark
//
//  Created by Gil Biren on 27.11.20.
//

import Foundation

struct BenchmarkConfiguration: BenchmarkServiceConfigurationProtocol {
    let serviceType: BenchmarkServiceProtocol.Type
    let description: String
    let cpuCoreRunType: CpuCoreRunType
    let duration: TimeInterval
    
    init(cpuCoreRunType: CpuCoreRunType, duration: TimeInterval, description: String, serviceType: BenchmarkServiceProtocol.Type) {
        self.cpuCoreRunType = cpuCoreRunType
        self.duration = duration
        self.description = description
        self.serviceType = serviceType
    }
}
