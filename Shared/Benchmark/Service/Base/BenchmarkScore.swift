//
//  BenchmarkScore.swift
//  Benchmark
//
//  Created by Gil Biren on 27.11.20.
//

import Foundation

struct BenchmarkScore: Identifiable {
    var id = ObjectIdentifier(BenchmarkScore.self)
    let name: String
    let score: Int
}
