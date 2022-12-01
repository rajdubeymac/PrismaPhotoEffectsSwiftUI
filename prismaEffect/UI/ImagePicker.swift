//
//  ImagePickerSingle.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias OnPick = (UIImage) -> Void
    private var onPick: OnPick
    
    @Environment(\.presentationMode) internal var presentationMode
    
    let sourceType: UIImagePickerController.SourceType
    
    init(_ sourceType: UIImagePickerController.SourceType, onPick: @escaping OnPick) {
        self.sourceType = sourceType
        self.onPick = onPick
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = context.coordinator
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
    
    func updateUIViewController(_: UIImagePickerController, context _: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        private func main(_ completion: @escaping(() -> ())) {
            DispatchQueue.main.async(execute: completion)
        }
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            guard let image = info[.originalImage] as? UIImage else {
                print("Failed to retrieve image")
                main { [weak self] in
                    self?.parent.presentationMode.wrappedValue.dismiss()
                }
                return
            }
            main { [weak self] in
                self?.parent.onPick(image)
                self?.parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            main { [weak self] in
                self?.parent.presentationMode.wrappedValue.dismiss()
                
            }
        }
    }
}
