//
//  StickyCell.swift
//  StickyCells
//
//  Created by Maxime Tenth on 9/10/20.
//  Copyright © 2020 Mothxim. All rights reserved.
//

import UIKit

private var _levelKey: UInt8 = 0

extension UIView {
    var level: Int? {
        get {
            objc_getAssociatedObject(self, &_levelKey) as? Int
        }
        set(newValue) {
            objc_setAssociatedObject(self, &_levelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


open class StickyCell: UITableViewCell {

    open var stickyUIView: UIView!

    public func setLevel(_ level: Int?) {
        stickyUIView.level = level
    }

    open func makeStickyView() -> UIView {
        fatalError("Implement in subclass")
    }

    open override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                                 withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                                 verticalFittingPriority: UILayoutPriority) -> CGSize {
        stickyUIView.sizeThatFits(targetSize)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        stickyUIView.frame.size = bounds.size
    }
}

open class StickyCellWith<StickyView: UIView>: StickyCell {

    public var stickyView: StickyView! {
        stickyUIView as? StickyView
    }

    open override func makeStickyView() -> UIView {
        StickyView(frame: .zero)
    }

}


