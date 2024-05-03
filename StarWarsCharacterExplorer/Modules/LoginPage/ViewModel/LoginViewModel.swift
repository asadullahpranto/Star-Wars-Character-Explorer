//
//  LoginViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

class LoginViewModel {
    func login(with email: String, and password: String) async -> Bool {
        let result = await UserInfo.fetchUser(using: email)
        
        switch result {
        case .success:
            return true
            
        case .failure:
            return false
        }
    }
}
