//
//  GalleryView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var avatar: AvatarModel
    // for renaming
    @State private var renamingAvatar: SavedAvatar? = nil
    @State private var newName: String = ""
    // for multi select editing
    @State private var isEditing = false
    @State private var selectedAvatars: Set<UUID> = []


    var body: some View {
        VStack{
            Text("Gallery")
                .font(.title(size: 60))
                .foregroundColor(.primary)
    
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(avatar.savedAvatars) { saved in
                        let isSelected = selectedAvatars.contains(saved.id)

                        VStack(spacing: 8) {
                            ZStack() {

                            AvatarThumbnailView(saved: saved)
                                        
                                ZStack(alignment: .bottom) {
                                    // Picture Frame overlay — cycle through 4 frames
                                    Image("frame\((avatar.savedAvatars.firstIndex(where: { $0.id == saved.id }) ?? 0) % 4 + 1)")
                                        .resizable()
                                        .scaledToFit()
                                        .overlay(
                                            isEditing && isSelected ?
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.blue, lineWidth: 4)
                                            : nil
                                        )
                                        .onTapGesture {
                                            if isEditing {
                                                if isSelected {
                                                    selectedAvatars.remove(saved.id)
                                                } else {
                                                    selectedAvatars.insert(saved.id)
                                                }
                                            }
                                        }
                                    // show checkmark on item being selected
                                    if isEditing {
                                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                            .padding(8)
                                            .foregroundColor(isSelected ? .blue : .gray)
                                    }
                                    
                                    // name laid ontop of the frame cutely :)
                                    Text(saved.name.isEmpty ? saved.date.formatted(date: .abbreviated, time: .omitted) : saved.name)
                                        .font(.alert(size:16))
                                        .padding(.bottom, 17)
                                    }
                            }
                        }
                        .padding()
                        .contextMenu {
                            Button {
                                renamingAvatar = saved
                                newName = saved.name
                            } label: {
                                Label("Rename", systemImage: "pencil")
                            }
                            
                            Button() {
                                //avatar.shareAvatar()
                            } label: {
                                Label("Share", systemImage: "square.and.arrow.up") // TODO
                            }
                            
                            Button(role: .destructive) {
                                avatar.deleteAvatar(saved)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if isEditing {
                        Button(role: .destructive) {
                            for id in selectedAvatars {
                                if let avatarToDelete = avatar.savedAvatars.first(where: { $0.id == id }) {
                                    avatar.deleteAvatar(avatarToDelete)
                                }
                            }
                            selectedAvatars.removeAll()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            // TODO: Add actual share functionality
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    }
                    
                    Button(isEditing ? "Done" : "Edit") {
                        withAnimation {
                            isEditing.toggle()
                            if !isEditing {
                                selectedAvatars.removeAll()
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
