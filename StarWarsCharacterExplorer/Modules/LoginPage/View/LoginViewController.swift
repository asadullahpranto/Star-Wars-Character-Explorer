//
//  LoginViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/30/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginIconHolderView: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        // top circular-image
        loginIconHolderView.layer.cornerRadius = loginIconHolderView.frame.width / 2
        loginIconHolderView.layer.masksToBounds = true
        loginIconHolderView.layer.borderWidth = 2
        loginIconHolderView.layer.borderColor = UIColor.white.cgColor
        
        nameField.configurePlaceHolder(with: .darkGray, placeHolder: "Name")
        nameField.addTarget(self, action: #selector(handleNameField), for: .valueChanged)
        
        emailField.configurePlaceHolder(with: .darkGray, placeHolder: "Email")
        emailField.addTarget(self, action: #selector(handleEmailField), for: .valueChanged)
        
        // login button
        loginButton.applyGradient(colours: [.orange, .red], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        
        // bottom section
        registerButton.setUnderlineTitle("Sign In")
        registerButton.addTarget(self, action: #selector(gotoRegisterPage), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc private func handleNameField() {
        
    }
    
    @objc private func handleEmailField() {
        
    }
    
    @objc private func gotoRegisterPage() {
        let registerVC = RegisterViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(registerVC, animated: true)
    }

}
