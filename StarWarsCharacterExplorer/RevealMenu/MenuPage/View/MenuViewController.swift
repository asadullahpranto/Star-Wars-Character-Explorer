//
//  MenuViewController.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 2/5/24.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var nameAbbreLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginLogoutButton: UIButton!
    
    let viewModel = MenuViewModel()
    
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
    }
    
    private func fetchUserInfo() {
        Task {
            let result = await viewModel.getUserInfo(using: nil)
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.nameAbbreLabel.text = userInfo.name?.getNameComponents()
                    self.nameLabel.text = userInfo.name
                    self.emailLabel.text = userInfo.email
                    self.loginLogoutButton.setTitle("Sign Out", for: .normal)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.loginLogoutButton.setTitle("Sign In", for: .normal)
            }
        }
    }
}
