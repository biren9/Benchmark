//
//  ListElement.swift
//  Benchmark
//
//  Created by Gil Biren on 03.12.20.
//

import Foundation

enum ListElement: Identifiable, CaseIterable {
    case cpuCoreRunType
    case algortihm
    case qualityOfService
    
    var id: UUID { UUID() }
    
    var title: String {
        switch self {
        case .algortihm:
            return "Algorithm"
        case .cpuCoreRunType:
            return "CPU"
        case .qualityOfService:
            return "QualityOfService"
        }
    }
}
