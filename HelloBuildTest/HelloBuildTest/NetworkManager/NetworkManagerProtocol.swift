//
//  NetworkManagerProtocol.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func getUserList(page: Int, completion: @escaping (Result<[User], HBError>) -> Void)
}
