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
        avatarModel.skinColor = .pink
        avatarModel.eyeColor = .blue
        avatarModel.selectedItems[.selectCharacter] = ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter)
        avatarModel.selectedItems[.background] = ClothingItem(name: "Bg1", imageName: "Bg1", category: .background)
        avatarModel.selectedItems[.extra] = ClothingItem(name: "Extra6", imageName: "extra6", category: .extra)
        avatarModel.selectedItems[.outfit] = ClothingItem(name: "Outfit6", imageName: "outfit6", category: .outfit)
        self.model = avatarModel
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

