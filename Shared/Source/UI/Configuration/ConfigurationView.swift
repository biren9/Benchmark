//
//  ConfigurationView.swift
//  Benchmark (iOS)
//
//  Created by Gil Biren on 28.11.20.
//

import SwiftUI

struct ConfigurationView: View {
    @Binding var isPresented: Bool
    @State var sliderValue: Double = 20
    
    var body: some View {
        VStack {
            Label("Configuration", systemImage: "gear")
                .font(.title)
            
            Picker(selection: .constant(1), label: Text("Algorithm")) {
                Text("Prime numbers").tag(1)
            }
            
            
            Picker(selection: .constant(1), label: Text("CPU")) {
                Text("single core").tag(1)
                Text("multi core").tag(2)
            }
            
            Slider(value: $sliderValue, in: 0...100) {
                Text("Duration: \(formatteDuration(sliderValue))")
            }
            Button("Done") {
                isPresented = false
            }
        }.padding()
    }
    
    
    func formatteDuration(_ number: Double) -> String {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: number, unit: UnitDuration.seconds)
        return formatter.string(from: measurement)
    }
}

#if DEBUG
struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(isPresented: .constant(true))
    }
}
#endif
