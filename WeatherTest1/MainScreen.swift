//
//  MainScreen.swift
//  WeatherTest1
//
//  Created by Raymundo Mondragon Lara on 17/11/23.
//

import SwiftUI
import WeatherKit

struct MainScreen: View {
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

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            // Location and Settings
            HStack(alignment: .center) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                }
                Spacer()
                
                Text(viewModel.locationName)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                Button(action: {}) {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.title2)
                }
            }
            .padding()

            // Temperature Display
            Text("\(viewModel.temperature)°")
                .font(.system(size: 100, weight: .bold))
            Text("Feels like \(viewModel.feelsLike)°")
                .font(.subheadline)
        }
        .padding(.top, 40) // Space for top bar
    }
}

struct HourlyForecastView: View {
    var hourlyForecast: [HourWeather]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(hourlyForecast, id: \.hour) { hourWeather in
                VStack {
                    Text("\(hourWeather.hour):00")
                        .font(.caption)
                    Image(systemName: hourWeather.conditionIcon)
                    Text("\(hourWeather.temperature)°")
                }
            }
        }
    }
}

struct WeatherAlertsView: View {
    var windWarning: Bool
    var weatherNarrative: String
    
    var body: some View {
        VStack {
            // Wind Warning
            if windWarning {
                Text("WIND WARNING")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }

            // Narrative Text
            Text(weatherNarrative)
                .padding()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
    }
}

struct AdditionalDetailsView: View {
    var gusts: String
    var moonPhase: String
    
    var body: some View {
        HStack {
            DetailView(title: gusts, icon: "wind")
            DetailView(title: moonPhase, icon: "moon.stars")
        }
    }
}

struct DetailView: View {
    var title: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
            Text(title)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct CustomTabBar: View {
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
    MainScreen()
}
