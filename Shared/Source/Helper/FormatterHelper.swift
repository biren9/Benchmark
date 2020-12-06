//
//  FormatterHelper.swift
//  Benchmark (macOS)
//
//  Created by Gil Biren on 01.12.20.
//

import Foundation

class FormatterHelper {
    static func formatteDuration(_ number: Double) -> String {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: number, unit: UnitDuration.seconds)
        return formatter.string(from: measurement)
    }
    
    static func formatteNumber(_ number: Double, decimalPlaces: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalPlaces
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
