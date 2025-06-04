//
//  CharacterSelectView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//

import SwiftUI

struct CharacterSelectView: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var selectedCharacter: ClothingItem? = nil
    @State private var showStarsFor: ClothingItem? = nil

    let characters: [ClothingItem] = [
        ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny2", imageName: "bunny2", category: .selectCharacter),
        ClothingItem(name: "Bunny3", imageName: "bunny3", category: .selectCharacter),
        ClothingItem(name: "Bunny4", imageName: "bunny4", category: .selectCharacter),
        ClothingItem(name: "Bunny5", imageName: "bunny5", category: .selectCharacter),
        ClothingItem(name: "Bunny6", imageName: "bunny6", category: .selectCharacter),
        ClothingItem(name: "Bunny7", imageName: "bunny7", category: .selectCharacter),
    ]

    var body: some View {
        VStack {
            Text("Choose Your Character")
                .font(.heading(size: 48))
                .padding()
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxHeight: UIScreen.main.bounds.height / 3)
                
                if let selected = selectedCharacter {
                    Image(selected.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: UIScreen.main.bounds.height / 3)
                        .transition(.opacity)
                } else {
                    Image(systemName: "questionmark")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.gray)
                }
                
            }
            .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(characters) { character in
                        CharacterCardView(
                            character: character,
                            isSelected: selectedCharacter == character,
                            showStars: showStarsFor == character
                        ) {
                            withAnimation {
                                selectedCharacter = character
                                showStarsFor = character
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showStarsFor = nil
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .font(.title)
                    .padding(.leading, 8)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.title)
                    .padding(.trailing, 8)
            }
            
            if let selected = selectedCharacter {
                NavigationLink(destination: {
                    CustomizationView()
                        .onAppear {
                            avatar.selectedItems[.selectCharacter] = selected
                            avatar.saveCurrentAvatar()
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
        .background(Color.bgColor)
        .onAppear {
            avatar.loadSavedAvatar()
        }
    }
}


#Preview {
    PreviewWrapper {
        CharacterSelectView()
    }
}
