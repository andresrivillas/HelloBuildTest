//
//  UserList.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserListViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: UserListViewModel(networkManager: NetworkManager()))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach (viewModel.filteredUserList, id: \.id) { user in
                        UserItem(user: user)
                            .onTapGesture {
                                viewModel.selectedUser = user
                            }
                            .onAppear {
                                if user == viewModel.filteredUserList.last {
                                    viewModel.fetchUsers()
                                }
                            }
                    }
                }
                .frame(alignment: .leading)
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.fetchUsers()
            }
            .background(Color(UIColor.systemBackground))
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .alert(viewModel.errorMessage, isPresented: $viewModel.shouldShowError) {
                Button("OK", role: .cancel) { }
            }
            .sheet(item: $viewModel.selectedUser){ user in
                UserDetailView(user: user)
                    .presentationDetents([.fraction(0.5)])
            }
            
        }
    }
}

#Preview {
    UserListView()
}
