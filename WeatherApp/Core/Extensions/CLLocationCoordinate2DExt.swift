//
//  CLLocationCoordinate2DExt.swift
//  WeatherApp
//
//  Created by Julio on 17/8/25.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
