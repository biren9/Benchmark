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
    @Binding private(set) var stressTest: Bool
    var onDone: (() -> Void)?
    
    var body: some View {
        VStack {
            Label("Configuration", systemImage: "gear")
                .font(.title)
            
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
            
            HStack {
                VStack(alignment: .leading, spacing: nil, content: {
                    Text("Duration: \(formatteDuration(duration))")
                    Slider(value: $duration, in: 1...60, step: 1)
                        .disabled(stressTest)
                })
                Toggle(isOn: $stressTest) {
                    Text("Stress Test")
                }
            }
            
            Button("Done") {
                onDone?()
                isPresented = false
            }
        }
        .padding()
    }
    
    private func formatteDuration(_ number: Double) -> String {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: number, unit: UnitDuration.seconds)
        return formatter.string(from: measurement)
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
            stressTest: .constant(false)
        )
    }
}
#endif
