//
//  ShareView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/11/25.
//

import SwiftUI

struct ShareView: View {
    @EnvironmentObject var avatar: AvatarModel
    @Binding var path: NavigationPath
    
    //sharing
    @State private var isSharing = false
    @State private var shareImage: UIImage? = nil

    var body: some View {
        VStack {
            Spacer()
            Text("Share your Bunny!")
                .font(.title(size: 55))
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)

            AvatarPreviewView()

            HStack{
                NavigationLink(value: AppRoute.gallery) {
                    SaveOutfitButton(path: $path)
                        .buttonStyle(.borderedProminent)
                        .font(.heading(size: 48))
                        .padding()
                }
                
                Button {
                    let image = avatar.renderAvatarImage(from: SavedAvatar(
                        id: UUID(),
                        name: "Shared Bunny",
                        date: Date(),
                        items: avatar.selectedItems
                    ))
                    shareImage = image
                    isSharing = true
                } label: {
                    VStack {
                        Text("Share")
                        Image(systemName: "arrow.down.circle")
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(.heading(size: 48))
                .padding()
                .sheet(isPresented: $isSharing, onDismiss: {
                    // go back to home after share sheet closes
                    path.removeLast(path.count)
                }) {
                    ShareSheet(activityItems: shareImage.map { [$0] } ?? [])
                }

            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bgColor)
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    PreviewWrapper {
        ShareView(path: .constant(NavigationPath()))
    }
}

