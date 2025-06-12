//
//  WelcomeView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack(path: $path) {
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
                    NavigationLink(value: AppRoute.characterSelect) {
                        Text("Play")
                            .font(.heading(size: 60))
                    }
                    .font(.heading(size: 60))
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 40)
                    
                    NavigationLink(value: AppRoute.gallery){
                        Text("Gallery")
                    }
                    .font(.heading(size: 60))
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 40)
                }
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: AppRoute.settings) {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                    }
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .characterSelect:
                    CharacterSelectView(path: $path)
                case .customization:
                    CustomizationView(path: $path)
                case .gallery:
                    GalleryView(path: $path)
                case .settings:
                    SettingsView(path: $path)
                case .share:
                    ShareView(path: $path)
                }
            }
        }
        
    }
        
}

#Preview{
    PreviewWrapper{
        WelcomeView(path: .constant(NavigationPath()))
    }
}
