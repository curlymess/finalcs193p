//
//  CharacterThumbnailView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//

import SwiftUI

struct CharacterThumbnailView: View {
    let character: ClothingItem
    let isSelected: Bool
    let showStars: Bool
    let onSelect: () -> Void

    var body: some View {
        ZStack {
            Image(character.imageName)
                .resizable()
                .frame(width: 180, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 3)
                )
                .scaleEffect(isSelected ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
                .onTapGesture(perform: onSelect)

            if showStars {
                ShimmerStars()
                    .transition(.opacity)
                    .zIndex(1)
                    .allowsHitTesting(false)
            }
        }
    }
}
