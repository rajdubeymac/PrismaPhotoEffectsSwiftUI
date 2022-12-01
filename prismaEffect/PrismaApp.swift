//
//  PrismaApp.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//
import GoogleMobileAds
import SwiftUI
import PurchaseKit

@main
struct PrismaApp: App {
    init(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        PKManager.loadProducts(identifiers: [AppConfig.productID])
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Manager.shared)
                .preferredColorScheme(.dark)
                .accentColor(.primary)
        }
    }
}
