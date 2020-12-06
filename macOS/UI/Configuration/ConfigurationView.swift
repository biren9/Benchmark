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
    @ObservedObject private(set) var configuration: Configuration
    private(set) var onDone: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: nil) {
            Label("Configuration", systemImage: "gear")
                .font(.title)
            
            VStack(alignment: .leading) {
                  
                VStack {
                    Picker(
                        selection: $configuration.algortihm,
                        label: Label(ListElement.algortihm.title, systemImage: ListElement.algortihm.imageName)) {
                        ForEach(AvailableAlgortihm.allCases, id: \.self) {
                            Text($0.algortihm.name)
                        }
                    }
                    
                    Picker(
                        selection: $configuration.qualityOfService,
                        label: Label(ListElement.qualityOfService.title, systemImage: ListElement.qualityOfService.imageName)) {
                        ForEach(QualityOfService.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    
                    Picker(
                        selection: $configuration.cpuCoreRunType,
                        label: Label(ListElement.cpuCoreRunType.title, systemImage: ListElement.cpuCoreRunType.imageName)) {
                        ForEach(CpuCoreRunType.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: nil) {
                    Text( "Duration: " + (configuration.isStressTest ?
                            "∞" : "\(FormatterHelper.formatteDuration(configuration.duration))")
                    )
                    HStack {
                        Slider(value: $configuration.duration, in: 5...60, step: 5)
                            .disabled(configuration.isStressTest)
                        Toggle(isOn: $configuration.isStressTest) {
                            Text("Stress test")
                        }
                    }
                    
                    Text( "Thread priority: -")
                    Slider(value: $configuration.threadPriority, in: 0...1)
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
            configuration: Configuration()
        )
        .preferredColorScheme(.dark)
    }
}
#endif
