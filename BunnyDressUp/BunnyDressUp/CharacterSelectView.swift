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

    let characters: [ClothingItem] = [
        ClothingItem(name: "Bunny", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny2", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny3", imageName: "bunny", category: .selectCharacter),
        ClothingItem(name: "Bunny4", imageName: "bunny", category: .selectCharacter)
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
                        LazyVGrid(columns: columns) {
                            ForEach(characters) { character in
                                Image(character.imageName)
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(character == selectedCharacter ? Color.primary : Color.clear, lineWidth: 3)
                                    )
                                    .scaleEffect(character == selectedCharacter ? 1.1 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: selectedCharacter)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedCharacter = character
                                        }
                                    }
                                    .background(Color.white)
//                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                            }
                        }
                        .padding()
                        .frame(alignment: .center)
                        .background(Color.bg2Color)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .background(Color.bgColor)
                    
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
