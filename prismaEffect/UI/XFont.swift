import SwiftUI

struct XFont {
    
    // MARK: - Fonts
    
    static var title: Font { with(size: .large) }
    
    static var subtitle: Font { with(size: .medium) }
    
    static var paragraph: Font { with(size: .small) }

    static var small: Font { with(size: .extraSmall) }
        
    // MARK: - Size
    
    enum Size: CGFloat {
        case extraLarge = 80.0
        case large = 55
        case medium = 27.0
        case small = 23.0
        case extraSmall = 17.0
        case mini = 12.0
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let name = "AvenirNext-Heavy"
    }
    
    // MARK: - Methods
    
    static func with(size: Size) -> Font {
        Font.custom(Constants.name, size: size.rawValue)
    }
    
}
