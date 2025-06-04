//
//  AvatarPreviewView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct AvatarPreviewView: View {
    @EnvironmentObject var avatar: AvatarModel

    var baseImageName: String {
        avatar.selectedItems[.selectCharacter]?.imageName ?? "bunny"
    }

    var body: some View {
        ZStack {
            // Base character image
            Image(baseImageName)
                .resizable()
                .scaledToFit()
                .zIndex(1)

            // Background (placed behind character)
            if let bg = avatar.selectedItems[.background] {
                Image(bg.imageName)
                    .resizable()
                    .scaledToFit()
                    .zIndex(-1)
            }

            // Outfit - use @1x img
            if let outfit = avatar.selectedItems[.outfit] {
                Image(outfit.imageName)
                    .resizable()
                    .scaledToFit()
                    .zIndex(2)
                
            }

            // Extra items - use @1x img
            if let extra = avatar.selectedItems[.extra] {
                Image(extra.imageName)
                    .resizable()
                    .scaledToFit()
                    .zIndex(3)
            }
        }
        .frame(width: 300, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .onChange(of: avatar.selectedItems[.outfit]) { _, newValue in
            if let outfit = newValue {
                print("Outfit image name changed to: \(outfit.imageName)")
            } else {
                print("Outfit was removed")
            }
        }
    }
}

#Preview {
    PreviewWrapper {
        AvatarPreviewView()
    }
}
