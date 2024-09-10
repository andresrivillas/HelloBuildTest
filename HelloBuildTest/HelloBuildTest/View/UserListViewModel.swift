//
//  UserListViewModel.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

class UserListViewModel: ObservableObject {
    
    @Published var userList: [User] = []
    @Published var isLoading: Bool = false
    @Published var limitReached: Bool = false
    @Published var sortOrder: SortOption = .id
    var page: Int = 0
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        fetchUsers()
    }
    
    var sortedUserList: [User] {
        switch sortOrder {
        case .name:
            return userList.sorted { $0.firstName < $1.firstName }
        case .lastName:
            return userList.sorted { $0.lastName < $1.lastName }
        case .email:
            return userList.sorted { $0.email < $1.email}
        case .phone:
            return userList.sorted { $0.phone < $1.phone }
        case .id:
            return userList.sorted { $0.id < $1.id }
        }
    }
    
    func fetchUsers() {
        isLoading = !userList.isEmpty
        networkManager.getUserList(page: page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    if users.count < 4 {
                        self.limitReached = true
                    }
                    self.isLoading = false
                    self.userList.append(contentsOf: users)
                    self.page += 4
                case .failure(let error):
                    self.isLoading = false
                }
            }
        }
    }
}


