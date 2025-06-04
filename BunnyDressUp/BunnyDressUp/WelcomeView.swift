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
                VStack(spacing: 0){
                    Text("Bunny")
                        .font(.title(size: 80))
                        .bold()
                        .foregroundColor(.primary)
                    Text("Friends")
                        .font(.title(size: 76))
                        .bold()
                        .foregroundColor(.primary)
                }
                Spacer()

                VStack(spacing: 30){
                    NavigationLink("Play", destination: CharacterSelectView())
                        .font(.heading(size: 60))
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal, 40)
                        .toolbar {
                            ToolbarItem() {
                                NavigationLink(destination: SettingsView()) {
                                    Image(systemName: "gearshape.fill")
                                }
                            }
                        }
                    
                    NavigationLink("Gallery", destination: GalleryView())
                        .font(.heading(size: 60))
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal, 40)
                }
                Spacer()
            }
            .padding()
        }
        
    }
        
}

#Preview{
    PreviewWrapper{
        WelcomeView()
    }
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
