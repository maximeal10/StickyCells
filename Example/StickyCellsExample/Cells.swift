//
// Created by Maxime Tenth on 9/14/20.
// Copyright (c) 2020 Mothxim. All rights reserved.
//

import UIKit
import StickyCells

protocol CellModel {
    func setup(cell: UITableViewCell)
    static var reuseIdentifier: String { get }
}

extension CellModel {
    var reuseIdentifier: String { Self.reuseIdentifier }
}

class HeaderLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 16))
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let origin = super.sizeThatFits(size)
        return CGSize(width: origin.width + 32,
                      height: origin.height + 32)
    }
}

class HeaderCell: StickyCellWith<HeaderLabel> {}


class ItemModel: CellModel {

    var text: String

    static let reuseIdentifier = "cell"

    init(_ text: String) {
        self.text = text
    }

    func setup(cell: UITableViewCell) {
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .darkGray
    }
}

class HeaderModel: CellModel {

    static let reuseIdentifier = "header"

    var text: String
    var level: Int?

    init(_ text: String, level: Int?) {
        self.text = text
        self.level = level
    }

    func setup(cell: UITableViewCell) {
        guard let cell = cell as? HeaderCell else { return }
        cell.stickyView.text = "\(text) [level \(level?.description ?? "nil")]"
        cell.stickyView.numberOfLines = 0
        cell.stickyView.backgroundColor = .white
        cell.setLevel(level)
    }

}