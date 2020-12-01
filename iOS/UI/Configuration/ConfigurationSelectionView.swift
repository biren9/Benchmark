//
//  ConfigurationSelectionView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 01.12.20.
//

import SwiftUI

struct ConfigurationSelectionView: View {
    let listElement: ListElement
    
    var body: some View {
        Text(listElement.title)
    }
}

#if DEBUG
struct ConfigurationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSelectionView(
            listElement: .algortihm
        )
    }
}
#endif
