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
            return "cpuCoreRunType"
        case .qualityOfService:
            return "qualityOfService"
        }
    }
}

struct ConfigurationView: View {
    @Binding private(set) var isPresented: Bool
    @Binding private(set) var cpuCoreRunType: CpuCoreRunType
    @Binding private(set) var duration: TimeInterval
    @Binding private(set) var algortihm: AvailableAlgortihm
    @Binding private(set) var qualityOfService: QualityOfService
    @Binding private(set) var isStressTest: Bool
    private(set) var onDone: (() -> Void)?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: nil) {
                List(ListElement.allCases) { item in
                    NavigationLink(destination: ConfigurationSelectionView(listElement: item)) {
                        Text(item.title)
                    }.navigationTitle(Text("Configuration"))
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
}

#if DEBUG
struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(
            isPresented: .constant(true),
            cpuCoreRunType: .constant(.multiCore),
            duration: .constant(20),
            algortihm: .constant(.aes),
            qualityOfService: .constant(.utility),
            isStressTest: .constant(false)
        )
    }
}
#endif
