//
//  UsersViewModel.swift
//  JSONExample
//
//  Created by Xiaochun Shen on 2022/10/27.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
//    @Published var users: [User] = []
    @Published var hasError = false
    @Published var error: UserError?
    @Published private(set) var isRefreshing = false
    
    
    
    func fetchUsers() {
        
        isRefreshing = true
        hasError = false
        
//        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
//        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
//        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        let lichessUrlString = "https://lichess.org/api/user/Unkreativ3"
//        let user1UrlString = "https://jsonplaceholder.typicode.com/users/1"
//        let topplayerUrlString = "https://lichess.org/api/player"
        
    
        
        if let url = URL(string: lichessUrlString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                // TODO: Handle returning data on the Main thread
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        // TODO: handel error
                        self.hasError = true
                        self.error = UserError.custom(error: error)
                        
                    } else {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // Hnadle properties that look like first_name > firstName
                        
                        if let data = data,
                           let user = try? decoder.decode(User.self, from: data) {
                            // TODO: handel setting the data
//                            self.users = users
                            
                            let user = try decoder.decode(User.self, from: data)
                            print(user)
                            
                            
                        } else {
                            // TODO: handel error
                            
                            self.hasError = true
                            self.error = UserError.failedToDecode
                            print(error)
                        }
                        
                    }
                    self.isRefreshing = false 
                    
                }
       
                
            }.resume()
        }
    }
}

extension UsersViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
