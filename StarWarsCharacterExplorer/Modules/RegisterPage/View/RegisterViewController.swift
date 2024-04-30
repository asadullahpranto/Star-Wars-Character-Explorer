//
//  RegisterViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/29/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       configureViews()
    }
    
    private func configureViews() {
        registerButton.applyGradient(colours: [.orange, .red], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
        signInButton.setUnderlineTitle("Sign In")
        signInButton.addTarget(self, action: #selector(gotoLoginPage), for: .touchUpInside)
        
        var genderOption = [UIMenuElement]()
        genderOption.append(UIAction(title: "Male") { _ in
            self.genderButton.setTitle("Male", for: .normal)
        })
        
        genderOption.append(UIAction(title: "Female") { _ in
            self.genderButton.setTitle("Female", for: .normal)
        })
        
        genderButton.showsMenuAsPrimaryAction = true
        genderButton.menu = UIMenu(options: .displayInline, children: genderOption)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc private func gotoLoginPage() {
        let loginVC = LoginViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
