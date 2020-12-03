//
//  ConfigurationView.swift
//  Benchmark (iOS)
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
        NavigationView {
            VStack(alignment: .center, spacing: nil) {
                List(ListElement.allCases) { item in
                    VStack {
                        NavigationLink(
                            destination: ConfigurationSelectionView(
                                listElement: item,
                                configuration: configuration
                            )
                        ) {
                            listLabel(item)
                        }
                        .navigationTitle(Text("Configuration"))
                    }
                }

                Text("Duration: \(FormatterHelper.formatteDuration(configuration.duration))")
                Slider(value: $configuration.duration, in: 5...60, step: 5)
                    .disabled(configuration.isStressTest)
                
                Toggle(isOn: $configuration.isStressTest) {
                    Text("Stress Test")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                Button("Done") {
                    onDone?()
                    isPresented = false
                }
            }.padding(20)
        }
    }
    
    func listLabel(_ element: ListElement) -> some View {
        switch element {
        case .algortihm:
            return Label(configuration.algortihm.algortihm.name, systemImage: "skew")
        case .cpuCoreRunType:
            return Label(configuration.cpuCoreRunType.name, systemImage: "cpu")
        case .qualityOfService:
            return Label(configuration.qualityOfService.name, systemImage: "speedometer")
        }
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
