//
//  NSTError.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import Foundation

public enum NSTError : Error {
    case unknown
    case assetPathError
    case modelError
    case resizeError
    case pixelBufferError
    case predictionError
}

extension NSTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .assetPathError:
            return "Model file not found"
        case .modelError:
            return "Model error"
        case .resizeError:
            return "Resizing failed"
        case .pixelBufferError:
            return "Pixel Buffer conversion failed"
        case .predictionError:
            return "CoreML prediction failed"
        }
    }
}
