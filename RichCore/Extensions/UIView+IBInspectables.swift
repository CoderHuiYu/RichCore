// Copyright © 2022 MMCore. All rights reserved.

import UIKit

extension UIView {
    @IBInspectable open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue; clipsToBounds = true }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}

extension UIView {

    
    func addRoundedCorners(conrners: UIRectCorner , radius: CGFloat) {
       
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: conrners,
                                cornerRadii: CGSize(width: radius, height: radius))

        // Set path as a mask to display optional drag indicator view & rounded corners
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask

        // Improve performance by rasterizing the layer
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
