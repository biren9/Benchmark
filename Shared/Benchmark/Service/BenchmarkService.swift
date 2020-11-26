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
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var numberOfCalculations: Int?
    
    private let duration: TimeInterval
    private var startDate: Date?
    private var timer: Timer?
    
    private let feedbackQueue = DispatchQueue(label: "\(BenchmarkService.self)-feedbackQueue")
    private var operationQueue: OperationQueue?
    
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func run() {
        numberOfCalculations = 0
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            guard let startDate = self.startDate else { return }
            let elapsedTimeInterval = abs(startDate.timeIntervalSinceNow)
            self.progress = elapsedTimeInterval / self.duration
            if elapsedTimeInterval > self.duration {
                self.operationQueue?.cancelAllOperations()
                self.stopOperations(progress: 1)
            }
        })
        startOperations()
    }
    
    func stop() {
        stopOperations(progress: 0)
        numberOfCalculations = nil
    }
    
    private func markAsComplete() {
        guard operationQueue != nil else { return }
        feedbackQueue.async { [weak self] in
            guard let self = self else { return }
            guard self.operationQueue != nil else { return }
            DispatchQueue.main.async {
                guard self.operationQueue != nil, let numberOfCalculations = self.numberOfCalculations else { return }
                self.numberOfCalculations = numberOfCalculations+1
            }
        }
    }
    
    private func calculation() {
        BenchmarkCalculationPrime.calculate()
        markAsComplete()
        if let queue = operationQueue {
            addOperation(to: queue)
        }
    }
    
    private func generateOperations() {
        let queue = OperationQueue()
        for _ in 1...ProcessInfo.processInfo.processorCount {
            addOperation(to: queue)
        }
        operationQueue = queue
    }
    
    private func addOperation(to queue: OperationQueue) {
        queue.addOperation(calculation)
    }
    
    private func startOperations() {
        generateOperations()
        isRunning = true
        progress = 0
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
