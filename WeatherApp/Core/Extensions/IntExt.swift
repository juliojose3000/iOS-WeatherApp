//
//  IntExt.swift
//  WeatherApp
//
//  Created by Julio on 13/8/25.
//

import Foundation

extension Int {
    func toTimeString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a" // You can customize the format
        return dateFormatter.string(from: date)
    }
}
