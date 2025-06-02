//
//  AvatarModel.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI
import AVFoundation

class AvatarModel: ObservableObject {
    @Published var selectedItems: [CustomizationCategory: ClothingItem] = [:]
    @Published var skinColor: Color = .init(red: 1.0, green: 0.87, blue: 0.77) // optional if you still want skinColor
    @Published var eyeColor: Color = .brown // optional if you still want eyeColor
    @Published var savedAvatars: [SavedAvatar] = []
    @Published var isMusicOn: Bool = true {
        didSet {
            if isMusicOn {
                MusicPlayer.shared.play()
            } else {
                MusicPlayer.shared.stop()
            }
        }
    }

    func saveCurrentAvatar() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let autoName = formatter.string(from: Date())
        let avatar = SavedAvatar(
            name: autoName,
            date: Date(),
            skinColor: skinColor,
            eyeColor: eyeColor,
            items: selectedItems
        )
        savedAvatars.append(avatar)
    }

    func saveOutfit(named name: String) {
        let outfit = SavedAvatar(
            name: name,
            date: Date(),
            skinColor: skinColor,
            eyeColor: eyeColor,
            items: selectedItems
        )
        savedAvatars.append(outfit)
    }

}

class MusicPlayer {
    static let shared = MusicPlayer()
    private var player: AVAudioPlayer?

    func play() {
        guard let url = Bundle.main.url(forResource: "background_music", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print("Failed to play music: \(error)")
        }
    }

    func stop() {
        player?.stop()
    }
}

struct ClothingItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    let category: CustomizationCategory
}

struct SavedAvatar: Identifiable {
    let id = UUID()
    let name: String  // let it auto be the date made
    let date: Date
    let skinColor: Color
    let eyeColor: Color
    let items: [CustomizationCategory: ClothingItem]
}


enum CustomizationCategory: String, CaseIterable, Identifiable {
    case selectCharacter
    case background
    case outfit
    case extra

    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .selectCharacter: return "Character"
        case .background: return "Background"
        case .outfit: return "Outfit"
        case .extra: return "Extra"
        }
    }
}
