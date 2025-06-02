//
//  BunnyDressUpApp.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

@main
struct DressUpApp: App {
    @StateObject private var avatar = AvatarModel()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(avatar)
                .onAppear {
                    if avatar.isMusicOn {
                        MusicPlayer.shared.play()
                    }
                }
        }
    }
}

