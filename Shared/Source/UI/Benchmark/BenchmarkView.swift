//
//  BenchmarkView.swift
//  Shared
//
//  Created by Gil Biren on 25.11.20.
//

import SwiftUI
import BenchmarkWrapper

struct BenchmarkView: View {
    @ObservedObject private var benchmarkService: BenchmarkServiceWrapper
    
    @State private var isConfigurationVisible = false
    
    init(benchmarkService: BenchmarkServiceWrapper) {
        self.benchmarkService = benchmarkService
    }
    
    func progressTitle() -> String {
        if benchmarkService.isRunning {
            return "\(Int(benchmarkService.progress*100))%"
        }
        return "Benchmark"
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:40, content: {
            HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Spacer(minLength: 60)
                ProgressView(progressTitle(), value: benchmarkService.progress, total: 1)
                Spacer(minLength: 60)
            })
            List(benchmarkService.scores) { item in
                HStack {
                    Spacer()
                    Text("\(item.name): \(item.score)")
                    Spacer()
                }
            }
            
            HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Spacer()
                Button(benchmarkService.isRunning ? "Stop" : "Start") {
                    if benchmarkService.isRunning {
                        benchmarkService.stop()
                    } else {
                        benchmarkService.run()
                    }
                }
                Spacer()
                Button("Configure") {
                    isConfigurationVisible = true
                }
                .disabled(benchmarkService.isRunning)
                .sheet(isPresented: $isConfigurationVisible, onDismiss: {
                    isConfigurationVisible = false
                }, content: {
                    ConfigurationView(isPresented: $isConfigurationVisible)
                        .frame(minWidth: 300)
                })
                Spacer()
            })
        })
        .padding(20)
    }
}

#if DEBUG
struct BenchmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkView(
            benchmarkService: BenchmarkServiceWrapper(
                benchmarkServiceConfigurations: []
            )
        )
    }
}
#endif
