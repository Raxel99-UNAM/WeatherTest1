//
//  WeatherViewModel.swift
//  WeatherTest1
//
//  Created by Raymundo Mondragon Lara on 17/11/23.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var locationName: String = "Naples"
    @Published var windWarning: Bool = false
    @Published var temperature: Int = 0
    @Published var feelsLike: Int = 0
    @Published var weatherNarrative: String = ""
    @Published var hourlyForecast: [HourWeather] = []
    @Published var currentWeather: WeatherCondition?
    
    private var weatherService = WeatherService.shared
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        let location = CLLocation(latitude: 40.853294, longitude: 14.305573) // Coordinates for Naples
        
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                
                DispatchQueue.main.async {
                    self.locationName = "Naples"
                    self.temperature = Int(weather.currentWeather.temperature.converted(to: .celsius).value)
                    self.feelsLike = Int(weather.currentWeather.apparentTemperature.converted(to: .celsius).value)
                    self.weatherNarrative = weather.currentWeather.condition.description
                    
                    // Setting a wind warning if wind speed is above a certain threshold, e.g., 25 mph
                    self.windWarning = weather.currentWeather.wind.speed.value > 25

                    // Since hourlyForecast is not optional, we don't use 'if let'
                    self.hourlyForecast = weather.hourlyForecast.compactMap { forecast in
                        HourWeather(hour: Calendar.current.component(.hour, from: forecast.date),
                                    temperature: Int(forecast.temperature.converted(to: .celsius).value),
                                    conditionIcon: forecast.condition.sfSymbolName)
                    }
                    self.currentWeather = weather.currentWeather.condition
                }
            } catch {
                self.weatherNarrative = "Failed to retrieve data."
                print("Error fetching weather data: \(error.localizedDescription)")

            }
        }
    }
}

struct HourWeather {
    let hour: Int
    let temperature: Int
    let conditionIcon: String
}

extension WeatherCondition {
    var sfSymbolName: String {
        switch self {
        case .clear:
            return "sun.max.fill"
        case .cloudy:
            return "cloud.fill"
        case .rain:
            return "cloud.rain.fill"
        // Add additional cases for each WeatherCondition
        default:
            return "questionmark.circle.fill"
        }
    }
}


