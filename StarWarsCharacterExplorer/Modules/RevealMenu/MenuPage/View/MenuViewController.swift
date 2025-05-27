//
//  MenuViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 2/5/24.
//

import UIKit

protocol SlideMenuDelegate: AnyObject {
    func didTapMenuButton()
}

protocol LoginLogoutDelegate: AnyObject {
    func didLoginLogoutTapped(email: String, isLogingOut: Bool)
}

class MenuViewController: UIViewController {

    @IBOutlet weak var nameAbbreLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginLogoutButton: UIButton!
    
    weak var delegate: LoginLogoutDelegate?
    
    let viewModel = MenuViewModel()
    private var isLoggedIn = false
    private var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchUserInfo()
    }
    
    private func setupViews() {
        profileView.layer.cornerRadius = profileView.frame.width / 2
        profileView.layer.borderWidth = 1
        profileView.layer.borderColor = UIColor.white.cgColor
        profileView.layer.masksToBounds = true
        
        loginLogoutButton.layer.cornerRadius = loginLogoutButton.frame.height / 4
        loginLogoutButton.addTarget(self, action: #selector(handleLoginLogout), for: .touchUpInside)
    }
    
    @objc private func handleLoginLogout() {
        delegate?.didLoginLogoutTapped(email: email, isLogingOut: true)
    }
    
    func fetchUserInfo() {
        viewModel.getUserInfo(using: nil) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    if userInfo.isLoggedIn {
                        self.isLoggedIn = true
                        self.email = userInfo.email ?? ""
                        self.nameAbbreLabel.text = userInfo.name?.getNameComponents()
                        self.nameLabel.text = userInfo.name
                        self.emailLabel.text = userInfo.email
                        self.loginLogoutButton.setTitle("Sign Out", for: .normal)
                    } else {
                        self.isLoggedIn = false
                        self.email = ""
                        self.nameAbbreLabel.text = "AA"
                        self.nameLabel.text = nil
                        self.emailLabel.text = nil
                        self.loginLogoutButton.setTitle("Sign In", for: .normal)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loginLogoutButton.setTitle("Sign In", for: .normal)
                }
            }
        }
    }
}
