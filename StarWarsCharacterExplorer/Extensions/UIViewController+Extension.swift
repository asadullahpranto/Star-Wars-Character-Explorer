//
//  UIViewController+Extension.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/29/24.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title.capitalized, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            
        }
        alertVC.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }

    }
}
