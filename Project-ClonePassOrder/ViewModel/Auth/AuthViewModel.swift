//
//  AuthViewModel.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/30.
//

import Foundation

enum EmptyTextField {
    case emailEmpty
    case passwordEmpty
}

final class AuthViewModel {
    
    //MARK: - output
    
    init(service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    var service: AuthServiceProtocol
    var email: String?
    var password: String?
    var textfildEmpty: Observer<EmptyTextField> = Observer(value: .emailEmpty)
    var uid: Observer<String?> = Observer(value: nil)
    var authError: Observer<AuthError> = Observer(value: .loginFaildError)
    var loginStart: Observer<Bool> = Observer(value: false)
    var logoutSuccess: Observer<Bool> = Observer(value: false)
}

extension AuthViewModel {
    
    func userLogin(email: String, password: String) {
        if email == "" {
            textfildEmpty.value = .emailEmpty
        } else if password == "" {
            textfildEmpty.value = .passwordEmpty
        } else {
            self.email = email
            self.password = password
            login()
            loginStart.value = true
        }
    }
    func textFieldEmptyString() -> String {
        switch textfildEmpty.value {
        case .emailEmpty:
            return "아이디를 입력해주세요!"
        case .passwordEmpty:
            return "비빌번호를 입력해주세요!"
        }
    }
    func login() {
        guard let email = email,
            let password = password else {
            return
        }
        let model = AuthModel(email: email, password: password)
        service.login(model: model) { [weak self] result in
            switch result {
            case .success(let uid):
                self?.uid.value = uid
            case .failure(let error):
                self?.authError.value = error
            }
        }
    }
    func logout() {
       try? service.logout { [weak self] result in
           switch result {
           case .success():
               self?.logoutSuccess.value = true
           case .failure(let error):
               self?.authError.value = error
           }
        }
    }
    
}
