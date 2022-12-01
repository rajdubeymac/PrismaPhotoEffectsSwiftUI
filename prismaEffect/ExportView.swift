//
//  ExportView.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//
import SwiftUI
import UIKit
import Combine
struct ExportView: View {
    
    @EnvironmentObject var shared:Manager
    @Environment(\.presentationMode) var presentationMode
     var im : UIImage
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    @State  var showSuccessPopup = false
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .padding(.trailing)
                
                Text("Export your photo")
                    .font(.system(size: 26, weight: .semibold))
                    .multilineTextAlignment(.center)
                
                Spacer()
                ZStack{
                    HStack(spacing: 24){
                        Spacer().frame(width: 8)
                        VStack{
                            
                                Image(uiImage: im)
                                    .resizable()
                                    .modifier(ImageBorder())
                            
                            Button(action:{
                                let responder = WriteImageToFileResponder()
                                responder.addCompletion { (image, error) in
                                // completion block
                                    if(shared.isPremium == false){
                                        Interstitial.shared.showInterstitialAds()
                                    }
                                   showSuccessPopup = true
                                }
                                UIImageWriteToSavedPhotosAlbum(im, responder, #selector(WriteImageToFileResponder.image(_:didFinishSavingWithError:contextInfo:)), nil)
                                
                               
                                
                            }){
                                RaiseButton("Save picture")
                            }
                            .padding(.top, 24)
                        }
                       
                        Spacer().frame(width: 8)
                    }
                }
                .frame(height: 400)
                .clipped()
                Spacer()
                
                Spacer().frame(height: 16)
               if(shared.isPremium == false){
                    BannerAdmob(unitID: AppConfig.adMobbannerAdID).frame( height: 60, alignment: .center)
                }
            }
            
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showSuccessPopup) {
            Alert(title: Text("Success"), message: Text("Your export success"), dismissButton: .default(Text("Close"), action: {
               
            })
            )
        }
    }
    
}
class WriteImageToFileResponder: NSObject {
    typealias WriteImageToFileResponderCompletion = ((UIImage?, Error?) -> Void)?
    var completion: WriteImageToFileResponderCompletion = nil
    
    override init() {
        super.init()
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if (completion != nil) {
            error == nil ? completion?(image, error) : completion?(nil, error)
            completion = nil
        }
        
    }
    func addCompletion(completion:WriteImageToFileResponderCompletion) {
        self.completion = completion
    }
}
struct ImageBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .border(Color("accent"), width: 3)
    }
}
struct RaiseButton: View {
    
    var title:String
    var systemName:String
    init(_ title:String, systemName:String = "arrow.down.to.line") {
        self.title = title
        self.systemName = systemName
    }
    
    var body: some View {
        HStack{
            Image(systemName: systemName)
            Text(title)
            
        }
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .frame(minWidth: 160, minHeight: 48)
        .background(Color("accent"))
        .cornerRadius(40)
    }
}
