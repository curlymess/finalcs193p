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
            ForEach(0..<20, id: \.self) { i in
                Image(systemName: "sparkles")
                    .foregroundColor(.yellow)
                    .font(.title)
                    .opacity(Double.random(in: 0.7...1))
                    .position(x: CGFloat.random(in: 10...140), y: CGFloat.random(in: -100...20))
                    .rotationEffect(.degrees(Double.random(in: 0..<360)))

                    .scaleEffect(animate ? 1.2 : 0.8)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 0.5...1.5))
                            .repeatForever(autoreverses: true),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
        .frame(height: 60)
        .offset(y: -60)
    }
}
