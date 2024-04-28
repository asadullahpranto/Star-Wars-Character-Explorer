//
//  NSObject+Extension.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/28/24.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
