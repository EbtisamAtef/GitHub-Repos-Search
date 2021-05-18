//
//  ErrorModel.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import Foundation

struct ErrorModel:Codable{
    let message : String
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
    
    init (message: String){
        self.message = message
    }
    
    static var networkError: ErrorModel {
        let error = ErrorModel (message: "No Internet Connection")
        return error
    }
    
    static var serializationError: ErrorModel {
        let error = ErrorModel (message: "Something went wrong")
        return error
    }
}

extension ErrorModel: Error {
    
}

extension Error {
    var errorMsg: String {
        return (self as? ErrorModel)?.message ?? "Something went wrong"
    }
}
