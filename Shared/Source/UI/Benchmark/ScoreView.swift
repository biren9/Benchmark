//
//  ScoreView.swift
//  Benchmark
//
//  Created by Gil Biren on 30.11.20.
//

import SwiftUI
import BenchmarkWrapper

struct ScoreView: View {
    let score: BenchmarkScore
    
    var body: some View {
        HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Spacer()
            VStack(alignment: .leading, spacing: nil) {
                Label(score.configuration.algorithm.name, systemImage: "skew")
                Label(score.configuration.cpuCoreRunType.name, systemImage: "cpu")
                Label(score.configuration.qualityOfService.name, systemImage: "speedometer")
            }
            .font(.title3)
            Spacer()
            Label("\(Int(Double(score.score).rounded() / score.configuration.duration))", systemImage: "rosette")
                .font(.title)
            Spacer()
        })
    }
}

#if DEBUG
struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(
            score: BenchmarkScore(
                score: 100000,
                configuration: BenchmarkConfiguration(
                    qualityOfService: .utility,
                    algorithm: AvailableAlgortihm.aes.algortihm,
                    cpuCoreRunType: .multiCore,
                    duration: 20
                )
            )
        )
    }
}
#endif
