//
//  Font+Custom.swift
//  BunnyDressUp
//
//  Created by Noor Fakih on 6/2/25.
//

import SwiftUI

extension Font {
    static func title(size: CGFloat) -> Font {
        .custom("Amorlate", size: size, relativeTo: .largeTitle)
    }
    
    static func heading(size: CGFloat) -> Font {
        .custom("BrookeShappell10", size: size)
    }
    
    static func alert(size: CGFloat) -> Font {
        .custom("Ups, Downs, Highs & Lows", size: size)
    }
    
    static func body(size: CGFloat) -> Font {
        .custom("Bubble Bats", size: size, relativeTo: .body)
    }



}

#Preview(){
    Text("Bunny Friends")
        .font(.title(size: 32))
        
    Text("head - Bunny Friends")
        .font(.heading(size: 32))
    
    Text("alert - Bunny Friends")
        .font(.alert(size: 32))
    
    Text("body - Bunny Friends")
        .font(.body(size: 32))
}
