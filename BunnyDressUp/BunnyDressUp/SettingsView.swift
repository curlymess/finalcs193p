//
//  SettingsView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var avatar: AvatarModel

    var body: some View {
        Form {
            Toggle("Background Music", isOn: $avatar.isMusicOn)
        }
        .navigationTitle("Settings")
        .padding()
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
        SettingsView()
            .environmentObject(model)
    }
}

