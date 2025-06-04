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

