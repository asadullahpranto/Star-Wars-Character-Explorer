//
//  SWApiEndpoint.swift
//  StarWarsCharacterExplorer
//
//  Created by Bitmorpher 4 on 4/24/24.
//

import Foundation
import Alamofire

enum SWApiEndpoint {
    case charactersList(url: String)
    case getDetailsBy(url: String)
    case filterCharactersBy(name: String?, species: String?, affiliation: String?, pageNo: Int)
}

extension SWApiEndpoint: Endpoint {
    var headers: Alamofire.HTTPHeaders {
        return ["Accept": "application/json"]
    }
    
    var url: String {
        switch self {
        case .charactersList(let url):
            return url
            
        case .getDetailsBy(let url):
            return url
            
        case .filterCharactersBy(name: let name, species: let species, affiliation: let affiliation, pageNo: let pageNo):
            return ""
        }
    }
    
//    var scheme: String {
//        return "https"
//    }
//    
//    var host: String {
//        return "swapi.py4e.com"
//    }
//    
//    var path: String {
//        switch self {
//        case .charactersListFor:
//            return "/api/people"
//            
//        case .characterDetailsBy(let id):
//            return "/api/people/\(id)"
//            
//        case .filterCharactersBy:
//            return ""
//        }
//    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var header: Alamofire.HTTPHeaders {
        return ["Content-type": "application/json"]
    }
    
//    var body: [String : Any]? {
//        return nil
//    }
//    
//    var queryItems: [URLQueryItem]? {
//        switch self {
//        case .charactersList(let url):
//            return [
//                URLQueryItem(name: "page", value: "\(pageNo)")
//            ]
//            
//        case .characterDetailsBy(let charID):
//            return nil
//            
//        case .filterCharactersBy(let name, let species, let affiliation, let pageNo):
//            return [
//                URLQueryItem(name: "param1", value: "value1")
//            ]
//        }
//    }
}
