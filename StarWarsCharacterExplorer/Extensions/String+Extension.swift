//
//  String+Extension.swift
//  StarWarsCharacterExplorer
//
//  Created by Md Amanullah on 2/5/24.
//

import Foundation

extension String {
    func getNameComponents() -> String {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .abbreviated
        
        if let component = formatter.personNameComponents(from: self) {
            return formatter.string(from: component)
        }
        return ""
    }
    
    var isValidEmail: Bool {
        return NSPredicate(
            format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        )
        .evaluate(with: self)
    }
}
