//
//  UITextField+Extension.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 1/5/24.
//

import UIKit

extension UITextField {
    func configurePlaceHolder(with color: UIColor, placeHolder: String) {
//        self.backgroundColor = color
        self.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
    
}
