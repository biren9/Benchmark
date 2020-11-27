//
//  BenchmarkCalculationPrime.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation

final class BenchmarkCalculationPrime: BenchmarkServiceProtocol {
    
    var cpuCoreRunType: CpuCoreRunType { .singleCore }
    
    var duration: TimeInterval { 10 }
    
    var description: String { "Prime" }
    
    func generateScore(numberOfCalculations: Int) -> Int {
        return numberOfCalculations
    }
    
    func calculate() {
        calculatePrime()
    }
    
    private func calculatePrime() {
        let to = Int(pow(2.0, 32.0))
        for number in 0...to {
            _ = isPrime(number)
        }
    }
    
    private func isPrime(_ n: Int) -> Bool {
        if n <= 1 {
            return false
        }
     
        for divider in 2..<n where n%divider == 0 {
            return false
        }
        return true;
    }
}
