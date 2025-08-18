//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//
import Foundation

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int

    // Custom initializer for creating a WeatherResponse object
    init(coord: Coord, weather: [Weather], base: String, main: Main, visibility: Int, wind: Wind, rain: Rain?, clouds: Clouds, dt: Int, sys: Sys, timezone: Int, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.rain = rain
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
}

struct Coord: Codable {
    let lon: Double
    let lat: Double

    // Custom initializer
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String

    // Custom initializer
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?

    // Custom initializer, providing default values for optional properties
    init(temp: Double, feels_like: Double, temp_min: Double, temp_max: Double, pressure: Int, humidity: Int, sea_level: Int? = nil, grnd_level: Int? = nil) {
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity
        self.sea_level = sea_level
        self.grnd_level = grnd_level
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?

    // Custom initializer
    init(speed: Double, deg: Int, gust: Double? = nil) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

struct Rain: Codable {
    let oneHour: Double?

    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }

    // Custom initializer
    init(oneHour: Double? = nil) {
        self.oneHour = oneHour
    }
}

struct Clouds: Codable {
    let all: Int

    // Custom initializer
    init(all: Int) {
        self.all = all
    }
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int

    // Custom initializer
    init(type: Int, id: Int, country: String, sunrise: Int, sunset: Int) {
        self.type = type
        self.id = id
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
