//
//  Manager.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import UIKit
import CoreML
import SwiftUI

class Manager: NSObject, ObservableObject {
    
    static var shared = Manager()
    @AppStorage("isPremium") var isPremium: Bool = false
    @Published var showSpinner = false
    @Published var resultImage: UIImage?
    @Published var errorMessage: String?
    @Published var filterType = FilterType.None
    
    @Published var selectedImage: UIImage? {
        didSet { if originalImage == nil { originalImage = selectedImage } }
    }
    var originalImage: UIImage?
  /*  func process(image: UIImage) {
        showSpinner = true
        switch filterType {
        case .Cartoon:
            aiModel.process(image)
        case .VanGogh:
            aiModel.process(image: image, selectedNSTModel: .starryNight)
        case .Pointillism:
            aiModel.process(image: image, selectedNSTModel: .pointillism)
        case .mosaic:
            aiModel.process(image: image, selectedNSTModel: .mosaic)
        }
    }*/
}

extension UIImage {
    @nonobjc public func resized(to newSize: CGSize, scale: CGFloat = 1) -> UIImage {
      let format = UIGraphicsImageRendererFormat.default()
      format.scale = scale
      let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
      let image = renderer.image { _ in
        draw(in: CGRect(origin: .zero, size: newSize))
      }
      return image
    }
    func getMosaicModel() -> mosaic? {
        do {
            let config = MLModelConfiguration()
            return try mosaic(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getCandyModel() -> candy? {
        do {
            let config = MLModelConfiguration()
            return try candy(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getFeatherModel() -> feather? {
        do {
            let config = MLModelConfiguration()
            return try feather(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getMuseModel() -> muse? {
        do {
            let config = MLModelConfiguration()
            return try muse(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getScreamModel() -> scream? {
        do {
            let config = MLModelConfiguration()
            return try scream(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getUdnieModel() -> udnie? {
        do {
            let config = MLModelConfiguration()
            return try udnie(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getCassattModel() -> cassatt? {
        do {
            let config = MLModelConfiguration()
            return try cassatt(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getDegasModel() -> degas? {
        do {
            let config = MLModelConfiguration()
            return try degas(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getManetModel() -> manet? {
        do {
            let config = MLModelConfiguration()
            return try manet(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getMonetModel() -> monet? {
        do {
            let config = MLModelConfiguration()
            return try monet(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getMorisotModel() -> morisot? {
        do {
            let config = MLModelConfiguration()
            return try morisot(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getPissarroModel() -> pissarro? {
        do {
            let config = MLModelConfiguration()
            return try pissarro(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getRenoirModel() -> renoir? {
        do {
            let config = MLModelConfiguration()
            return try renoir(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getSisleyModel() -> sisley? {
        do {
            let config = MLModelConfiguration()
            return try sisley(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getWaterModel() -> water? {
        do {
            let config = MLModelConfiguration()
            return try water(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getWaveModel() -> wave? {
        do {
            let config = MLModelConfiguration()
            return try wave(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getStyleModel() -> style? {
        do {
            let config = MLModelConfiguration()
            return try style(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getcupheadModel() -> cuphead? {
        do {
            let config = MLModelConfiguration()
            return try cuphead(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getpaintModel() -> paint? {
        do {
            let config = MLModelConfiguration()
            return try paint(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func getnightModel() -> night? {
        do {
            let config = MLModelConfiguration()
            return try night(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    private func getCartoonModel() -> cartoon? {
        do {
            let config = MLModelConfiguration()
            return try cartoon(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    private func getPointillismModel() -> point? {
        do {
            let config = MLModelConfiguration()
            return try point(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    private func getStarryNightModel() -> starNight? {
        do {
            let config = MLModelConfiguration()
            return try starNight(configuration: config)
        } catch {
            print("Error loading model: \(error)")
            return nil
        }
    }
    func applyCartoonEffects() -> UIImage? {
        guard let model = getCartoonModel() else { return nil }
        let width: CGFloat = 256
        let height: CGFloat = 256

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(input: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.activation_out
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyMosicEffects() -> UIImage? {

        guard let model = getMosaicModel() else { return nil }
        let width: CGFloat = 640
        let height: CGFloat = 960

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(input: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.squeeze_out
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyMosaaicEffects() -> UIImage? {

        guard let model = getStyleModel() else { return nil }
        let width: CGFloat = 480
        let height: CGFloat = 640

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(_0: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage._156
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applycupheadEffects() -> UIImage? {

        guard let model = getcupheadModel() else { return nil }
        let width: CGFloat = 640
        let height: CGFloat = 960

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(input: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.squeeze_out
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applypaintEffects() -> UIImage? {

        guard let model = getpaintModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(input: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.activation_out
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyPointillismEffects() -> UIImage? {

        guard let model = getPointillismModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(myInput: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.myOutput
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyStarryNightEffects() -> UIImage? {

        guard let model = getStarryNightModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applynightEffects() -> UIImage? {

        guard let model = getnightModel() else { return nil }
        let width: CGFloat = 640
        let height: CGFloat = 960

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(input: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.squeeze_out
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    
    func applyCandyEffects() -> UIImage? {

        guard let model = getCandyModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyFeatherEffects() -> UIImage? {

        guard let model = getFeatherModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyMuseEffects() -> UIImage? {

        guard let model = getMuseModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyScreamEffects() -> UIImage? {

        guard let model = getScreamModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyUdnieEffects() -> UIImage? {

        guard let model = getUdnieModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
        let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyCassattEffects() -> UIImage? {

        guard let model = getCassattModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyDegasEffects() -> UIImage? {

        guard let model = getDegasModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyManetEffects() -> UIImage? {

        guard let model = getManetModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyMonetEffects() -> UIImage? {

        guard let model = getMonetModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyMorisotEffects() -> UIImage? {

        guard let model = getMorisotModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyPissarroEffects() -> UIImage? {

        guard let model = getPissarroModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyRenoirEffects() -> UIImage? {

        guard let model = getRenoirModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applySisleyEffects() -> UIImage? {

        guard let model = getSisleyModel() else { return nil }
        let width: CGFloat = 512
        let height: CGFloat = 512

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(image: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.stylizedImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
      return finalImage
    }
    func applyWaterEffects() -> UIImage? {

        guard let model = getWaterModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
    func applyWaveEffects() -> UIImage? {

        guard let model = getWaveModel() else { return nil }
        let width: CGFloat = 720
        let height: CGFloat = 720

        let resizedImage = resized(to: CGSize(width: height, height: height), scale: 1)
        guard let pixelBuffer = resizedImage.pixelBuffer(width: Int(width), height: Int(height)),
              let outputPredictionImage = try? model.prediction(inputImage: pixelBuffer)
        else { return nil }
        let outputBuffer = outputPredictionImage.outputImage
        let outputImage = CIImage(cvPixelBuffer: outputBuffer, options: [:])
        let finalImage = UIImage(
                        ciImage: outputImage,
                        scale: scale,
                        orientation: self.imageOrientation
                    ).resized(to: CGSize(width: size.width, height: size.height))
        
      return finalImage
    }
}
func presentAlert(title: String, message: String, primaryAction: UIAlertAction = .ok, secondaryAction: UIAlertAction? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(primaryAction)
    if let secondary = secondaryAction { alert.addAction(secondary) }
    var root = UIApplication.shared.windows.first?.rootViewController
    if let presenter = root?.presentedViewController { root = presenter }
    root?.present(alert, animated: true, completion: nil)
}

extension UIAlertAction {
    static var cancel: UIAlertAction {
        UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
    
    static var ok: UIAlertAction {
        UIAlertAction(title: "ok", style: .cancel, handler: nil)
    }
}
