// Copyright © 2020 PeoGooCore. All rights reserved.
import Foundation
import UIKit

// TODO: Make Fonts and enum and move all the font-specific properties into this enum.
enum FontFamily : String {
    case alternative = "Frank Ruhl Libre"
}

public enum PGFontWeight {
    /// Equivalent to CSS weight 400.
    case regular
    /// Equivalent to CSS weight 500.
    case medium
    /// Equivalent to CSS weight 600.
    case semibold
    /// Equivalent to CSS weight 700.
    case bold
    /// Equivalent to CSS weight 800.
    case heavy

    public var systemWeight: CGFloat {
        switch self {
        case .regular: return UIFont.Weight.regular.rawValue
        case .medium: return UIFont.Weight.medium.rawValue
        case .semibold: return UIFont.Weight.semibold.rawValue
        case .bold: return UIFont.Weight.bold.rawValue
        case .heavy: return UIFont.Weight.heavy.rawValue
        }
    }
}

/// Font size for the project's official default font.
public enum PGFontSize : Int, CaseIterable {
    case size12 = 12
    case size13 = 13
    case size14 = 14
    case size15 = 15
    case size16 = 16
    case size17 = 17
    case size18 = 18
    case size19 = 19
    case size20 = 20
    case size24 = 24
    case size30 = 30
    case size32 = 32
    case size40 = 40
    case size48 = 48

    /// The font size, measured in points, represented as CGFloat.
    public var pointSize: CGFloat { return CGFloat(rawValue) }

    /// The respective line height for this font size.
    ///
    ///  - size12 corresponds to 12pt
    ///  - size13 corresponds to 17pt
    ///  - size14 corresponds to 18pt
    ///  - size15 corresponds to 19pt
    ///  - size16 corresponds to 20pt
    ///  - size17 corresponds to 21pt
    ///  - size18 corresponds to 22pt
    ///  - size19 corresponds to 23pt
    ///  - size20 corresponds to 24pt
    ///  - size24 corresponds to 30pt
    ///  - size32 corresponds to 38pt
    ///  - size40 corresponds to 48pt
    ///  - size48 corresponds to 56pt
    ///
    public var lineHeight: CGFloat {
        switch self {
        case .size12: return 12
        case .size13: return 17
        case .size14: return 18
        case .size15: return 19
        case .size16: return 20
        case .size17: return 21
        case .size18: return 22
        case .size19: return 23
        case .size20: return 24
        case .size24: return 30
        case .size30: return 34
        case .size32: return 38
        case .size40: return 48
        case .size48: return 56
        }
    }
}

/// Alternate font size, used for the alternate font. At the moment the alternate font is FrankRuhlLibre.
public enum PGAlternateFontSize : Int, CaseIterable {
    case size14 = 14
    case size17 = 17
    case size19 = 19
    case size24 = 24
    case size32 = 32
    case size40 = 40
    case size48 = 48

    /// The font size, measured in points, represented as CGFloat.
    public var pointSize: CGFloat { return CGFloat(rawValue) }

    /// The respective line height for this font size.
    ///
    ///  - size14 corresponds to 18pt
    ///  - size17 corresponds to 22pt
    ///  - size19 corresponds to 24pt
    ///  - size24 corresponds to 24pt
    ///  - size32 corresponds to 40pt
    ///  - size40 corresponds to 40pt + 2pt, total 42pt, techinical requirement to avoid clipping issues on @3x screens.
    ///  - size48 corresponds to 48pt
    ///
    public var lineHeight: CGFloat {
        switch self {
        case .size14: return 18
        case .size17: return 22
        case .size19: return 24
        case .size24: return 24
        case .size32: return 40
        case .size40: return 40 + 2 // Slight margin to avoid clipping on @3x screens
        case .size48: return 48
        }
    }
}

extension UIFont {
    // Not @objc because it doesn't give a warning when passing the system constants (e.g. UIFontSizeBold)
    /// Project's official default font.
    public class func peogooFont(size: PGFontSize, weight: PGFontWeight = .regular, isItalic: Bool = false) -> UIFont {
        return peogooFont(size: size.pointSize, weight: UIFont.Weight(rawValue: weight.systemWeight), isItalic: isItalic)
    }

    /// Project's official default font.
    public class func peogooFont(nonStandardSize: CGFloat, weight: PGFontWeight = .regular, isItalic: Bool = false) -> UIFont {
        return peogooFont(size: nonStandardSize, weight: UIFont.Weight(rawValue: weight.systemWeight), isItalic: isItalic)
    }
    
    public class func peogooFont(zoomableSize: PGFontSize, weight: PGFontWeight = .regular, isItalic: Bool = false) -> UIFont {
        return peogooFont(size: zoomableSize.pointSize, weight: UIFont.Weight(rawValue: weight.systemWeight), isItalic: isItalic)
    }

    /// Project's alternate font. At the moment it is FrankRuhlLibre.
    public class func peogooAlternateFont(size: PGAlternateFontSize, weight: PGFontWeight = .regular) -> UIFont {
        return peogooAlternateFont(size: size.pointSize, weight: UIFont.Weight(rawValue: weight.systemWeight))
    }

    private static func peogooAlternateFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontName: String = {
            switch weight.rawValue {
            case UIFont.Weight.black.rawValue: return "FrankRuhlLibre-Black"
            case UIFont.Weight.bold.rawValue: return "FrankRuhlLibre-Bold"
            case UIFont.Weight.medium.rawValue: return "FrankRuhlLibre-Medium"
            case UIFont.Weight.regular.rawValue: return "FrankRuhlLibre-Regular"
            case UIFont.Weight.light.rawValue: return "FrankRuhlLibre-Light"
            default: return "FrankRuhlLibre-Regular"
            }
        }()
        return UIFont(name: fontName, size: size)!
    }

    private static func peogooFont(size: CGFloat, weight: UIFont.Weight, isItalic: Bool = false) -> UIFont {
        return isItalic ? .italicSystemFont(ofSize: size) : .systemFont(ofSize: size, weight: weight)
    }
}

// MARK: Legacy
extension UIFont {
    @objc public class func objc_peogooFont(size: CGFloat) -> UIFont {
        return peogooFont(size: size, weight: UIFont.Weight.regular)
    }

    @objc public class func objc_peogooFont(size: CGFloat, weight: CGFloat) -> UIFont {
        return peogooFont(size: size, weight: UIFont.Weight(rawValue: weight))
    }

    /// Common fonts by use
    @objc public static func peogooLargeBoldTitle() -> UIFont { return UIFont.peogooFont(size: .size32, weight: .bold) }
    @objc public static func peogooCellDescription() -> UIFont { return UIFont.peogooFont(size: .size12) }
    @objc public static func peogooDetailLabelTitle() -> UIFont { return UIFont.peogooFont(size: .size14) }
    @objc public static func peogooMediumDetailLabelTitle() -> UIFont { return UIFont.peogooFont(size: .size14, weight: .semibold) }
    @objc public static func peogooDefaultFontAndSize() -> UIFont { return UIFont.peogooFont(size: .size17) }
    @objc public static func peogooDefaultSemiBoldFontAndSize() -> UIFont { return UIFont.peogooFont(size: .size17, weight: .bold) }
}

