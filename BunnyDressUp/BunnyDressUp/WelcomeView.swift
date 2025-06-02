//
//  WelcomeView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Let's get fancy!")
                    .font(.largeTitle)
                    .bold()

                NavigationLink("Start Dressing Up", destination: CustomizationView())
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 40)

                NavigationLink("View Saved Avatars", destination: GalleryView())
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 40)

                NavigationLink("Settings", destination: SettingsView())
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 40)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview{
    let model = AvatarModel()
        // auto load models for the gallery later
    WelcomeView()
        .environmentObject(model)
}

// to do
// connect save avatar button to the actual screen to change the name
// update UI !!!! make it cute
// add animations
// add msuic
// add sound effects
// make seetings button properly accessible on each screen
// add icons for the bg, outfits, etc
// add more characters
