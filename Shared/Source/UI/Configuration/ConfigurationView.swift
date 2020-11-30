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
    @Binding private(set) var algortihm: Algortihm
    @Binding private(set) var qualityOfService: QualityOfService
    var onDone: (() -> Void)?
    
    var body: some View {
        VStack {
            Label("Configuration", systemImage: "gear")
                .font(.title)
            
            Picker(selection: $algortihm, label: Text("Algorithm")) {
                ForEach(AppConfig.algorithm, id: \.self) {
                    Text($0.name)
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
            
            VStack(alignment: .leading, spacing: nil, content: {
                Spacer(minLength: 30)
                Text("Duration: \(formatteDuration(duration))")
                Slider(value: $duration, in: 0...100)
            })
            Button("Done") {
                onDone?()
                isPresented = false
            }
        }.padding()
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
            algortihm: .constant(AppConfig.algorithm[0]),
            qualityOfService: .constant(.default)
        )
    }
}
#endif
