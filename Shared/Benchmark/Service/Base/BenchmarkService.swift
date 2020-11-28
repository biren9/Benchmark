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
    
    func increaseScore() {
        semaphore.wait()
        localScore += 1
        semaphore.signal()
    }
    
    func setScore(_ score: Int) {
        semaphore.wait()
        localScore = score
        semaphore.signal()
    }
    
    func generateScore() -> Int {
        semaphore.wait()
        let localScore = self.localScore
        semaphore.signal()
        return localScore
    }
    
    func cancel() { }
    
    func calculate() { }
    
    func isCancelled() -> Bool {
        Thread.current.isCancelled
    }
}