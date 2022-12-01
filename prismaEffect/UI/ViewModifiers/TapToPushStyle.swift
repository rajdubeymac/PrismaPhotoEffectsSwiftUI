//
//  NavigationLinkStyle.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import SwiftUI

struct TapToPushStyle<Destination: View>: ViewModifier {
    
    let destination: Destination
    
    func body(content: Content) -> some View {
        return NavigationLink(destination: destination) {
            content
        }
        .isDetailLink(false)
        .buttonStyle(.borderless)
    }
}

extension View {
    func tapToPush<Destination: View>(_ destination: Destination) -> some View {
        ModifiedContent(content: self, modifier: TapToPushStyle(destination: destination))
    }
}
