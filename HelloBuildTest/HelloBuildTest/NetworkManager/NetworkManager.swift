//
//  NetworkManager.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

class NetworkManager: NetworkManagerProtocol{
    
    private let baseURL = "https://dummyjson.com/"
    
    func getUserList(page: Int, completion completed: @escaping (Result<[User], HBError>) -> Void) {
        let endpoint = baseURL + "users?limit=4&skip=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalid))
            print(HBError.invalid)
            return
        }
        
        print(endpoint)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                print(HBError.unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                print(HBError.invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                print(HBError.invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode(UsersResponse.self, from: data)
                completed(.success(users.users))
                print(users)
            } catch {
                completed(.failure(.invalidData))
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
    
}


