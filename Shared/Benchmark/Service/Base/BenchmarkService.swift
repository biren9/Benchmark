//
//  BenchmarkService.swift
//  Benchmark
//
//  Created by Gil Biren on 27.11.20.
//

import Foundation

class BenchmarkService: BenchmarkServiceProtocol {
    private let semaphore = DispatchSemaphore(value: 1)
    private var localScore = 0
    
    required init() { }
    
    func generateScore() -> Int {
        semaphore.wait()
        let localScore = self.localScore
        semaphore.signal()
        return localScore
    }
    
    func cancel() { }
    
    func calculate() {
        semaphore.wait()
        localScore += 1
        semaphore.signal()
    }
    
    func isCancelled() -> Bool {
        Thread.current.isCancelled
    }
}
