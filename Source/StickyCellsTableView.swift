//
//  StickyCellsTableView.swift
//  StickyCells
//
//  Created by Maxime Tenth on 9/10/20.
//  Copyright © 2020 Mothxim. All rights reserved.
//

import UIKit

open class StickyCellsTableView: UITableView {

    private var needToUpdateStickyCellsInfo = false
    private var needToReorderStickyViews = false
    private var stickyCells: [StickyCell: IndexPath] = [:]
    private var stickyCellsOriginY: [IndexPath: CGFloat] = [:]
    private var lastInsertedStickyView: UIView?
    private var stickyViewsReverseOrdered: [(IndexPath, UIView)] = []
    private var stickyViews: [IndexPath: UIView] = [:] {
        didSet {
            stickyViewsReverseOrdered = stickyViews.keys.sorted().compactMap {
                guard let view = stickyViews[$0] else { return nil }
                return ($0, view)
            }.reversed()
        }
    }

    open var stickyOffsetTop: CGFloat {
        contentInset.top
    }

    open override func reloadData() {

        stickyViews.values.forEach { $0.removeFromSuperview() }
        stickyViews.removeAll(keepingCapacity: true)
        stickyCellsOriginY.removeAll(keepingCapacity: true)
        stickyCells.removeAll(keepingCapacity: true)
        lastInsertedStickyView = nil

        super.reloadData()
    }

    // Sorry, Not well tested
    open override func reloadSections(_ sections: IndexSet, with animation: RowAnimation) {

        for (cell, indexPath) in stickyCells {
            if !sections.contains(indexPath.section) {
                stickyCells[cell] = nil
            }
        }
        stickyViews.filter {
            sections.contains($0.key.section)
        }.forEach { indexPath, view in
            stickyViews[indexPath] = nil
            view.removeFromSuperview()
        }

        lastInsertedStickyView = nil

        needToReorderStickyViews = true

        super.reloadSections(sections, with: animation)

    }

    // Sorry, Not well tested
    open override func reloadRows(at indexPaths: [IndexPath], with animation: RowAnimation) {

        for (cell, indexPath) in stickyCells {
            if !indexPaths.contains(indexPath) {
                stickyCells[cell] = nil
            }
        }
        stickyViews.filter {
            indexPaths.contains($0.key)
        }.forEach { indexPath, view in
            stickyViews[indexPath] = nil
            view.removeFromSuperview()
        }

        lastInsertedStickyView = nil

        needToReorderStickyViews = true

        super.reloadRows(at: indexPaths, with: animation)
    }

    open override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        let cell = super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let stickyCell = cell as? StickyCell {
            let stickyView: UIView
            if let existing = stickyViews[indexPath] {
                stickyView = existing
            } else {
                stickyView = stickyCell.makeStickyView()
                if let lastInsertedStickyView = lastInsertedStickyView {
                    insertSubview(stickyView, belowSubview: lastInsertedStickyView)
                } else {
                    addSubview(stickyView)
                }
                lastInsertedStickyView = stickyView
            }
            stickyCell.stickyUIView = stickyView
            stickyCells[stickyCell] = indexPath
            stickyViews[indexPath] = stickyView
            needToUpdateStickyCellsInfo = true
        }
        return cell
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        if needToUpdateStickyCellsInfo {
            needToUpdateStickyCellsInfo = false
            for (cell, indexPath) in stickyCells {
                stickyCellsOriginY[indexPath] = cell.frame.origin.y
            }
        }

        var lastLevelY: [Int: CGFloat] = [:]

        for (index, (indexPath, stickyView)) in stickyViewsReverseOrdered.enumerated() {
            guard let originTop = stickyCellsOriginY[indexPath] else { continue } // unexpected

            let floatingTop: CGFloat
            if let level = stickyView.level {

                let lowerLevelLastY = lastLevelY.keys.filter {
                    $0 <= level
                }.compactMap {
                    lastLevelY[$0]
                }.reduce(CGFloat.greatestFiniteMagnitude, min)

                let stickiedHeight: CGFloat
                if level > 0 {
                    let upperViews = stickyViewsReverseOrdered.suffix(from: index)
                    stickiedHeight = (0...max(0, level-1))
                    .reversed()
                    .compactMap {
                        level in upperViews.first { $0.1.level == level }?.1.bounds.height
                    }.reduce(0, +)
                } else {
                    stickiedHeight = 0
                }

                floatingTop = min(lowerLevelLastY - stickyView.bounds.height,
                                  max(contentOffset.y + stickyOffsetTop + stickiedHeight,
                                      originTop))
                lastLevelY[level] = floatingTop
            } else {
                floatingTop = originTop
            }

            stickyView.frame.origin.y = floatingTop

            if needToReorderStickyViews {
                addSubview(stickyView)
            }

        }

        needToReorderStickyViews = false

    }
}
