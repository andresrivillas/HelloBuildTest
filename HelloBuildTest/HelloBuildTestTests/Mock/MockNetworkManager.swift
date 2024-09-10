//
//  MockNetworkManager.swift
//  HelloBuildTestTests
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    var mockUsers: [User] = []
    var shouldFail: Bool = false
    
    func getUserList(page: Int, completion: @escaping (Result<[User], HBError>) -> Void) {
        if shouldFail {
            completion(.failure(.invalid))
        } else {
            completion(.success(mockUsers))
        }
    }
}
