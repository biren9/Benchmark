//
//  ConfigurationView.swift
//  Benchmark (macOS)
//
//  Created by Gil Biren on 01.12.20.
//

import SwiftUI
import BenchmarkWrapper

struct ConfigurationView: View {
    @Binding private(set) var isPresented: Bool
    @Binding private(set) var cpuCoreRunType: CpuCoreRunType
    @Binding private(set) var algortihm: AvailableAlgortihm
    @Binding private(set) var qualityOfService: QualityOfService
    @Binding private(set) var duration: TimeInterval
    @Binding private(set) var isStressTest: Bool
    private(set) var onDone: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: nil) {
            Label("Configuration", systemImage: "gear")
                .font(.title)
            
            VStack {
                Picker(selection: $algortihm, label: Text("Algorithm")) {
                    ForEach(AvailableAlgortihm.allCases, id: \.self) {
                        Text($0.algortihm.name)
                    }
                }
                
                Picker(selection: $qualityOfService, label: Text("Quality of service")) {
                    ForEach(QualityOfService.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                
                Picker(selection: $cpuCoreRunType, label: Text("CPU")) {
                    ForEach(CpuCoreRunType.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                
                VStack(alignment: .leading, spacing: nil) {
                    Text("Duration: \(FormatterHelper.formatteDuration(duration))")
                    HStack {
                            Slider(value: $duration, in: 5...60, step: 5)
                                .disabled(isStressTest)
                        Toggle(isOn: $isStressTest) {
                            Text("Stress Test")
                        }
                    }
                }
            }
            
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
            cpuCoreRunType: .constant(.multiCore),
            algortihm: .constant(.aes),
            qualityOfService: .constant(.utility),
            duration: .constant(20),
            isStressTest: .constant(false)
        )
    }
}
#endif
