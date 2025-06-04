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
    // delet confirm
    @State private var showingDeleteConfirmation = false
    @State private var avatarsToDelete: [SavedAvatar] = []

    var body: some View {
        VStack{
            Text("Gallery")
                .font(.title(size: 60))
                .foregroundColor(.primary)
    
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(avatar.savedAvatars) { saved in
                        let isSelected = selectedAvatars.contains(saved.id)
                        let frameIndex = avatar.savedAvatars.firstIndex(where: { $0.id == saved.id }) ?? 0
                        
                        
                        GalleryItemView(
                            saved: saved,
                            isSelected: isSelected,
                            isEditing: isEditing,
                            frameIndex: frameIndex,
                            onTap: {
                                if isEditing {
                                    if isSelected {
                                        selectedAvatars.remove(saved.id)
                                    } else {
                                        selectedAvatars.insert(saved.id)
                                    }
                                }
                            }
                        )
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
                                avatarsToDelete = [saved]
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
                            avatarsToDelete = avatar.savedAvatars.filter { selectedAvatars.contains($0.id) }
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
            .alert("Are you sure you want to delete the selected avatars?", isPresented: Binding(
                get: { !avatarsToDelete.isEmpty },
                set: { if !$0 { avatarsToDelete = [] } }
            )) {
                Button("Delete", role: .destructive) {
//                    for ava in avatarsToDelete {
//                        avatar.deleteAvatar(ava)
//                    }
//                    selectedAvatars.removeAll(where: { id in avatarsToDelete.contains(where: { $0.id == id }) })
//                    avatarsToDelete = []
                }
                Button("Cancel", role: .cancel) {
                    avatarsToDelete = []
                }
            } message: {
                Text("This action cannot be undone.")
            }
            
            Spacer()
            
        }.background(Color.gre.opacity(0.4))
    }
    
    
}


#Preview {
    PreviewWrapper{
        GalleryView()
    }
}
