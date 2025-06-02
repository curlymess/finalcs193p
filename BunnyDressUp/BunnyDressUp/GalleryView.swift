//
//  GalleryView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var avatar: AvatarModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(avatar.savedAvatars) { saved in
                    VStack {
                        AvatarThumbnailView(saved: saved)
                        Text(saved.date, style: .date)
                            .font(.caption)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Saved Avatars")
    }
}

struct AvatarThumbnailView: View {
    let saved: SavedAvatar

    var baseCharacterImage: String {
        saved.items[.selectCharacter]?.imageName ?? "default_character"
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
        .frame(width: 120, height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
    }
}

#Preview {
    let model = AvatarModel()
    model.skinColor = .pink
    model.eyeColor = .blue
    model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter)
    model.selectedItems[.background] = ClothingItem(name: "Bg1", imageName: "Bg1", category: .background)
    model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
    model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit6", category: .outfit)

    let savedAvatar = SavedAvatar(
        name: "heyyy",
        date: Date(),
        skinColor: .pink,
        eyeColor: .blue,
        items: model.selectedItems
    )
    model.savedAvatars.append(savedAvatar)

    return NavigationStack {
        GalleryView()
            .environmentObject(model)
    }
}
