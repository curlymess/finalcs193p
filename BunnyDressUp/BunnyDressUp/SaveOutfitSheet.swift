//
//  SaveOutfitSheet.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SaveOutfitSheet: View {
    @EnvironmentObject var avatar: AvatarModel
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Outfit name", text: $name)
                Button("Save") {
                    avatar.saveOutfit(named: name)
                    dismiss()
                }
            }
            .navigationTitle("Save Outfit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
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
        SaveOutfitSheet()
            .environmentObject(model)
    }
}

