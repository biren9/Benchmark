//
//  ListElement.swift
//  Benchmark
//
//  Created by Gil Biren on 03.12.20.
//

import Foundation

protocol UIRepresentable {
    var title: String { get }
    var imageName: String { get }
}


enum ListElement: Identifiable, CaseIterable, UIRepresentable {
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
            return "Quality of service"
        }
    }
    
    var imageName: String {
        switch self {
        case .algortihm:
            return "skew"
        case .cpuCoreRunType:
            return "cpu"
        case .qualityOfService:
            return "speedometer"
        }
    }
}
