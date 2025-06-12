//
//  SaveOutfitButton.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SaveOutfitButton: View {
    @EnvironmentObject var avatar: AvatarModel
    @Binding var path: NavigationPath
    @State private var showSheet = false


    var body: some View {
        Button("Add to Gallery") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            SaveOutfitSheet{
                path.append(AppRoute.gallery)
            }
        }
    }
}

#Preview {
    PreviewWrapper{
        SaveOutfitButton(path: .constant(NavigationPath()))
    }
}

