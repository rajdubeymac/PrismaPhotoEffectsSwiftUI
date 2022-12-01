//
//  AdsManager.swift
//  Prisma (iOS)
//
//  Created by Raj Dubey on 29/10/22.
//


import Foundation
import SwiftUI
import GoogleMobileAds

struct BannerAdmob: UIViewRepresentable {

    var unitID: String

    func makeCoordinator() -> Coordinator {
        // For Implementing Delegates..
        return Coordinator()
    }

    func makeUIView(context: Context) -> GADBannerView{
        let adView = GADBannerView(adSize: GADAdSizeBanner)

        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getRootViewController()

        adView.load(GADRequest())

        return adView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {

    }

    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}
class Interstitial: NSObject, GADFullScreenContentDelegate {
    var interstitial: GADInterstitialAd?
    
    static var shared: Interstitial = Interstitial()
    
    /// Default initializer of interstitial class
    override init() {
        super.init()
        loadInterstitial()
    }
    
    /// Request AdMob Interstitial ads
    func loadInterstitial() {
            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: AppConfig.adMobinterAdID, request: request, completionHandler: { [self] ad, error in
                if ad != nil {
                    interstitial = ad
                    interstitial?.fullScreenContentDelegate = self
                }
            })
    }
    
    func showInterstitialAds() {
        if self.interstitial != nil{
            var root = UIApplication.shared.windows.first?.rootViewController
            if let presenter = root?.presentedViewController {
                root = presenter
            }
            self.interstitial?.present(fromRootViewController: root!)
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadInterstitial()
    }
}
// Extending Application to get RootView..
extension UIApplication {
    func getRootViewController() -> UIViewController {

        guard let screen = self.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }

        return root
    }
}

