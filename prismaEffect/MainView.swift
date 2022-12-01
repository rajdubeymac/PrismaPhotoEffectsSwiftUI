//
//  MainView.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import SwiftUI
struct MainView: View {
    
    // MARK: - Constants
    
    private struct Constants {
        struct Button {
            static let size: CGFloat = 100
            static let cornerRadius: CGFloat = 40
            static let spacing: CGFloat = 22
            static let borderWidth: CGFloat = 3
        }
        struct Title {
            static let topSpacing: CGFloat = 32
            static let sideSpacing: CGFloat = 16
        }
    }
    @State private var showSheet = false
    @EnvironmentObject var manager: Manager
    var body: some View {
            VStack {
                Spacer()
                VStack {
                    Image("splash").resizable().aspectRatio(contentMode: .fit).frame(width: 250, height: 250)
                    Spacer().frame(height: 50)
                    Text("Prisma Effect").font(XFont.subtitle)
                }
                
                .padding(.horizontal, Constants.Title.sideSpacing)
                .padding(.top, Constants.Title.topSpacing)
                
                Spacer()

                HStack {
                    Spacer().frame(width: 50)
                    Image
                        .photo
                        .padding([.top,.bottom],20)
                    Spacer().frame(width: 20)
                    Text("CHOOSE PHOTO")
                        .font(XFont.small)
                        .padding([.top,.bottom],20)
                    Spacer().frame(width: 50)
                }
                .background(Rectangle().strokeBorder(lineWidth: Constants.Button.borderWidth).cornerRadius(5))
                .tapToPresent (
                    ImagePicker(.photoLibrary) {
                        manager.selectedImage = $0
                        showSheet = true
                    }
                        .edgesIgnoringSafeArea(.vertical)
                )
                .imageScale(.large)
                Spacer()
                if(manager.isPremium == false){
                     BannerAdmob(unitID: AppConfig.adMobbannerAdID).frame( height: 60, alignment: .center)
                 }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(item: $manager.errorMessage) {
                Alert(title: Text("Error"), message: Text($0), dismissButton: .cancel())
            }.fullScreenCover(isPresented: $showSheet) {
                EffectView()
            }
       
    }
    
   
}
