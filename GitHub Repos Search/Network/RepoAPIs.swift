//
//  RepoAPIs.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import Moya

enum ReposAPIs {
    case repos(page: Int, keyword: String)
}

extension ReposAPIs: TargetType {
    
    var baseURL: URL {
        return URL (string: "https://api.github.com/")!
    }
    
    var path: String {
        switch self {
        case .repos:
            return "search/repositories"
        }
    }
    
    var method: Method {
        switch  self {
        case .repos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .repos(let page, let keyword):
            return Task.requestParameters(parameters: ["page": page, "q":keyword, "type": "users"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
