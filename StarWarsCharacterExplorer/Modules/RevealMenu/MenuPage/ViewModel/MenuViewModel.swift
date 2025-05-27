//
//  MenuViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

class MenuViewModel {
    
    func getUserInfo(using email: String?, completion: @escaping (Result<UserInfo, CoreDataError>) -> Void) {
        UserInfo.fetchUser(using: email, completion: completion)
    }
}
