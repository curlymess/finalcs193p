//
//  SaveOutfitSheet.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SaveOutfitSheet: View {
    @EnvironmentObject var avatar: AvatarModel
    @Environment(\.dismiss) private var dismiss
    @State private var outfitName: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Outfit name", text: $outfitName)
                }
            }
            .navigationTitle("Save Outfit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save") {
                        avatar.saveOutfit(named: outfitName)
                        dismiss()
                }
            }
        }
    }
}

#Preview {
    PreviewWrapper{
        SaveOutfitSheet()
    }
}

