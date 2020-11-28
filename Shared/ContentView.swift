//
//  ContentView.swift
//  Shared
//
//  Created by Gil Biren on 25.11.20.
//

import SwiftUI
import BenchmarkWrapper

struct ContentView: View {
    @ObservedObject private var benchmarkService = BenchmarkServiceWrapper(
        benchmarkServiceConfigurations: [
            BenchmarkConfiguration(
                cpuCoreRunType: .singleCore,
                duration: 20,
                description: "Prime numbers singleCore",
                serviceType: BenchmarkCalculationPrime.self,
                qualityOfService: .userInitiated
            ),
            BenchmarkConfiguration(
                cpuCoreRunType: .multiCore,
                duration: 20,
                description: "Prime numbers multiCore",
                serviceType: BenchmarkCalculationPrime.self,
                qualityOfService: .userInitiated
            ),
            BenchmarkConfiguration(
                cpuCoreRunType: .singleCore,
                duration: 20,
                description: "Prime number n",
                serviceType: BenchmarkCalculationPrime2.self,
                qualityOfService: .userInitiated
            )
        ]
    )
    
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
            Button(benchmarkService.isRunning ? "Stop" : "Start") {
                if benchmarkService.isRunning {
                    benchmarkService.stop()
                } else {
                    benchmarkService.run()
                }
            }
        })
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
