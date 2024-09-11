//
//  UserListViewModelTest.swift
//  HelloBuildTestTests
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation
import Combine
import XCTest
@testable import HelloBuildTest

class UserListViewModelTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    var viewModel: UserListViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockNetworkManager = MockNetworkManager()
        viewModel = UserListViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.userList.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.sortOrder, .id)
        XCTAssertFalse(viewModel.shouldShowError)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertNil(viewModel.selectedUser)
        XCTAssertFalse(viewModel.limitReached)
        XCTAssertEqual(viewModel.page, 0)
    }

    func testFetchUsersSuccess() {
        let mockUsers = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 2, firstName: "Pepe", lastName: "Perez", age: 25, email: "pepe.perez@example.com", image: "", phone: "0987654321", birthDate: "", university: ""),
            User(id: 3, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 4, firstName: "Jane", lastName: "Doe", age: 25, email: "jane.doe@example.com", image: "", phone: "0987654321", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false
        
        
        let exp = expectation(description: "Load data")
        
        viewModel.$userList
            .sink {
                if !$0.isEmpty {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)
        
        
        
        viewModel.fetchUsers()
        
        wait(for: [exp], timeout: 2)
        XCTAssertEqual(viewModel.userList.count, 4)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.userList.first?.firstName, "John")
        XCTAssertFalse(viewModel.shouldShowError)
    }
    
    func testLimitReached() {
        let mockUsers = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false
        
        let exp = expectation(description: "Load data")
        
        viewModel.$userList
            .sink {
                if !$0.isEmpty {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)
        
        
        
        viewModel.fetchUsers()
        
        wait(for: [exp], timeout: 2)
        XCTAssertTrue(viewModel.limitReached)
        XCTAssertFalse(viewModel.shouldShowError)
    }
    
    func testFetchUsersFailure() {
        mockNetworkManager.shouldFail = true
        
        let exp = expectation(description: "Load data")
        
        viewModel.$shouldShowError
            .sink {
                if $0 {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)
        
        
        
        viewModel.fetchUsers()
        
        wait(for: [exp], timeout: 2)
        
        XCTAssertEqual(viewModel.userList.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.shouldShowError)
        XCTAssertEqual(viewModel.errorMessage, HBError.invalid.rawValue)
    }
    
    func testSortByFirstName() {
        let mockUsers = [
            User(id: 1, firstName: "Bob", lastName: "Smith", age: 25, email: "alice@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 2, firstName: "Alice", lastName: "Johnson", age: 30, email: "bob@example.com", image: "", phone: "0987654321", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false

        let exp = expectation(description: "Sort data by first name")
        
        viewModel.$userList
            .sink {
                if !$0.isEmpty {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchUsers()
        wait(for: [exp], timeout: 2)

        viewModel.sortOrder = .name
        XCTAssertEqual(viewModel.sortedUserList.first?.firstName, "Alice")
        XCTAssertEqual(viewModel.sortedUserList.last?.firstName, "Bob")
    }
    
    func testSelectUser() {
        let mockUsers = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false

        let exp = expectation(description: "Select user")

        viewModel.$userList
            .sink {
                if !$0.isEmpty {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchUsers()
        wait(for: [exp], timeout: 2)
        
        viewModel.selectedUser = viewModel.userList.first
        XCTAssertEqual(viewModel.selectedUser?.firstName, "John")
    }
    
    func testFetchAdditionalPages() {
        viewModel.userList = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 2, firstName: "Jane", lastName: "Doe", age: 25, email: "jane.doe@example.com", image: "", phone: "0987654321", birthDate: "", university: ""),
        ]
        let mockUsersPage2 = [
            User(id: 3, firstName: "Alice", lastName: "Smith", age: 30, email: "alice.smith@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 4, firstName: "Bob", lastName: "Johnson", age: 35, email: "bob.johnson@example.com", image: "", phone: "0987654321", birthDate: "", university: "")
        ]
    
        
        let exp1 = expectation(description: "Load page 2")
        
        viewModel.$userList
            .sink {
                if $0.count == 4 {
                    exp1.fulfill()
                }
            }
            .store(in: &cancellables)
        
        
        mockNetworkManager.mockUsers = mockUsersPage2
        viewModel.fetchUsers()
        
        wait(for: [exp1], timeout: 2)
        XCTAssertEqual(viewModel.userList.count, 4)
        XCTAssertEqual(viewModel.page, 8)
    }
    
    func testSearchQueryFiltering() {
        let mockUsers = [
            User(id: 1, firstName: "Alice", lastName: "Doe", age: 25, email: "alice.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 2, firstName: "Bob", lastName: "Smith", age: 25, email: "bob.smith@example.com", image: "", phone: "0987654321", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false
        
        let exp = expectation(description: "Search users by query")
        
        viewModel.$userList
            .sink {
                if !$0.isEmpty {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchUsers()
        wait(for: [exp], timeout: 2)
        
        viewModel.searchQuery = "Alice"
        XCTAssertEqual(viewModel.filteredUserList.count, 1)
        XCTAssertEqual(viewModel.filteredUserList.first?.firstName, "Alice")
    }
}
