//
//  LoginViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation
import Combine

class LoginViewModel {
    
    @Published var email = ""
    @Published var password = ""
    
    var isValidUsernamePublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValidEmail }
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidUsernamePublisher, isValidPasswordPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    func isCorrectLogin(for email: String, and password: String) -> Bool {
        return self.email == email && self.password == password
    }
    
    func login(completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        
        if isCorrectLogin(for: email, and: password) {
            UserInfo.loginLogout(using: self.email, isLoging: true, completion: completion)
        } else {
            completion(.failure(CoreDataError.loginError))
        }
    }
}
