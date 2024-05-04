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
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailAgainField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var parentsNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configureViews()
    }
    
    private func configureViews() {
        registerButton.applyGradient(colours: [.orange, .red], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        signInButton.setUnderlineTitle("Sign In")
        signInButton.addTarget(self, action: #selector(gotoLoginPage), for: .touchUpInside)
        
        setupFormFields()
        setupGenderOption()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupFormFields() {
        nameField.configurePlaceHolder(with: .darkGray, placeHolder: "Name*")
        emailField.configurePlaceHolder(with: .darkGray, placeHolder: "Email*")
        emailAgainField.configurePlaceHolder(with: .darkGray, placeHolder: "Confirm Email*")
        phoneField.configurePlaceHolder(with: .darkGray, placeHolder: "Phone Number*")
        parentsNameField.configurePlaceHolder(with: .darkGray, placeHolder: "Parents Name*")
    }
    
    private func setupGenderOption() {
        var genderOption = [UIMenuElement]()
        genderOption.append(UIAction(title: "Male") { _ in
            self.genderButton.setTitleColor(.white, for: .normal)
            self.genderButton.setTitle("Male", for: .normal)
            self.parentsNameField.configurePlaceHolder(with: .darkGray, placeHolder: "Father's Name")
        })
        
        genderOption.append(UIAction(title: "Female") { _ in
            self.genderButton.setTitleColor(.white, for: .normal)
            self.genderButton.setTitle("Female", for: .normal)
            self.parentsNameField.configurePlaceHolder(with: .darkGray, placeHolder: "Mother's Name*")
        })
        
        genderButton.showsMenuAsPrimaryAction = true
        genderButton.menu = UIMenu(options: .displayInline, children: genderOption)
    }
    
    @objc private func handleRegister() {
        let userInfo = UserCredential(
            name: "Asadullah Pranto",
            email: "a@gmail.com",
            phone: "1234",
            gender: "male",
            parentName: "aaa"
        )
        
        UserInfo.addOrUpdateToDB(for: userInfo) { [weak self] isComplete in
            guard let self else { return }
            
            DispatchQueue.main.async {
                if isComplete {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    
                }
            }
        }
       
    }
    
    @IBAction func hoverAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    @objc private func gotoLoginPage() {
        let loginVC = LoginViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
