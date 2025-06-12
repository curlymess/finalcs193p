//
//  GalleryView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var avatar: AvatarModel
    @Binding var path: NavigationPath
    // for renaming
    @State private var renamingAvatar: SavedAvatar? = nil
    @State private var newName: String = ""
    // for multi select editing
    @State private var isEditing = false
    @State private var selectedAvatars: Set<UUID> = []
    // delet confirm
    @State private var showingDeleteConfirmation = false
    @State private var avatarsToDelete: [SavedAvatar] = []
    //share button
    @State private var avatarToShare: SavedAvatar? = nil
    @State private var isSharing = false
    @State private var shareImage: UIImage? = nil


    var body: some View {
        VStack(){
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
                        .contextMenu { makeAvatarContextMenu(for: saved) }
                    }
                }
            }
            .toolbar { galleryToolbar() }
            .deletionAlert(avatarsToDelete: $avatarsToDelete) { toDelete in
                deleteAvatars(toDelete)
            }
            .sheet(isPresented: $isSharing) {
                ShareSheet(activityItems: shareImage.map { [$0] } ?? [])
            }


            .alert("Rename Bunny", isPresented: Binding(
                get: { renamingAvatar != nil },
                set: { if !$0 { renamingAvatar = nil } }
            ), actions: {
                TextField("New name", text: $newName)

                Button("Save", action: {
                    if let original = renamingAvatar {
                        avatar.renameAvatar(original, to: newName)
                    }
                    renamingAvatar = nil
                })

                Button("Cancel", role: .cancel) {
                    renamingAvatar = nil
                }
            })

            Spacer()
            
        }
        .background(Color.gre.opacity(0.4))
    }

    // MARK: Private Functions
    
    private func deleteAvatars(_ toDelete: [SavedAvatar]) {
        for item in toDelete {
            avatar.deleteAvatar(item)
        }
        selectedAvatars.subtract(toDelete.map { $0.id })
        avatarsToDelete = []
    }
    
    @ViewBuilder
    private func makeAvatarContextMenu(for saved: SavedAvatar) -> some View {
        Button {
            renamingAvatar = saved
            newName = saved.name
        } label: {
            Label("Rename", systemImage: "pencil")
        }
        
        Button {
            avatarToShare = saved
            let image = avatar.renderAvatarImage(from: saved)
            shareImage = image
            isSharing = true
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }
        
        
        Button(role: .destructive) {
            avatarsToDelete = [saved]
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    
    @ToolbarContentBuilder
    private func galleryToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            if isEditing {
                Button(role: .destructive) {
                    avatarsToDelete = avatar.savedAvatars.filter { selectedAvatars.contains($0.id) }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                
//                Button {
//                    // TODO: Add actual share functionality
//                } label: {
//                    Label("Share", systemImage: "square.and.arrow.up")
//                }
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
}

extension View {
    func deletionAlert(
        avatarsToDelete: Binding<[SavedAvatar]>,
        deleteAction: @escaping ([SavedAvatar]) -> Void
    ) -> some View {
        self.alert("Are you sure you want to delete the selected bunnies?",
            isPresented: Binding(
                get: { !avatarsToDelete.wrappedValue.isEmpty },
                set: { if !$0 { avatarsToDelete.wrappedValue = [] } }
            )
        ) {
            Button("Delete", role: .destructive) {
                deleteAction(avatarsToDelete.wrappedValue)
            }
            Button("Cancel", role: .cancel) {
                avatarsToDelete.wrappedValue = []
            }
        } message: {
            Text("You can't undo this action!")
        }
    }
}

#Preview {
    PreviewWrapper{
        GalleryView(path: .constant(NavigationPath()))
    }
}
