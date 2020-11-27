//
//  BenchmarkScore.swift
//  Benchmark
//
//  Created by Gil Biren on 27.11.20.
//

import Foundation

struct BenchmarkScore: Identifiable {
    var id: String { UUID().uuidString }
    let name: String
    let score: Int
}
