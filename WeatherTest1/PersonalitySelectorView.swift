//
//  ContentView.swift
//  WeatherTest1
//
//  Created by Raymundo Mondragon Lara on 15/11/23.
//

import SwiftUI

struct PersonalitySelectorView: View {
    
    // Define the personality options and their descriptions
    let personalities = [
        (name: "Professional", description: "Sander will behave like a normal weather app."),
        (name: "Friendly", description: "Sander will be friendly and helpful."),
        (name: "Snarky", description: "Sander will be cheeky and playful."),
        (name: "Homicidal", description: "Sander will be dark and menacing."),
        (name: "Sander", description: "Sander will go way over the f----ing line.")
    ]
    
    @State private var selectedPersonalityIndex: Double = 2 // Default to "Snarky"
    @State private var sliderWidth: CGFloat = 0 // To store the width of the slider
   
    var body: some View {
        VStack(spacing: 20) {
             Spacer()
            
            // App icon
            Image("AppIconScreen") // Replace with actual app icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.top, 20)
            
            // Screen title and description
            Text("Personality")
                .font(.largeTitle)
            
            Text("Choose a personality for your weather assistant.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            
            // Description box for selected personality
            Text(personalities[Int(selectedPersonalityIndex.rounded())].description)
                .font(.caption)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
                .transition(.slide)
                .animation(.default, value: selectedPersonalityIndex)
            
            // Slider with custom track and icons
            HStack {
                Image(systemName: "suitcase.fill") // Start icon
                    .foregroundColor(.gray)
                ZStack {
                    // Custom track
                    Rectangle()
                        .frame(height: 5)
                        .foregroundColor(.gray)
                        .cornerRadius(2.5)
                    
                    // Divisions
                    HStack(spacing: 0) {
                        ForEach(0..<personalities.count) { index in
                            Rectangle()
                                .frame(width: 2, height: 15)
                                .foregroundColor(selectedPersonalityIndex.rounded() == Double(index) ? .blue : .gray)
                            if index < personalities.count - 1 {
                                Spacer()
                            }
                        }
                    }
                    
                    // The actual slider
                    Slider(value: $selectedPersonalityIndex, in: 0...Double(personalities.count - 1), step: 1)
                        .accentColor(Color.clear)
                        .onChange(of: selectedPersonalityIndex) { newValue in
                            // Trigger haptic feedback when the selected value changes
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.prepare()
                            impactMed.impactOccurred()
                        }
                }
                .frame(width: 200) // Control the width of your slider here
                
                Image(systemName: "hare.fill") // End icon
                    .foregroundColor(.gray)
            }
            .padding()
            
            // Continue Button
            Button(action: {
                // Action to proceed with the selected personality
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Spacer()
        }
    }
}

#Preview {
    PersonalitySelectorView()
}
