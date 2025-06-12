//
//  GalleryItemView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/4/25.
//

import SwiftUI

struct GalleryItemView: View {
    let saved: SavedAvatar
    let isSelected: Bool
    let isEditing: Bool
    let frameIndex: Int
    let onTap: () -> Void

    var body: some View {
        
        VStack(spacing: 8){
            ZStack() {
                // character
                AvatarThumbnailView(saved: saved)
                    .scaleEffect(0.8)
                
                ZStack(alignment: .bottom) {
                    // Picture Frame overlay — cycle through 4 frames
                    Image("frame\(frameIndex % 4 + 1)")
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            isEditing && isSelected ?
                            RoundedRectangle(cornerRadius: 12).stroke(Color.blue, lineWidth: 4)
                            : nil
                        )
                        .onTapGesture {
                            onTap()
                        }
                    // show checkmark on item being selected
                    if isEditing {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .padding(8)
                            .foregroundColor(isSelected ? .blue : .gray)
                    }
                    
                    // name laid ontop of the frame cutely :)
                    Text(saved.name.isEmpty ? saved.date.toShortDateString() : saved.name)
                        .font(.alert(size: 16))
                        .padding(.bottom, 22)
                }
            }
        }
    }
}

extension Date {
    func toShortDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // ensures consistent output
        formatter.dateFormat = "MM/d/yyyy" // e.g. Jun 11, 2025
        return formatter.string(from: self)
    }
}

#Preview{
    PreviewWrapper{
        GalleryView(path: .constant(NavigationPath()))
    }
}


