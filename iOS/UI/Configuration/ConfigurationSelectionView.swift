//
//  ConfigurationSelectionView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 01.12.20.
//

import SwiftUI
import BenchmarkWrapper

struct ConfigurationSelectionView: View {
    let listElement: ListElement
    @ObservedObject var configuration: Configuration
    
    var body: some View {
        ZStack {
            List(AvailableAlgortihm.allCases) { item in
                Button(action: {
                    configuration.algortihm = item
                }, label: {
                    Label(
                        item.algortihm.name,
                        systemImage: item == configuration.algortihm ? "checkmark.circle.fill" : "circle"
                    )
                })
            }
            .opacity(listElement == .algortihm ? 1 : 0)
            List(CpuCoreRunType.allCases) { item in
                Button(action: {
                    configuration.cpuCoreRunType = item
                }, label: {
                    Label(
                        item.name,
                        systemImage: item == configuration.cpuCoreRunType ? "checkmark.circle.fill" : "circle"
                    )
                })
            }
            .opacity(listElement == .cpuCoreRunType ? 1 : 0)
            List(QualityOfService.allCases) { item in
                Button(action: {
                    configuration.qualityOfService = item
                }, label: {
                    Label(
                        item.name,
                        systemImage: item == configuration.qualityOfService ? "checkmark.circle.fill" : "circle"
                    )
                })
            }
            .opacity(listElement == .qualityOfService ? 1 : 0)
        }
    }
}

#if DEBUG
struct ConfigurationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSelectionView(
            listElement: .algortihm,
            configuration: Configuration()
        )
    }
}
#endif
