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
            // Background color/image
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack {
                // Top bar space (status bar automatically managed by iOS)
                Spacer().frame(height: 40)

                // Location and Settings
                HStack {
                    Text(viewModel.locationName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)

                // Wind Warning
                if viewModel.windWarning {
                    Text("WIND WARNING")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Temperature Display
                Text("\(viewModel.temperature)°")
                    .font(.system(size: 100, weight: .bold))
                Text("Feels like \(viewModel.feelsLike)°")
                    .font(.subheadline)

                // Narrative Text
                Text(viewModel.weatherNarrative)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                // Hourly Forecast
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.hourlyForecast, id: \.hour) { hourWeather in
                            VStack {
                                Text("\(hourWeather.hour):00")
                                    .font(.caption)
                                Image(systemName: hourWeather.conditionIcon)
                                Text("\(hourWeather.temperature)°")
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Additional Details
                HStack {
                    DetailView(title: "25 mph gusts", icon: "wind")
                    DetailView(title: "Waxing crescent moon", icon: "moon.stars")
                }

                Spacer()

                // Custom Tab Bar
                CustomTabBar()
            }
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
