//
//  ConfigurationContentView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 01.12.20.
//

import SwiftUI
import BenchmarkWrapper

struct ConfigurationContentView: View {
    @Binding private(set) var cpuCoreRunType: CpuCoreRunType
    @Binding private(set) var duration: TimeInterval
    @Binding private(set) var algortihm: AvailableAlgortihm
    @Binding private(set) var qualityOfService: QualityOfService
    @Binding private(set) var isStressTest: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Text("Duration: \(FormatterHelper.formatteDuration(duration))")
            HStack {
                    Slider(value: $duration, in: 1...60, step: 1)
                        .disabled(isStressTest)
                Toggle(isOn: $isStressTest) {
                    Text("Stress Test")
                }
            }
        }
    }
}

struct ConfigurationContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationContentView(
            cpuCoreRunType: .constant(.multiCore),
            duration: .constant(20),
            algortihm: .constant(.aes),
            qualityOfService: .constant(.utility),
            isStressTest: .constant(false)
        )
    }
}
