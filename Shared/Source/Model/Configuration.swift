//
//  Configuration.swift
//  Benchmark
//
//  Created by Gil Biren on 03.12.20.
//

import BenchmarkWrapper
import SwiftUI

class Configuration: ObservableObject {
    @Published var cpuCoreRunType: CpuCoreRunType = .multiCore
    @Published var threadPriority: Double = 1
    @Published var algortihm: AvailableAlgortihm = .aes
    @Published var qualityOfService: QualityOfService = .utility
    @Published var duration: TimeInterval = 5
    @Published var isStressTest: Bool = false
}
