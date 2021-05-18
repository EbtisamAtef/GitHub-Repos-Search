//
//  Service.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import Foundation
import Alamofire
import Moya



class Service {
    
    static let instance = Service()
    
    let provider = MoyaProvider<ReposAPIs> (plugins: [NetworkLoggerPlugin ()])
    
    func loadRepos<T: Decodable>(keyword: String, page: Int, _ completion: @escaping ((T?, Error?) -> Void)) {
        
        self.provider.request(.repos(page: page, keyword: keyword)) { (result) in
            
            switch result {
            case .success(let response):
                
                if (200 ... 299) ~= response.statusCode {
                    
                    do {
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(T.self, from: response.data)
                        completion(responseData, nil)
                    } catch {
                        completion(nil, ErrorModel.serializationError)
                    }
                    
                } else {
                   
                    do {
                        let decoder = JSONDecoder()
                        let errorData = try decoder.decode(ErrorModel.self, from: response.data)
                        completion(nil, errorData)
                    } catch {
                        completion(nil, ErrorModel.serializationError)
                    }
                    
                }
                
            case .failure:
                completion(nil, ErrorModel.networkError)
            }
        }
    }
    
    func getData<T:Decodable>(url:String,completion: @escaping (T?,ErrorModel?,Error?)->Void){
        print("api url is \(url)")
        AF.request(url)
            .validate(statusCode : 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                
                
                
                case .success(let value):
                    guard let data = response.data else{return}
                    do{
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(T.self, from: data)
                        print("jsob is \(responseData)")
                        completion(responseData,nil,nil)
                    }catch let jsonError{
                        print("json error is \(jsonError)")
                    }
                    print(value)
                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? 0
                    if statusCode > 300 {
                        // Handle Error Model
                        guard let data = response.data else{return}
                        do{
                            let decoder = JSONDecoder()
                            let error = try decoder.decode(ErrorModel.self, from: data)
                            completion(nil,error,nil)
                        }catch let jsonError{
                            print("json error is \(jsonError)")
                        }
                    }else{
                        // Handle Newtwork (offline)
                        print("error is \(error)")
                        completion(nil,nil,error)
                    }
                }
            })
    }
}
