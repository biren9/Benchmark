//
//  BenchmarkCalculationPrime.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation
import BenchmarkWrapper

final class BenchmarkCalculationPrime: BenchmarkService {
    
    override func calculate() {
        super.calculate()
        calculatePrime()
        increaseScore()
    }
    
    private func calculatePrime() {
        let to = Int(pow(2.0, 12.0))
        for number in 0...to {
            guard !isCancelled() else { return }
            isPrime(number)
        }
    }
    
    @discardableResult
    private func isPrime(_ n: Int) -> Bool {
        if n <= 1 {
            return false
        }
     
        for divider in 2..<n where n%divider == 0 {
            return false
        }
        return true
    }
}
