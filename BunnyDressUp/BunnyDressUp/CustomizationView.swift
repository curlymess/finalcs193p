//
//  CustomizationView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct CustomizationView: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var selectedCategory: CustomizationCategory = .selectCharacter

    let items: [ClothingItem] = [
        // Characters
        ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny2", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny3", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny4", imageName: "bunny", category: .selectCharacter),

        // Backgrounds
        ClothingItem(name: "Bg1", imageName: "Bg1", category: .background),
        ClothingItem(name: "Bg2", imageName: "Bg2", category: .background),
        ClothingItem(name: "Bg3", imageName: "Bg3", category: .background),
        ClothingItem(name: "Bg4", imageName: "Bg4", category: .background),
        ClothingItem(name: "Bg5", imageName: "Bg5", category: .background),

        // Outfits
        ClothingItem(name: "Outfit1", imageName: "outfit1", category: .outfit),
        ClothingItem(name: "Outfit2", imageName: "outfit2", category: .outfit),
        ClothingItem(name: "Outfit3", imageName: "outfit3", category: .outfit),
        ClothingItem(name: "Outfit4", imageName: "outfit4", category: .outfit),
        ClothingItem(name: "Outfit5", imageName: "outfit5", category: .outfit),
        ClothingItem(name: "Outfit6", imageName: "outfit6", category: .outfit),

        // Extras
        ClothingItem(name: "Extra1", imageName: "extra1", category: .extra),
        ClothingItem(name: "Extra2", imageName: "extra2", category: .extra),
        ClothingItem(name: "Extra3", imageName: "extra3", category: .extra),
        ClothingItem(name: "Extra4", imageName: "extra4", category: .extra),
        ClothingItem(name: "Extra5", imageName: "extra5", category: .extra),
        ClothingItem(name: "Extra6", imageName: "extra6", category: .extra),
    ]

    var body: some View {
        VStack {
            // select item to change
            Picker("Category", selection: $selectedCategory) {
                ForEach(CustomizationCategory.allCases) { category in
                    Text(category.displayName).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // actually items to dress character with show display depending the category
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(items.filter { $0.category == selectedCategory }) { item in
                        VStack {
                            Image(
                                (item.category == .outfit || item.category == .extra) ? (item.imageName + "_icon") : item.imageName)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(avatar.selectedItems[selectedCategory] == item ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        avatar.selectedItems[selectedCategory] = item
                                    }
                                }
                            Text(item.name)
                                .font(.caption)
                        }
                    }
                }
                .padding()
            }

            Spacer()

            Text("Preview")
                .font(.headline)

            AvatarPreviewView()
                .frame(width: 300, height: 400)
                .padding()

            Button("Save Avatar") {
                avatar.saveCurrentAvatar()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Customize")
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
        CustomizationView()
            .environmentObject(model)
    }
}
