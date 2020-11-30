//
//  AppConfig.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import Foundation
import BenchmarkWrapper

struct Algortihm: Hashable, Identifiable {
    let id = UUID()
    let type: AvailableAlgortihm
    let name: String
}

enum AvailableAlgortihm {
    case prime
    
    var type: BenchmarkServiceProtocol.Type {
        switch self {
        case .prime:
            return BenchmarkCalculationPrime.self
        }
    }
}


extension CpuCoreRunType: Identifiable {
    public var id: UUID { UUID() }
}

extension QualityOfService: Identifiable {
    public var id: UUID { UUID() }
    
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
        Algortihm(type: .prime, name: "Prime"),
        Algortihm(type: .prime, name: "Prime 2")
    ]
}
