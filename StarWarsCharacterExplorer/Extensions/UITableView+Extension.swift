//
//  UITableView+Extensions.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/30/24.
//

import UIKit

extension UITableView {
    func showLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(50))
        
        self.tableFooterView = spinner
        self.tableFooterView?.isHidden = false
    }
    
    func hideLoadingFooter() {
        self.tableFooterView?.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.tableFooterView = nil
            self.layoutIfNeeded()
        }
    }
}
