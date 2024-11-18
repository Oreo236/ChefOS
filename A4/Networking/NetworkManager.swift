//
//  NetworkManager.swift
//  A4
//

import Alamofire
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    // Get Recipes
    func getRecipes(completion: @escaping ([Recipe]) -> Void){
        let endpoint = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder) { response in
                switch response.result {
                case .success(let recipes):
                    completion(recipes)
                case .failure(let error):
                    print ("Error in NetworkManager.getRecipes: \(error.localizedDescription)")
                    completion([])
                }
            }
    }
    
    // MARK: - Requests
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void){
        let devEndpoint = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(devEndpoint, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder) {response in
                switch response.result {
                case .success(let recipes):
                    print("Successfully fetched \(recipes.count) recipes")
                    completion(recipes)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRecipes: \(error.localizedDescription)")
                    completion([])
                }
            }
    }
}
