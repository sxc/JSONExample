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
                List {
                    ForEach(vm.users, id: \.id) { user in
                        UserView(user: user)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Users")
            }
            .onAppear(perform: vm.fetchUsers)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
