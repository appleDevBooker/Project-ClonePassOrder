//
//  SignUpViewModel.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/31.
//

import Foundation
import UIKit


final class SignUpViewModel {
 
    static let shared: SignUpViewModel = SignUpViewModel()
    
    init(
        imageUploaderService: ImageUploaderServiceProtocol = ImageUploaderService(),
        signUpService: SignUpServiceProtocol = SignUpService()
    ) {
        self.imageUploaderService = imageUploaderService
        self.signUpService = signUpService
    }
    
    var imageUploaderService: ImageUploaderServiceProtocol
    var signUpService: SignUpServiceProtocol
    var profileImageData: Data? = nil
    var userName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var phoneNumber: String = ""
    var verificationCode: String = ""
    var verificationID: Observer<String> = Observer(value: "")
    var imageURL: Observer<String> = Observer(value: "")
    var is14YearsOld: Observer<Bool> = Observer(value: false)
    var isAgreeService: Observer<Bool> = Observer(value: false)
    var isAgreeLocationService: Observer<Bool> = Observer(value: false)
    var isAgreePrivacyInformation: Observer<Bool> = Observer(value: false)
    var isAgreePrivacyThirdPartyInformation: Observer<Bool> = Observer(value: false)
    var isAgreeMarketingReceive: Observer<Bool> = Observer(value: false)
    var imageUploadError: Observer<ImageUploaderError> = Observer(value: .uploadImageFaildError)
    var signUpError: Observer<SigunUpError> = Observer(value: .upLoadFireStoreError)
    var signUpEnd: Observer<Bool> = Observer(value: false)
    var phoneNumberAuthSuccess: Observer<Bool> = Observer(value: false)
}

extension SignUpViewModel {
    
    func profileImageConrvertData(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            return
        }
        self.profileImageData = imageData
    }
    func textFieldEmptyVaild(text: String) -> Bool{
        if text == "" {
            return false
        } else {
            return true
        }
    }
    func userNameToLongValid(userName: String) -> Bool {
        if userName.count < 9 {
            self.userName = userName
            return true
        } else {
            return false
        }
    }
    func emailValidCheck(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: email) {
            self.email = email
            return true
        } else {
            return false
        }
    }
    func passwordToShortValid(password: String) -> Bool {
        if password.count > 7 {
            self.password = password
            return true
        } else {
            return false
        }
    }
    func confirmPasswordValid(confirmPassword: String) -> Bool {
        if confirmPassword == self.password {
            self.confirmPassword = confirmPassword
            return true
        } else {
            return false
        }
    }
    func phoneNumberConverting(phoneNumber: String) {
        if phoneNumber.count >= 10 {
      var convertPhoneNumber = phoneNumber
        convertPhoneNumber.removeFirst()
        convertPhoneNumber.insert(
            "-", at: convertPhoneNumber.index(convertPhoneNumber.startIndex, offsetBy: 2)
        )
        convertPhoneNumber.insert(
            "-", at: convertPhoneNumber.index(convertPhoneNumber.startIndex, offsetBy: 7)
        )
        
        self.phoneNumber = "+82 \(convertPhoneNumber)"
        }
    }
    func requiredAgreedValid() -> Bool {
        if is14YearsOld.value &&
            isAgreeService.value &&
            isAgreeLocationService.value &&
            isAgreePrivacyInformation.value &&
            isAgreePrivacyThirdPartyInformation.value {
            return true
        } else {
            return false
        }
    }
    func profileImageUpload() {
        guard let imageData = profileImageData else {
            return
        }
        imageUploaderService.uploadImage(
            fileName: "프로필이미지",
            imageData: imageData) { [weak self] result in
                switch result {
                case .success(let url):
                    self?.imageURL.value = url
                case .failure(let error):
                    self?.imageUploadError.value = error
                }
            }
    }
    func signUpUser() {
        let model = SignUpModel(
            email: self.email,
            password: self.password,
            phoneNumber: "",
            profileImageURL: self.imageURL.value,
            userName: self.userName,
            is14YearsOld: self.is14YearsOld.value,
            isAgreeService: self.isAgreeService.value,
            isAgreeLocationService: self.isAgreeLocationService.value,
            isAgreePrivacyInformation: self.isAgreePrivacyInformation.value,
            isAgreePrivacyThirdPartyInformation: self.isAgreePrivacyThirdPartyInformation.value,
            isAgreeMarketingReceive: self.isAgreeMarketingReceive.value
        )
        signUpService.signUp(model: model) { [weak self] result in
            switch result {
            case .success():
                self?.signUpEnd.value = true
            case .failure(let error):
                self?.signUpError.value = error
            }
        }
    }
    func phoneNumberAuth() {
        signUpService.phoneAuth(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success(let id):
                self?.verificationID.value = id
            case .failure(let error):
                self?.signUpError.value = error
            }
        }
    }
    func phoneNumberAuthValid() {
        signUpService.credentialAuth(
            verificationID: self.verificationID.value,
            verificationcode: self.verificationCode) { [weak self] result in
                switch result {
                case .success(let bool):
                    self?.phoneNumberAuthSuccess.value = bool
                    AuthViewModel().logout()
                case .failure(let error):
                    self?.signUpError.value = error
                }
            }
    }
}
