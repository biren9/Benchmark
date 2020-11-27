//
//  BenchmarkServiceProtocol.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation

protocol BenchmarkServiceProtocol {
    var description: String { get }
    var duration: TimeInterval { get }
    
    func calculate()
    func generateScore(numberOfCalculations: Int) -> Int
}
