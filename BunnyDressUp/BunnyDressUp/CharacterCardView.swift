//
//  CharacterCardView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//

import SwiftUI

struct CharacterCardView: View {
    let character: ClothingItem
    let isSelected: Bool
    let showStars: Bool
    let onTap: () -> Void

    var body: some View {
    VStack {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            Image(character.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 3)
                )
                .scaleEffect(isSelected ? 1.00 : 0.90)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
                .onTapGesture {
                    onTap()
                }
        }
        .aspectRatio(1, contentMode: .fit)
        
        if showStars {
            ShimmerStars()
                .transition(.opacity)
                .zIndex(1)
        }
    }
    .frame(maxHeight: UIScreen.main.bounds.height / 4)
    
}

}


//struct CharacterCardView: View {
//    let character: ClothingItem
//    let isSelected: Bool
//    let showStars: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        ZStack {
//            Image(character.imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(
//                    width: UIScreen.main.bounds.height * 0.8, // divide by number of visible cards per page
//                    height: UIScreen.main.bounds.height * 0.8 // / CGFloat(3)
//                )
//                .frame(maxWidth: .infinity, alignment: .center)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 3)
//                )
//                .scaleEffect(isSelected ? 1.1 : 1.0)
//                .animation(.easeInOut(duration: 0.2), value: isSelected)
//                .onTapGesture { onTap() }
//
//            if showStars {
//                ShimmerStars()
//                    .transition(.opacity)
//                    .zIndex(1)
//            }
//        }
//    }
//}
