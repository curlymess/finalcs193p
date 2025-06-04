//
//  CharacterSelectView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/2/25.
//

import SwiftUI

struct CharacterSelectView: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var selectedCharacter: ClothingItem? = nil
    @State private var showStarsFor: ClothingItem? = nil

    let characters: [ClothingItem] = [
        ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny1", imageName: "bunny1", category: .selectCharacter),
        ClothingItem(name: "Bunny2", imageName: "bunny2", category: .selectCharacter),
        ClothingItem(name: "Bunny3", imageName: "bunny3", category: .selectCharacter),
        ClothingItem(name: "Bunny4", imageName: "bunny4", category: .selectCharacter),
        ClothingItem(name: "Bunny5", imageName: "bunny5", category: .selectCharacter),
        ClothingItem(name: "Bunny6", imageName: "bunny6", category: .selectCharacter),
        ClothingItem(name: "Bunny7", imageName: "bunny7", category: .selectCharacter)
    ]

    var body: some View {
            GeometryReader { geometry in
                let columnCount = geometry.size.width < 500 ? 2 : 3
                let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: columnCount)
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 0){
                        Text("Choose Your")
                            .font(.heading(size: 48))
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("Character")
                            .font(.heading(size: 48))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(10)
                    
                    
                    ScrollView {
                        CharacterGridView(
                            characters: characters,
                            selectedCharacter: selectedCharacter,
                            showStarsFor: showStarsFor
                        ) { character in
                            withAnimation {
                                selectedCharacter = character
                                showStarsFor = character
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showStarsFor = nil
                                }
                            }
                        }
                        .background(Color.bgColor)
                    }
                    
                    if let selected = selectedCharacter
                    {
                        NavigationLink(destination: {
                            CustomizationView()
                                .onAppear {
                                    avatar.selectedItems[.selectCharacter] = selected
                                    avatar.saveCurrentAvatar() // Save selection
                                }
                        }) {
                            Text("Next")
                                .bold()
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }

                }
            }
            .background(Color.bgColor)
            .onAppear {
                avatar.loadSavedAvatar()
            }
    }
}


#Preview {
    PreviewWrapper {
        CharacterSelectView()
            .environment(\.font, Font.body(size: 24))
    }
}
