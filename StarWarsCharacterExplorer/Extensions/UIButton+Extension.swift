//
//  UIButton+Extension.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/30/24.
//

import UIKit

extension UIButton {
    func setUnderlineTitle(_ title: String, for state: UIControl.State = .normal) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: self.titleColor(for: state) ?? UIColor.black, // Use button's title color
            .baselineOffset: 4
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attributedString, for: state)
    }
}
