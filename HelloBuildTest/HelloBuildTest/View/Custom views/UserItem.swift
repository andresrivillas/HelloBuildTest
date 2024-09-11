//
//  UserItem.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import SwiftUI

struct UserItem: View {
    
    var user: User
    
    var body: some View {
        HStack(spacing: 10) {
            ProfileImage(imageUrl: user.image)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 10) {
                Text(user.fullName)
                    .font(.headline)
                    .padding(.bottom, 20)
                InfoItem(image: "envelope", info: user.email) { openMailApp(user.email)}
                InfoItem(image: "phone", info: user.phone) { dialPhoneNumber(user.phone) }
            }
        }
        .frame(maxWidth: 360, maxHeight: 140, alignment: .leading)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    UserItem(user: User.example)
}
