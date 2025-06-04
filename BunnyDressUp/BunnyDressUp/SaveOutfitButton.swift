//
//  SaveOutfitButton.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SaveOutfitButton: View {
    @EnvironmentObject var avatar: AvatarModel
    @State private var showSheet = false

    var body: some View {
        Button("Save Outfit") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            SaveOutfitSheet()
        }
    }
}

#Preview {
    PreviewWrapper{
        SaveOutfitButton()
            .environment(\.font, Font.body(size: 24))
    }
}

