//
//  GalleryView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var avatar: AvatarModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(avatar.savedAvatars) { saved in
                    VStack {
                        AvatarThumbnailView(saved: saved)
                        Text(saved.date, style: .date)
                            .font(.caption)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Saved Avatars")
    }
}


#Preview {
    PreviewWrapper{
        GalleryView()
    }
}
