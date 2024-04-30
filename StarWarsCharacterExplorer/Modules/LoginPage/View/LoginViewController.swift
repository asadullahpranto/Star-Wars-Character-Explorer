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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        loginButton.applyGradient(colours: [.orange, .red], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        
        registerButton.setUnderlineTitle("Sign In")
        registerButton.addTarget(self, action: #selector(gotoRegisterPage), for: .touchUpInside)
    }
    
    @objc private func gotoRegisterPage() {
        let registerVC = RegisterViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(registerVC, animated: true)
    }

}
