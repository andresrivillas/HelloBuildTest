//
//  UserListViewModelTest.swift
//  HelloBuildTestTests
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

import XCTest
@testable import HelloBuildTest

class UserListViewModelTests: XCTestCase {
    
    var viewModel: UserListViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = UserListViewModel(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    // Test successful fetch of users
    func testFetchUsersSuccess() {
        // Arrange
        let mockUsers = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: ""),
            User(id: 2, firstName: "Jane", lastName: "Doe", age: 25, email: "jane.doe@example.com", image: "", phone: "0987654321", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false
        
        // Act
        viewModel.fetchUsers()
        
        // Assert
        XCTAssertEqual(viewModel.userList.count, 2, "UserList should have 2 users.")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after users are fetched.")
        XCTAssertEqual(viewModel.userList.first?.firstName, "John", "First user should be John.")
    }
    
    // Test limit reached case
    func testLimitReached() {
        // Arrange
        let mockUsers = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 25, email: "john.doe@example.com", image: "", phone: "1234567890", birthDate: "", university: "")
        ]
        mockNetworkManager.mockUsers = mockUsers
        mockNetworkManager.shouldFail = false
        
        // Act
        viewModel.fetchUsers()
        
        // Assert
        XCTAssertTrue(viewModel.limitReached, "limitReached should be true if less than 4 users are fetched.")
    }
    
    // Test failure case
    func testFetchUsersFailure() {
        // Arrange
        mockNetworkManager.shouldFail = true
        
        // Act
        viewModel.fetchUsers()
        
        // Assert
        XCTAssertEqual(viewModel.userList.count, 0, "UserList should be empty when fetching fails.")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after failure.")
    }
}
