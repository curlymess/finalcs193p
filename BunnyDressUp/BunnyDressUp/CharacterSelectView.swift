//
//  CharacterSelectView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//

import SwiftUI

struct CharacterSelectView: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var avatar: AvatarModel
    @State private var selectedCharacter: ClothingItem? = nil
    @State private var showStarsFor: ClothingItem? = nil
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var scrollIndex: Int = 0

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
            VStack(spacing: 0){
                Text("Choose Your")
                    .font(.heading(size: 36))
                Text("Character")
                    .font(.heading(size: 44))
            }.padding()

            VStack{
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
                
                ZStack {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(characters.indices, id: \.self) { index in
                                    let character = characters[index]
                                    CharacterCardView(
                                        character: character,
                                        isSelected: selectedCharacter == character,
                                        showStars: showStarsFor == character
                                    ) {
                                        withAnimation {
                                            selectedCharacter = character
                                            showStarsFor = character
                                            scrollIndex = index
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                showStarsFor = nil
                                            }
                                        }
                                    }
                                    .id(index)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .onAppear {
                            scrollViewProxy = proxy
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            scrollBy(-1)
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding()
                        }
                        Spacer()
                        Button(action: {
                            scrollBy(1)
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.primary)
                                .font(.title)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 150)
            }
            .background(Color.bg2Color)

            Spacer()

            if let selected = selectedCharacter {
                NavigationLink(value: AppRoute.customization) {
                    Text("Next")
                }
                .buttonStyle(.borderedProminent)
                .font(.heading(size: 48))
                .padding()
                .onAppear {
                    avatar.selectedItems[.selectCharacter] = selected
                    avatar.saveCurrentAvatar()
                }
            }
        }
        .background(Color.bgColor)
        .onAppear {
            avatar.loadSavedAvatar()
        }
    }

    private func scrollBy(_ direction: Int) {
        guard let proxy = scrollViewProxy else { return }
        let newIndex = min(max(scrollIndex + direction, 0), characters.count - 1)
        scrollIndex = newIndex
        withAnimation {
            proxy.scrollTo(newIndex, anchor: .center)
        }
    }

}

#Preview {
    PreviewWrapper {
        CharacterSelectView(path: .constant(NavigationPath()))
    }
}
