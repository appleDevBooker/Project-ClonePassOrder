//
//  UserViewModel.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/01.
//

import Foundation

final class UserViewModel {
    
    static let shared = UserViewModel()
    
    init(service: UserServiceProtocol = UserService()) {
        self.userService = service
    }
    
    var userService: UserServiceProtocol
    var model: Observer<UserModel> = Observer(value: UserModel.EMPTY)
    var userServiceError: Observer<UserServiceError> = Observer(value: .snapShotError)
    var userName: String {
        return model.value.userName
    }
    var profileImageUrl: URL? {
        return URL(string: model.value.profileImageUrl)
    }
}


extension UserViewModel {
    
    func userFetch(uid: String) {
        userService.fetch(uid: uid) { [weak self] result in
            switch result {
            case .success(let model):
                self?.model.value = model
            case .failure(let error):
                self?.userServiceError.value = error
            }
        }
    }
    func userServiceErrorString() -> String {
       return "앱종료후 다시 실행해주세요"
    }
}
