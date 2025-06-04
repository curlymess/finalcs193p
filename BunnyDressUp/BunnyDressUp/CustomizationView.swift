//
//  CustomizationView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct CustomizationView: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var selectedCategory: CustomizationCategory = .background
    @State private var showGallery = false


    let items: [ClothingItem] = [
        // select Character on previous screen

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
    
    var filteredCategories: [CustomizationCategory] {
        CustomizationCategory.allCases.filter { $0 != .selectCharacter }
    }

    var body: some View {
        VStack {
            
            Text("Dress Up!")
                .font(.title(size: 60))
                .foregroundStyle(Color.primary)
            
            // select item to change
            Picker("Category", selection: $selectedCategory) {
                ForEach(CustomizationCategory.allCases) { category in
                    if category != .selectCharacter {
                        Text(category.displayName)
//                            .font(.heading(size: 20)) font doesnt work here for some reason
                            .tag(category)
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // actually items to dress character with show display depending the category
            ScrollView(.horizontal) {
                HStack(alignment: .center) {
                    ForEach(items.filter { $0.category == selectedCategory }) { item in
                        VStack {
                            GeometryReader { geo in
                                let size = min(geo.size.width, geo.size.height)
                                
                                Image(
                                    (item.category == .outfit || item.category == .extra) ? (item.imageName + "_icon") : item.imageName
                                )
                                .resizable()
                                .scaledToFit()
                                .frame(width: size, height: size)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(avatar.selectedItems[selectedCategory] == item ? Color.primary : Color.clear, lineWidth: 3)
                                )
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    withAnimation {
                                        avatar.selectedItems[selectedCategory] = item
                                    }
                                }
                            }
                            .aspectRatio(1, contentMode: .fit) // sqyare
                            
                            Text(item.name)
                                .font(.body(size: 16))
                        }
                    }
                    
                }
            }

            Spacer()

            AvatarPreviewView()

            Button("Add to Gallery!") {
                avatar.saveCurrentAvatar()
                showGallery = true
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .appStyle()
        .navigationDestination(isPresented: $showGallery) {
            GalleryView()
                .environmentObject(avatar)
        }
    }
}

#Preview {
    PreviewWrapper {
        CustomizationView()
    }
}
