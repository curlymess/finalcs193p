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
    @State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                WelcomeView(path: $path)
            }
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
