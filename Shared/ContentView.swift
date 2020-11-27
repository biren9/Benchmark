//
//  ContentView.swift
//  Shared
//
//  Created by Gil Biren on 25.11.20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var benchmarkService = BenchmarkService( benchmarkServices: [BenchmarkCalculationPrime(), BenchmarkCalculationPrime()])
    
    func progressTitle() -> String {
        if let score = benchmarkService.score {
            return "Score: \(score)"
        } else if benchmarkService.isRunning {
            return "\(Int(benchmarkService.progress*100))%"
        }
        return "Benchmark"
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 50, content: {
            ProgressView(progressTitle(), value: benchmarkService.progress, total: 1)
            Button(benchmarkService.isRunning ? "Stop" : "Start") {
                if benchmarkService.isRunning {
                    benchmarkService.stop()
                } else {
                    benchmarkService.run()
                }
            }
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
