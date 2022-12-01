//
//  FullScreenPresenting.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import SwiftUI

struct TapToPresentStyle<Destination: View>: ViewModifier {
    
    let destination: Destination
    let isFullScreen: Bool
    
    @State private var sheetIsPresented = false
    @State private var fullScreenIsPresented = false
    @Environment(\.presentationMode) private var presentationMode
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                if isFullScreen {
                    fullScreenIsPresented = true
                } else {
                    sheetIsPresented = true
                }
            }
            .fullScreenCover(isPresented: $fullScreenIsPresented) {
                destination
            }
            .sheet(isPresented: $sheetIsPresented) {
                destination
            }
    }

}


extension View {
    func tapToPresent<Destination: View>(_ view: Destination, _ isFullScreen: Bool = true) -> some View {
        ModifiedContent(content: self, modifier: TapToPresentStyle(destination: view, isFullScreen: isFullScreen))
    }
}
