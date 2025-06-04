//
//  PreviewWrapper.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/2/25.
//

import SwiftUI

struct PreviewWrapper<Content: View>: View {
    let content: Content
    let model: AvatarModel

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        let avatarModel = AvatarModel()
        //        avatarModel.skinColor = .pink
        //        avatarModel.eyeColor = .blue
        avatarModel.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter)
        avatarModel.selectedItems[.background] = ClothingItem(name: "Bg1", imageName: "Bg1", category: .background)
        avatarModel.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
        avatarModel.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit6", category: .outfit)
        self.model = avatarModel
        
        let model = AvatarModel()
        model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny2", imageName: "bunny2", category: .selectCharacter)
        model.selectedItems[.background] = ClothingItem(name: "Bg1", imageName: "Bg1", category: .background)
        model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
        model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit6", category: .outfit)

        let savedAvatar = SavedAvatar(
            id: UUID(),
            name: "heyyy",
            date: Date(),
            items: model.selectedItems
        )
        avatarModel.savedAvatars.append(savedAvatar)
        
        model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny3", imageName: "bunny3", category: .selectCharacter)
        model.selectedItems[.background] = ClothingItem(name: "Bg1", imageName: "Bg4", category: .background)
        model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra3", category: .extra)
        model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit1", category: .outfit)

        let savedAvatar2 = SavedAvatar(
            id: UUID(),
            name: "Opal",
            date: Date(),
            items: model.selectedItems
        )
        avatarModel.savedAvatars.append(savedAvatar2)
        
        model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny4", imageName: "bunny4", category: .selectCharacter)
        model.selectedItems[.background] = ClothingItem(name: "Bg2", imageName: "Bg2", category: .background)
        model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra3", category: .extra)
        model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit1", category: .outfit)

        let savedAvatar3 = SavedAvatar(
            id: UUID(),
            name: "Thyme",
            date: Date(),
            items: model.selectedItems
        )
        avatarModel.savedAvatars.append(savedAvatar3)
        
        model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny5", imageName: "bunny5", category: .selectCharacter)
        model.selectedItems[.background] = ClothingItem(name: "Bg3", imageName: "Bg3", category: .background)
        model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
        model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit4", category: .outfit)

        let savedAvatar4 = SavedAvatar(
            id: UUID(),
            name: "Zaytoun",
            date: Date(),
            items: model.selectedItems
        )
        avatarModel.savedAvatars.append(savedAvatar4)
        
        model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny6", imageName: "bunny6", category: .selectCharacter)
        model.selectedItems[.background] = ClothingItem(name: "Bg3", imageName: "Bg3", category: .background)
        model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
        model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit4", category: .outfit)

        let savedAvatar5 = SavedAvatar(
            id: UUID(),
            name: "Olive",
            date: Date(),
            items: model.selectedItems
        )
        avatarModel.savedAvatars.append(savedAvatar5)
        
        model.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny7", imageName: "bunny7", category: .selectCharacter)
        model.selectedItems[.background] = ClothingItem(name: "Bg3", imageName: "Bg3", category: .background)
        model.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
        model.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit4", category: .outfit)

        let savedAvatar6 = SavedAvatar(
            id: UUID(),
            name: "Bun Bun",
            date: Date(),
            items: model.selectedItems
        )
        avatarModel.savedAvatars.append(savedAvatar6)

        
    }

    var body: some View {
        NavigationStack {
            content
        }.environmentObject(model)

    }
}

#Preview {
    PreviewWrapper {
        CharacterSelectView()
    }
}

