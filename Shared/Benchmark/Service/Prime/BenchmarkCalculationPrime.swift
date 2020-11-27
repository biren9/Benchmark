//
//  BenchmarkCalculationPrime.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation

final class BenchmarkConfigurationPrime: BenchmarkServiceConfigurationProtocol {
    var serviceType: BenchmarkServiceProtocol.Type { BenchmarkCalculationPrime.self }
    var cpuCoreRunType: CpuCoreRunType { .multiCore }
    var duration: TimeInterval { 20 }
    var description: String { "Prime multiCore" }
}

final class BenchmarkCalculationPrime: BenchmarkService {
    
    override func calculate() {
        calculatePrime()
        super.calculate()
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
        return true;
    }
}



final class BenchmarkConfigurationPrime2: BenchmarkServiceConfigurationProtocol {
    var serviceType: BenchmarkServiceProtocol.Type { BenchmarkCalculationPrime2.self }
    var cpuCoreRunType: CpuCoreRunType { .singleCore }
    var duration: TimeInterval { 20 }
    var description: String { "Prime singleCore" }
}

final class BenchmarkCalculationPrime2: BenchmarkService {
    
    override func calculate() {
        calculatePrime()
        super.calculate()
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
        return true;
    }
}
