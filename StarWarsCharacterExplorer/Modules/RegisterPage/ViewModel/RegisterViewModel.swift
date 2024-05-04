//
//  RegisterViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 4/5/24.
//

import Foundation
import Combine

class RegisterViewModel {
    
    @Published var name = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var password = ""
    
    var isValidNamePublisher: AnyPublisher<Bool, Never> {
        $name
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
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
    
    var isValidPhoneNumberPublisher: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.count > 5 }
            .eraseToAnyPublisher()
    }
    
    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            isValidNamePublisher,
            isValidUsernamePublisher,
            isValidPasswordPublisher,
            isValidPhoneNumberPublisher
        )
        .map { $0 && $1 && $2 && $3}
        .eraseToAnyPublisher()
    }
    
    func isCorrectRegister(for email: String,
                           pass password: String,
                           name: String,
                           phone phoneNumber: String) -> Bool {
        return self.email == email && self.password == password && self.name == name && self.phoneNumber == phoneNumber
    }
    
    func register(using userInfo: UserCredential, completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        
        if isCorrectRegister(for: email, pass: password, name: name, phone: phoneNumber) {
            
            UserInfo.addOrUpdateToDB(for: userInfo, completion: completion)
        } else {
            completion(.failure(CoreDataError.loginError))
        }
    }
}
