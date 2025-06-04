//
//  SettingsView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var avatar: AvatarModel

    var body: some View {
        Form {
            Toggle("Background Music", isOn: $avatar.isMusicOn)
            Toggle("Log in to save your info", isOn: $avatar.isMusicOn)

            
            
        }
        .navigationTitle("Settings")
        .font(.body(size: 32))
        .padding()
        .background(Color.bgColor)
    }
}

#Preview {
    PreviewWrapper{
        SettingsView()
    }
}

