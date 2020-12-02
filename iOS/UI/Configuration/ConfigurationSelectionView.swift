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
    @Binding private(set) var cpuCoreRunType: CpuCoreRunType
    @Binding private(set) var algortihm: AvailableAlgortihm
    @Binding private(set) var qualityOfService: QualityOfService
    
    var body: some View {
        ZStack {
            List(AvailableAlgortihm.allCases) { item in
                Button(action: {
                    algortihm = item
                }, label: {
                    Label(
                        item.algortihm.name,
                        systemImage: item == algortihm ? "checkmark.circle.fill" : "circle"
                    )
                })
            }
            .opacity(listElement == .algortihm ? 1 : 0)
            List(CpuCoreRunType.allCases) { item in
                Button(action: {
                    cpuCoreRunType = item
                }, label: {
                    Label(
                        item.name,
                        systemImage: item == cpuCoreRunType ? "checkmark.circle.fill" : "circle"
                    )
                })
            }
            .opacity(listElement == .cpuCoreRunType ? 1 : 0)
            List(QualityOfService.allCases) { item in
                Button(action: {
                    qualityOfService = item
                }, label: {
                    Label(
                        item.name,
                        systemImage: item == qualityOfService ? "checkmark.circle.fill" : "circle"
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
            cpuCoreRunType: .constant(.singleCore),
            algortihm: .constant(.aes),
            qualityOfService: .constant(.background)
        )
    }
}
#endif
