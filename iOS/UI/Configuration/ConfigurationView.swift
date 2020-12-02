//
//  ConfigurationView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 01.12.20.
//

import SwiftUI
import BenchmarkWrapper

enum ListElement: Identifiable, CaseIterable {
    case cpuCoreRunType
    case algortihm
    case qualityOfService
    
    var id: UUID { UUID() }
    
    var title: String {
        switch self {
        case .algortihm:
            return "Algorithm"
        case .cpuCoreRunType:
            return "CPU"
        case .qualityOfService:
            return "QualityOfService"
        }
    }
}

struct ConfigurationView: View {
    @Binding private(set) var isPresented: Bool
    @Binding private(set) var cpuCoreRunType: CpuCoreRunType
    @Binding private(set) var algortihm: AvailableAlgortihm
    @Binding private(set) var qualityOfService: QualityOfService
    @Binding private(set) var duration: TimeInterval
    @Binding private(set) var isStressTest: Bool
    private(set) var onDone: (() -> Void)?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: nil) {
                List(ListElement.allCases) { item in
                    VStack {
                        NavigationLink(destination: ConfigurationSelectionView(
                                        listElement: item,
                                        cpuCoreRunType: $cpuCoreRunType,
                                        algortihm: $algortihm,
                                        qualityOfService: $qualityOfService)) {
                            listLabel(item)
                        }.navigationTitle(Text("Configuration"))
                    }
                }

                Text("Duration: \(FormatterHelper.formatteDuration(duration))")
                Slider(value: $duration, in: 1...60, step: 1)
                    .disabled(isStressTest)
                
                Toggle(isOn: $isStressTest) {
                    Text("Stress Test")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                Button("Done") {
                    onDone?()
                    isPresented = false
                }
            }
        }
        .padding()
    }
    
    func listLabel(_ element: ListElement) -> some View {
        switch element {
        case .algortihm:
            return Label(algortihm.algortihm.name, systemImage: "skew")
        case .cpuCoreRunType:
            return Label(cpuCoreRunType.name, systemImage: "cpu")
        case .qualityOfService:
            return Label(qualityOfService.name, systemImage: "speedometer")
        }
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
            isStressTest: .constant(true)
        )
        .preferredColorScheme(.dark)
    }
}
#endif
