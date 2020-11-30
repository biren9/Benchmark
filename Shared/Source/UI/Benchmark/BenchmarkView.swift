//
//  BenchmarkView.swift
//  Shared
//
//  Created by Gil Biren on 25.11.20.
//

import SwiftUI
import BenchmarkWrapper

struct BenchmarkView: View {
    @State private var isConfigurationVisible = false
    @ObservedObject private var benchmarkService =  BenchmarkServiceWrapper()
    @State private var cpuCoreRunType: CpuCoreRunType = .singleCore
    @State private var duration: TimeInterval = 20
    @State private var algortihm = AppConfig.algorithm[0]
    @State private var qualityOfService = QualityOfService.allCases[0]
    
    func progressTitle() -> String {
        if benchmarkService.runningState == .running {
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
                    Text("\(item.name): \(Int(Double(item.score) / duration))")
                    Spacer()
                }
            }
            
            HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Spacer()
                Button(benchmarkService.runningState == .running ? "Stop" : "Start") {
                    if benchmarkService.runningState == .running {
                        benchmarkService.stop()
                    } else {
                        benchmarkService.run()
                    }
                }
                .disabled(benchmarkService.runningState == .needConfiguration)
                Spacer()
                Button("Configure") {
                    isConfigurationVisible = true
                }
                .disabled(benchmarkService.runningState == .running)
                .sheet(isPresented: $isConfigurationVisible, onDismiss: {
                    isConfigurationVisible = false
                }, content: {
                    ConfigurationView(
                        isPresented: $isConfigurationVisible,
                        cpuCoreRunType: $cpuCoreRunType,
                        duration: $duration,
                        algortihm: $algortihm,
                        qualityOfService: $qualityOfService,
                        onDone: setConfiguration
                    )
                    .frame(minWidth: 300)
                })
                Spacer()
            })
        })
        .padding(20)
    }
    
    private func setConfiguration() {
        let configuration = BenchmarkConfiguration(
            cpuCoreRunType: cpuCoreRunType,
            duration: duration,
            description: "--",
            serviceType: algortihm.type.type,
            qualityOfService: qualityOfService
        )
        benchmarkService.setConfigurations(configuration)
    }
}

#if DEBUG
struct BenchmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkView()
    }
}
#endif
