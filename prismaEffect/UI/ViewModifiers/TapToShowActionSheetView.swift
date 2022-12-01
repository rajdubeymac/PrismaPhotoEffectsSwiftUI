//
//  TapToShowActionSheetView.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import SwiftUI

public struct TapToShowActionSheetView<Content: View>: View {
    
    private let content: Content
    private let actionSheet: ActionSheet
    
    @State private var showActionSheet = false
    
    public init(actionSheet: ActionSheet, content: Content) {
        self.content = content
        self.actionSheet = actionSheet
    }
    
    public var body: some View {
        Button {
            showActionSheet = true
        } label: {
            content
        }
        .actionSheet(isPresented: $showActionSheet) {
            actionSheet
        }
    }
}
