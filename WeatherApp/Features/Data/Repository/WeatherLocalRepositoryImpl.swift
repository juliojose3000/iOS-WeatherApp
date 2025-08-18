import CoreData

final class WeatherLocalRepositoryImpl: WeatherLocalRepository {
    private let context = CoreDataStack.shared.context

    func save(weather: WeatherResponse) {
        let entity = WeatherEntity(context: context)
        entity.cityName = weather.name
        entity.temp = weather.main.temp
        entity.minTemp = weather.main.temp_min
        entity.maxTemp = weather.main.temp_max
        entity.humidity = Int16(weather.main.humidity)
        entity.pressure = Int16(weather.main.pressure)
        entity.weatherDescription = weather.weather.first?.description
        entity.icon = weather.weather.first?.icon
        entity.windSpeed = weather.wind.speed
        entity.windDeg = Int16(weather.wind.deg)
        entity.sunrise = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
        entity.sunset = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
        entity.timestamp = Date()
        try? context.save()
    }

    func fetchLatest() -> WeatherResponse? {
        let request: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        request.fetchLimit = 1
        guard let entity = try? context.fetch(request).first else { return nil }

        // Map WeatherEntity back to WeatherResponse, using the custom initializers.
        // Default values are provided for properties not stored in Core Data.
        let coord = Coord(lon: 0.0, lat: 0.0)
        let weather = [Weather(id: 0, main: "", description: entity.weatherDescription ?? "", icon: entity.icon ?? "")]
        let main = Main(
            temp: entity.temp,
            feels_like: 0.0, // Default value
            temp_min: entity.minTemp,
            temp_max: entity.maxTemp,
            pressure: Int(entity.pressure),
            humidity: Int(entity.humidity),
            sea_level: nil,
            grnd_level: nil
        )
        let wind = Wind(
            speed: entity.windSpeed,
            deg: Int(entity.windDeg)
        )
        let rain: Rain? = nil // Default value
        let clouds = Clouds(all: 0) // Default value
        let sys = Sys(
            type: 0, // Default value
            id: 0, // Default value
            country: "", // Default value
            sunrise: Int(entity.sunrise?.timeIntervalSince1970 ?? 0),
            sunset: Int(entity.sunset?.timeIntervalSince1970 ?? 0)
        )

        return WeatherResponse(
            coord: coord,
            weather: weather,
            base: "", // Default value
            main: main,
            visibility: 0, // Default value
            wind: wind,
            rain: rain,
            clouds: clouds,
            dt: 0, // Default value
            sys: sys,
            timezone: 0, // Default value
            id: 0, // Default value
            name: entity.cityName ?? "",
            cod: 0 // Default value
        )
    }
}
