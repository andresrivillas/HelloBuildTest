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
    @Published var sortOrder: SortOption = .id
    @Published var shouldShowError: Bool = false
    @Published var errorMessage: String = ""
    @Published var selectedUser: User?
    @Published var limitReached: Bool = false
    @Published var searchQuery: String = ""
    var page: Int = 0
    
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    var filteredUserList: [User] {
        if searchQuery.isEmpty {
            return sortedUserList
        } else {
            return sortedUserList.filter { $0.fullName.lowercased().contains(searchQuery.lowercased()) }
        }
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
        if isLoading || limitReached || !searchQuery.isEmpty {
            return
        }
        isLoading = !userList.isEmpty
        networkManager.getUserList(page: page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    
                    self.isLoading = false
                    self.userList.append(contentsOf: users)
                    self.page += 4
                    if users.count < 4 {
                        self.limitReached = true
                    }
                case .failure(let error):
                    
                    self.errorMessage = error.rawValue
                    self.shouldShowError = true
                    self.isLoading = false
                }
            }
        }
    }
}


