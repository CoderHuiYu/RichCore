// Copyright © 2022 mmCore. All rights reserved.

import UIKit


extension UIColor {
    private convenience init(rgbHex value: UInt) {
        let red = CGFloat((value >> 16) & 0xFF) / 255
        let green = CGFloat((value >> 8) & 0xFF) / 255
        let blue = CGFloat((value >> 0) & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    private convenience init(argbHex value: UInt) {
        let alpha = CGFloat((value >> 24) & 0xFF) / 255
        let red = CGFloat((value >> 16) & 0xFF) / 255
        let green = CGFloat((value >> 8) & 0xFF) / 255
        let blue = CGFloat((value >> 0) & 0xFF) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Initializes a color instance declared outside of the project's design guidelines using a custom RGB hex.
    public static func nonStandardColor(withRGBHex value: UInt) -> UIColor {
        return .init(rgbHex: value)
    }
    
    public static func nonStandardColor(withARGBHex value: UInt) -> UIColor {
        return .init(argbHex: value)
    }
    
    static let standardThemeColors: [UIColor] = {
        [UInt(0x047AFF), 0xFF2D55, 0xFF9F0A, 0x34C759, 0x9000FF].map { hex in
            return UIColor.nonStandardColor(withRGBHex: hex)
        }
    }()
    
//    static var currentConfigedMainColor: UIColor {
//        return .nonStandardColor(withRGBHex: MMInterfaceManager.shared.appearanceConifg.mainColor)
//    }
    
    static let lockImageTintColor = UIColor.nonStandardColor(withRGBHex: 0xC4C3C5)
    
    var argbHex: UInt {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let multiplier = CGFloat(255.999999)
        var result: UInt = 0
        result |= UInt(alpha * multiplier) << 24
        result |= UInt(red * multiplier) << 16
        result |= UInt(green * multiplier) << 8
        result |= UInt(blue * multiplier)
        return result
    }
    
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
   
    public static var mmEditColor: UIColor {
        return .nonStandardColor(withRGBHex: 0x047AFF)
    }
    public static var mmBarItemColor: UIColor {
        return .nonStandardColor(withRGBHex: 0x047AFF)
    }
    public static var mmCellSelectedColor: UIColor {
        return .nonStandardColor(withRGBHex: 0xDFDEE5)
    }
  
    public static var mmPenRedColor: UIColor {
        return .red
    }
    public static var mmPenBlackColor: UIColor {
        return .black
    }
    public static var mmPenYellowColor: UIColor {
        return .nonStandardColor(withRGBHex: 0xF0B633)
    }
    public static var mmPenGreenColor: UIColor {
        return .nonStandardColor(withRGBHex: 0x24C936)
    }
    public static var mmPenBlueColor: UIColor {
        return .nonStandardColor(withRGBHex: 0x047AFF)
    }
    public static var mmPopBackGroundColor: UIColor {
        return .nonStandardColor(withRGBHex: 0xf6f6f6)
    }
    
    var data: Data {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
        return data ?? Data()
    }
    
    static func from(data: Data) -> UIColor {
        let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
        return color ?? .black.withAlphaComponent(0)
    }
}


