//
//  UIView+Extension.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/29/24.
//

import UIKit

extension UIView {
    
    func applyGradient(colours: [UIColor],
                       startPoint: CGPoint = CGPoint(x: 0, y: 0),
                       endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}
