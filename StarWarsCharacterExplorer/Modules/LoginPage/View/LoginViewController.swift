//
//  LoginViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/30/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginIconHolderView: UIView!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    let viewModel = LoginViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupPublisher()
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
        
        emailField.configurePlaceHolder(with: .darkGray, placeHolder: "Email")
        
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
    
    func setupPublisher() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: emailField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: passwordField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.isSubmitEnabled
            .map { $0 ? CGFloat(1.0) : CGFloat(0.5) }
            .assign(to: \.alpha, on: loginButton)
            .store(in: &cancellables)
    }
    
    @objc private func handleUserLogin() {
        guard let email = emailField.text else { return }
        
        viewModel.login() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let isSuccess):
                print("login success")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
            case .failure(let error):
                print("login error: " + error.localizedDescription)
            }
        }
    }
    
    @objc private func gotoRegisterPage() {
        let registerVC = RegisterViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(registerVC, animated: true)
    }

}
