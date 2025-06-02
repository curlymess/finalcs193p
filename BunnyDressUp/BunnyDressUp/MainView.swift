//
//  ContentView.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/1/25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: CustomizationCategory? = .background

    var body: some View {
        NavigationSplitView {
            List(CustomizationCategory.allCases) { category in
                NavigationLink(value: category) {
                    Text(category.rawValue.capitalized)
                }
            }
            .navigationTitle("Categories")
        } detail: {
            if selectedCategory != nil {
                CustomizationView()
            } else {
                Text("Select a category")
            }
        }
    }
}

#Preview {
    MainView()
}
