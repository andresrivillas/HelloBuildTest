//
//  User.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let image: String
    let phone: String
    let birthDate: String
    let university: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
#if DEBUG
    static let example = User(id: 123, firstName: "Andres", lastName: "Rivillas", age: 26, email: "andresrivillas97@gmail.com", image: "https://fatly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U", phone: "+57 3052465943", birthDate: "1997-11-10", university: "ITM")
#endif
}
