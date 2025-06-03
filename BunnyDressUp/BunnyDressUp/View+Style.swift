//
//  View+Style.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/2/25.
//

import SwiftUI

extension View {
    func appStyle() -> some View {
        self
            .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

#Preview(){
    PreviewWrapper{
        CustomizationView()
            .appStyle()
    }
}
