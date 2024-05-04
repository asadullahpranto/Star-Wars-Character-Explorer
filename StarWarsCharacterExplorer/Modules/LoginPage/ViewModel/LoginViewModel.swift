//
//  LoginViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

class LoginViewModel {
    func login(with email: String, and password: String, completion: @escaping (Bool) -> Void) {
        UserInfo.fetchUser(using: email) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                completion(true)
                
            case .failure:
                completion(false)
            }
        }
    }
}
