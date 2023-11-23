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
    @Published var windWarning: Bool = true // Set true for UI demonstration
    @Published var temperature: Int = 17 // Static temperature for UI demonstration
    @Published var feelsLike: Int = 17 // Static 'feels like' for UI demonstration
    @Published var weatherNarrative: String = "Daily alerts" // Static narrative for UI demonstration
    @Published var hourlyForecast: [HourWeather] = []
    
    init() {
        generateMockHourlyForecast()
    }
    
    func generateMockHourlyForecast() {
        let currentHour = Calendar.current.component(.hour, from: Date())
        let weatherIcons = ["sun.max.fill", "cloud.drizzle.fill", "cloud.fill", "cloud.sun.fill", "moon.stars.fill"]
        
        hourlyForecast = (currentHour...currentHour+24).map { hour in
            let normalizedHour = hour % 24
            let randomTemp = Int.random(in: 8...17)
            let randomIcon = weatherIcons.randomElement()!
            return HourWeather(hour: normalizedHour, temperature: randomTemp, conditionIcon: randomIcon)
        }
    }
}

struct HourWeather: Identifiable {
    let id = UUID()
    let hour: Int
    let temperature: Int
    let conditionIcon: String
}



