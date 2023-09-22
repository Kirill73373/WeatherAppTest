import Foundation

struct WeatherModel: Codable {
    var lat: Double = 0
    var lon: Double = 0
    var current: Current = .init(dt: 0, temp: 0, weather: [])
    var hourly: [HourlyWeather] = []
    var daily: [DailyWeather] = []
    
    init() {
        
    }
}

struct Current: Codable {
    let dt, temp: Double
    let weather: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let description, icon: String
}

struct HourlyWeather: Codable {
    let dt, temp: Double
    let weather: [HourlyWeatherInfo]
}

struct HourlyWeatherInfo: Codable {
    let description, icon: String
}

struct DailyWeather: Codable {
    let dt: Double
    let temp: DailyTemp
    let weather: [DailyWeatherInfo]
}

struct DailyTemp: Codable {
    let min, max: Double
}

struct DailyWeatherInfo: Codable {
    let icon: String
}
