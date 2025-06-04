//
//  CharacterGridView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//

import SwiftUI

struct CharacterGridView: View {
    let characters: [ClothingItem]
    let selectedCharacter: ClothingItem?
    let showStarsFor: ClothingItem?
    let onSelect: (ClothingItem) -> Void

    var body: some View {
        GeometryReader { geometry in
            let columnCount = geometry.size.width < 500 ? 2 : 3
            let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: columnCount)

            LazyVGrid(columns: columns) {
                ForEach(characters) { character in
                    CharacterThumbnailView(
                        character: character,
                        isSelected: character == selectedCharacter,
                        showStars: showStarsFor == character
                    ) {
                        onSelect(character)
                    }
                }
            }
            .padding()
            .background(Color.bg2Color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(height: 600) // or a suitable height, to prevent scrollview sizing issues
    }
}
