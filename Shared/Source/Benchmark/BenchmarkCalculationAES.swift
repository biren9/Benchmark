//
//  BenchmarkCalculationSha.swift
//  Benchmark
//
//  Created by Gil Biren on 30.11.20.
//

import Foundation
import BenchmarkWrapper
import CryptoKit

final class BenchmarkCalculationAES: BenchmarkService {
    private let key = SymmetricKey(size: .bits256)
    private let messageData = "This is a very secure Message 🧐".data(using: .utf8)!
    
    override func calculate() {
        if decryptEncrypt() {
            increaseScore()
        }
    }
    
    private func decryptEncrypt() -> Bool {
        guard let sealBox = try? AES.GCM.seal(messageData, using: key) else { return false }
        guard let messageData = try? AES.GCM.open(sealBox, using: key) else { return false }
        return self.messageData == messageData
    }
}
