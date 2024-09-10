//
//  ProfileImage.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import SwiftUI
import UIKit

struct ProfileImage: View {
    
    var imageUrl: String
    
    var body: some View {
        let defaultImage = Image(systemName: "person.crop.circle")
            .frame(width: 100, height: 100)
            .scaledToFit()
            .foregroundColor(Color(UIColor.systemGray))
        
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle()) // Make the image circular
                    .overlay(
                        Circle().stroke(Color(UIColor.systemGray2), lineWidth: 5) // Add a circular border
                    )

            case .failure:
                defaultImage
            @unknown default:
                defaultImage
            }
        }
    }
}

#Preview {
    ProfileImage(imageUrl: "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U")
}
