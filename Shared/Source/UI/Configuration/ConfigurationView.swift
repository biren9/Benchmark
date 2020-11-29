//
//  ConfigurationView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import SwiftUI
import BenchmarkWrapper

struct ConfigurationView: View {
    @Binding var isPresented: Bool
    @State var sliderValue: Double = 20
    @State var selectedAlgorithm: Int = 0
    @State var selectedQualityOfService: Int = 0
    @State var selectedCpuRunType: Int = 0
    
    var body: some View {
        VStack {
            Label("Configuration", systemImage: "gear")
                .font(.title)
            
            Picker(selection: $selectedAlgorithm, label: Text("Algorithm")) {
                ForEach(0..<AppConfig.algorithm.count) {
                    Text(AppConfig.algorithm[$0].name)
                }
            }
            
            Picker(selection: $selectedQualityOfService, label: Text("Quality of service")) {
                ForEach(0..<QualityOfService.allCases.count) {
                    Text(QualityOfService.allCases[$0].name)
                }
            }
            
            
            Picker(selection: $selectedCpuRunType, label: Text("CPU")) {
                ForEach(0..<CpuCoreRunType.allCases.count) {
                    Text(CpuCoreRunType.allCases[$0].name)
                }
            }
            
            Slider(value: $sliderValue, in: 0...100) {
                Text("Duration: \(formatteDuration(sliderValue))")
            }
            Button("Done") {
                isPresented = false
            }
        }.padding()
    }
    
    
    func formatteDuration(_ number: Double) -> String {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: number, unit: UnitDuration.seconds)
        return formatter.string(from: measurement)
    }
}

#if DEBUG
struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(isPresented: .constant(true))
    }
}
#endif
