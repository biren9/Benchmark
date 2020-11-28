//
//  BenchmarkServiceConfiguration.swift
//  Benchmark
//
//  Created by Gil Biren on 27.11.20.
//

import Foundation

struct BenchmarkConfiguration: BenchmarkServiceConfigurationProtocol {
    let qualityOfService: QualityOfService
    let serviceType: BenchmarkServiceProtocol.Type
    let description: String
    let cpuCoreRunType: CpuCoreRunType
    let duration: TimeInterval
    
    init(cpuCoreRunType: CpuCoreRunType, duration: TimeInterval, description: String, serviceType: BenchmarkServiceProtocol.Type, qualityOfService: QualityOfService) {
        self.cpuCoreRunType = cpuCoreRunType
        self.duration = duration
        self.description = description
        self.serviceType = serviceType
        self.qualityOfService = qualityOfService
    }
}