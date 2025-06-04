//
//  ShimmerStars.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/3/25.
//

import SwiftUI

struct ShimmerStars: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { i in
                Image(systemName: "sparkles")
                    .foregroundColor(.yellow)
                    .font(.title)
                    .opacity(animate ? 1 : 0)
                    .offset(x: CGFloat.random(in: -30...30), y: CGFloat.random(in: -50...0))
                    .scaleEffect(animate ? 1.2 : 0.8)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(Double(i) * 0.2), value: animate)
            }
        }
        .onAppear {
            animate = true
        }
        .frame(height: 60)
        .offset(y: -60)
    }
}
