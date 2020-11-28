//
//  AppConfig.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import Foundation
import BenchmarkWrapper

class AppConfig {
    static let a = BenchmarkServiceWrapper(
        benchmarkServiceConfigurations: [
            BenchmarkConfiguration(
                cpuCoreRunType: .singleCore,
                duration: 20,
                description: "Prime numbers singleCore",
                serviceType: BenchmarkCalculationPrime.self,
                qualityOfService: .userInitiated
            ),
            BenchmarkConfiguration(
                cpuCoreRunType: .multiCore,
                duration: 20,
                description: "Prime numbers multiCore",
                serviceType: BenchmarkCalculationPrime.self,
                qualityOfService: .userInitiated
            ),
            BenchmarkConfiguration(
                cpuCoreRunType: .singleCore,
                duration: 20,
                description: "Prime number n",
                serviceType: BenchmarkCalculationPrime2.self,
                qualityOfService: .userInitiated
            )
        ]
    )
}
