//
//  RegisterViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/29/24.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {

    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var parentsNameField: UITextField!
    
    let viewModel = RegisterViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        setupPublisher()
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
        passwordField.configurePlaceHolder(with: .darkGray, placeHolder: "Password*")
        phoneField.configurePlaceHolder(with: .darkGray, placeHolder: "Phone Number*")
        parentsNameField.configurePlaceHolder(with: .darkGray, placeHolder: "Parents Name")
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
            self.parentsNameField.configurePlaceHolder(with: .darkGray, placeHolder: "Mother's Name")
        })
        
        genderButton.showsMenuAsPrimaryAction = true
        genderButton.menu = UIMenu(options: .displayInline, children: genderOption)
    }
    
    @objc private func handleRegister() {
        let userInfo = prepareUserInfoData()
        UserInfo.addOrUpdateToDB(for: userInfo) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let isSuccess):
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                print("Register success")
                
            case .failure(let error):
                print("Register failed: " + error.localizedDescription)
            }
            
        }
       
    }
    
    private func prepareUserInfoData() -> UserCredential {
        let name = nameField.text
        let email = emailField.text
        let phone = phoneField.text
        let gender = genderButton.titleLabel?.text
        let parentName = parentsNameField.text
        
        return UserCredential(
            name: name ?? "",
            email: email ?? "",
            phone: phone ?? "",
            gender: gender ?? "",
            parentName: parentName  ?? ""
        )
    }
    
    @IBAction func hoverAction(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    @objc private func gotoLoginPage() {
        let loginVC = LoginViewController()
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func setupPublisher() {
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
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: nameField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: phoneField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.phoneNumber, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.isSubmitEnabled
            .map { $0 ? CGFloat(1.0) : CGFloat(0.5) }
            .assign(to: \.alpha, on: registerButton)
            .store(in: &cancellables)
    }
}
