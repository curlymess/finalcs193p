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
                .environment(\.font, Font.body(size: 24))
                .onAppear {
                    if avatar.isMusicOn {
                        MusicPlayer.shared.play()
                    }
                }
        }
    }
}

// #ffebe8
// #FDDDE6
// 0em dotted #ccc
// #ddd hover


// vanilla ice - #F3E1E7 bg
// magenta - #F279BC
// lavender - #B6B9F2
// green - #66D998
