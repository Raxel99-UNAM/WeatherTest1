//
//  WeatherView.swift
//  WeatherTest1
//
//  Created by Raymundo Mondragon Lara on 22/11/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel() // Your ViewModel should handle the WeatherKit data fetching

    var body: some View {
        ZStack {
            // Animated background
            AnimatedWeatherBackgroundView()

            // Rest of your UI content
            VStack {
                // Display the location name, temperature, feels like temperature, etc.
                CurrentWeatherView(viewModel: viewModel)

                // Display the hourly forecast
                ScrollView(.horizontal, showsIndicators: false) {
                    HourlyForecastView(hourlyForecast: viewModel.hourlyForecast)
                        .padding(.horizontal)
                }

                // Display any wind warnings and weather narrative
                WeatherAlertsView(windWarning: viewModel.windWarning, weatherNarrative: viewModel.weatherNarrative)

                // Display additional details like wind speed and moon phase
                AdditionalDetailsView(gusts: "25 mph gusts", moonPhase: "Waxing crescent moon")

                Spacer()

                // Custom Tab Bar at the bottom
                CustomTabBar()            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomTabBar2: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "cloud.fill")
            Spacer()
            Image(systemName: "map.fill")
            Spacer()
            Image(systemName: "location.fill")
            Spacer()
            Image(systemName: "gear")
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}

#Preview {
    WeatherView()
}
