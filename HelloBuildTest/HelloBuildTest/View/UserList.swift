//
//  UserList.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import SwiftUI

struct UserList: View {
    @StateObject private var viewModel: UserListViewModel
        
        init() {
            _viewModel = StateObject(wrappedValue: UserListViewModel(networkManager: NetworkManager()))
        }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach (viewModel.sortedUserList.indices, id: \.self) { index in
                        ZStack {
                            UserItem(user: viewModel.sortedUserList[index])
                            
                            if index == (viewModel.userList.count - 2) && !viewModel.isLoading && !viewModel.limitReached {
                                Color.clear
                                    .onAppear {
                                        viewModel.fetchUsers()
                                    }
                                    .frame(width: CGFloat.leastNonzeroMagnitude)
                                    .listStyle(.grouped)
                            }
                        }
                    }
                    if viewModel.isLoading{
                        SkeletonLoader()
                    }
                }
                .frame(alignment: .leading)
                .padding(.horizontal)
            }
            .background(Color(UIColor.systemBackground))
            .toolbar {
                Menu {
                    Picker("Sort by", selection: $viewModel.sortOrder) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
        }
    }
}

private struct SkeletonLoader: View {
    var body: some View {
        ForEach(0..<4, id: \.self) { _ in
            Color(UIColor.secondarySystemBackground)
                .frame(width: 360, height: 140)
                .cornerRadius(10)
                .modifier(PulseAnimation())
        }
    }
}

struct PulseAnimation: ViewModifier {
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0.4)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    isVisible = true
                }
            }
    }
}

#Preview {
    UserList()
}
