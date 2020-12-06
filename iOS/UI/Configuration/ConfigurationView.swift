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
                                elements: listableElements(item),
                                selectedIndex: selectedIndex(item),
                                onSelectinChange: { selectedIndex in
                                    selectIndex(selectedIndex, element: item)
                                }
                            )
                        ) {
                            listLabel(item)
                        }
                    }
                }

                Text( "Duration: " + (configuration.isStressTest ?
                        "∞" : "\(FormatterHelper.formatteDuration(configuration.duration))")
                )
                Slider(value: $configuration.duration, in: 5...60, step: 5)
                    .disabled(configuration.isStressTest)
                
                Toggle(isOn: $configuration.isStressTest) {
                    Text("Stress test")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                
                Text( "Thread priority: -")
                Slider(value: $configuration.threadPriority, in: 0...1)
                
                Button("Done") {
                    onDone?()
                    isPresented = false
                }
            }
            .padding(20)
            .navigationTitle(Text("Configuration"))
        }
    }

    private func selectIndex(_ index: Int, element: ListElement) {
        switch element {
        case .algortihm:
            configuration.algortihm = AvailableAlgortihm.allCases[index]
        case .cpuCoreRunType:
            configuration.cpuCoreRunType = CpuCoreRunType.allCases[index]
        case .qualityOfService:
            configuration.qualityOfService = QualityOfService.allCases[index]
        }
    }
    
    private func selectedIndex(_ element: ListElement) -> Int {
        switch element {
        case .algortihm:
            return AvailableAlgortihm.allCases.firstIndex { $0 == configuration.algortihm } ?? 0
        case .cpuCoreRunType:
            return CpuCoreRunType.allCases.firstIndex { $0 == configuration.cpuCoreRunType } ?? 0
        case .qualityOfService:
            return QualityOfService.allCases.firstIndex { $0 == configuration.qualityOfService } ?? 0
        }
    }
    
    private func listableElements(_ element: ListElement) -> [Listable] {
        switch element {
        case .algortihm:
            return AvailableAlgortihm.allCases
        case .cpuCoreRunType:
            return CpuCoreRunType.allCases
        case .qualityOfService:
            return QualityOfService.allCases
        }
    }
    
    private func listLabel(_ element: ListElement) -> some View {
        switch element {
        case .algortihm:
            return Label(configuration.algortihm.algortihm.name, systemImage: element.imageName)
        case .cpuCoreRunType:
            return Label(configuration.cpuCoreRunType.name, systemImage: element.imageName)
        case .qualityOfService:
            return Label(configuration.qualityOfService.name, systemImage: element.imageName)
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
