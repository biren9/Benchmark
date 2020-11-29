//
//  AppConfig.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import Foundation
import BenchmarkWrapper

struct Algortihm {
    let type: BenchmarkServiceProtocol.Type
    let name: String
}

extension QualityOfService {
    
    static var allCases: [QualityOfService] {
        [.utility, .background, .default, .userInitiated, .userInteractive]
    }
    
    var name: String {
        switch self {
        case .utility:
            return "Utility"
        case .userInteractive:
            return "UserInteractive"
        case .userInitiated:
            return "UserInitiated"
        case .background:
            return "Background"
        case .default:
            return "Default"
        @unknown default:
            return "Unknown"
        }
    }
}

extension CpuCoreRunType {
    static var allCases: [CpuCoreRunType] {
        [.singleCore, .multiCore]
    }
    
    var name: String {
        switch self {
        case .singleCore:
            return "SingleCore"
        case .multiCore:
            return "MultiCore"
        }
    }
}

class AppConfig {
    static let algorithm = [
        Algortihm(type: BenchmarkCalculationPrime.self, name: "Prime"),
        Algortihm(type: BenchmarkCalculationPrime.self, name: "Prime 2")
    ]
}
