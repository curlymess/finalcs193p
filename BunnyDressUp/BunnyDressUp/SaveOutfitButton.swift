//
//  SaveOutfitButton.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SaveOutfitButton: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var showSheet = false

    var body: some View {
        Button("Save Outfit") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            SaveOutfitSheet()
        }
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

    return NavigationStack {
        SaveOutfitButton()
            .environmentObject(model)
    }
}

