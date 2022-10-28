//
//  ContentView.swift
//  JSONExample
//
//  Created by Xiaochun Shen on 2022/10/27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = UsersViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isRefreshing {
                    ProgressView()
                } else {
//                    List {
//                        ForEach(vm.users, id: \.id) { user in
//                            UserView(user: user)
//                                .listRowSeparator(.hidden)
//                        }
//                    }
//                    .listStyle(.plain)
                    VStack {
                        Text($vm.user.id)
//                        Text(vm.user.username)
                    }
                    .navigationTitle("Users")
                    }
                }
            }
            .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button(action: vm.fetchUsers) {
                    Text("Retry")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
