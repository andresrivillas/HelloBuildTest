//
//  UserListViewModelTest.swift
//  HelloBuildTestTests
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

//import XCTest
//@testable import HelloBuildTest
//
//class UserListViewModelTests: XCTestCase {
//    var viewModel: UserListViewModel!
//    var mockNetworkManager: MockNetworkManager!
//    
//    override func setUp() {
//        super.setUp()
//        mockNetworkManager = MockNetworkManager()
//        viewModel = UserListViewModel(networkManager: mockNetworkManager)
//    }
//    
//    override func tearDown() {
//        viewModel = nil
//        mockNetworkManager = nil
//        super.tearDown()
//    }
//    
//    func testFetchUsersSuccess() {
//        mockNetworkManager.mockUsers = [User(id: 1, firstName: "John", lastName: "Doe", age: 30, email: "john.doe@example.com", image: "", phone: "1234567890")]
//        
//        viewModel.fetchUsers()
//        
//        XCTAssertEqual(viewModel.userList.count, 1)
//        XCTAssertEqual(viewModel.userList.first?.firstName, "John")
//    }
//    
//    func testFetchUsersFailure() {
//        mockNetworkManager.shouldFail = true
//        
//        viewModel.fetchUsers()
//        
//        XCTAssertFalse(viewModel.isLoading)
//        XCTAssertTrue(viewModel.userList.isEmpty)
//    }
//}
