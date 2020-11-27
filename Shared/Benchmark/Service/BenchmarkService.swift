//
//  BenchmarkService.swift
//  Benchmark
//
//  Created by Gil Biren on 25.11.20.
//

import Foundation
import Combine

final class BenchmarkService: ObservableObject {
    @Published private(set) var progress: Double = 0
    @Published private(set) var isRunning = false
    @Published private(set) var score: Int?
    
    private let benchmarkServices: [BenchmarkServiceProtocol]
    private let completeDuration: TimeInterval
    
    private var numberOfCalculations: [Int]
    private var serviceIndex = 0
    private var benchmarkStartDate: Date?
    private var serviceStartDate: Date?
    private var timer: Timer?
    
    private let feedbackQueue = DispatchQueue(label: "\(BenchmarkService.self)-feedbackQueue")
    private var operationQueue: OperationQueue?
    
    
    init(benchmarkServices: [BenchmarkServiceProtocol]) {
        self.benchmarkServices = benchmarkServices
        numberOfCalculations = Array(repeating: 0, count: benchmarkServices.count)
        completeDuration = benchmarkServices.reduce(0, { $0 + $1.duration })
    }
    
    func run() {
        guard completeDuration > 0 else { return }
        score = nil
        isRunning = true
        progress = 0
        benchmarkStartDate = Date()
        serviceStartDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            guard let benchmarkStartDate = self.benchmarkStartDate else { return }
            self.updateTimer(benchmarkStartDate: benchmarkStartDate)
        })
        generateOperations()
    }
    
    func stop() {
        stopOperations(progress: 0)
        score = nil
    }
    
    private func updateTimer(benchmarkStartDate: Date) {
        let elapsedBenchmarkTimeInterval = abs(benchmarkStartDate.timeIntervalSinceNow)
        self.progress = min(elapsedBenchmarkTimeInterval / completeDuration, 1)
        
        let elapsedServiceTimeInterval = abs(serviceStartDate!.timeIntervalSinceNow)
        if elapsedServiceTimeInterval > benchmarkServices[serviceIndex].duration {
            self.operationQueue?.cancelAllOperations()
            if benchmarkServices.count > serviceIndex+1 {
                serviceIndex += 1
                serviceStartDate = Date()
                generateOperations()
            } else {
                var score = 0
                for (index, service) in benchmarkServices.enumerated() {
                    score += service.generateScore(numberOfCalculations: numberOfCalculations[index])
                }
                self.score = score
                self.stopOperations(progress: 1)
            }
        }
    }
    
    private func markAsComplete(index: Int) {
        guard operationQueue != nil else { return }
        feedbackQueue.async { [weak self] in
            guard let self = self else { return }
            guard self.operationQueue != nil else { return }
            self.numberOfCalculations[index] += 1
        }
    }
    
    private func calculation() {
        let serviceIndex = self.serviceIndex
        benchmarkServices[serviceIndex].calculate()
        markAsComplete(index: serviceIndex)
        if let queue = operationQueue {
            addOperation(to: queue)
        }
    }
    
    private func generateOperations() {
        let queue = OperationQueue()
        let processorCount: Int
        switch benchmarkServices[serviceIndex].cpuCoreRunType {
        case .singleCore:
            processorCount = 1
        case .multiCore:
            processorCount = ProcessInfo.processInfo.processorCount
        }
        for _ in 1...processorCount {
            addOperation(to: queue)
        }
        operationQueue = queue
    }
    
    private func addOperation(to queue: OperationQueue) {
        queue.addOperation(calculation)
    }
    
    private func stopOperations(progress: Double) {
        timer?.invalidate()
        timer = nil
        isRunning = false
        operationQueue?.cancelAllOperations()
        operationQueue = nil
        self.progress = progress
    }
}
