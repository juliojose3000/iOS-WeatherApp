//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
}
