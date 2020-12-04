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
    @ObservedObject private var configuration = Configuration()
    @ObservedObject private var cpuService = CPUService(timerUpdateInterval: 0.5)
    
    private let cpuGraphHeight: CGFloat = 20
    
    init() {
        setConfiguration()
    }
    
    func progressTitle() -> String {
        if benchmarkService.runningState == .running {
            return "\(Int(benchmarkService.progress*100))%"
        } else if benchmarkService.progress == 1 {
            return "Done"
        }
        return "Benchmark"
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:40, content: {
            HStack(alignment: .center, spacing: nil, content: {
                Spacer(minLength: 60)
                ProgressView(progressTitle(), value: benchmarkService.progress, total: 1)
                Spacer(minLength: 60)
            })
            
            HStack(alignment: .bottom) {
                ForEach(cpuService.coresInfo) { item in
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: cpuGraphHeight, height: cpuGraphHeight)
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .frame(width: cpuGraphHeight, height: max(CGFloat(item.usage)*cpuGraphHeight, 1))
                    }
                }
            }
            .frame(minHeight: cpuGraphHeight, idealHeight: cpuGraphHeight, maxHeight: cpuGraphHeight)
            
            benchmarkService.score.map { ScoreView(score: $0) }
            
            HStack(alignment: .center, spacing: nil, content: {
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
                        configuration: configuration,
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
        let benchmarkConfiguration = BenchmarkConfiguration(
            qualityOfService: configuration.qualityOfService,
            algorithm: configuration.algortihm.algortihm,
            cpuCoreRunType: configuration.cpuCoreRunType,
            duration: configuration.isStressTest ? .never : .seconds(Int(configuration.duration))
        )
        benchmarkService.stop()
        benchmarkService.setConfiguration(benchmarkConfiguration)
    }
}

#if DEBUG
struct BenchmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkView()
    }
}
#endif
