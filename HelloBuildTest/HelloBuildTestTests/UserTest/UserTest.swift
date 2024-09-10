//
//  UserTest.swift
//  HelloBuildTestTests
//
//  Created by Andres Rivillas on 10/09/24.
//

import XCTest
@testable import HelloBuildTest

class UserTests: XCTestCase {
    
    func testUserInitialization() {
        let user = User(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            age: 30,
            email: "john.doe@example.com",
            image: "https://example.com/image.jpg",
            phone: "+1234567890",
            birthDate: "1997-11-10",
            university: "Test"
        )
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.firstName, "John")
        XCTAssertEqual(user.lastName, "Doe")
        XCTAssertEqual(user.age, 30)
        XCTAssertEqual(user.email, "john.doe@example.com")
        XCTAssertEqual(user.image, "https://example.com/image.jpg")
        XCTAssertEqual(user.phone, "+1234567890")
    }
    
    func testFullNameComputedProperty() {
        let user = User(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            age: 30,
            email: "john.doe@example.com",
            image: "https://example.com/image.jpg",
            phone: "+1234567890",
            birthDate: "1997-11-10",
            university: "Test"
        )
        XCTAssertEqual(user.fullName, "John Doe")
    }
    
    func testCodableCompliance() {
        let user = User(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            age: 30,
            email: "john.doe@example.com",
            image: "https://example.com/image.jpg",
            phone: "+1234567890",
            birthDate: "1997-11-10",
            university: "Test"
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            let data = try encoder.encode(user)
            let decodedUser = try decoder.decode(User.self, from: data)
            
            XCTAssertEqual(user.id, decodedUser.id)
            XCTAssertEqual(user.firstName, decodedUser.firstName)
            XCTAssertEqual(user.lastName, decodedUser.lastName)
            XCTAssertEqual(user.age, decodedUser.age)
            XCTAssertEqual(user.email, decodedUser.email)
            XCTAssertEqual(user.image, decodedUser.image)
            XCTAssertEqual(user.phone, decodedUser.phone)
        } catch {
            XCTFail("Failed to encode/decode user: \(error)")
        }
    }
    
    func testDecodableCompliance() {
        let jsonString = """
            {
                "users": [
                    {
                        "id": 1,
                        "firstName": "Emily",
                        "lastName": "Johnson",
                        "age": 28,
                        "email": "emily.johnson@x.dummyjson.com",
                        "image": "https://dummyjson.com/icon/emilys/128",
                        "phone": "+81 965-431-3024",
                        "birthDate": "1996-5-30",
                        "university": "University of Wisconsin--Madison",
                    }
                ]
            }
            """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let decodedResponse = try JSONDecoder().decode(UsersResponse.self, from: jsonData)
            
            XCTAssertEqual(decodedResponse.users.count, 1)
            
            let firstUser = decodedResponse.users[0]
            XCTAssertEqual(firstUser.id, 1)
            XCTAssertEqual(firstUser.firstName, "Emily")
            XCTAssertEqual(firstUser.lastName, "Johnson")
            XCTAssertEqual(firstUser.age, 28)
            XCTAssertEqual(firstUser.email, "emily.johnson@x.dummyjson.com")
            XCTAssertEqual(firstUser.image, "https://dummyjson.com/icon/emilys/128")
            XCTAssertEqual(firstUser.phone, "+81 965-431-3024")
            XCTAssertEqual(firstUser.birthDate, "1996-5-30")
            XCTAssertEqual(firstUser.university, "University of Wisconsin--Madison")
            
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}

