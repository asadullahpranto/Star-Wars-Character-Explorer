//
//  MenuViewModel.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 3/5/24.
//

import Foundation

class MenuViewModel {
    
    func getUserInfo(using email: String?) async -> Result<UserInfo, CoreDataError> {
        return await UserInfo.fetchUser(using: email)
    }
}
