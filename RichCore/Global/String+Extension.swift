// Copyright © 2022 SFCore. All rights reserved.

import UIKit
extension String {
    ///国际化的文本
    public var local: String {
        NSLocalizedString(self, comment: "")
    }
    
    public static var timeStamp: String  {
        Date().timeStamp
    }
    
    public var timeStamp: String  {
        Date().timeStamp
    }
}

extension String {

    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func heigth(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}
