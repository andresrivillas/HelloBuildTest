//
//  InfoUserItem.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 11/09/24.
//

import SwiftUI

struct InfoItem: View {
    var image: String
    var info: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                    .frame(width: 20)
                Text(info)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .lineLimit(1)
            }
        }.foregroundStyle(.secondary)
            .frame(alignment: .leading)
    }
}
