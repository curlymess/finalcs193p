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
//    @Published var skinColor: Color = .init(red: 1.0, green: 0.87, blue: 0.77) // optional if still want skinColor
//    @Published var eyeColor: Color = .brown // optional if still want eyeColor
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
    
    private let saveKey = "SavedAvatars"

    func saveAvatarsToDisk() {
        do {
            let data = try JSONEncoder().encode(savedAvatars)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Error saving avatars: \(error)")
        }
    }
    
    @MainActor
    func renderAvatarImage(from saved: SavedAvatar, size: CGSize = CGSize(width: 300, height: 300)) -> UIImage {
        let avatarView = AvatarThumbnailView(saved: saved)
            .frame(width: size.width, height: size.height)
        return renderImage(from: avatarView, size: size)
    }
    
    func renderImage<V: View>(from view: V, size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: view)
        controller.view.frame = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func saveImageToTempFile(_ image: UIImage) -> URL? {
        guard let data = image.pngData() else { return nil }
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("avatar.png")
        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            print("Failed to write image to temp file:", error)
            return nil
        }
    }


    func loadSavedAvatar() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                let avatars = try JSONDecoder().decode([SavedAvatar].self, from: data)
                savedAvatars = avatars
            } catch {
                print("Error loading avatars: \(error)")
            }
        }
    }
    
    func deleteAvatar(_ avatarToDelete: SavedAvatar) {
        savedAvatars.removeAll { $0.id == avatarToDelete.id }
        saveAvatarsToDisk()
    }

    func renameAvatar(_ avatarToRename: SavedAvatar, to newName: String) {
        if let index = savedAvatars.firstIndex(where: { $0.id == avatarToRename.id }) {
            savedAvatars[index].name = newName
            saveAvatarsToDisk()
        }
    }


    func saveCurrentAvatar() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let autoName = formatter.string(from: Date())
        
        let avatar = SavedAvatar(
            id: UUID(),
            name: autoName,
            date: Date(),
//            skinColor: skinColor,
//            eyeColor: eyeColor,
            items: selectedItems
        )
        savedAvatars.append(avatar)
        saveAvatarsToDisk()
    }
    
    func saveOutfit(named name: String) {
        let avatar = SavedAvatar(
            id: UUID(),
            name: name.isEmpty ? "Unnamed Outfit" : name,
            date: Date(),
            items: selectedItems
        )
        savedAvatars.append(avatar)
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

struct ClothingItem: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let imageName: String
    let category: CustomizationCategory
    
    init(id: UUID = UUID(), name: String, imageName: String, category: CustomizationCategory) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.category = category
    }
    
    static func == (lhs: ClothingItem, rhs: ClothingItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SavedAvatar: Identifiable, Codable {
    let id: UUID
    var name: String  // let it auto be the date made
    var date: Date
//    let skinColor: CodableColor
//    let eyeColor: CodableColor
    var items: [CustomizationCategory: ClothingItem]
}


enum CustomizationCategory: String, CaseIterable, Identifiable, Codable, Hashable {
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
