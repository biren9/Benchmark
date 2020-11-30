//
//  AppConfig.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import Foundation
import BenchmarkWrapper

enum AvailableAlgortihm: CaseIterable, Identifiable {
    case prime
    case aes
    
    public var id: UUID { UUID() }
    
    var algortihm: Algortihm {
        switch self {
        case .prime:
            return Algortihm(name: "Prime numbers from 0 to 2^12", type: BenchmarkCalculationPrime.self)
        case .aes:
            return Algortihm(name: "AES encrypt / decrypt", type: BenchmarkCalculationAES.self)
        }
    }
}

extension CpuCoreRunType: Identifiable {
    public var id: UUID { UUID() }
}

extension QualityOfService: Identifiable {
    public var id: UUID { UUID() }
    
    static var allCases: [QualityOfService] {
        [.default, .background, .utility, .userInitiated, .userInteractive]
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
        AvailableAlgortihm.prime.algortihm
    ]
}
