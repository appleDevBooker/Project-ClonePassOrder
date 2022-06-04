//
//  AuthService.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/30.
//

import Foundation
import Firebase

enum AuthError: Error {
    var errorMessage: String {
        switch self {
        case .loginFaildError:
            return "아이디와 비밀번호를 확인후 다시 시도해주세요"
        case .authResultNilError:
            return "회원정보를 불러오는것에 실패했습니다 다시 시도해주세요"
        case .logoutFaildError:
            return "로그아웃에 실패했습니다 다시 시도해주세요"
        }
    }
    case loginFaildError
    case authResultNilError
    case logoutFaildError
}

protocol AuthServiceProtocol {
    func login(
        model: AuthModel,
        completion: @escaping (Result<String, AuthError>) -> Void
    )
    func logout(completion: @escaping (Result<Void, AuthError>) -> Void) throws
}

struct AuthService: AuthServiceProtocol {
    func login(
        model: AuthModel,
        completion: @escaping (Result<String, AuthError>) -> Void
    ) {
        Auth.auth().signIn(withEmail: model.email, password: model.password) { authResult, error in
            if error != nil {
                completion(.failure(.loginFaildError))
            } else {
                guard let result = authResult else {
                    completion(.failure(.authResultNilError))
                    return
                }
                completion(.success(result.user.uid))
            }
        }
    }
    func logout(completion: @escaping (Result<Void, AuthError>) -> Void) throws {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.logoutFaildError))
        }
    }
    
    
}
