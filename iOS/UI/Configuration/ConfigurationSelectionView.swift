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
    let elements: [Listable]
    @State var selectedIndex: Int
    var onSelectinChange: ((Int) -> Void)?
    
    var body: some View {
        List(0..<elements.count) { index in
            let item = elements[index]
            Button(action: {
                selectedIndex = index
                onSelectinChange?(index)
            }, label: {
                Label(
                    item.name,
                    systemImage: selectedIndex == index ? imageNameSelected : imageNameUnselected
                )
            })
        }
    }
}

#if DEBUG
struct ConfigurationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSelectionView(
            elements: AvailableAlgortihm.allCases,
            selectedIndex: 1
        )
    }
}
#endif
