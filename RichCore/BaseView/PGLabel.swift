// Copyright © 2020 maxudong. All rights reserved.

import UIKit
import Foundation

open class PGLabel : UILabel {
    open override var font: UIFont! { didSet { enforceStyleGuide() } }
    open override var textColor: UIColor! { didSet { enforceStyleGuide() } }
    open override var text: String? { didSet { enforceStyleGuide() } }
    open override var attributedText: NSAttributedString? { didSet { enforceStyleGuide() } }
    open var containerInsets: UIEdgeInsets = .zero { didSet { invalidateIntrinsicContentSize() } }
    private var isInitializing = true

    // MARK: Initialization
    public required init?(coder: NSCoder) { // Interface Builder
        super.init(coder: coder)
        isInitializing = false
        enforceStyleGuide()
    }

    public init(text: String? = nil, size: PGFontSize = .size14, weight: PGFontWeight = .regular, color: UIColor = .black, alignment: NSTextAlignment = .left, lines: Int = 1) {
        super.init(frame: .zero)
        self.text = text
        font = .peogooFont(size: size, weight: weight)
        textColor = color
        textAlignment = alignment
        numberOfLines = lines
        isInitializing = false
        enforceStyleGuide()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        enforceStyleGuide()
    }

    // MARK: Style Guide Adherence
    private func enforceStyleGuide() { }

    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard containerInsets != .zero else { return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines) }
        let insetRect = bounds.inset(by: containerInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -containerInsets.top, left: -containerInsets.left, bottom: -containerInsets.bottom, right: -containerInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: containerInsets))
    }
}
