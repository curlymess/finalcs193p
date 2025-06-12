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
    var onSave: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    Text("Name your Bunny")
                        .font(.body(size: 32))
                    TextField("Name", text: $outfitName)
                }
            }
//            .navigationTitle("Edit Bunny Info")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .font(.body(size: 32))
                }
                
                ToolbarItem(placement: .confirmationAction){
                    Button("Save") {
                        avatar.saveOutfit(named: outfitName)
                        onSave()
                        dismiss()
                    }
                    .font(.body(size: 32))
                }
            }
        }
    }
}

#Preview {
    PreviewWrapper{
//        SaveOutfitSheet()
    }
}

