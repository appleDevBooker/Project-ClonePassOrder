//
//  MockAuthService.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/30.
//

import Foundation

struct MockAuthService: AuthServiceProtocol {
    
    var loginResult: Result<String, AuthError>?
    var logoutResult: Result<Void, AuthError>?
    
    func login(
        model: AuthModel,
        completion: @escaping (Result<String, AuthError>) -> Void
    ) {
        completion(loginResult!)
    }
    func logout(completion: @escaping (Result<Void, AuthError>) -> Void) throws {
        completion(logoutResult!)
    }
    
}
