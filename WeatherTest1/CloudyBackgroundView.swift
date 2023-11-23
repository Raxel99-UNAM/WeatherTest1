//
//  CloudyBackgroundView.swift
//  WeatherTest1
//
//  Created by Raymundo Mondragon Lara on 22/11/23.
//

import SwiftUI

struct CloudyBackgroundView: View {
    @State private var cloudOffset1: CGFloat = UIScreen.main.bounds.width
    @State private var cloudOffset2: CGFloat = UIScreen.main.bounds.width
    @State private var cloudOffset3: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        // Placeholder for your background image
        Image("CloudyBackground")
            .resizable()
            .scaledToFit()
        // Clouds at the top of the screen
        ZStack {
            // Cloud 1
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 40)
                .offset(x: cloudOffset1, y: -UIScreen.main.bounds.height / 5) // Position clouds at the top fifth of the screen
                .onAppear {
                    withAnimation(Animation.linear(duration: 7).repeatForever(autoreverses: false)) {
                        cloudOffset1 = -UIScreen.main.bounds.width
                    }
                }
            
            // Cloud 2
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 50)
                .offset(x: cloudOffset2, y: -UIScreen.main.bounds.height / 4) // Position clouds slightly lower
                .onAppear {
                    withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                        cloudOffset2 = -UIScreen.main.bounds.width * 2
                    }
                }
            
            // Cloud 3
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 30)
                .offset(x: cloudOffset3, y: -UIScreen.main.bounds.height / 3) // Position clouds even lower
                .onAppear {
                    withAnimation(Animation.linear(duration: 6).repeatForever(autoreverses: false)) {
                        cloudOffset3 = -UIScreen.main.bounds.width * 1.5
                    }
                }
        }
        .opacity(0.9) // Set the opacity to make clouds less pronounced
    }
}

// Updated AnimatedWeatherBackgroundView to only display CloudyBackgroundView
struct AnimatedWeatherBackgroundView: View {
    var body: some View {
        CloudyBackgroundView()
    }
}

#Preview {
    CloudyBackgroundView()
}
