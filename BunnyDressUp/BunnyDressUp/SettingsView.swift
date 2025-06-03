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
        }
        .navigationTitle("Settings")
        .padding()
    }
}

#Preview {
    PreviewWrapper{
        SettingsView()
    }
}

