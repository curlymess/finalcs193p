//
//  AvatarThumbnailView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//
import SwiftUI

struct AvatarThumbnailView: View {
    let saved: SavedAvatar

    var baseCharacterImage: String {
        saved.items[.selectCharacter]?.imageName ?? "bunny"
    }

    var body: some View {
        ZStack {
            Image(baseCharacterImage)
                .resizable()
                .scaledToFit()

            if let bg = saved.items[.background] {
                Image(bg.imageName)
                    .resizable()
                    .scaledToFit()
                    .zIndex(-1)
            }

            if let outfit = saved.items[.outfit] {
                Image(outfit.imageName)
                    .resizable()
                    .scaledToFit()
            }

            if let extra = saved.items[.extra] {
                Image(extra.imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
    }
}
