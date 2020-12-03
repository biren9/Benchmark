//
//  AppConfig.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import Foundation
import BenchmarkWrapper

protocol Listable {
    var name: String { get }
}

enum AvailableAlgortihm: CaseIterable, Identifiable, Listable {
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
    
    var name: String {
        algortihm.name
    }
}

extension CpuCoreRunType: Identifiable, Listable {
    public var id: UUID { UUID() }
    
    static var allCases: [CpuCoreRunType] {
        [.singleCore, .multiCore]
    }
    
    var name: String {
        switch self {
        case .singleCore:
            return "SingleCore"
        case .multiCore:
            return "MultiCore"
        case .custom(let cores):
            return "\(cores) Cores"
        }
    }
}

extension QualityOfService: Identifiable, Listable {
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
