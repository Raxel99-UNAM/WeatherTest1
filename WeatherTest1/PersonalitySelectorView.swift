//
//  ContentView.swift
//  WeatherTest1
//
//  Created by Raymundo Mondragon Lara on 15/11/23.
//

import SwiftUI


struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat { .zero }
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct PersonalitySelectorView: View {
    
    // Define the personality options and their descriptions
    let personalities = [
        (name: "Professional", description: "Sander will behave like a normal weather app."),
        (name: "Friendly", description: "Sander will be friendly and helpful."),
        (name: "Snarky", description: "Sander will be cheeky and playful."),
        (name: "Homicidal", description: "Sander will be dark and menacing."),
        (name: "Sander", description: "Sander will go way over the f----ing line.")
    ]
    
    // The maximum width for the bubble
    private let maxBubbleWidth: CGFloat = 150
    
    @State private var selectedPersonalityIndex: Double = 2 // Default to "Snarky"
    @State private var bubbleWidth: CGFloat? // To store the dynamic width of the bubble

   
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                // App icon
                Image("AppIconScreen") // Replace with actual app icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 70)
                
                // Screen title and description
                Text("Personality")
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                
                Text("Choose a personality for your weather assistant.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 130)
                    .fontDesign(.rounded)
                
                // Slider with custom track and icons
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        HStack {
                            Image(systemName: "drop.fill") // Start icon
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "flame.fill") // End icon
                                .foregroundColor(.gray)
                        }.padding()
                        
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
                                        .frame(width: 4, height: 15)
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
                        .frame(width: geometry.size.width - 90) // Deduct total padding
                        
                        // Message bubble
                        VStack(alignment: .leading, spacing: 0) {
                            Text(personalities[Int(selectedPersonalityIndex.rounded())].name)
                                .font(.headline)
                                .fontDesign(.rounded)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(personalities[Int(selectedPersonalityIndex.rounded())].description)
                                .font(.caption)
                                .fontDesign(.rounded)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .frame(width: min(geometry.size.width - 50, maxBubbleWidth), height: 70, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .offset(x: bubbleOffset(for: selectedPersonalityIndex, in: geometry.size.width, bubbleWidth: min(geometry.size.width - 50, maxBubbleWidth)), y: -60)
                        .animation(.easeInOut, value: selectedPersonalityIndex)                }
                }
                .frame(height: 80) // Enough space for bubble
                
                // Continue Button
                NavigationLink(destination: MainScreen()) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .fontDesign(.rounded)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        
        }
    }
    // Calculate the horizontal offset for the message bubble
    private func bubbleOffset(for value: Double, in totalWidth: CGFloat, bubbleWidth: CGFloat) -> CGFloat {
        let sliderRange = totalWidth - 60 // Adjust based on padding
        let thumbPosition = sliderRange * CGFloat(value / Double(personalities.count - 1))
        let halfBubbleWidth = bubbleWidth / 2
        
        // Calculate the offset so the bubble does not go off-screen
        let offset = min(max(thumbPosition, halfBubbleWidth + 30), totalWidth - halfBubbleWidth - 30) - (sliderRange / 2)
        return offset
    }
    
    private var bubbleText: String {
        let personality = personalities[Int(selectedPersonalityIndex.rounded())]
        return "\(personality.name): \(personality.description)"
    }
}
    
#Preview {
    PersonalitySelectorView()
}
