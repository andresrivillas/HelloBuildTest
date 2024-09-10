//
//  UserDetail.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import SwiftUI

struct UserDetail: View {
    var user: User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            ProfileImage(imageUrl: user.image)
                .frame(width: 150, height: 150)
            Text(user.fullName)
                .font(.title)
            InfoItem(image: "birthday.cake", info: user.birthDate.convertToDisplayFormat()) {}
            InfoItem(image: "graduationcap", info: user.university) {}
        }
        .padding()
        .cornerRadius(10)
    }
}

#Preview {
    UserDetail(user: User.example)
}
