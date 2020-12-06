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
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .leading) {
                Label(score.configuration.algorithm.name, systemImage: ListElement.algortihm.imageName)
                Label(score.configuration.cpuCoreRunType.name, systemImage: ListElement.cpuCoreRunType.imageName)
                Label(score.configuration.qualityOfService.name, systemImage: ListElement.qualityOfService.imageName)
            }
            .font(.title3)
            Spacer()
            Label("\(Int(Double(score.score).rounded() / Double(score.configuration.duration.seconds)))", systemImage: "rosette")
                .font(.title)
            Spacer()
        }
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
                    threadPriority: 1,
                    algorithm: AvailableAlgortihm.aes.algortihm,
                    cpuCoreRunType: .multiCore,
                    duration: .seconds(10)
                )
            )
        )
    }
}
#endif
