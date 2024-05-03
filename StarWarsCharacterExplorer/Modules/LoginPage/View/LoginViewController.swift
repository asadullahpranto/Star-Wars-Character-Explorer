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
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    let viewModel = LoginViewModel()
    
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
        
        passwordField.configurePlaceHolder(with: .darkGray, placeHolder: "Password")
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .oneTimeCode
        passwordField.addTarget(self, action: #selector(handlePasswordField), for: .editingChanged)
        
        emailField.configurePlaceHolder(with: .darkGray, placeHolder: "Email")
        emailField.addTarget(self, action: #selector(handlePasswordField), for: .editingChanged)
        
        // login button
        loginButton.applyGradient(colours: [.orange, .red], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(handleUserLogin), for: .touchUpInside)
        
        // bottom section
        registerButton.setUnderlineTitle("Sign In")
        registerButton.addTarget(self, action: #selector(gotoRegisterPage), for: .touchUpInside)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @objc private func handleEmailField() {
        
    }
    
    @objc private func handlePasswordField() {
        
    }
    
    @objc private func handleUserLogin() {
        Task {
            guard let email = emailField.text
//                  let pass = passwordField.text 
            else
            { return }
            let isValid = await viewModel.login(with: email, and: "123")
            
            if isValid {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func gotoRegisterPage() {
        let registerVC = RegisterViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(registerVC, animated: true)
    }

}
