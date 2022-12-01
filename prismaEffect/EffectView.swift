//
//  EffectView.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import SwiftUI
import PurchaseKit
struct EffectView: View {
    let premiumeffect = ["Cassatt","Water", "Pointillism", "Muse", "Scream", "Morisot", "Udnie", "Manet", "Monet", "Sisley", "Cartoon", "Night", "Degas"]
    @Environment(\.presentationMode) private var presentationMode
   // let uiImage: UIImage
    @State private var showControls = true
    @EnvironmentObject var obj: Manager
    var body: some View {
        VStack {
            topBar
            Spacer().frame(height: 10)
            Image(uiImage: obj.selectedImage!)
                .resizable()
                .scaledToFit()
                .overlay(overlayView)
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ZStack(alignment : .center){
                        Color(obj.filterType == .None ? "accent" : "panel")
                        ZStack{
                            ZStack(alignment : .center){
                                Color("button-dark").frame(width: 100, height: 100).cornerRadius(10)
                                VStack{
                                    Spacer()
                                    Image(systemName: "arrowshape.turn.up.backward.2.fill")
                                        .resizable().aspectRatio(contentMode: .fill)
                                        .frame(width: 30, height: 30)
                                        .background(Color("button-dark"))
                                    Spacer()
                                    Text("None")
                                        .font(.system(size: 12, weight: .medium))
                                        .frame(width: 100,height: 24)
                                        .background(obj.filterType == .None ? Color("accent") : Color.black)
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                    }.frame(width: 106, height: 106).cornerRadius(10)
                        .clipShape(Rectangle()).cornerRadius(10).onTapGesture {
                            obj.filterType = .None
                            obj.selectedImage = obj.originalImage
                        }
                    ForEach(FilterType.allCases.dropFirst(1)) { effect in
                        EffectPreview(effect: effect)
                    }.frame(height: 106)
                }
               .frame(height: 120)
                    .padding(10)
            } .background(Color("panel"))
           
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
                Interstitial.shared.loadInterstitial()
        }
    }
    
    private var topBar: some View {
        Group {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image.close
                        
                    }
                    Spacer()
                    Text("Prisma").font(XFont.subtitle)
                    Spacer()
                    Image.share
                        .tapToPresent(ExportView(im: obj.selectedImage!))
                }
                .imageScale(.large)
                .padding()
                .transition(.opacity)
        }
    }
    private func EffectPreview(effect: FilterType) -> some View {
        
        ZStack(alignment : .center){
            Color(obj.filterType == effect ? "accent" : "panel").frame(width: 106, height: 106).cornerRadius(10)
            ZStack {
                Image(effect.rawValue)
                    .resizable().aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100).cornerRadius(10)
                    .contentShape(Rectangle())
                VStack{
                    Spacer()
                    Text(effect.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 100, height: 24)
                        .background(obj.filterType == effect ? Color("accent") : Color.black)
                        .foregroundColor(.white)
                }
            }
        }.overlay(
            ZStack {
                if(premiumeffect.contains(effect.rawValue) && effect.rawValue != "None"){
                if obj.isPremium == false {
                    Color.black.opacity(0.5)
                    Image(systemName: "lock.fill")
                        .foregroundColor(.white).font(.system(size: 20))
                }
            }
            
        }
    )
    .clipShape(Rectangle()).cornerRadius(10).onTapGesture {
        if(premiumeffect.contains(effect.rawValue) && effect.rawValue != "None"){
        if obj.isPremium == false {
            presentAlert(title: "Prisma Premium", message: "Upgrade to use Premium Prisma Effects!", primaryAction: .cancel, secondaryAction: UIAlertAction(title: "UPGRADE", style: .default, handler: { _ in
                obj.showSpinner = true
                PKManager.purchaseProduct(identifier: AppConfig.productID) { _, status, _ in
                    DispatchQueue.main.async {
                        obj.showSpinner = false
                        if status == .success { obj.isPremium = true }
                        else if status == .restored{
                            obj.isPremium = true
                        }
                    }
                }
            }))
        } else {
            obj.filterType = effect
            obj.showSpinner = true
                EffectView.applyEffect(effect, image: obj.originalImage){image in
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                    obj.selectedImage = image
                    obj.showSpinner = false
                    }
                }
        }}else {
            obj.filterType = effect
            obj.showSpinner = true
                EffectView.applyEffect(effect, image: obj.originalImage){image in
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                    obj.selectedImage = image
                    obj.showSpinner = false
                    }
                }
        }
       
    }
    }
    private var overlayView: some View {
        Group {
            if obj.showSpinner {
                VStack {
                    SpinnerView()
                        .frame(width: 150, height: 150)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity).background(.black.opacity(0.9))
            }
        }
    }
    static func applyEffect(_ t: FilterType, image: UIImage?, completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            var im = image
            switch(t){
            case .Paint:
                    im =  image!.applypaintEffects()!
            case .Mosaic:
                    im =  image!.applyMosicEffects()!
            case .Wave:
                    im =  image!.applyWaveEffects()!
            case .Water:
                     im =  image!.applyWaterEffects()!
            case .Starnight:
                    im =  image!.applyStarryNightEffects()!
            case .Pointillism:
                    im =  image!.applyPointillismEffects()!
            case .Style:
                    im =  image!.applyMosaaicEffects()!
            case .Cuphead:
                    im =  image!.applycupheadEffects()!
            case .Candy:
                    im =  image!.applyCandyEffects()!
            case .Feather:
                     im =  image!.applyFeatherEffects()!
            case .Muse:
                   im =  image!.applyMuseEffects()!
            case .Scream:
                     im =  image!.applyScreamEffects()!
            case .Udnie:
                     im =  image!.applyUdnieEffects()!
            case .Cartoon:
                     im =  image!.applyCartoonEffects()!
            case .Night:
                     im =  image!.applynightEffects()!
            case .Cassatt:
                     im =  image!.applyCassattEffects()!
            case .Degas:
                     im =  image!.applyDegasEffects()!
            case .Manet:
                    im =  image!.applyManetEffects()!
            case .Monet:
                     im =  image!.applyMonetEffects()!
            case .Morisot:
                     im =  image!.applyMorisotEffects()!
            case .Pissarro:
                     im =  image!.applyPissarroEffects()!
            case .Renoir:
                    im =  image!.applyRenoirEffects()!
            case .Sisley:
                    im =  image!.applySisleyEffects()!
            case .None:
                completion(nil)
            }
            completion(im)
        }
    }
}

