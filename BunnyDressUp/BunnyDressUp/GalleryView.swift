//
//  GalleryView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var renamingAvatar: SavedAvatar? = nil
    @State private var newName: String = ""

    var body: some View {
        VStack{
            Text("Gallery")
                .font(.title(size: 60))
                .foregroundColor(.primary)
    
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(avatar.savedAvatars) { saved in
                        VStack(spacing: 8) {
                            // Picture Frame
                            ZStack {
                                AvatarThumbnailView(saved: saved)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                ZStack(alignment: .bottom) {
                                    // Frame overlay — cycle through 4 frames
                                    Image("frame\((avatar.savedAvatars.firstIndex(where: { $0.id == saved.id }) ?? 0) % 4 + 1)")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    // Name
                                    Text(saved.name.isEmpty ? saved.date.formatted(date: .abbreviated, time: .omitted) : saved.name)
                                        .font(.alert(size:16))
                                        .padding(.bottom, 17)
                                }
                                
                            }
                            //                        .frame(width: 120, height: 120)
                        }
                        .padding()
                        .contextMenu {
                            Button(role: .destructive) {
                                avatar.deleteAvatar(saved)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                renamingAvatar = saved
                                newName = saved.name
                            } label: {
                                Label("Rename", systemImage: "pencil")
                            }
                        }
                    }
                }
            }
            .alert("Rename Avatar", isPresented: Binding(
                get: { renamingAvatar != nil },
                set: { if !$0 { renamingAvatar = nil } }
            ), actions: {
                TextField("New name", text: $newName)
                Button("Save") {
                    if let index = avatar.savedAvatars.firstIndex(where: { $0.id == renamingAvatar?.id }) {
                        avatar.savedAvatars[index].name = newName
                        avatar.saveAvatarsToDisk()
                    }
                    renamingAvatar = nil
                }
                Button("Cancel", role: .cancel) {
                    renamingAvatar = nil
                }
            }) {
                Text("Enter a new name for the avatar.")
            }
        }.background(Color.gre.opacity(0.4))
    }
    
    
}


#Preview {
    PreviewWrapper{
        GalleryView()
    }
}
