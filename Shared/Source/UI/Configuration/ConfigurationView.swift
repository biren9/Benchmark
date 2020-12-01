//
//  ConfigurationView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import SwiftUI
import BenchmarkWrapper

struct ConfigurationView: View {
    @Binding private(set) var isPresented: Bool
    @Binding private(set) var cpuCoreRunType: CpuCoreRunType
    @Binding private(set) var duration: TimeInterval
    @Binding private(set) var algortihm: AvailableAlgortihm
    @Binding private(set) var qualityOfService: QualityOfService
    @Binding private(set) var isStressTest: Bool
    private(set) var onDone: (() -> Void)?
    
    var body: some View {
        VStack {
            ConfigurationContentView(
                cpuCoreRunType: $cpuCoreRunType,
                duration: $duration,
                algortihm: $algortihm,
                qualityOfService: $qualityOfService,
                isStressTest: $isStressTest
            )
            Button("Done") {
                onDone?()
                isPresented = false
            }
        }
        .padding()
    }
}

#if DEBUG
struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(
            isPresented: .constant(true),
            cpuCoreRunType: .constant(.singleCore),
            duration: .constant(20),
            algortihm: .constant(AvailableAlgortihm.aes),
            qualityOfService: .constant(.default),
            isStressTest: .constant(false)
        )
    }
}
#endif
