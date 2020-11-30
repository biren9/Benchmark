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
    private let messageData = String.random(length: 5000).data(using: .utf8)!
    
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

private extension String {
    static func random(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.;-£¶¨èà$üö§¢+*ç%&/()=🤯🙈🥸 "
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
