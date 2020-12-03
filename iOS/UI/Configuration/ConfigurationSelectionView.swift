//
//  ConfigurationSelectionView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 01.12.20.
//

import SwiftUI
import BenchmarkWrapper

struct ConfigurationSelectionView: View {
    private let imageNameSelected = "checkmark.circle.fill"
    private let imageNameUnselected = "circle"
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
                        systemImage: item == configuration.algortihm ? imageNameSelected : imageNameUnselected
                    )
                })
            }
            
            List(CpuCoreRunType.allCases) { item in
                Button(action: {
                    configuration.cpuCoreRunType = item
                }, label: {
                    Label(
                        item.name,
                        systemImage: item == configuration.cpuCoreRunType ? imageNameSelected : imageNameUnselected
                    )
                })
            }
            
            List(QualityOfService.allCases) { item in
                Button(action: {
                    configuration.qualityOfService = item
                }, label: {
                    Label(
                        item.name,
                        systemImage: item == configuration.qualityOfService ? imageNameSelected : imageNameUnselected
                    )
                })
            }
            
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
