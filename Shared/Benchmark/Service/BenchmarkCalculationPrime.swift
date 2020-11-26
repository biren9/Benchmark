//
//  BenchmarkCalculationPrime.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation

final class BenchmarkCalculationPrime: BenchmarkCalculation {
    
    static func calculate() {
        calculatePrime()
    }
    
    private static func calculatePrime() {
        let to = Int(pow(2.0, 12.0))
        for number in 0...to {
            _ = isPrime(number)
        }
    }
    
    private static func isPrime(_ n: Int) -> Bool {
        if n <= 1 {
            return false
        }
     
        for divider in 2..<n where n%divider == 0{
            return false
        }
        return true;
    }
}
