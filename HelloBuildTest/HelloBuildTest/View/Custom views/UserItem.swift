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
            VStack(alignment: .leading, spacing: 20) {
                Text(user.fullName)
                    .font(.headline)
                InfoItem(image: "envelope", info: user.email)
                InfoItem(image: "phone", info: user.phone)
            }
        }
        .frame(maxWidth: 360, maxHeight: 140, alignment: .leading)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct InfoItem: View {
    var image: String
    var info: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .frame(width: 20)
            Text(info)
                .font(.system(size: 12, weight: .light, design: .serif))
        }.foregroundStyle(.secondary)
    }
}

#Preview {
    UserItem(user: User.example)
}
