//
//  SignUpEmailController.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/16.
//

import UIKit
import SVProgressHUD

enum SignUpState {
    case userName
    case email
    case password
    case passwordConfirm
    case phoneNumber
}

class SignUpViewController: UIViewController {
    
    //MARK: - 프로퍼티
    
     var signUpState: SignUpState = .userName
    private var textFieldText: String = "닉네임"
    private var textFieldPlaceHolder: String = "8글자 이하로 작성해주세요"
    private var phoneNumberConfirmTextField: UITextField?
    private let welcomeView: UIView = UIView().welcomeView()
    private let nextButton: UIButton = UIButton().nextButton()
    private var phoneNumberConfirmButton: UIButton?
    private lazy var textField: UITextField = UITextField().signUpTextField(
        text: textFieldText,
        placeholder: textFieldPlaceHolder
    )
    var id = ""
    
    //MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSetAttribute()
        setAtrribute()
        setLayout()
        setBinding()
    }
    
    //MARK: - 셀렉터메서드
    
    @objc private func nextButtonTapped() {
        pushNextView()
    }
    @objc private func phoneNumberConfirmButtonTapped() {
        if SignUpViewModel.shared.textFieldEmptyVaild(text: textField.text ?? "") {
            SignUpViewModel.shared.phoneNumberConverting(phoneNumber: textField.text!)
            SignUpViewModel.shared.phoneNumberAuth()
        } else {
            Toast.message(superView: view, text: "전화번호를 입력해주세요")
        }
        
    }
    
    //MARK: - 메서드
    
    private func setLayout() {
        self.welcomViewSetLayout(view: view, welcomeView: welcomeView)
        if signUpState == .phoneNumber {
            guard let phoneNumberConfirmButton = phoneNumberConfirmButton else {
                return
            }
            [phoneNumberConfirmButton,textField].forEach {
                view.addSubview($0)
            }
            phoneNumberConfirmButton.snp.makeConstraints { make in
                make.top.equalTo(welcomeView.snp.bottom).offset(100)
                make.trailing.equalToSuperview().offset(-20)
                make.width.equalTo(80)
            }
            textField.snp.makeConstraints { make in
                make.top.equalTo(welcomeView.snp.bottom).offset(100)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalTo(phoneNumberConfirmButton.snp.leading).offset(-20)
            }
            self.nextButtonSetLayout(view: view, button: nextButton, topView: textField)
        } else {
            self.textFieldSetLayout(view: view, textField: textField, topView: welcomeView)
            self.nextButtonSetLayout(view: view, button: nextButton, topView: textField)
        }
    }
    private func setAtrribute() {
        view.backgroundColor = .systemBackground
        textField.delegate = self
        textField.becomeFirstResponder()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        if signUpState == .phoneNumber {
            phoneNumberConfirmButton = UIButton().emailLoginButton(
                text: "확인",
                image: nil ,
                height: 40
            )
            guard let phoneNumberConfirmButton = phoneNumberConfirmButton else {
                return
            }
            phoneNumberConfirmTextField = UITextField().signUpTextField(
                text: "인증번호 입력",
                placeholder: "인증번호 6자리 입력"
            )
            phoneNumberConfirmButton.addTarget(
                self,
                action: #selector(phoneNumberConfirmButtonTapped),
                for: .touchUpInside
            )
        }
    }
    private func naviSetAttribute() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
    }
    private func setBinding() {
        SignUpViewModel.shared.phoneNumberAuthSuccess.bind { [weak self] _ in
            SVProgressHUD.SVoff(view: self!.view, button: [self!.nextButton])
            let vc = AgreementViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        SignUpViewModel.shared.verificationID.bind { [weak self] _ in
            guard let phoneNumberConfirmTextField = self?.phoneNumberConfirmTextField else {
                return
            }
            self?.view.addSubview(phoneNumberConfirmTextField)
            phoneNumberConfirmTextField.snp.makeConstraints { make in
                make.top.equalTo(self!.textField.snp.bottom).offset(40)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalTo(self!.view.snp.trailing).offset(-20)
            }
           
            self!.nextButton.snp.removeConstraints()
            self!.nextButtonSetLayout(
                view: self!.view,
                button: self!.nextButton,
                topView: phoneNumberConfirmTextField
            )
        }
        SignUpViewModel.shared.signUpError.bind { [weak self] error in
            SVProgressHUD.SVoff(view: self!.view, button: [self!.nextButton])
            Toast.message(superView: self!.view, text: error.errorMessage)
        }
    }
    private func pushNextView() {
        let vc = SignUpViewController()
        let text = textField.text ?? ""
        switch self.signUpState {
        case .userName:
            if SignUpViewModel.shared.textFieldEmptyVaild(text: text) {
                if SignUpViewModel.shared.userNameToLongValid(userName: text) {
                    vc.signUpState = .email
                    vc.textFieldText = "이메일"
                    vc.textFieldPlaceHolder = "passorder@gmail.com"
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    Toast.message(superView: view, text: "닉네임을 8글자이하로 작성해주세요")
                }
            } else {
                Toast.message(superView: view, text: "닉네임을 입력해주세요!")
            }
        case .email:
            if SignUpViewModel.shared.textFieldEmptyVaild(text: text) {
                if SignUpViewModel.shared.emailValidCheck(email: text) {
                    vc.signUpState = .password
                    vc.textFieldText = "비밀번호"
                    vc.textFieldPlaceHolder = "8자리이상으로 작성해주세요"
                    vc.textField.isSecureTextEntry = true
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    Toast.message(superView: view, text: "이메일을 확인해주세요!")
                }
            } else {
                Toast.message(superView: view, text: "이메일을 입력해주세요!")
            }
        case .password:
            if SignUpViewModel.shared.textFieldEmptyVaild(text: text) {
                if SignUpViewModel.shared.passwordToShortValid(password: text) {
                    vc.signUpState = .passwordConfirm
                    vc.textFieldText = "비밀번호 한번더 입력"
                    vc.textFieldPlaceHolder = "비밀번호 한번더 입력"
                    vc.textField.isSecureTextEntry = true
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    Toast.message(superView: view, text: "비밀번호를 8자리 이상으로 작성해주세요!")
                }
            } else {
                Toast.message(superView: view, text: "비밀번호를 입력해주세요")
            }
        case .passwordConfirm:
            if SignUpViewModel.shared.textFieldEmptyVaild(text: text) {
                if SignUpViewModel.shared.confirmPasswordValid(confirmPassword: text) {
                    vc.signUpState = .phoneNumber
                    vc.textFieldText = "휴대폰으로 인증"
                    vc.textFieldPlaceHolder = "- 없이번호만입력"
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    Toast.message(superView: view, text: "비밀번호가 일치하지않습니다 다시입력해주세요!")
                }
            } else {
                Toast.message(superView: view, text: "비밀번호를 입력해주세요")
            }
        case .phoneNumber:
            guard let phoneNumberConfirmTextField = phoneNumberConfirmTextField else {
                return
            }
            guard let text = phoneNumberConfirmTextField.text else {
                return
            }
            SignUpViewModel.shared.verificationCode = text
            SignUpViewModel.shared.phoneNumberAuthValid()
            SVProgressHUD.SVshow(view: view, text: "", button: [nextButton])
        }
    }
}

//MARK: - 텍스트필드 델리게이트

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushNextView()
        return true
    }
}
