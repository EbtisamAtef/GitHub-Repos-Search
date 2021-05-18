//
//  SearchRepoModel.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import Foundation

struct SearchRepoModel: Codable{
    let total_count: Int
    let incomplete_results : Bool
    let items : [RepoDetailsModel]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.total_count = try values.decodeIfPresent(Int.self, forKey: .total_count) ?? 1
        self.incomplete_results = try values.decodeIfPresent(Bool.self, forKey: .incomplete_results) ?? false
        self.items = try values.decodeIfPresent([RepoDetailsModel].self, forKey: .items) ?? []
   }
}


struct RepoDetailsModel:Codable{
    let name : String?
    let description : String?
    let language : String?
    let stargazers_count : Int?
    let owner : OwnerModel?
    
//    init(from decoder: Decoder) throws {
//         let values = try decoder.container(keyedBy: CodingKeys.self)
//         self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
//         self.description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
//         self.language = try values.decodeIfPresent(String.self, forKey: .language) ?? ""
//         self.stargazers_count = try values.decodeIfPresent(Int.self, forKey: .stargazers_count) ?? 0
//         self.owner = try OwnerModel(from: decoder)
//    }
}

struct OwnerModel:Codable{
    let login : String
    let avatar_url : String
    let type : String
    
    init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         self.login = try values.decodeIfPresent(String.self, forKey: .login) ?? ""
         self.avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url) ?? ""
         self.type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
    }
}

