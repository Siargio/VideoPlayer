//
//  StackView+Ext.swift
//  VideoPlayer
//
//  Created by Sergio on 18.04.23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
